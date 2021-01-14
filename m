Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC32F6B28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbhANThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbhANThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:15 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79515C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:35 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id g5so5642654qke.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=R63zbbCAwIca54YwZmiIwYnYLBR+THCEQGhD+FuGdpk=;
        b=swxZvrs/FyBUYyfMULYTNVyP+KnTw21pr9Aiiqx7Q46Yx/Ut5r2yaF5AVCRuhq/+qf
         U+GtJUGu288gKpEedjG8+E9MOJsAOKPjfLUhdmkBfAN/AYExLqyFthP1Q6aAzb32CSkc
         KaMVXz4yb51GNIVqOYZ8ks1UkuhO1eVAc2q8PxT16Gfsk0Cj2SVUVvIUco1fk1j0HbPz
         caWuq2bW15nwFh/knGbnoPd41H6ZddRXPBpThpo703woe6zwphpuUGiZsNkOlfFwkATT
         NWh9eYF1LC4Ln5qhMwFeGKmdF5E8Vf2akSKQVJkvUjL4lepD/g3Z05a8XdUM2vZ7qR6M
         QAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=R63zbbCAwIca54YwZmiIwYnYLBR+THCEQGhD+FuGdpk=;
        b=mq1g8RzB2bqDdZQy2NC4zMAlhefTKZpGqBgs96ZIVnK3TS7Yjhdc4v+ucpEvx7xNco
         sG3yxdNPy/Py45ReHRhHwSHu+tOGDG2aZwv+wnTxCluHbzGGpoSMpd0Ff1HpvoLzkEEE
         4AdgeIMz8yvPC8/s9xVJrCqs4HawOBtGq2kx71sTt3H6L2YPTcNJgLw9pu4EkXbvl6iC
         f5NKa+D+69U77TDy/lk+w/gpzySCQb51w6LZd9PjhMBfH3Jr17pIyKimtiaaP76w0guh
         XtReCeIibBL/K4BUNtLje34GXbzNvI9TxE/r6JiTumLUJpbGUbYfHoUNcNET+OT+oZHK
         gmhw==
X-Gm-Message-State: AOAM531R9uwikZaXKkD19rPw44bh90KNIvWzQWMFJhTbX4f3Zuh0olFk
        EqrPoXcqZ3yt1hOTbPQG+DXlqBlOVfP0nw0Q
X-Google-Smtp-Source: ABdhPJzTwS7gDhbMJeWMCLyUR7WhVrcIzT1QADDy3zJiUE3fwfmlECttiTh3d1GYrDqZu6WWlM6UTcfC/EjW5ohN
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4643:: with SMTP id
 y3mr8625481qvv.3.1610652994549; Thu, 14 Jan 2021 11:36:34 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:16 +0100
Message-Id: <cover.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 00/15] kasan: HW_TAGS tests support and fixes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

This patchset adds support for running KASAN-KUnit tests with the
hardware tag-based mode and also contains a few fixes.

Changes v2->v3:
- Don't call kmalloc(0) when generating random size.
- Use ARRAY_SIZE() in kmem_cache_bulk_alloc() test.
- Print error message when tests are being ran with kasan.mode=off.
- Move _RET_IP_ to inline wrappers for kasan annotations.

Andrey Konovalov (15):
  kasan: prefix global functions with kasan_
  kasan: clarify HW_TAGS impact on TBI
  kasan: clean up comments in tests
  kasan: add macros to simplify checking test constraints
  kasan: add match-all tag tests
  kasan, arm64: allow using KUnit tests with HW_TAGS mode
  kasan: rename CONFIG_TEST_KASAN_MODULE
  kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
  kasan: adapt kmalloc_uaf2 test to HW_TAGS mode
  kasan: fix memory corruption in kasan_bitops_tags test
  kasan: move _RET_IP_ to inline wrappers
  kasan: fix bug detection via ksize for HW_TAGS mode
  kasan: add proper page allocator tests
  kasan: add a test for kmem_cache_alloc/free_bulk
  kasan: don't run tests when KASAN is not enabled

 Documentation/dev-tools/kasan.rst  |  24 +-
 arch/arm64/include/asm/memory.h    |   1 +
 arch/arm64/include/asm/mte-kasan.h |  12 +
 arch/arm64/kernel/mte.c            |  12 +
 arch/arm64/mm/fault.c              |  16 +-
 include/linux/kasan-checks.h       |   6 +
 include/linux/kasan.h              |  37 ++-
 lib/Kconfig.kasan                  |   6 +-
 lib/Makefile                       |   2 +-
 lib/test_kasan.c                   | 424 +++++++++++++++++++++--------
 lib/test_kasan_module.c            |   5 +-
 mm/kasan/common.c                  |  56 ++--
 mm/kasan/generic.c                 |  38 +--
 mm/kasan/kasan.h                   |  69 +++--
 mm/kasan/quarantine.c              |  22 +-
 mm/kasan/report.c                  |  15 +-
 mm/kasan/report_generic.c          |   8 +-
 mm/kasan/report_hw_tags.c          |   8 +-
 mm/kasan/report_sw_tags.c          |   8 +-
 mm/kasan/shadow.c                  |  26 +-
 mm/kasan/sw_tags.c                 |  20 +-
 mm/mempool.c                       |   2 +-
 mm/slab.c                          |   2 +-
 mm/slab_common.c                   |  16 +-
 mm/slub.c                          |   4 +-
 tools/objtool/check.c              |   2 +-
 26 files changed, 559 insertions(+), 282 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

