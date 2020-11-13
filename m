Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB12B2872
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKMWUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgKMWUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:19 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDEBC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:15 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id x2so7551825qkd.23
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zDRs3jeCXygY+JyOeXMq20UgM8uSb4KrUxuaITbMOZY=;
        b=oYiPLvJu/XTU91AcaWzI+zIka8pJ4zOYISWQJm2YQEoBIQmUtZXE2p6vHwScRN0OD5
         OofDcM6yowxVd0Zk27aXD0pEIo7k/vSxmA1PC+su68Sw58gH1tol77Yylsu3pis7X7Gk
         JR9kYrASJYp2Ps20TIti0md6bEHoo5MEFlEpITwYKXhLAPF1mjstLz+FPFur0tqyhh64
         qorkXRZJ1RGjQROvGXtomZJ6hSN5s0pG/a/okB7wmjij1zJdCXvsXbIjvzzJtm7YCcJj
         xQBI/YdJsBsK2HIgkeMCv7G09dINwBL3r2PS/8f/+ry5/vLg+56RSaDX5iAAJr7/aakV
         GOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zDRs3jeCXygY+JyOeXMq20UgM8uSb4KrUxuaITbMOZY=;
        b=H/jgwMRX5X1W7OLLObnMN1RJGw05qf8RZdbM9MqGdyNIOHjU2W5v1jmUGQxm9ITaKy
         W/X3R523znnTwCA4++kPFYtBEoJVP4p0SAZpWbqhq1Sx+q/gHkgxNhvxbhbLSkwVgLZM
         OhzYbwqGM7r14/uVEAWbqX+JSKBY/9pc7YfTGssuCDVlN2cDrl9W8y87Xq+kr53pt1fr
         VWn/AvSX/wQR7tZZZz1Om6x66PKrS4WwsOoGA3y0lJ41IP2LPqMStKf0gGPaE3zKxf1d
         cIrvcRdlHZSf/1Ra+TI76C+xsQcThcYS4s8xfrDRq8Tf0I0SInMdpNNJ5rpFZBlt3Q38
         T8aQ==
X-Gm-Message-State: AOAM531kz+RHXYcgWUYfnmWwahyNbYt86youSNZL2JQuVqQoc2+ffHBJ
        GQXwL4agyuWP8i4/dH0eBfCZGJ785UjTlIDJ
X-Google-Smtp-Source: ABdhPJwrIM+NO9srgJ6VhONg2kxsAw0fuuOZOoAo2uh12jrGckt7gnSj8RF+3oP1HmsU3dXZ8vqmOgJjt7gvoqf8
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:fdcb:: with SMTP id
 g11mr4474180qvs.58.1605306014857; Fri, 13 Nov 2020 14:20:14 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:50 +0100
Message-Id: <cover.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 00/19] kasan: boot parameters for hardware tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
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
allow to disable or otherwise control particular KASAN features, as well
as provides some initial optimizations for running KASAN in production.

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

- kasan.stacktrace=off/on - enable stacks collection
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

https://github.com/xairy/linux/tree/up-boot-mte-v3

This patchset is based on v10 of "kasan: add hardware tag-based mode for
arm64" patchset [1].

For testing in QEMU hardware tag-based KASAN requires:

1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
   to run).
2. GCC version 10.

[1] https://lkml.org/lkml/2020/11/13/1154
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] https://arxiv.org/pdf/1802.09517.pdf
[4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
[5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
[6] https://github.com/qemu/qemu

=== History

Changes v2 -> v3:
- Rebase onto v10 of the HW_TAGS series.
- Add missing return type for kasan_enabled().
- Always define random_tag() as a function.
- Mark kasan wrappers as __always_inline.
- Don't "kasan: simplify kasan_poison_kfree" as it's based on a false
  assumption, add a comment instead.
- Address documentation comments.
- Use <linux/static_key.h> instead of <linux/jump_label.h>.
- Rework switches in mm/kasan/hw_tags.c.
- Don't init tag in ____kasan_kmalloc().
- Correctly check SLAB_TYPESAFE_BY_RCU flag in mm/kasan/common.c.
- Readability fixes for "kasan: clean up metadata allocation and usage".
- Change kasan_never_merge() to return SLAB_KASAN instead of excluding it
  from flags.
- (Vincenzo) Address concerns from checkpatch.pl (courtesy of Marco Elver).

Changes v1 -> v2:
- Rebased onto v9 of the HW_TAGS patchset.
- Don't initialize static branches in kasan_init_hw_tags_cpu(), as
  cpu_enable_mte() can't sleep; do in in kasan_init_hw_tags() instead.
- Rename kasan.stacks to kasan.stacktrace.

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

Andrey Konovalov (19):
  kasan: simplify quarantine_put call site
  kasan: rename get_alloc/free_info
  kasan: introduce set_alloc_info
  kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
  kasan: allow VMAP_STACK for HW_TAGS mode
  kasan: remove __kasan_unpoison_stack
  kasan: inline kasan_reset_tag for tag-based modes
  kasan: inline random_tag for HW_TAGS
  kasan: open-code kasan_unpoison_slab
  kasan: inline (un)poison_range and check_invalid_free
  kasan: add and integrate kasan boot parameters
  kasan, mm: check kasan_enabled in annotations
  kasan, mm: rename kasan_poison_kfree
  kasan: don't round_up too much
  kasan: simplify assign_tag and set_tag calls
  kasan: clarify comment in __kasan_kfree_large
  kasan: clean up metadata allocation and usage
  kasan, mm: allow cache merging with no metadata
  kasan: update documentation

 Documentation/dev-tools/kasan.rst | 186 ++++++++++++--------
 arch/Kconfig                      |   8 +-
 arch/arm64/kernel/sleep.S         |   2 +-
 arch/x86/kernel/acpi/wakeup_64.S  |   2 +-
 include/linux/kasan.h             | 245 ++++++++++++++++++++------
 include/linux/mm.h                |  22 ++-
 mm/kasan/common.c                 | 283 ++++++++++++++++++------------
 mm/kasan/generic.c                |  27 +--
 mm/kasan/hw_tags.c                | 185 +++++++++++++++----
 mm/kasan/kasan.h                  | 120 +++++++++----
 mm/kasan/quarantine.c             |  13 +-
 mm/kasan/report.c                 |  61 ++++---
 mm/kasan/report_hw_tags.c         |   2 +-
 mm/kasan/report_sw_tags.c         |  15 +-
 mm/kasan/shadow.c                 |   5 +-
 mm/kasan/sw_tags.c                |  17 +-
 mm/mempool.c                      |   4 +-
 mm/slab_common.c                  |   3 +-
 18 files changed, 824 insertions(+), 376 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

