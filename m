Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F84819F64B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgDFNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 09:01:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgDFNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zNFwdM697I69ZxsCtjPZ0n5v/OJG96sZh4pg4CmQykg=; b=bkPu4imxbhFePpIISA5dVVI3ve
        hrQewkOpY2Kuo+k2IrrOwjR5jq8r9+N9osdPKRIfENFy0m4qW0bvFozgCbfDlXhUkal2InBY+EK75
        i3LGusKTGbjzZ7R7/IIetY/CgF4NPThI4Zu91d0NJj8m279Qr4YQbCvDdnHNQPATYu2pfZB8E1NQq
        Jy4X30m9gCugOuVgHUxi4EgZ4rkJDMheCEzCgQtabp7YoOAOYOKqTmzeIV4vWXoxyOhDVJX5lF3uV
        qIklpFRsBvRPbd4t73fj3Vsl8gXb/0H5sYeVcNWd1QjPuVtWwXCNp7gV7dgIzk82n+5uHmlRQMeCN
        jXx0rbMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLRNz-000587-1y; Mon, 06 Apr 2020 13:01:55 +0000
Date:   Mon, 6 Apr 2020 06:01:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200406130155.GB29306@infradead.org>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> 
> __get_vm_area() is an exported symbol, make sure the callers stay in
> the expected memory range. When calling this function with memory
> ranges outside of the VMALLOC range *bad* things can happen.
> 
> (I noticed this when I managed to corrupt the kernel text by accident)

Maybe it is time to unexport it?  There are only two users:

 - staging/media/ipu3 really should be using vmap.  And given that it
   is a staging driver it really doesn't matter anyway if we break it.
 - pcmcia/electra_cf.c is actually using it for something that is not
   a vmalloc address.  But it is so special that I think prohibiting
   to build it as module seems fine.

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  mm/vmalloc.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2130,6 +2130,13 @@ static struct vm_struct *__get_vm_area_n
>  struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
>  				unsigned long start, unsigned long end)
>  {
> +	/*
> +	 * Ensure callers stay in the vmalloc range.
> +	 */
> +	if (WARN_ON(start < VMALLOC_START || start > VMALLOC_END ||
> +		    end < VMALLOC_START || end > VMALLOC_END))
> +		return NULL;
> +
>  	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
>  				  GFP_KERNEL, __builtin_return_address(0));
>  }
---end quoted text---
