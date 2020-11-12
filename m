Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC12E2B032E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgKLKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:53:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:57878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKLKxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:53:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605178380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q92i3jNFlDey2zfzOmaWmIpJgWWQB2STitndo/BWuxQ=;
        b=rHTa/6kuqazJebjOzKki+k8mtd8HRIuwA5B+WZy0sAyq74Ed5hTyfGkAuPT4xhnHZkYN3u
        O1MIePLOj8AicNhgmrF5ufCHzV2gmDwWt5WaNmjipXGsiCeLlBiNvsHmxKgcP/8heR2Io7
        qOm9xya+v5yrOEs+z/YsUGlmWejMy4M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC631AF21;
        Thu, 12 Nov 2020 10:52:59 +0000 (UTC)
Date:   Thu, 12 Nov 2020 11:52:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Subject: Re: [PATCH 1/2] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201112105258.GZ12240@dhcp22.suse.cz>
References: <20201105191508.1961686-1-riel@surriel.com>
 <20201105191508.1961686-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105191508.1961686-2-riel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-11-20 14:15:07, Rik van Riel wrote:
> The allocation flags of anonymous transparent huge pages can be controlled
> through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
> help the system from getting bogged down in the page reclaim and compaction
> code when many THPs are getting allocated simultaneously.
> 
> However, the gfp_mask for shmem THP allocations were not limited by those
> configuration settings, and some workloads ended up with all CPUs stuck
> on the LRU lock in the page reclaim code, trying to allocate dozens of
> THPs simultaneously.
> 
> This patch applies the same configurated limitation of THPs to shmem
> hugepage allocations, to prevent that from happening.

I believe you should also exaplain why we want to control defrag by the
global knob while the enable logic is per mount.

> This way a THP defrag setting of "never" or "defer+madvise" will result
> in quick allocation failures without direct reclaim when no 2MB free
> pages are available.
> 
> With this patch applied, THP allocations for tmpfs will be a little
> more aggressive than today for files mmapped with MADV_HUGEPAGE,
> and a little less aggressive for files that are not mmapped or
> mapped without that flag.

This begs some numbers. A little is rather bad unit of performance. I do
agree that unifying those makes sense in general though.

> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/gfp.h | 2 ++
>  mm/huge_memory.c    | 6 +++---
>  mm/shmem.c          | 8 +++++---
>  3 files changed, 10 insertions(+), 6 deletions(-)
-- 
Michal Hocko
SUSE Labs
