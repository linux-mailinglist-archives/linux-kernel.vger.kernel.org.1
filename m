Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4114D2F9C96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbhARJvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:51:20 -0500
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:40527 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389070AbhARJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:43:12 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 76CFFFBF03
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:42:19 +0000 (GMT)
Received: (qmail 26312 invoked from network); 18 Jan 2021 09:42:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2021 09:42:19 -0000
Date:   Mon, 18 Jan 2021 09:42:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com, haiwang.fu@tcl.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com, tang.ding@tcl.com, vbabka@suse.cz,
        xiushui.ye@tcl.com
Subject: Re: [PATCH] mm, compaction: move high_pfn to the for loop scope.
Message-ID: <20210118094217.GQ3592@techsingularity.net>
References: <20210112142711.b82cf36abaa7ff04773e212f@linux-foundation.org>
 <20210118074126.1838139-1-wu-yan@tcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210118074126.1838139-1-wu-yan@tcl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:41:26PM +0800, Rokudo Yan wrote:
> In fast_isolate_freepages, high_pfn will be used if a prefered one(PFN >= low_fn) not found. But the high_pfn
> is not reset before searching an free area, so when it was used as freepage, it may from another free area searched before.
> And move_freelist_head(freelist, freepage) will have unexpected behavior(eg. corrupt the MOVABLE freelist)
> 
> Unable to handle kernel paging request at virtual address dead000000000200
> Mem abort info:
>   ESR = 0x96000044
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000044
>   CM = 0, WnR = 1
> [dead000000000200] address between user and kernel address ranges
> 
> -000|list_cut_before(inline)
> -000|move_freelist_head(inline)
> -000|fast_isolate_freepages(inline)
> -000|isolate_freepages(inline)
> -000|compaction_alloc(?, ?)
> -001|unmap_and_move(inline)
> -001|migrate_pages([NSD:0xFFFFFF80088CBBD0] from = 0xFFFFFF80088CBD88, [NSD:0xFFFFFF80088CBBC8] get_new_p
> -002|__read_once_size(inline)
> -002|static_key_count(inline)
> -002|static_key_false(inline)
> -002|trace_mm_compaction_migratepages(inline)
> -002|compact_zone(?, [NSD:0xFFFFFF80088CBCB0] capc = 0x0)
> -003|kcompactd_do_work(inline)
> -003|kcompactd([X19] p = 0xFFFFFF93227FBC40)
> -004|kthread([X20] _create = 0xFFFFFFE1AFB26380)
> -005|ret_from_fork(asm)
> ---|end of frame
> 
> The issue was reported on an smart phone product with 6GB ram and 3GB zram as swap device.
> 
> This patch fixes the issue by reset high_pfn before searching each free area, which ensure
> freepage and freelist match when call move_freelist_head in fast_isolate_freepages().
> 
> Fixes: 5a811889de10f1eb ("mm, compaction: use free lists to quickly locate a migration target")
> 
> Signed-off-by: Rokudo Yan <wu-yan@tcl.com>

Other than a fixes line, I do not think this changed so my previous Ack
still applies

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
