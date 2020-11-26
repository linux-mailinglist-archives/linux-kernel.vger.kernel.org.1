Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB152C59A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 17:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403854AbgKZQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 11:56:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391237AbgKZQ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:56:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1125ACE0;
        Thu, 26 Nov 2020 16:56:47 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm,thp,shmem: limit shmem THP alloc gfp_mask
To:     Rik van Riel <riel@surriel.com>, hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
References: <20201124194925.623931-1-riel@surriel.com>
 <20201124194925.623931-2-riel@surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <18cea0b2-1037-3276-1d42-2a4adcc129e4@suse.cz>
Date:   Thu, 26 Nov 2020 17:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124194925.623931-2-riel@surriel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 8:49 PM, Rik van Riel wrote:
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
> 
> Controlling the gfp_mask of THP allocations through the knobs in
> sysfs allows users to determine the balance between how aggressively
> the system tries to allocate THPs at fault time, and how much the
> application may end up stalling attempting those allocations.
> 
> This way a THP defrag setting of "never" or "defer+madvise" will result
> in quick allocation failures without direct reclaim when no 2MB free
> pages are available.
> 
> With this patch applied, THP allocations for tmpfs will be a little
> more aggressive than today for files mmapped with MADV_HUGEPAGE,
> and a little less aggressive for files that are not mmapped or
> mapped without that flag.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
