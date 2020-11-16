Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3752B461C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKPOpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:45:05 -0500
Received: from foss.arm.com ([217.140.110.172]:40702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgKPOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:45:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC84031B;
        Mon, 16 Nov 2020 06:45:03 -0800 (PST)
Received: from [10.37.12.42] (unknown [10.37.12.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84C973F718;
        Mon, 16 Nov 2020 06:45:01 -0800 (PST)
Subject: Re: [PATCH mm v3 00/19] kasan: boot parameters for hardware tag-based
 mode
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1605305978.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fd7ab51e-269b-fffc-f504-7f3af862c914@arm.com>
Date:   Mon, 16 Nov 2020 14:48:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 10:19 PM, Andrey Konovalov wrote:
> === Overview
> 
> Hardware tag-based KASAN mode [1] is intended to eventually be used in
> production as a security mitigation. Therefore there's a need for finer
> control over KASAN features and for an existence of a kill switch.
> 
> This patchset adds a few boot parameters for hardware tag-based KASAN that
> allow to disable or otherwise control particular KASAN features, as well
> as provides some initial optimizations for running KASAN in production.
> 
> There's another planned patchset what will further optimize hardware
> tag-based KASAN, provide proper benchmarking and tests, and will fully
> enable tag-based KASAN for production use.
> 
> Hardware tag-based KASAN relies on arm64 Memory Tagging Extension (MTE)
> [2] to perform memory and pointer tagging. Please see [3] and [4] for
> detailed analysis of how MTE helps to fight memory safety problems.
> 
> The features that can be controlled are:
> 
> 1. Whether KASAN is enabled at all.
> 2. Whether KASAN collects and saves alloc/free stacks.
> 3. Whether KASAN panics on a detected bug or not.
> 
> The patch titled "kasan: add and integrate kasan boot parameters" of this
> series adds a few new boot parameters.
> 
> kasan.mode allows to choose one of three main modes:
> 
> - kasan.mode=off - KASAN is disabled, no tag checks are performed
> - kasan.mode=prod - only essential production features are enabled
> - kasan.mode=full - all KASAN features are enabled
> 
> The chosen mode provides default control values for the features mentioned
> above. However it's also possible to override the default values by
> providing:
> 
> - kasan.stacktrace=off/on - enable stacks collection
>                             (default: on for mode=full, otherwise off)
> - kasan.fault=report/panic - only report tag fault or also panic
>                              (default: report)
> 
> If kasan.mode parameter is not provided, it defaults to full when
> CONFIG_DEBUG_KERNEL is enabled, and to prod otherwise.
> 
> It is essential that switching between these modes doesn't require
> rebuilding the kernel with different configs, as this is required by
> the Android GKI (Generic Kernel Image) initiative.
> 

Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> === Benchmarks
> 
> For now I've only performed a few simple benchmarks such as measuring
> kernel boot time and slab memory usage after boot. There's an upcoming
> patchset which will optimize KASAN further and include more detailed
> benchmarking results.
> 
> The benchmarks were performed in QEMU and the results below exclude the
> slowdown caused by QEMU memory tagging emulation (as it's different from
> the slowdown that will be introduced by hardware and is therefore
> irrelevant).
> 
> KASAN_HW_TAGS=y + kasan.mode=off introduces no performance or memory
> impact compared to KASAN_HW_TAGS=n.
> 
> kasan.mode=prod (manually excluding tagging) introduces 3% of performance
> and no memory impact (except memory used by hardware to store tags)
> compared to kasan.mode=off.
> 
> kasan.mode=full has about 40% performance and 30% memory impact over
> kasan.mode=prod. Both come from alloc/free stack collection.
> 
> === Notes
> 
> This patchset is available here:
> 
> https://github.com/xairy/linux/tree/up-boot-mte-v3
> 
> This patchset is based on v10 of "kasan: add hardware tag-based mode for
> arm64" patchset [1].
> 
> For testing in QEMU hardware tag-based KASAN requires:
> 
> 1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
>    to run).
> 2. GCC version 10.
> 
> [1] https://lkml.org/lkml/2020/11/13/1154
> [2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
> [3] https://arxiv.org/pdf/1802.09517.pdf
> [4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
> [5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
> [6] https://github.com/qemu/qemu
> 
> === History
> 
> Changes v2 -> v3:
> - Rebase onto v10 of the HW_TAGS series.
> - Add missing return type for kasan_enabled().
> - Always define random_tag() as a function.
> - Mark kasan wrappers as __always_inline.
> - Don't "kasan: simplify kasan_poison_kfree" as it's based on a false
>   assumption, add a comment instead.
> - Address documentation comments.
> - Use <linux/static_key.h> instead of <linux/jump_label.h>.
> - Rework switches in mm/kasan/hw_tags.c.
> - Don't init tag in ____kasan_kmalloc().
> - Correctly check SLAB_TYPESAFE_BY_RCU flag in mm/kasan/common.c.
> - Readability fixes for "kasan: clean up metadata allocation and usage".
> - Change kasan_never_merge() to return SLAB_KASAN instead of excluding it
>   from flags.
> - (Vincenzo) Address concerns from checkpatch.pl (courtesy of Marco Elver).
> 
> Changes v1 -> v2:
> - Rebased onto v9 of the HW_TAGS patchset.
> - Don't initialize static branches in kasan_init_hw_tags_cpu(), as
>   cpu_enable_mte() can't sleep; do in in kasan_init_hw_tags() instead.
> - Rename kasan.stacks to kasan.stacktrace.
> 
> Changes RFC v2 -> v1:
> - Rebrand the patchset from fully enabling production use to partially
>   addressing that; another optimization and testing patchset will be
>   required.
> - Rebase onto v8 of KASAN_HW_TAGS series.
> - Fix "ASYNC" -> "async" typo.
> - Rework depends condition for VMAP_STACK and update config text.
> - Remove unneeded reset_tag() macro, use kasan_reset_tag() instead.
> - Rename kasan.stack to kasan.stacks to avoid confusion with stack
>   instrumentation.
> - Introduce kasan_stack_collection_enabled() and kasan_is_enabled()
>   helpers.
> - Simplify kasan_stack_collection_enabled() usage.
> - Rework SLAB_KASAN flag and metadata allocation (see the corresponding
>   patch for details).
> - Allow cache merging with KASAN_HW_TAGS when kasan.stacks is off.
> - Use sync mode dy default for both prod and full KASAN modes.
> - Drop kasan.trap=sync/async boot parameter, as async mode isn't supported
>   yet.
> - Choose prod or full mode depending on CONFIG_DEBUG_KERNEL when no
>   kasan.mode boot parameter is provided.
> - Drop krealloc optimization changes, those will be included in a separate
>   patchset.
> - Update KASAN documentation to mention boot parameters.
> 
> Changes RFC v1 -> RFC v2:
> - Rework boot parameters.
> - Drop __init from empty kasan_init_tags() definition.
> - Add cpu_supports_mte() helper that can be used during early boot and use
>   it in kasan_init_tags()
> - Lots of new KASAN optimization commits.
> 
> Andrey Konovalov (19):
>   kasan: simplify quarantine_put call site
>   kasan: rename get_alloc/free_info
>   kasan: introduce set_alloc_info
>   kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
>   kasan: allow VMAP_STACK for HW_TAGS mode
>   kasan: remove __kasan_unpoison_stack
>   kasan: inline kasan_reset_tag for tag-based modes
>   kasan: inline random_tag for HW_TAGS
>   kasan: open-code kasan_unpoison_slab
>   kasan: inline (un)poison_range and check_invalid_free
>   kasan: add and integrate kasan boot parameters
>   kasan, mm: check kasan_enabled in annotations
>   kasan, mm: rename kasan_poison_kfree
>   kasan: don't round_up too much
>   kasan: simplify assign_tag and set_tag calls
>   kasan: clarify comment in __kasan_kfree_large
>   kasan: clean up metadata allocation and usage
>   kasan, mm: allow cache merging with no metadata
>   kasan: update documentation
> 
>  Documentation/dev-tools/kasan.rst | 186 ++++++++++++--------
>  arch/Kconfig                      |   8 +-
>  arch/arm64/kernel/sleep.S         |   2 +-
>  arch/x86/kernel/acpi/wakeup_64.S  |   2 +-
>  include/linux/kasan.h             | 245 ++++++++++++++++++++------
>  include/linux/mm.h                |  22 ++-
>  mm/kasan/common.c                 | 283 ++++++++++++++++++------------
>  mm/kasan/generic.c                |  27 +--
>  mm/kasan/hw_tags.c                | 185 +++++++++++++++----
>  mm/kasan/kasan.h                  | 120 +++++++++----
>  mm/kasan/quarantine.c             |  13 +-
>  mm/kasan/report.c                 |  61 ++++---
>  mm/kasan/report_hw_tags.c         |   2 +-
>  mm/kasan/report_sw_tags.c         |  15 +-
>  mm/kasan/shadow.c                 |   5 +-
>  mm/kasan/sw_tags.c                |  17 +-
>  mm/mempool.c                      |   4 +-
>  mm/slab_common.c                  |   3 +-
>  18 files changed, 824 insertions(+), 376 deletions(-)
> 

-- 
Regards,
Vincenzo
