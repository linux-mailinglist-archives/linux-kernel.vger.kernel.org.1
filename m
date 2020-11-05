Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAE92A8850
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgKEUtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgKEUtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:49:32 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479BAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:49:32 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id g15so2065644ybq.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2MIruyaauzWgJCQrDte1MB4IpvSBdXb3vNyeqYlOUw=;
        b=ESrF9IcKhtDw5DqW9rXJ+qkn5shjVlT4Cjig2bs8yPhkAcgiU+hrT6N/0OzyZU3yjv
         prDeyiV6SymdWZsuBfKqyBZ+YoBHntnyygI1Xpc/Tdx4FG8SuVO86FaSB6Qb8Ig7Kpne
         fBf4epGDxYzLfrHKgVyFbhjOmvz8kMAkKAfPsQC2amGWqF/sfjd25MNg2/E3T3HhfpGW
         YZ8e2wrs0MLvpR6+6Us0x1w5mgi5Lbonal2TaMg/b9+Y10oCoAfhLV3xSqbUyzSfwdro
         pkO3gT0mj1UmG8cGgi/quABuGHVYVPBRyghAKqSUzESdZxzYxqrO7xwTVqYiahlmCejk
         NDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2MIruyaauzWgJCQrDte1MB4IpvSBdXb3vNyeqYlOUw=;
        b=NKNLlADmYGX1WFXG08SqUp0o0nLgOEZw5OLkq1Jc+CvY61pBhL/5Cgu2zQ8QSYYHl6
         IKWwc+qxmDLXr0LDKpqzwRyM773ITH28019mGpWjFqGcaCsHFypf0HRi6qV81Y3wY4Ge
         wRAmnI3FuYIRlcHrFffgSi5of9udt2dDbvlxMdqA+edLxtxtUjEq+vvrJ139hxMmuSKL
         Vp4lHZ0IRGy2bpx5H8V63129I5UjTFRFDiJs21/v7zVVKbQlvIeHqIX5W4os3vu9sAXO
         TwOyQ3aar2sxnRolqb/Y+/iQ00gMp2ZW4R9DE3wflPOZbVRsWoX63wYbjtlpG9Oei9Yc
         4N6w==
X-Gm-Message-State: AOAM533ZLadtLHt7NRKzcqF71JMr/uENTpLLnYlqbQ/KgkSJ7yRPTf4a
        a7hEhn7nOxgoP7I2kqyfBadl5ZdCPUeIk2W7+3oY8Q==
X-Google-Smtp-Source: ABdhPJwj1u5XrkXlzejV/nLB6ICULh11m1WKsybtfXFuaX4uWtvjq3sryh36iSInHwlSA6XqM2CrV7QzFIbdZLO3w/c=
X-Received: by 2002:a25:b2a1:: with SMTP id k33mr6394582ybj.337.1604609371269;
 Thu, 05 Nov 2020 12:49:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Thu, 5 Nov 2020 12:49:19 -0800
Message-ID: <CAFKCwrgCfx_DBf_b0bJum5Y6w1hp_xzQ_xqgMe1OH2Kqw6qrxQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] kasan: boot parameters for hardware tag-based mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 4:02 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> === Overview
>
> Hardware tag-based KASAN mode [1] is intended to eventually be used in
> production as a security mitigation. Therefore there's a need for finer
> control over KASAN features and for an existence of a kill switch.
>
> This patchset adds a few boot parameters for hardware tag-based KASAN that
> allow to disable or otherwise control particular KASAN features.
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
> - kasan.stack=off/on - enable stacks collection
>                    (default: on for mode=full, otherwise off)

I think this was discussed before, but should this be kasan.stacktrace
or something like that?
In other places "kasan stack" refers to stack instrumentation, not
stack trace collection.
Ex.: CONFIG_KASAN_STACK

> - kasan.fault=report/panic - only report tag fault or also panic
>                          (default: report)
>
> If kasan.mode parameter is not provided, it defaults to full when
> CONFIG_DEBUG_KERNEL is enabled, and to prod otherwise.
>
> It is essential that switching between these modes doesn't require
> rebuilding the kernel with different configs, as this is required by
> the Android GKI (Generic Kernel Image) initiative.
>
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
> https://github.com/xairy/linux/tree/up-boot-mte-v1
>
> and on Gerrit here:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3707
>
> This patchset is based on v8 of "kasan: add hardware tag-based mode for
> arm64" patchset [1].
>
> For testing in QEMU hardware tag-based KASAN requires:
>
> 1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
>    to run).
> 2. GCC version 10.
>
> [1] https://lkml.org/lkml/2020/11/4/1208
> [2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
> [3] https://arxiv.org/pdf/1802.09517.pdf
> [4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
> [5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
> [6] https://github.com/qemu/qemu
>
> === History
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
> Andrey Konovalov (20):
>   kasan: simplify quarantine_put call site
>   kasan: rename get_alloc/free_info
>   kasan: introduce set_alloc_info
>   kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
>   kasan: allow VMAP_STACK for HW_TAGS mode
>   kasan: remove __kasan_unpoison_stack
>   kasan: inline kasan_reset_tag for tag-based modes
>   kasan: inline random_tag for HW_TAGS
>   kasan: inline kasan_poison_memory and check_invalid_free
>   kasan: inline and rename kasan_unpoison_memory
>   kasan: add and integrate kasan boot parameters
>   kasan, mm: check kasan_enabled in annotations
>   kasan: simplify kasan_poison_kfree
>   kasan, mm: rename kasan_poison_kfree
>   kasan: don't round_up too much
>   kasan: simplify assign_tag and set_tag calls
>   kasan: clarify comment in __kasan_kfree_large
>   kasan: clean up metadata allocation and usage
>   kasan, mm: allow cache merging with no metadata
>   kasan: update documentation
>
>  Documentation/dev-tools/kasan.rst | 180 ++++++++++++--------
>  arch/Kconfig                      |   8 +-
>  arch/arm64/kernel/sleep.S         |   2 +-
>  arch/x86/kernel/acpi/wakeup_64.S  |   2 +-
>  include/linux/kasan.h             | 253 +++++++++++++++++++++------
>  include/linux/mm.h                |  22 ++-
>  kernel/fork.c                     |   2 +-
>  mm/kasan/common.c                 | 274 ++++++++++++++++++------------
>  mm/kasan/generic.c                |  27 +--
>  mm/kasan/hw_tags.c                | 171 ++++++++++++++++---
>  mm/kasan/kasan.h                  | 113 ++++++++----
>  mm/kasan/quarantine.c             |  13 +-
>  mm/kasan/report.c                 |  61 ++++---
>  mm/kasan/report_hw_tags.c         |   2 +-
>  mm/kasan/report_sw_tags.c         |  13 +-
>  mm/kasan/shadow.c                 |   5 +-
>  mm/kasan/sw_tags.c                |  17 +-
>  mm/mempool.c                      |   2 +-
>  mm/slab_common.c                  |  13 +-
>  19 files changed, 816 insertions(+), 364 deletions(-)
>
> --
> 2.29.1.341.ge80a0c044ae-goog
>
