Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8957627445B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIVOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:35:10 -0400
Received: from verein.lst.de ([213.95.11.211]:44905 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVOfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:35:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB79767373; Tue, 22 Sep 2020 16:35:06 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:35:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH 2/2] vfree: Update documentation
Message-ID: <20200922143506.GA26664@lst.de>
References: <20200921224628.20704-1-willy@infradead.org> <20200921224628.20704-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921224628.20704-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:46:28PM +0100, Matthew Wilcox (Oracle) wrote:
>  * Document that you can call vfree() on an address returned from vmap()
>  * Remove the note about the minimum size -- the minimum size of a vmalloc
>    allocation is one page
>  * Add a Context: section
>  * Fix capitalisation
>  * Reword the prohibition on calling from NMI context to avoid a double
>    negative
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/vmalloc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3893fc8915c4..942a44bdeec6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2313,20 +2313,20 @@ static void __vfree(const void *addr)
>  }
>  
>  /**
> - * vfree - release memory allocated by vmalloc()
> - * @addr:  memory base address
> + * vfree - Release memory allocated by vmalloc()
> + * @addr:  Memory base address
>   *
>   * Free the virtually continuous memory area starting at @addr, as
> + * obtained from vmalloc(), vmalloc_32() or __vmalloc().  If called
> + * on an @addr obtained from vmap(), it will put one refcount on each
> + * mapped page, which will free the page if this is the last refcount
> + * on the page.  If @addr is NULL, no operation is performed.

This reads a little confusing.  First it only allows vmalloc* and
then it mentions vmap in the next sentence.  And what about
vmalloc_32_user, vzalloc_node, vmalloc_node, vmalloc_user, vzalloc and
__vmalloc_node?
