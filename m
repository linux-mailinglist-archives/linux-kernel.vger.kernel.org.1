Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0731D1D82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 20:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgEMSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 14:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390079AbgEMSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:32:59 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4540020671;
        Wed, 13 May 2020 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589394778;
        bh=Qfxp4RkKifYwn+DnBDj1Wn+LE1G0Gl079k/dFlALe0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s4ru3/GKMct8lOhciaqKnieA8fhnb4v3LdxyKiCkzRLYN6P/1jGU+5NcS9gkBylKQ
         iRPU/O2e/goa+dLm6nHmT/1jtW0qGkleo598rUPDaccnevF5fXVzwP6SbgCuiAu9Rb
         e9Nx72ixY6btNYYs9R4u0xsNXkTTNGaPrmPbp3UQ=
Date:   Wed, 13 May 2020 11:32:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
Message-Id: <20200513113256.44ac9ce4c51a7ec1a5c5ba40@linux-foundation.org>
In-Reply-To: <158937872515.474360.5066096871639561424.stgit@buzz>
References: <158937872515.474360.5066096871639561424.stgit@buzz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 17:05:25 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Function isolate_migratepages_block() runs some checks out of lru_lock
> when choose pages for migration. After checking PageLRU() it checks extra
> page references by comparing page_count() and page_mapcount(). Between
> these two checks page could be removed from lru, freed and taken by slab.
> 
> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
> Race window is tiny. For certain workload this happens around once a year.
> 
> 
>  page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>  flags: 0x500000000008100(slab|head)
>  raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>  raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>  ------------[ cut here ]------------
>  kernel BUG at ./include/linux/mm.h:628!
>  invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>  Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>  RIP: 0010:isolate_migratepages_block+0x986/0x9b0
> 
> 
> To fix just opencode page_mapcount() in racy check for 0-order case and
> recheck carefully under lru_lock when page cannot escape from lru.
> 
> Also add checking extra references for file pages and swap cache.

It sounds like a cc:stable is appropriate?

> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		}
>  
>  		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> +		 * Migration will fail if an page is pinned in memory,
>  		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * admittedly racy check simplest case for 0-order pages.
> +		 *
> +		 * Open code page_mapcount() to avoid VM_BUG_ON(PageSlab(page)).
> +		 * Page could have extra reference from mapping or swap cache.
>  		 */
> -		if (!page_mapping(page) &&
> -		    page_count(page) > page_mapcount(page))
> +		if (!PageCompound(page) &&
> +		    page_count(page) > atomic_read(&page->_mapcount) + 1 +
> +				(!PageAnon(page) || PageSwapCache(page)))
>  			goto isolate_fail;
>  
>  		/*
> @@ -975,6 +979,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  				low_pfn += compound_nr(page) - 1;
>  				goto isolate_fail;
>  			}
> +
> +			/* Recheck page extra references under lock */
> +			if (page_count(page) > page_mapcount(page) +
> +				    (!PageAnon(page) || PageSwapCache(page)))
> +				goto isolate_fail;
>  		}
>  
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
