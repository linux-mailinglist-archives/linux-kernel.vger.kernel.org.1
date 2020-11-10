Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544882AE321
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbgKJWUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKJWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:31 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08698C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:29 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id z9so53256qvo.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=b8CotiQpp+bxdSd+En1KItJC9YbOfc1UzHfr7o3MXho=;
        b=TE1cjQylaz7WVbUR98IXpWOPPBBq4Qh8MmY97tCmFN9DBLoGUK3rx2kCW2RbccouWS
         cPAaPT633Jvi4lklMFpafl1VEmSgHCmQVQEG6lyYG82mFV6LGW7jPBFpmYx/Qm1EQAMF
         Alc3pfPoOvzUwTw7LFriUG7lb64ONVUjW1q67IcXsuiZKCG2AJKTJJYMdT9gsijqdQ+Y
         nHXx8RW74n2kVk6kLzuy++6vCEJ2zVE6y59tulRalVlLceEKWckK6Z+7C93bVSL7zCiI
         bofFftiLpykGr9yfFdNRdOGXcJ4hlU9gSa7FsqsPXKOqCT1aEaaI8nbODPNf6TbXq9Zg
         RNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=b8CotiQpp+bxdSd+En1KItJC9YbOfc1UzHfr7o3MXho=;
        b=Uo9/oQsokVhvUC1Bt3B4HsLBE+JHX1I6bZDuFTmWlqLkjKLg8bdgBbbVYfY99WJo9z
         TRev86Zc82UyvuCZDgEaF459YPjJ+DGHr/+SiZMFEP0e8HD2pz6cfgdLxP1/32LyiLTu
         iar3hcr4oQrz6kUans6vajrKpCKho9aDGNOH97mf7a6gzgmgbe1HHHpBDWIwrV40lqT0
         At+Z6YV8CYlFRt07pec9J6DoSoquxVfjYIa/iC2CJLtWN1luzudvbmL1AWX8Xykwq5wq
         iQU81byGc/kV9kpHJsxqA9TdwtVljdSCyvRR9LHLoVqcikTw31qAKTA7i4KY1UPqmzFw
         TbHQ==
X-Gm-Message-State: AOAM533LA6kWFYSu6GN8+VI9ylnY2DbJNmgLX14LGUWkJrQWJ9IuBdI1
        JizsVf4l2Vm/W6xekTkQuWhbfMCF48aS3Kfz
X-Google-Smtp-Source: ABdhPJynNxxNYoTQdR7OhXYoNUqGyoTK2jWTZjYmRunbHScSbVa5DLzZdzztAMft98mFzrfUJUbAZtpb2IXDN7Ne
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:548b:: with SMTP id
 q11mr21256172qvy.44.1605046829085; Tue, 10 Nov 2020 14:20:29 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:04 +0100
Message-Id: <cover.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 00/20] kasan: boot parameters for hardware tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

https://github.com/xairy/linux/tree/up-boot-mte-v2

and on Gerrit here:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3707

This patchset is based on v9 of "kasan: add hardware tag-based mode for
arm64" patchset [1].

For testing in QEMU hardware tag-based KASAN requires:

1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
   to run).
2. GCC version 10.

[1] https://lkml.org/lkml/2020/11/10/1187
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] https://arxiv.org/pdf/1802.09517.pdf
[4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
[5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
[6] https://github.com/qemu/qemu

=== History

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
 mm/kasan/hw_tags.c                | 183 ++++++++++++++++----
 mm/kasan/kasan.h                  | 113 ++++++++----
 mm/kasan/quarantine.c             |  13 +-
 mm/kasan/report.c                 |  61 ++++---
 mm/kasan/report_hw_tags.c         |   2 +-
 mm/kasan/report_sw_tags.c         |  13 +-
 mm/kasan/shadow.c                 |   5 +-
 mm/kasan/sw_tags.c                |  17 +-
 mm/mempool.c                      |   2 +-
 mm/slab_common.c                  |  13 +-
 19 files changed, 826 insertions(+), 366 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8-goog

