# frozen_string_literal: true

module Pageable
  DEFALT_PAGE_SIZE = 20
  DEFALT_OFFSET = 0

  def limit
    params[:limit]&.to_i || DEFALT_PAGE_SIZE
  end

  def offset
    params[:offset]&.to_i || DEFALT_OFFSET
  end

  def page_data(total)
    {
      meta: { total: total },
      links: links(total)
    }
  end

  def links(total)
    links = { self: endpoint_url(query_params) }
    if offset + DEFALT_PAGE_SIZE < total
      links[:next] = endpoint_url(query_params(new_offset: offset + DEFALT_PAGE_SIZE))
    end
    unless offset == DEFALT_OFFSET
      links[:prev] = endpoint_url(query_params(new_offset: offset - DEFALT_PAGE_SIZE))
    end
    links
  end
end
