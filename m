Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA328E7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgJNUor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgJNUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:44:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C613C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:45 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s1so301292qvq.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Wp6ksUSUbEBH3QFRcUbKn90ZmE0mGR4EaPOxflY/Bhk=;
        b=XHIWX6TPUFJcGkAyHbWmWYvAO2eoTUguo4tRVo9+s/uBaOM7wucKOo1UnOUyeevkYw
         ZW6L/ImbWQf1HDVWU1I7EP+YsIxOm5CRxYHiSJDsN7IPEO5KqdenWyJzJsAHQbaQ//dy
         MbjXRVqE1oG+KlALEYmR2h9SbsySTuWvBPnc9mc9TqQQmIodwB10fqezFmIAGG7qG27c
         jI6/ynsLEqFTXnvb678mUKa/4ATypgMGNTxnYcZ+qjEeuw4HTQKDUFfc0T3bevZaecso
         rR2v2yabN6AoS1g6a4EXSSFWcUQAVcm2Y7UavScPQw5h1MatLhgkV8ZEZnycheR4WEn0
         kpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Wp6ksUSUbEBH3QFRcUbKn90ZmE0mGR4EaPOxflY/Bhk=;
        b=gtpFSQb8KXsoIKsP4WjJPMTuq0CQZNxGtvGRY4QuCyJgoVpQEDsfcVxRL2BPazWg0a
         PJfS2D/147hcGXjqKr2x6/itJGh00zmAsjy7i0+mY6fYMjLJvDdO6F5MII+1qToq/vqF
         99lSOaolm08E4Nev/Mq3S8o+bmDau9VQFrCVirRfxtawykHHTTRzAkrah70mlI4i2MMa
         j7/nxM2Ibj5Qj6TVRbZC2QhDuRO+NKZSedFM0+MSgSgK4suh6uyfAe9gzIpKREVRJK23
         v+kW7za2n3NKa7wm09dCBvPhkQ5Q8RXpWXhEBiKMIeA8iwC50SaBbDhMZ2GjChFijovr
         N4kQ==
X-Gm-Message-State: AOAM530+l36FOoOPCBaXeTrGQ7mrmwjcgc6m5uZetBD0Z29gQfwqfur3
        aTMio/971DUaJc1cgjNtOjkFSyfK2Z/fDdTQ
X-Google-Smtp-Source: ABdhPJy0w2DnvpsFk3ItIJc1FaFkjnQTtGD7dHFRkOJ2Z1pc/lhHaiZhAhM/IoqGk5LaY9pnhlyLDnPQtq6jckck
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5747:: with SMTP id
 q7mr1451102qvx.0.1602708284222; Wed, 14 Oct 2020 13:44:44 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:28 +0200
Message-Id: <cover.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use on arm64
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

This patchset is not complete (see particular TODOs in the last patch),
and I haven't performed any benchmarking yet, but I would like to start the
discussion now and hear people's opinions regarding the questions mentioned
below.

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

The last patch of this series adds a new boot time parameter called
kasan_mode, which can have the following values:

- "kasan_mode=on" - only production features
- "kasan_mode=debug" - all debug features
- "kasan_mode=off" - no checks at all (not implemented yet)

Currently outlined differences between "on" and "debug":

- "on" doesn't keep track of alloc/free stacks, and therefore doesn't
  require the additional memory to store those
- "on" uses asyncronous tag checking (not implemented yet)

=== Questions

The intention with this kind of a high level switch is to hide the
implementation details. Arguably, we could add multiple switches that allow
to separately control each KASAN or MTE feature, but I'm not sure there's
much value in that.

Does this make sense? Any preference regarding the name of the parameter
and its values?

What should be the default when the parameter is not specified? I would
argue that it should be "debug" (for hardware that supports MTE, otherwise
"off"), as it's the implied default for all other KASAN modes.

Should we somehow control whether to panic the kernel on a tag fault?
Another boot time parameter perhaps?

Any ideas as to how properly estimate the slowdown? As there's no
MTE-enabled hardware yet, the only way to test these patches is use an
emulator (like QEMU). The delay that is added by the emulator (for setting
and checking the tags) is different from the hardware delay, and this skews
the results.

A question to KASAN maintainers: what would be the best way to support the
"off" mode? I see two potential approaches: add a check into each kasan
callback (easier to implement, but we still call kasan callbacks, even
though they immediately return), or add inline header wrappers that do the
same.

=== Notes

This patchset is available here:

https://github.com/xairy/linux/tree/up-prod-mte-rfc1

and on Gerrit here:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3460

This patchset is based on v5 of "kasan: add hardware tag-based mode for
arm64" patchset [1].

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

Andrey Konovalov (8):
  kasan: simplify quarantine_put call
  kasan: rename get_alloc/free_info
  kasan: introduce set_alloc_info
  kasan: unpoison stack only with CONFIG_KASAN_STACK
  kasan: mark kasan_init_tags as __init
  kasan, arm64: move initialization message
  arm64: kasan: Add system_supports_tags helper
  kasan: add and integrate kasan_mode boot param

 arch/arm64/include/asm/memory.h  |  1 +
 arch/arm64/kernel/sleep.S        |  2 +-
 arch/arm64/mm/kasan_init.c       |  3 ++
 arch/x86/kernel/acpi/wakeup_64.S |  2 +-
 include/linux/kasan.h            | 14 ++---
 mm/kasan/common.c                | 90 ++++++++++++++++++--------------
 mm/kasan/generic.c               | 18 ++++---
 mm/kasan/hw_tags.c               | 63 ++++++++++++++++++++--
 mm/kasan/kasan.h                 | 25 ++++++---
 mm/kasan/quarantine.c            |  5 +-
 mm/kasan/report.c                | 22 +++++---
 mm/kasan/report_sw_tags.c        |  2 +-
 mm/kasan/sw_tags.c               | 14 +++--
 13 files changed, 182 insertions(+), 79 deletions(-)

-- 
2.28.0.1011.ga647a8990f-goog

