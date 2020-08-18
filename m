Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21032247C14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 04:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRCPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 22:15:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726328AbgHRCPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 22:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597716939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8Le9o7OV5u/OMIcRahhDVii3MpltXfWjLaJZ2qsfDU=;
        b=h3TYM4DxqLxzzyPUnVTvlzi3CD2J9zOJ2jm78gfzzdCNLk/qdeMa0asgUmadxY1KD6ZOqS
        jU5tLVFX1E054vd0ayPQqRhcKZ9h9lf5kGxpr/jkNUkDvGsbyOnTqPvd88TgmrGGMYHd3p
        gR8CWuLJgLyIzcb4FqSrkShnr7nQ9tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-byIUhCK6OS6ZpAvfYpp-mw-1; Mon, 17 Aug 2020 22:15:35 -0400
X-MC-Unique: byIUhCK6OS6ZpAvfYpp-mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC771DDE9;
        Tue, 18 Aug 2020 02:15:34 +0000 (UTC)
Received: from T590 (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2402756B6;
        Tue, 18 Aug 2020 02:15:28 +0000 (UTC)
Date:   Tue, 18 Aug 2020 10:15:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Fix page_is_mergeable() for compound pages
Message-ID: <20200818021524.GA2505641@T590>
References: <20200817195206.15172-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817195206.15172-1-willy@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:52:06PM +0100, Matthew Wilcox (Oracle) wrote:
> If we pass in an offset which is larger than PAGE_SIZE, then
> page_is_mergeable() thinks it's not mergeable with the previous bio_vec,
> leading to a large number of bio_vecs being used.  Use a slightly more
> obvious test that the two pages are compatible with each other.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 52d52d1c98a9 ("block: only allow contiguous page structs in a bio_vec")
> 
> ---
>  block/bio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index c63ba04bd629..a9931f23d933 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -740,8 +740,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
>  		struct page *page, unsigned int len, unsigned int off,
>  		bool *same_page)
>  {
> -	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) +
> -		bv->bv_offset + bv->bv_len - 1;
> +	size_t bv_end = bv->bv_offset + bv->bv_len;
> +	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) + bv_end - 1;
>  	phys_addr_t page_addr = page_to_phys(page);
>  
>  	if (vec_end_addr + 1 != page_addr + off)
> @@ -750,9 +750,9 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
>  		return false;
>  
>  	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
> -	if (!*same_page && pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
> -		return false;
> -	return true;
> +	if (*same_page)
> +		return true;
> +	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);

Looks this way is more straightforward, meantime can cover compound
pages:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

