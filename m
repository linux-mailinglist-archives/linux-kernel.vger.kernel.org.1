Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13CC2AE354
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbgKJWYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKJWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:24:48 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0CCC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:24:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x13so157327pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ucd1v1fmt9Aox8XVlg3EWNREpeq3rzghILv47+FEoWM=;
        b=qd3Cs5Q4zD9FN0h/khO9RMtqTvfg7O6eyjCISpARPCPCATV4vG5DirNu9mAXW5I84T
         ULT+AtPvVcMU/ztiqOH4R+ZOId+bvaZsk2suw2frMQrRFT7ckqs0TnZOScxPI+BLlRXL
         0Qmteo1HURp5lnxLkyOcXCRc+PKeAjYZgkfHFQWzm0yBTOguVC0IHxG1lRibMCPZK3MM
         wcTZOTtdX4FUtQ4DRPRtzH7Qr31ClXjABBv3viqidQ2nUsPT5Ffqjq0Rzu8Cy2hnDaKa
         YbGF90LFH2p5PCY5hL0BEZG6Y1WsdS3azADHK1hAhCArGjL519/jJvnohdDkNvsEx6Zp
         oCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ucd1v1fmt9Aox8XVlg3EWNREpeq3rzghILv47+FEoWM=;
        b=nAGe84x8fzuCybIyCzY//yRpC+oZq0uBB6xI2BDOVKVS8idtTrE7XkN2OYcZRbVpVP
         5sbJuoRuT5k0cpM/CRPo5A9ksgIbUJvjOaes+bUFRjMql4MW9czmHwVh/tF3MTiFLVho
         FRkGVERuBayZPIYC32RIAK2ub8RMt9n16HwvSnvzJyMMbbjI0YLr+94W/gsuiTMCx/KA
         3HHucP/BbRpcinMQeHsiGu2/+NlYscHvJwCLem4vLkHfdFiK+074Vl2Zqu10xjDTR7lA
         AulehGuIeAe28/FO/DjHYC2Ijcx6sv1SW+NvPCIPdNysW6dfXgO/TdjU15mjRnK6k3Ii
         Wx/A==
X-Gm-Message-State: AOAM530NrLAeFyteBFQr0KEJWzNZuCa3IOllEGTfBS5C8LaEgwfBtJyR
        5I48iTFAm2Mv997Succ24qGVBjr+wsv1Xe2yUxjZLA==
X-Google-Smtp-Source: ABdhPJyZfDFXhwsd1+Iq7h8kSbUfCK+bJ881Ml71HNzH45UNvs62nV+pID0jjYxKPKW7LC2jzeu8XzAcQ9mqMhQqK5M=
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr349233pjz.136.1605047086391;
 Tue, 10 Nov 2020 14:24:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 10 Nov 2020 23:24:35 +0100
Message-ID: <CAAeHK+yz7219CWL_afRiJD10FHR5pC9roMz7_dxOq9feAhmKMw@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] kasan: boot parameters for hardware tag-based mode
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

On Tue, Nov 10, 2020 at 11:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
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

Can I get everyone's Ack on these boot parameters?

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
> https://github.com/xairy/linux/tree/up-boot-mte-v2
>
> and on Gerrit here:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3707
>
> This patchset is based on v9 of "kasan: add hardware tag-based mode for
> arm64" patchset [1].
>
> For testing in QEMU hardware tag-based KASAN requires:
>
> 1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
>    to run).
> 2. GCC version 10.
>
> [1] https://lkml.org/lkml/2020/11/10/1187
> [2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
> [3] https://arxiv.org/pdf/1802.09517.pdf
> [4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
> [5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
> [6] https://github.com/qemu/qemu
>
> === History
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
>  mm/kasan/hw_tags.c                | 183 ++++++++++++++++----
>  mm/kasan/kasan.h                  | 113 ++++++++----
>  mm/kasan/quarantine.c             |  13 +-
>  mm/kasan/report.c                 |  61 ++++---
>  mm/kasan/report_hw_tags.c         |   2 +-
>  mm/kasan/report_sw_tags.c         |  13 +-
>  mm/kasan/shadow.c                 |   5 +-
>  mm/kasan/sw_tags.c                |  17 +-
>  mm/mempool.c                      |   2 +-
>  mm/slab_common.c                  |  13 +-
>  19 files changed, 826 insertions(+), 366 deletions(-)
>
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
