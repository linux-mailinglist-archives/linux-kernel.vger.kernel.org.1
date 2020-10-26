Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4435F29851A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 01:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420788AbgJZAOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 20:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1420781AbgJZAOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 20:14:12 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1637223BE;
        Mon, 26 Oct 2020 00:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603671251;
        bh=+XvynSj/JRwnS3CMFpuxWWK3dpmsjzmgNq1XtjZG5ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CVWf6PdOOaPZewJwUn4D2IdorViwmdjaXXRbM595VwSxU/GcAxuG5EynebUKWtDMu
         m81uokGUUg7SYkBT4bXKrWCXmvcNARvNcYbhEpkXdujZgL0nBxK9PHmmXesz8/2ixA
         ylGeyMgs5zPvAkXCq2DJL+VjrGIBuGtHlL7qnw3Y=
Date:   Sun, 25 Oct 2020 17:14:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: swap: Use memset to fill the swap_map with
 SWAP_HAS_CACHE
Message-Id: <20201025171411.20fce472df99bc43fce7156c@linux-foundation.org>
In-Reply-To: <20200921122224.7139-1-linmiaohe@huawei.com>
References: <20200921122224.7139-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 08:22:24 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:

> We could use helper memset to fill the swap_map with SWAP_HAS_CACHE instead
> of a direct loop here to simplify the code. Also we can remove the local
> variable i and map this way.
> 
> ...
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -975,8 +975,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>  {
>  	unsigned long idx;
>  	struct swap_cluster_info *ci;
> -	unsigned long offset, i;
> -	unsigned char *map;
> +	unsigned long offset;
>  
>  	/*
>  	 * Should not even be attempting cluster allocations when huge
> @@ -996,9 +995,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>  	alloc_cluster(si, idx);
>  	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
>  
> -	map = si->swap_map + offset;
> -	for (i = 0; i < SWAPFILE_CLUSTER; i++)
> -		map[i] = SWAP_HAS_CACHE;
> +	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>  	unlock_cluster(ci);
>  	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
>  	*slot = swp_entry(si->type, offset);

I suppose so.  But it does assume that the ->swapmap array has the type
char.  If we ever change that, breakage will ensue.

