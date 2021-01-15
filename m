Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4815D2F8309
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbhAORxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbhAORxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:53:41 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FBBC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:00 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id b8so4462673wrv.14
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RYO/TR1Bbm4mW1iECzdQbQ7ZTGAweoPPzyjiEaLEaqY=;
        b=V3MEXFzAfm6O1FvX8MH9E2c/cNrk8iXVj8ItAgiMFTqZM5o/X5AjOwZwKENM0Idqd4
         ZJ1jnjUK1t4aSH5ejtcq+ohqtE3hN4nvlrhH8B8wmSkPyWWVHtLQysbPxtAz8BIq5+VH
         HfPjHdcqflkFxM22fcpJ8+tOaoJJCmFGWGh9XW/zG4lPfKHWpofI/SftBwcqlOQE1o+t
         pf1l14nu5KYEHzIfsw+q8PKLTXbmG5+sXeVdXrIxVNxTilgWy+LjVSpZrR2x4ydpm0Jn
         zgEHF9T1KiOxZez1mb1+2NICyi1vuPwCx6ChPYzvm+JYaAIg3/PhKpGQBGlukojuzNGo
         NbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RYO/TR1Bbm4mW1iECzdQbQ7ZTGAweoPPzyjiEaLEaqY=;
        b=HkyGp1dXWqy9Wxu1RL7zYnLfEMSz81VlE/Ec0UWZO4K0zmuzjDUBFQqyNgUB4Sn2+B
         vhscR4g7HVPDxblT2lb8zxNF9KfugmdhT8m1QU713EaEj9X0AJamUozdD5vOBhl4wQZl
         wbrq72akuKSxSCZB1X0s/5DEMj/O42aBSkp6QL701qEqyDpaisuxnlYfWbHHUZ1SbzFo
         tCjsm7rURspc6w8x/7mK46QH6C2E3sYK/DLhGRDFdd+7AtggoRalTlz+FQLbNmgqhILR
         m09+J4seqPEghWW1uJteb1M1iEFRmmkkRdPM971IQ0Qm/0KXVnphcgLXRSB3z9AmS++s
         LPxA==
X-Gm-Message-State: AOAM532MTmiHBBmQEuY/dvaoyVN04I/oIzWJm+dd++3iTIpJILIrPCyT
        edfSu2WWVr1RZO47quPzbp7C6j4mQpHWhPct
X-Google-Smtp-Source: ABdhPJwG7faCpWeSX1O6QyfKQBzOXvqJrvQ3oBy9bg4d19WgkuuCGOUUerhmN4bT/0H9a4FTovsR3D5BFWBKy5hj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:c64f:: with SMTP id
 u15mr13855560wrg.270.1610733179247; Fri, 15 Jan 2021 09:52:59 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:37 +0100
Message-Id: <cover.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 00/15] kasan: HW_TAGS tests support and fixes
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

Changes v3->v4:
- Fix using tabs instead of spaces in bulk tests.
- Simplify is_write calculation in report_tag_fault().
- Add a comment about tests to report_tag_fault().

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
 arch/arm64/mm/fault.c              |  20 +-
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
 26 files changed, 563 insertions(+), 282 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

