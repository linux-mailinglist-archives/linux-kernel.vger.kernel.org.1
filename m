Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B626B01A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgIOWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD661C061356
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:02 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id i10so1706061wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4/ByT/O4Nvro4TMeKsqTFF+dTSNFkXyz3Nr2NgmhNnY=;
        b=vWPqCcAogi/jKWDdSun+38aXUOu71RzUkxMZHry8mER86ei6RngcWX7q1L6xR8ZMlh
         QRknTpkFeRjQB1Jy58mQQL41sc1vD8ym2kiC7LjDoQmF23mcwpIPTsdDobRXsA+wx7se
         onuLgOwct/FFx9HpJ53MiI1FHLQ58Z70nV57zxp96T1XBGa23PiyDtLZxuL6P9a36qYD
         TJ/ejxtH2CWVIhfzyck0X++QNvuP0WMwnWGT8AdjRRBPqiKJfMUb1CzXadGEgAli4123
         XCjrmwUFGZDw094+VZFg3RpgzxrCIaGO/3PmKr636pE4cvr0uy2ePrBnNkou2IwHJHFD
         c5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4/ByT/O4Nvro4TMeKsqTFF+dTSNFkXyz3Nr2NgmhNnY=;
        b=sRtcAEmmOxAmu2GCHGDS6e5D13BR0TF/mgMOflo6ngQoszZnW1lxWd5YfWrhMv4/uA
         UvUnToHBr1hOGissKvPXlZ6Kd4r3RPKeZ5QUXFIQVcvQW8MZib+msoYRxHdRJtiMT/VB
         CpiI3hKZlqvDoDYCAJ2P60gJpngsOepyUhLTClRxPiYTFYyADQ89HPd8O3r01VDY5e8I
         L1X0FxRHdpM87Hjj2ZvihpauBKV16f2XfkXyM+vVd2w8qQPRWLduMHC4D/NkdgNqGVwU
         jZgrXVqeNzwPoL9/VDLne4c+dwUTgmjAw7UNoeZCPww4+Kjz3etj2No2Iq/Onsd6EIS7
         W0Hw==
X-Gm-Message-State: AOAM531F23cAM1T+Yz/2qn8xiSgX/fmfsrqpb/m8J1Ubc9va8D8BJ8JT
        SwRatIk2/+6b5t9z1Ed9Wq0/ct5h2czlLyzX
X-Google-Smtp-Source: ABdhPJyJzy0pAfIpJ83kYJpmfubqjIv8bKNgjP3h8jm4Z1uHk8W7Ngaeixu1VZJreyO5PJKTsLfJTs9OkhL7AtDF
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:6385:: with SMTP id
 x127mr1274747wmb.95.1600204621569; Tue, 15 Sep 2020 14:17:01 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:58 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <f741b1ed6bee015a4accc2f2fdcaad8cc1c1bb47.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 16/37] kasan: kasan_non_canonical_hook only for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

kasan_non_canonical_hook() is only applicable to KASAN modes that use
shadow memory, and won't be needed for hardware tag-based KASAN.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
---
 mm/kasan/report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8ad1ced1607d..2cce7c9beea3 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -376,7 +376,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
-#ifdef CONFIG_KASAN_INLINE
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	defined(CONFIG_KASAN_INLINE)
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
-- 
2.28.0.618.gf4bc123cb7-goog

