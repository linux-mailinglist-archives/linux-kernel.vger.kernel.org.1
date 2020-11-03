Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612B92A4F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgKCSxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgKCSxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:53:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3117C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:53:32 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c20so15043046pfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6wbMpMDbsPnNn1F4g2wW5/vG7RtDIz8QzbbN5We5DBc=;
        b=gpcWqTY3QAMN4XeftvhDgmWNBbCT68d9S2c6ljWhAwPMUUd6VT+gPS1pdh4O7CTWuM
         vAnw0c8r5yaHb73maBkVPeQU3QO7Nle7shZiYoA3eQKCULrNuzw8kEWn89Pz6Fp8aVtt
         /VqnuArj+7GOmuDoY+RkY++XGwQBboRw4uo+9YkCmqHjZg5e2HVnCWdTe8kNeofa9L8M
         oG3sfhYTYggz/IH85tClKRGF8HNz/oxJDef7YafSLGsIQ5j1IelRZ45xZSciN3yJmvSn
         3oLfT5HN0mqv/7GETGC4WT+fSL9VrYutq5Od80YVtxX/65FHYRzsDlR59jIw3d1LVH7s
         JDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6wbMpMDbsPnNn1F4g2wW5/vG7RtDIz8QzbbN5We5DBc=;
        b=SycYUYvMq/0rsLKRqzEM8pM299WPlC1wwqgdEBqTsA53pEoCebOhocucDo8IvOY0gO
         B1g6MrGgDRfzdGFUq1QOnNDn4TgkK6y9ri/jvUD+UTuk1e4J3FLfzfYf36dTm+gPjMy4
         3jEDsNJmyp7PTvuRmFfcUITTzm9IlnGpzZNiThhAItzAvAvZZOSuK1gekrCckzxH9ybi
         exH92gl4neyfaWFCOLyZDuB6YRIYo8c31baxvZd7AsuUL3cvKStdO/rFB+BYdYyUFIna
         YMKur59AXqvCuuoT9HnZ/s6SWjuGXpYo+GPpXywnxm72qMIj/tIZHNKtG3Q+seJhxA6O
         RCeQ==
X-Gm-Message-State: AOAM532Z5dzQJyz+RJ+3OhucnK7KKkNAHnwhiM11vQCrHDcavFzsSRFz
        GKsLqvvahn1APcv7mMkiJSoSlg==
X-Google-Smtp-Source: ABdhPJwsmhHY1aVzCHF78OlMwhf6QAXy9+zV7FjolLHkf/W38jn1YNn6JyV1YwqEBq04X8MqYTk+mQ==
X-Received: by 2002:a63:d245:: with SMTP id t5mr17291046pgi.283.1604429612029;
        Tue, 03 Nov 2020 10:53:32 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e184sm17930081pfe.146.2020.11.03.10.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:53:31 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:53:30 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>
cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Heesub Shin <heesub.shin@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Subject: Re: [cma] 1ea6c22c9b:
 page_allocation_failure:order:#,mode:#(__GFP_RECLAIMABLE),nodemask=(null)
In-Reply-To: <20201103053007.GQ31092@shao2-debian>
Message-ID: <alpine.DEB.2.23.453.2011031048350.237832@chino.kir.corp.google.com>
References: <20201103053007.GQ31092@shao2-debian>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020, kernel test robot wrote:

> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 1ea6c22c9b85ec176bb78d7076be06a4142f8bdd ("[PATCH 1/2] cma: redirect page allocation to CMA")
> url: https://github.com/0day-ci/linux/commits/Chris-Goldsworthy/Increasing-CMA-Utilization-with-a-GFP-Flag/20201102-224143
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +---------------------------------------------------------------------------+------------+------------+
> |                                                                           | 67b6d2ce11 | 1ea6c22c9b |
> +---------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                            | 6          | 0          |
> | boot_failures                                                             | 0          | 8          |
> | page_allocation_failure:order:#,mode:#(__GFP_RECLAIMABLE),nodemask=(null) | 0          | 8          |
> | Mem-Info                                                                  | 0          | 8          |
> | kernel_BUG_at_kernel/workqueue.c                                          | 0          | 8          |
> | invalid_opcode:#[##]                                                      | 0          | 8          |
> | EIP:workqueue_init_early                                                  | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception                                  | 0          | 8          |
> +---------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    2.108390] Memory: 8203240K/8388088K available (12819K kernel code, 6610K rwdata, 11292K rodata, 628K init, 12064K bss, 184848K reserved, 0K cma-reserved, 7481224K highmem)
> [    2.111999] Checking if this processor honours the WP bit even in supervisor mode...Ok.
> [    2.113918] random: get_random_u32 called from kmem_cache_open+0x1f/0x240 with crng_init=0
> [    2.114387] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    2.117656] Kernel/User page tables isolation: enabled
> [    2.119610] swapper: page allocation failure: order:0, mode:0x10(__GFP_RECLAIMABLE), nodemask=(null)
> [    2.121604] CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0-rc1-00365-g1ea6c22c9b85 #1
> [    2.123401] Call Trace:
> [    2.123990]  dump_stack+0x1b/0x1d
> [    2.124787]  warn_alloc+0x81/0xd9
> [    2.125599]  __alloc_pages_slowpath+0x79c/0x7a9
> [    2.126690]  ? get_page_from_freelist+0xb8/0x20d
> [    2.127750]  __alloc_pages_nodemask+0x107/0x188
> [    2.128795]  __alloc_pages_node+0x17/0x1c
> [    2.129757]  alloc_slab_page+0x26/0x4e
> [    2.130649]  allocate_slab+0x80/0x27e
> [    2.131521]  ___slab_alloc+0x247/0x2ec
> [    2.132605]  ? radix_tree_node_alloc+0x5e/0x8e
> [    2.133915]  ? validate_chain+0x5a8/0x5c3
> [    2.134838]  __slab_alloc+0x34/0x4d
> [    2.135830]  ? __slab_alloc+0x34/0x4d
> [    2.136909]  ? fs_reclaim_release+0x8/0x13
> [    2.137910]  kmem_cache_alloc+0x46/0x157
> [    2.138854]  ? radix_tree_node_alloc+0x5e/0x8e
> [    2.140103]  radix_tree_node_alloc+0x5e/0x8e
> [    2.141369]  idr_get_free+0xc1/0x21a
> [    2.142230]  idr_alloc_u32+0x4d/0x80
> [    2.143016]  idr_alloc+0x30/0x3e
> [    2.143751]  worker_pool_assign_id+0x37/0x47
> [    2.144682]  workqueue_init_early+0x9f/0x1f6
> [    2.145707]  start_kernel+0x206/0x467
> [    2.146592]  ? early_idt_handler_common+0x44/0x44
> [    2.147671]  i386_start_kernel+0x42/0x44
> [    2.148607]  startup_32_smp+0x164/0x168
> [    2.149567] Mem-Info:
> [    2.150101] active_anon:0 inactive_anon:0 isolated_anon:0
> [    2.150101]  active_file:0 inactive_file:0 isolated_file:0
> [    2.150101]  unevictable:0 dirty:0 writeback:0
> [    2.150101]  slab_reclaimable:0 slab_unreclaimable:88
> [    2.150101]  mapped:0 shmem:0 pagetables:0 bounce:0
> [    2.150101]  free:2050715 free_pcp:0 free_cma:0
> [    2.156588] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:0kB all_unreclaimable? no
> [    2.162313] Normal free:721636kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:906864kB managed:722016kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    2.162318] lowmem_reserve[]: 0 0 0
> [    2.169009] HighMem free:7481224kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:7481224kB managed:7481224kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    2.169014] lowmem_reserve[]: 0 0 0
> [    2.175914] Normal: 1*4kB (M) 2*8kB (M) 1*16kB (U) 2*32kB (UM) 2*64kB (M) 2*128kB (UM) 1*256kB (M) 0*512kB 2*1024kB (UM) 1*2048kB (M) 175*4096kB (M) = 721636kB
> [    2.179229] HighMem: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 1*128kB (M) 1*256kB (M) 1*512kB (M) 1*1024kB (M) 2*2048kB (M) 1825*4096kB (M) = 7481224kB
> [    2.182343] 0 total pagecache pages
> [    2.183068] 2097022 pages RAM
> [    2.183799] 1870306 pages HighMem/MovableOnly
> [    2.184853] 46212 pages reserved
> [    2.185675] 0 pages cma reserved

Normally what would happen for a __GFP_RECLAIMABLE allocation is that we'd 
grab one of the free order-10 MIGRATE_MOVABLE pageblocks and convert it to 
MIGRATE_RECLAIMABLE as fallback and then allocate the page from there.  
Looks like the commit is breaking the fallback logic since I see an 
abundance of free memory yet no MIGRATE_RECLAIMABLE pageblocks (which 
would show 'E' in these lines):

 Normal: 1*4kB (M) 2*8kB (M) 1*16kB (U) 2*32kB (UM) 2*64kB (M) 2*128kB (UM) 1*256kB (M) 0*512kB 2*1024kB (UM) 1*2048kB (M) 175*4096kB (M) = 721636kB
 HighMem: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 1*128kB (M) 1*256kB (M) 1*512kB (M) 1*1024kB (M) 2*2048kB (M) 1825*4096kB (M) = 7481224kB

I'm concerned about the change in general, however, because it seems like 
__GFP_CMA doesn't absolutely *have* to exist and we get code like this 
that will quickly become unmaintainable:

#ifdef CONFIG_CMA
#define ___GFP_CMA		0x800000u
#else
#define ___GFP_CMA		0
#endif
#ifdef CONFIG_LOCKDEP
#ifdef CONFIG_CMA
#define ___GFP_NOLOCKDEP	0x1000000u
#else
#define ___GFP_NOLOCKDEP	0x800000u
#endif

I suspect that Michal Hocko <mhocko@suse.com> may also have an opinion on 
this patch.
