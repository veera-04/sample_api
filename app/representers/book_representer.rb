class BookRepresenter
        def initialize(book)
                @book=book
        end

        def as_json
                {
                        id: book.id,
                        title: book.title,
                        author: author_name(book.author),
                        age: book.author.age
                }
        end

        attr_reader :book
        
        def author_name(author)
                "#{author.first_name} #{author.last_name}"
        end
end