Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A72EB290
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbhAES2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAES2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:28:43 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F487C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:02 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id l138so528698qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=nYphEf0EMXtBFuH3fG+hMPTfNDw2lJ9R5ysG4cvqPlg=;
        b=v5sqPJZxpjuB11/GEAiHAptCrghLv65ERy0Hv+7MaL3WzshKqkIqkDTuMHHKEqFeyx
         XDt5JgUo0H/C7DysFO2iq2kmIDze675lBtfrkfziV1h8BEZyu0m44I5beQiJ+WDQyRyg
         ZDSKJuZk7wJdBeNO5ixEApi9E9/hdaiL/1R3MW3dAg5gAqRNy/bB1hrpZvraUmypt/z2
         Uzcnpo29W0CUS3gGZjF1ojkSLtZDVfu23OjNkkFjbFEV8xOvoou6KzNcw3Y78HqvfGTi
         u4s9T1AgT214fvDwE9dHZk+K42j+mK0vsHsf3buKuAmyF+9udTHK4lzEjFVrp0DwRD/3
         Zvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=nYphEf0EMXtBFuH3fG+hMPTfNDw2lJ9R5ysG4cvqPlg=;
        b=dbZMkc7o4Ut/lnQrqUOzEAsYo0rolO+dgeoASw8HPZuDIR+voK3hhBjuTdSu8KLfPm
         yw7kxH+IghXJVZdTjsFvTjI6DZTDKJSCLXqKVeX91XnFNEm9IwemGbZB3uZDsWUTBZnQ
         DMMXOBLM4D2nwBPXBauE1OyztnY+5q26l2AGjJvREKGXN23DMp96aHjiDgRzKAM8ebKw
         NUMKtfcLNcD+SyyUtOvX3WNET7nIg66NzOmmQ/NjoUb7a2Gejr5YdFrG0qDEeRj/DC/Y
         buRDR4FCfDhM/Eug1rkWx8EjSaF7sbbWZc7yzI6EL8BV4gtolYIM+jDoi25trn1WysGz
         6pWg==
X-Gm-Message-State: AOAM532DH1wShph1yALM41Nv94T+xLTJfjDwpNp10iIEn6kGtGWb7+XL
        Tdzdfo/WgP9zdiGiZ+xX5OudbfgIair6j++E
X-Google-Smtp-Source: ABdhPJyBmBn1OeHUqMcEB2ORvkkHdSVt9GdeufbfO1j9yYUuMJPmCZohnhhyOFPghR5tnMIPs4OyFl1ol+2Rc1u7
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:46e7:: with SMTP id
 h7mr858980qvw.44.1609871281623; Tue, 05 Jan 2021 10:28:01 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:44 +0100
Message-Id: <cover.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 00/11] kasan: HW_TAGS tests support and fixes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Andrey Konovalov (11):
  kasan: prefix exported functions with kasan_
  kasan: clarify HW_TAGS impact on TBI
  kasan: clean up comments in tests
  kasan: add match-all tag tests
  kasan, arm64: allow using KUnit tests with HW_TAGS mode
  kasan: rename CONFIG_TEST_KASAN_MODULE
  kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
  kasan: adopt kmalloc_uaf2 test to HW_TAGS mode
  kasan: fix memory corruption in kasan_bitops_tags test
  kasan: fix bug detection via ksize for HW_TAGS mode
  kasan: add proper page allocator tests

 Documentation/dev-tools/kasan.rst  |  22 +-
 arch/arm64/include/asm/memory.h    |   1 +
 arch/arm64/include/asm/mte-kasan.h |  12 ++
 arch/arm64/kernel/mte.c            |  12 ++
 arch/arm64/mm/fault.c              |  16 +-
 include/linux/kasan-checks.h       |   6 +
 include/linux/kasan.h              |  13 ++
 lib/Kconfig.kasan                  |   6 +-
 lib/Makefile                       |   2 +-
 lib/test_kasan.c                   | 312 +++++++++++++++++++++++------
 lib/test_kasan_module.c            |   5 +-
 mm/kasan/common.c                  |  56 +++---
 mm/kasan/generic.c                 |  38 ++--
 mm/kasan/kasan.h                   |  69 ++++---
 mm/kasan/quarantine.c              |  22 +-
 mm/kasan/report.c                  |  13 +-
 mm/kasan/report_generic.c          |   8 +-
 mm/kasan/report_hw_tags.c          |   8 +-
 mm/kasan/report_sw_tags.c          |   8 +-
 mm/kasan/shadow.c                  |  26 +--
 mm/kasan/sw_tags.c                 |  20 +-
 mm/slab_common.c                   |  15 +-
 tools/objtool/check.c              |   2 +-
 23 files changed, 484 insertions(+), 208 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

