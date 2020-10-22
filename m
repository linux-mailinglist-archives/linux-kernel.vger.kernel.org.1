Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CED295FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899498AbgJVNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899490AbgJVNT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:27 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:25 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id b17so644518ejb.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=gP40pqOrjsRuGDtDL77O5g/LDtgANLIwrEsf6Di4U2Q=;
        b=no5WMYSS4DXICHO7tqynwf3XdAj1MN4/xY09kXfVDaHV+63950L1AyRK4p2r/e8ouC
         NexlfADE+SImbTA/gzCkhJCD67GZSLVhMXoPf+T5lpLJca+lrhuwoPXPkoDUrLM6x7Md
         IRkcBhkYG39NxTZrIlLzi/e4h+7OfoJqdaIPwtxPFHM5g1OJ/VuXXbn5bVNa7dzhVZ1j
         I3YlMKaxdnoJiQn2fdX+9O7N38qifjSrRWZ2eoY9ZncHCJGOOfierwgIoerL623XkhRe
         dudHtE4sCo5L/DvSNVM3Uzh6UfGJGTSIs3MFuw8BRQBSNoxcDftKcXzYIwb0htm/wwZL
         ccag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=gP40pqOrjsRuGDtDL77O5g/LDtgANLIwrEsf6Di4U2Q=;
        b=ASdmYnsFcC7X8o4mxC17jliE4hyHXRDQNzED650cOAq4iCfE147hR0CETc2zIHMYBo
         mTtOiY2UsnMA7DJSAUOY/9bimNVgA/mJtJUBuRX1tooV9PD0I+BGK3gphCtE1Xi+smOs
         LlL+5B6D4RSn18vqXEm9hmaixv9RkwTo298OexoYgIqpqzmH5cMSut7AHGNXdcplT17W
         RN9Cri+jF98eggU6Gyf9H7R/1i5thR79i2XjZnHAR4IDCxjtEHvWJMeu79v/gPsDGljJ
         ae6tFMAZ6448lh+vqi5V0M9c/yPAfiSjhLUTzcY4GbrEzSUvz4VLVClhGbwCNjJuPU0b
         WbFA==
X-Gm-Message-State: AOAM530rrwJ13RmKI2D5TZc7Ju/bh3GCyDX2Tql4efCfykiSMwf6kqtF
        fOZKq5sONq2X/bkdKFYDYfWeLedUqCpAoaOv
X-Google-Smtp-Source: ABdhPJzlhaE947vp64h6xieB3QsrudOdETC5dVB+SqwtB18MkZ1wItOTmJk7R3hQ0eqQI84Ro5n+QMwWgmopJlug
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:aa7:d7d9:: with SMTP id
 e25mr2166504eds.253.1603372764236; Thu, 22 Oct 2020 06:19:24 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:18:52 +0200
Message-Id: <cover.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 00/21] kasan: hardware tag-based mode for production
 use on arm64
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

This patchset is not complete (hence sending as RFC), but I would like to
start the discussion now and hear people's opinions regarding the
questions mentioned below.

=== Overview

This patchset adopts the existing hardware tag-based KASAN mode [1] for
use in production as a memory corruption mitigation. Hardware tag-based
KASAN relies on arm64 Memory Tagging Extension (MTE) [2] to perform memory
and pointer tagging. Please see [3] and [4] for detailed analysis of how
MTE helps to fight memory safety problems.

The current plan is reuse CONFIG_KASAN_HW_TAGS for production, but add a
boot time switch, that allows to choose between a debugging mode, that
includes all KASAN features as they are, and a production mode, that only
includes the essentials like tag checking.

It is essential that switching between these modes doesn't require
rebuilding the kernel with different configs, as this is required by the
Android GKI initiative [5].

The patch titled "kasan: add and integrate kasan boot parameters" of this
series adds a few new boot parameters:

kasan.mode allows choosing one of main three modes:

- kasan.mode=off - no checks at all
- kasan.mode=prod - only essential production features
- kasan.mode=full - all features

Those mode configs provide default values for three more internal configs
listed below. However it's also possible to override the default values
by providing:

- kasan.stack=off/on - enable stacks collection
                       (default: on for mode=full, otherwise off)
- kasan.trap=async/sync - use async or sync MTE mode
                          (default: sync for mode=full, otherwise async)
- kasan.fault=report/panic - only report MTE fault or also panic
                             (default: report)

=== Benchmarks

For now I've only performed a few simple benchmarks such as measuring
kernel boot time and slab memory usage after boot. The benchmarks were
performed in QEMU and the results below exclude the slowdown caused by
QEMU memory tagging emulation (as it's different from the slowdown that
will be introduced by hardware and therefore irrelevant).

