Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC129F519
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgJ2T12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgJ2T1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:15 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C286AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:14 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id i1so1672789wrb.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oA6gmttblv8OmG3VJbCFTsqSwJTzGphkOsRK2ZeD750=;
        b=K1nHe9B/C1vUVBhjmN3ouwiA2G8Bil+4lOTK4Roy4CfYBtAkrBiqvKLoffIsQ5dmeX
         4w/tPJkLIjUxjWrbGhK0uX5TQJI8bCt9+XdTeg5hW1m2Rsh0lf7zBUkd2HOwOy5V35UP
         I5AnLEtT559b5rZqwgyQ7rwK3svrcoNaPYuS0x+6UIyRM10MNv9USnXLkRS4tyoxptqy
         WZAZekCmx94CldQgMK9MtCE5xD9/yCStJIYW8OHRxW5FdCXkIpoSi6VL6O22VJ6oPFGN
         9eD/c7wi8u6kDY0pqkXgwr9qCNFo6OZzfG4hwkWRHspPfd00kIIJ9yHGokHi1nDcyTN3
         VXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oA6gmttblv8OmG3VJbCFTsqSwJTzGphkOsRK2ZeD750=;
        b=Hef6u6pL0pfXkKZZT+W4ZrN11gGAz1JBYhCgpcyrBu0JRfgkp0cN5TtmB5rSrrLtIE
         W3fxTGYEGIpPzl5uRy/1cts0cxElOykCV5cyu+idAgWScYt9FEFQVFS2dx5aLUPvtB5s
         7NCymLKFveBCieMEDnWTdkI1/885BixQ2VFij2O0ccQe1XaWUG7OEorKb/H9vJPNZaU8
         kX/S048+nPxNZ/COQoXnRF8JqVY8QzUkkJZtwGkJfTvlcYaWKXPys8N/K54od6QTLIJz
         8nHeS/vxthmVAIbo6QYwK4LM+pvQKIWziO4utrTB+YemZxPuBiPD7Lrb4wAOKNJfL8L5
         nUKw==
X-Gm-Message-State: AOAM533Iyd+xQUQRfMIgPu9u4gXGBd8UA65H5CA6F8+TialOdpU//P/c
        W3FxQoxJD/40LE85HOda2pNOtzm/Wk079U13
X-Google-Smtp-Source: ABdhPJwLqg9Q2JCfZvLcHaZRnmwgB3K3EMmizulaJN0u7Fm4WDLwURsOiao/6X8pMf0ooBjhb23kIF7zGzlFYh6+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c92c:: with SMTP id
 h12mr464316wml.134.1603999633473; Thu, 29 Oct 2020 12:27:13 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:48 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <36ab70fef7688f7a43871b82320784a67f8ffb10.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 27/40] kasan: kasan_non_canonical_hook only for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
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
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
---
 mm/kasan/report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5d5733831ad7..594bad2a3a5e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -403,7 +403,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
-#ifdef CONFIG_KASAN_INLINE
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	defined(CONFIG_KASAN_INLINE)
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
-- 
2.29.1.341.ge80a0c044ae-goog

