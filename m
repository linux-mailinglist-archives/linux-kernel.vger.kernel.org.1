Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEC2F3F93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394562AbhALW2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:28:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731556AbhALW1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:27:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3C9923120;
        Tue, 12 Jan 2021 22:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610490432;
        bh=xxQ8MfqyAklnD0AulIQNNMFIA3u/PTYanCkpNaTjiYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pU67xGihUoOUdUglxIEJzItDAKZw0YIAbhe1AHc4leSkc/6MSGmkv58lLqZunhlXn
         PS7FupmFacuRuwH30+MHwSnvmGG+n0ouuipCw+mPFe6kSc51PAzAL//1E2M/nG8TTy
         1rNSX5qGFw+HkLTMJ40Nzl4Boknm7e5KZeg6F+cY=
Date:   Tue, 12 Jan 2021 14:27:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     <mgorman@techsingularity.net>, <aarcange@redhat.com>,
        <haiwang.fu@tcl.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <rientjes@google.com>, <tang.ding@tcl.com>,
        <vbabka@suse.cz>, <xiushui.ye@tcl.com>
Subject: Re: [PATCH] mm, compaction: move high_pfn to the for loop scope.
Message-Id: <20210112142711.b82cf36abaa7ff04773e212f@linux-foundation.org>
In-Reply-To: <20210112094720.1238444-1-wu-yan@tcl.com>
References: <20210112091041.GJ3592@techsingularity.net>
        <20210112094720.1238444-1-wu-yan@tcl.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 17:47:20 +0800 Rokudo Yan <wu-yan@tcl.com> wrote:

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
> Link: http://lkml.kernel.org/r/20190118175136.31341-12-mgorman@techsingularity.net
> Fixes: 5a811889de10f1eb ("mm, compaction: use free lists to quickly locate a migration target")

Could you please send a Signed-off-by: for this patch, as per
Documentation/process/submitting-patches.rst?
