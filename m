Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB10926B947
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIPBRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgIPBRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:17:50 -0400
Received: from X1 (unknown [67.22.170.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E8A207DE;
        Wed, 16 Sep 2020 01:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600219070;
        bh=AhUHdnUo9rJC4ndiU3DPdecCdebXpTSRQ5+5l3tt/Rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vEGWVXqW0XORjvPLXUCTjGJjOkgr3iekyk2VnZoNYdpLT0WSxr3JRDU08fmPZPEH4
         m8tnBGaSqBBcFN2q9/IDrD1x/ioYcHzfgW4AglvJmV/ua9/OxpTY19TdcArFzozl5U
         1WymYuFrqxY+zfNdSrFzPllVgfWmmRn7zZrkylTw=
Date:   Tue, 15 Sep 2020 18:17:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <yanfei.xu@windriver.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc.c: avoid inheritting current's flags when
 invoked in interrupt
Message-Id: <20200915181749.2bb7420e2c7e62267b21a0fc@linux-foundation.org>
In-Reply-To: <20200915075635.1112-1-yanfei.xu@windriver.com>
References: <20200915075635.1112-1-yanfei.xu@windriver.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 15:56:35 +0800 <yanfei.xu@windriver.com> wrote:

> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> alloc_mask shouldn't inherit the current task's flags when
> __alloc_pages_nodemask is invoked in interrupt.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4889,7 +4889,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	 * from a particular context which has been marked by
>  	 * memalloc_no{fs,io}_{save,restore}.
>  	 */
> -	alloc_mask = current_gfp_context(gfp_mask);
> +	if (!in_interrupt())
> +		alloc_mask = current_gfp_context(gfp_mask);
>  	ac.spread_dirty_pages = false;
>  
>  	/*

hm, yes, and perhaps other callsites in page_alloc.c.

I assume this doesn't actually make any runtime difference?  Because
gfp_mask in interrupt contexts isn't going to have __GFP_IO or __GFP_FS
anyway.
