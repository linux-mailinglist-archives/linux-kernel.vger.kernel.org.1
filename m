Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152022F4FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbhAMQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbhAMQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:22:26 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75208C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:21:46 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id e14so1724729qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=TpRL7Y20jiGyVCcZ/tWCsLwlWMyTmyOwumaDR68J98Q=;
        b=kexc0GKfahtN6+eXQ4ruAoOLfXYOFprgQrXCkxvEJ4XGP0AubHPETXRT+1ZyX93aGJ
         Ci/Vkgbh7T2Tlu1CDvyHkTxWE4m71vOgvCVcMT7gXv3zVgEcMswloFJO0DVm/ADlZ+E4
         4Nqm93YIYHS8WGPImuLEzT5IFzVyZt2ecgM+1TaSfdm6ZGnvi2ppo62W9EjIwgMFZCCH
         b5uv4pc1LYxe80V9rFyG0NduW3RAEyuyThHWXOHaQAj41HtadaBbp8yXOAHd68oIn8M9
         1NLM5xmg+DDnBnt6cRiWr1sGKs7unsxHMJMMvKaT3yVzf6cUhVEEtqn+8arAyLIARqhk
         cLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=TpRL7Y20jiGyVCcZ/tWCsLwlWMyTmyOwumaDR68J98Q=;
        b=D/NBIXw/9IZDca9YyTpBsZKk7M0IbD8ecHti/8AHxu7kW0zVIWiS15LTYkHs08ymtU
         rxa+yYTlQjxY7Mjxtj3cXaKxIz4RJaXA22iw4EY2H9deUpEyfcsbbc+TVHgnJE9GToC1
         4e45oTmYNyC6e98DwNTno3+YIGNRGCt7Ob16qi+gRlUXwbpyIgEqSTRC4CI1bwcfXGe1
         c1Lg24PyMPBJ/TAS4CCaLtAOQ74fvkvYZMVExvIw8v0a6D8PwREtWydDW+8KNnTtBBOr
         tshrWr2gZRYfWcg4ierCobjo8f8rTrPI1LzuK72KU/vVThuMMRk0UWlKE5Z+zothy+6C
         loWg==
X-Gm-Message-State: AOAM532OugKhNCzwUVLE/q3LLvUkbcuxQ+q3z+u9xLxo3Tdrfv5zhWlG
        ajFw7bxsr1KX2vI9S0wtnLGgRDHvvy9HgqBp
X-Google-Smtp-Source: ABdhPJxln7izs619Q1m6UWhaO6zc4ZsZXg5wmyVBo2nR12ArziZiYlCDdEdTU70Vf5xRC058gEIemBMfjVyu/LOK
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b99c:: with SMTP id
 v28mr1527191qvf.12.1610554905578; Wed, 13 Jan 2021 08:21:45 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:27 +0100
Message-Id: <cover.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 00/14] kasan: HW_TAGS tests support and fixes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

Changes in v1->v2:
- Fix return values of kasan_check_byte().
- Use KASAN_TEST_NEEDS_*() macros for checking configs required for tests.
- Fix unused size in match_all_not_assigned().
- Fix typo in KASAN docs: "consist on" => "consist of".
- Use READ/WRITE_ONCE() for accessing fail_data fields.
- Doesn't leak memory in kmalloc_uaf2().
- Do up to 16 attempts in kmalloc_uaf2().
- Use kasan_report() for reporting from ksize() check.
- Rename kasan_check() to kasan_byte_accessible().
- Add a test for kmem_cache_bulk_alloc().
- Checks that pointer tags are assigned from [KASAN_TAG_MIN, KASAN_TAG_KERNEL).
- Don't run tests with kasan.mode=off.

Andrey Konovalov (14):
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
 include/linux/kasan.h              |  16 ++
 lib/Kconfig.kasan                  |   6 +-
 lib/Makefile                       |   2 +-
 lib/test_kasan.c                   | 423 +++++++++++++++++++++--------
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
 mm/slab_common.c                   |  15 +-
 tools/objtool/check.c              |   2 +-
 23 files changed, 544 insertions(+), 266 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

