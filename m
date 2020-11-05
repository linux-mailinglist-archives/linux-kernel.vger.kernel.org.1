Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5F2A736A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbgKEACi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgKEACi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:38 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FBDC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:36 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id g12so117284qtc.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WSUBpnn+b8BH+LyGrDbHds9kTTIXmq8ZO4c/IH1ztE8=;
        b=tlosH7TYK549pHThXItN057SkhxAVtEmov60aTPXGGcxAQr+jBG2/9HWQQnVDHj7Lq
         I4rcwA92bbYaRi3LrrRj+r6cVPe1BLbMsnuLNxAqDQxgzofveZawQvgUZw1DV2v7qcGI
         C90TZE7jzRgAsnaJjj27SFbDu4SZSgMRbUoVxGlWD56qLEkTuH/ygfTexaNk2vv908bz
         UXJWwyqLCXV88Hc4JwZaIupPoEZRKKimXcqhaqA3vIwXzrNRUhH2glnY5hUGmB5bxRxZ
         gRVrHL3CRgV7XMXuYEsAhbcOYyAqqishtjGPg2q1+iGswsioyPqkoH85wGyc916RPirO
         F38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WSUBpnn+b8BH+LyGrDbHds9kTTIXmq8ZO4c/IH1ztE8=;
        b=BNmU1iE5PcK7+qJ3y/0DZ+BJ6T7iw1JIeoOC9aEXt/bVr4oBEUs7NUTi8sZzdcKmxN
         tTsgT1QZVs9gT5Efd+/oEx/dIZlYsdzunXtWaLaKuQE+nSonkX7G8i8saUaCJU62N+W5
         ish2jTLAsOd3vEse07yusuQ5gafOXZ8mIQpiISytoRxqMNJwMtmf00a2FQCjm5xH4Qgp
         X57pzFCxrEfQ7GcB6IbAEm4ylqFeYxozmFK/1prx9+bh9SRk3yLXGYd5bIV6zWWfj8u1
         h4/2UShhXjW/wM8ijxOdJLSp79MyDM/jGYQdJXa0moeURlHyZS+ke+OYUkWunRCswpyT
         MpJg==
X-Gm-Message-State: AOAM533DbqNpYFgaLVPkfuH7lDMTtS2RMwxvnAHSVeFQM5mBtLL7DxCb
        PegN/lmJV6d+iQxVMsu97slat1lbkqO/MUEk
X-Google-Smtp-Source: ABdhPJxM0Ooa/cktu8AEqoiwTREH3YYQ4nXnZhGizgrguujs+ZY0sca5P3O6TuibSvdClNd1q1Fa2i69iA8RvCzE
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c187:: with SMTP id
 n7mr286302qvh.19.1604534555430; Wed, 04 Nov 2020 16:02:35 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:10 +0100
Message-Id: <cover.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 00/20] kasan: boot parameters for hardware tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=== Overview

Hardware tag-based KASAN mode [1] is intended to eventually be used in
production as a security mitigation. Therefore there's a need for finer
control over KASAN features and for an existence of a kill switch.

This patchset adds a few boot parameters for hardware tag-based KASAN that
allow to disable or otherwise control particular KASAN features.

There's another planned patchset what will further optimize hardware
tag-based KASAN, provide proper benchmarking and tests, and will fully
enable tag-based KASAN for production use.

Hardware tag-based KASAN relies on arm64 Memory Tagging Extension (MTE)
[2] to perform memory and pointer tagging. Please see [3] and [4] for
detailed analysis of how MTE helps to fight memory safety problems.

The features that can be controlled are:

1. Whether KASAN is enabled at all.
2. Whether KASAN collects and saves alloc/free stacks.
3. Whether KASAN panics on a detected bug or not.

The patch titled "kasan: add and integrate kasan boot parameters" of this
series adds a few new boot parameters.

kasan.mode allows to choose one of three main modes:

- kasan.mode=off - KASAN is disabled, no tag checks are performed
- kasan.mode=prod - only essential production features are enabled
- kasan.mode=full - all KASAN features are enabled

The chosen mode provides default control values for the features mentioned
above. However it's also possible to override the default values by
providing:

- kasan.stack=off/on - enable stacks collection
                   (default: on for mode=full, otherwise off)
- kasan.fault=report/panic - only report tag fault or also panic
                         (default: report)

If kasan.mode parameter is not provided, it defaults to full when
CONFIG_DEBUG_KERNEL is enabled, and to prod otherwise.

It is essential that switching between these modes doesn't require
rebuilding the kernel with different configs, as this is required by
the Android GKI (Generic Kernel Image) initiative.

=== Benchmarks

For now I've only performed a few simple benchmarks such as measuring
kernel boot time and slab memory usage after boot. There's an upcoming
patchset which will optimize KASAN further and include more detailed
benchmarking results.

