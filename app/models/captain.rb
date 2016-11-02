class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    joins(:classifications, :boats).where("classifications.name = 'Catamaran'").uniq
  end

  def self.sailors
    joins(:boats, :classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.motorboats
    joins(:boats, :classifications).where("classifications.name = 'Motorboat'").uniq
  end

  def self.talented_seamen
    self.sailors.where(id: self.motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end



end
