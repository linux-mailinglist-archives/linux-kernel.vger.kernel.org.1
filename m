Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10128C33D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgJLUrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgJLUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:58 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140CC0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:58 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o25so10388855qtt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uq0E0gUhwkpPRwh8MWqD4WeS1X/FQmBRJFO+B9Xt1FE=;
        b=sz1Ze07rKqplPJ0+DGA5RjfoKP6RTiQZEXy1HdD5d1lHTVr8NCMBKdwrtjWmDXidMJ
         UVhnJdndg73S+XhgAXm2If8wRCNhdFzxSnblDGNzj/06vlFNLd3jbuhTkFeKBlEjXXtd
         8I5SE/+tc6IIU9AqVHuoQgLL8sPYQ+JvJVBGBeUCU4e0ssl7ubwsKBHCHb+MQkiaFdif
         60ITKHOkK/eCkVa31IoFJUzrwfGuofEbhJC3R/7yewR2AOT/z65zlvmZHAh+m2pb2WUg
         +X1/f/tWStNi/1ITBXky7psRrixzHD0UXlxSlU75r/STlWK6VIWILwikJ8Ohe7Yo2BF4
         +KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uq0E0gUhwkpPRwh8MWqD4WeS1X/FQmBRJFO+B9Xt1FE=;
        b=nSAtPF/0kiDwsf/UkEjB2GggDZtiYFFibhvFetDjA2oozsKQF+krE+5huqPVHl6Psi
         A7GINK1nMboIwvOf1culzjzFRk41UAvBZILIMD4e0sp9oiCQ6IFB0lySJVgDmgSzIsbl
         X5/parhOg6U5HrxhCgxUHqbCM76mik01wlfw17Gzh5i2suPChXphPPqBFO1IDGcinsHV
         zp2WqYJkXRxDqm/Dg+56+4kHO8wMu59RpUyFDviaZs90W07QBc3KgiQ+9uj3C/Gc/qLl
         syvDEHPQIXTXQ0PbUf9SlcIMM5TNQrfl+ahu2xN1R4rapl18iZZbWmU6xaTI/ZAzXDvG
         DBjQ==
X-Gm-Message-State: AOAM531kkuPFv+719EAPRm++LZkuoJG6xSbv/T1jIQvKvL7+h78ibxh9
        uwq3phKBLnohi8o/zvhu5AkwigoWympM78eH
X-Google-Smtp-Source: ABdhPJyKqrBiRa68gyDMJrYPpCJhWav3c2UwbvueDHej4PqK2X/mQm6ILlOLrb53fj94PAuIptwyFizaKBsSFPAf
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:174f:: with SMTP id
 dc15mr25993005qvb.26.1602535557397; Mon, 12 Oct 2020 13:45:57 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:33 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <4e28900397138acc0ea8a99cdff234ba68da518b.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 27/40] kasan: kasan_non_canonical_hook only for software modes
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
index 9e4d539d62f4..67aa30b45805 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -371,7 +371,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
-#ifdef CONFIG_KASAN_INLINE
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	defined(CONFIG_KASAN_INLINE)
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
-- 
2.28.0.1011.ga647a8990f-goog