The benchmarks were performed in QEMU and the results below exclude the
slowdown caused by QEMU memory tagging emulation (as it's different from
the slowdown that will be introduced by hardware and is therefore
irrelevant).

KASAN_HW_TAGS=y + kasan.mode=off introduces no performance or memory
impact compared to KASAN_HW_TAGS=n.

kasan.mode=prod (manually excluding tagging) introduces 3% of performance
and no memory impact (except memory used by hardware to store tags)
compared to kasan.mode=off.

kasan.mode=full has about 40% performance and 30% memory impact over
kasan.mode=prod. Both come from alloc/free stack collection.

=== Notes

This patchset is available here:

https://github.com/xairy/linux/tree/up-boot-mte-v1

and on Gerrit here:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3707

This patchset is based on v8 of "kasan: add hardware tag-based mode for
arm64" patchset [1].

For testing in QEMU hardware tag-based KASAN requires:

1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
   to run).
2. GCC version 10.

[1] https://lkml.org/lkml/2020/11/4/1208
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] https://arxiv.org/pdf/1802.09517.pdf
[4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
[5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
[6] https://github.com/qemu/qemu

=== History

Changes RFC v2 -> v1:
- Rebrand the patchset from fully enabling production use to partially
  addressing that; another optimization and testing patchset will be
  required.
- Rebase onto v8 of KASAN_HW_TAGS series.
- Fix "ASYNC" -> "async" typo.
- Rework depends condition for VMAP_STACK and update config text.
- Remove unneeded reset_tag() macro, use kasan_reset_tag() instead.
- Rename kasan.stack to kasan.stacks to avoid confusion with stack
  instrumentation.
- Introduce kasan_stack_collection_enabled() and kasan_is_enabled()
  helpers.
- Simplify kasan_stack_collection_enabled() usage.
- Rework SLAB_KASAN flag and metadata allocation (see the corresponding
  patch for details).
- Allow cache merging with KASAN_HW_TAGS when kasan.stacks is off.
- Use sync mode dy default for both prod and full KASAN modes.
- Drop kasan.trap=sync/async boot parameter, as async mode isn't supported
  yet.
- Choose prod or full mode depending on CONFIG_DEBUG_KERNEL when no
  kasan.mode boot parameter is provided.
- Drop krealloc optimization changes, those will be included in a separate
  patchset.
- Update KASAN documentation to mention boot parameters.

Changes RFC v1 -> RFC v2:
- Rework boot parameters.
- Drop __init from empty kasan_init_tags() definition.
- Add cpu_supports_mte() helper that can be used during early boot and use
  it in kasan_init_tags()
- Lots of new KASAN optimization commits.

Andrey Konovalov (20):
  kasan: simplify quarantine_put call site
  kasan: rename get_alloc/free_info
  kasan: introduce set_alloc_info
  kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
  kasan: allow VMAP_STACK for HW_TAGS mode
  kasan: remove __kasan_unpoison_stack
  kasan: inline kasan_reset_tag for tag-based modes
  kasan: inline random_tag for HW_TAGS
  kasan: inline kasan_poison_memory and check_invalid_free
  kasan: inline and rename kasan_unpoison_memory
  kasan: add and integrate kasan boot parameters
  kasan, mm: check kasan_enabled in annotations
  kasan: simplify kasan_poison_kfree
  kasan, mm: rename kasan_poison_kfree
  kasan: don't round_up too much
  kasan: simplify assign_tag and set_tag calls
  kasan: clarify comment in __kasan_kfree_large
  kasan: clean up metadata allocation and usage
  kasan, mm: allow cache merging with no metadata
  kasan: update documentation

 Documentation/dev-tools/kasan.rst | 180 ++++++++++++--------
 arch/Kconfig                      |   8 +-
 arch/arm64/kernel/sleep.S         |   2 +-
 arch/x86/kernel/acpi/wakeup_64.S  |   2 +-
 include/linux/kasan.h             | 253 +++++++++++++++++++++------
 include/linux/mm.h                |  22 ++-
 kernel/fork.c                     |   2 +-
 mm/kasan/common.c                 | 274 ++++++++++++++++++------------
 mm/kasan/generic.c                |  27 +--
 mm/kasan/hw_tags.c                | 171 ++++++++++++++++---
 mm/kasan/kasan.h                  | 113 ++++++++----
 mm/kasan/quarantine.c             |  13 +-
 mm/kasan/report.c                 |  61 ++++---
 mm/kasan/report_hw_tags.c         |   2 +-
 mm/kasan/report_sw_tags.c         |  13 +-
 mm/kasan/shadow.c                 |   5 +-
 mm/kasan/sw_tags.c                |  17 +-
 mm/mempool.c                      |   2 +-
 mm/slab_common.c                  |  13 +-
 19 files changed, 816 insertions(+), 364 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