KASAN_HW_TAGS=y + kasan.mode=off introduces no performance or memory
impact compared to KASAN_HW_TAGS=n.

kasan.mode=prod (without executing the tagging instructions) introduces
7% of both performace and memory impact compared to kasan.mode=off.
Note, that 4% of performance and all 7% of memory impact are caused by the
fact that enabling KASAN essentially results in CONFIG_SLAB_MERGE_DEFAULT
being disabled.

Recommended Android config has CONFIG_SLAB_MERGE_DEFAULT disabled (I assume
for security reasons), but Pixel 4 has it enabled. It's arguable, whether
"disabling" CONFIG_SLAB_MERGE_DEFAULT introduces any security benefit on
top of MTE. Without MTE it makes exploiting some heap corruption harder.
With MTE it will only make it harder provided that the attacker is able to
predict allocation tags.

kasan.mode=full has 40% performance and 30% memory impact over
kasan.mode=prod. Both come from alloc/free stack collection.

=== Questions

Any concerns about the boot parameters?

Should we try to deal with CONFIG_SLAB_MERGE_DEFAULT-like behavor mentioned
above?

=== Notes

This patchset is available here:

https://github.com/xairy/linux/tree/up-prod-mte-rfc2

and on Gerrit here:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3707

This patchset is based on v5 of "kasan: add hardware tag-based mode for
arm64" patchset [1] (along with some fixes).

For testing in QEMU hardware tag-based KASAN requires:

1. QEMU built from master [6] (use "-machine virt,mte=on -cpu max" arguments
   to run).
2. GCC version 10.

[1] https://lore.kernel.org/linux-arm-kernel/cover.1602535397.git.andreyknvl@google.com/
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] https://arxiv.org/pdf/1802.09517.pdf
[4] https://github.com/microsoft/MSRC-Security-Research/blob/master/papers/2020/Security%20analysis%20of%20memory%20tagging.pdf
[5] https://source.android.com/devices/architecture/kernel/generic-kernel-image
[6] https://github.com/qemu/qemu

=== History

Changes RFCv1->RFCv2:
- Rework boot parameters.
- Drop __init from empty kasan_init_tags() definition.
- Add cpu_supports_mte() helper that can be used during early boot and use
  it in kasan_init_tags()
- Lots of new KASAN optimization commits.

Andrey Konovalov (21):
  kasan: simplify quarantine_put call site
  kasan: rename get_alloc/free_info
  kasan: introduce set_alloc_info
  kasan: unpoison stack only with CONFIG_KASAN_STACK
  kasan: allow VMAP_STACK for HW_TAGS mode
  kasan: mark kasan_init_tags as __init
  kasan, arm64: move initialization message
  kasan: remove __kasan_unpoison_stack
  kasan: inline kasan_reset_tag for tag-based modes
  kasan: inline random_tag for HW_TAGS
  kasan: inline kasan_poison_memory and check_invalid_free
  kasan: inline and rename kasan_unpoison_memory
  arm64: kasan: Add cpu_supports_tags helper
  kasan: add and integrate kasan boot parameters
  kasan: check kasan_enabled in annotations
  kasan: optimize poisoning in kmalloc and krealloc
  kasan: simplify kasan_poison_kfree
  kasan: rename kasan_poison_kfree
  kasan: don't round_up too much
  kasan: simplify assign_tag and set_tag calls
  kasan: clarify comment in __kasan_kfree_large

 arch/Kconfig                       |   2 +-
 arch/arm64/include/asm/memory.h    |   1 +
 arch/arm64/include/asm/mte-kasan.h |   6 +
 arch/arm64/kernel/mte.c            |  20 +++
 arch/arm64/kernel/sleep.S          |   2 +-
 arch/arm64/mm/kasan_init.c         |   3 +
 arch/x86/kernel/acpi/wakeup_64.S   |   2 +-
 include/linux/kasan.h              | 225 ++++++++++++++++++-------
 include/linux/mm.h                 |  27 ++-
 kernel/fork.c                      |   2 +-
 mm/kasan/common.c                  | 256 ++++++++++++++++-------------
 mm/kasan/generic.c                 |  19 ++-
 mm/kasan/hw_tags.c                 | 182 +++++++++++++++++---
 mm/kasan/kasan.h                   | 102 ++++++++----
 mm/kasan/quarantine.c              |   5 +-
 mm/kasan/report.c                  |  26 ++-
 mm/kasan/report_sw_tags.c          |   2 +-
 mm/kasan/shadow.c                  |   1 +
 mm/kasan/sw_tags.c                 |  20 ++-
 mm/mempool.c                       |   2 +-
 mm/slab_common.c                   |   2 +-
 mm/slub.c                          |   3 +-
 22 files changed, 641 insertions(+), 269 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog

