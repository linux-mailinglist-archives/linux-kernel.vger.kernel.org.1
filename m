Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFED2A2F37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKBQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgKBQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:36 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA800C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:34 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id e23so3915694qkm.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oA6gmttblv8OmG3VJbCFTsqSwJTzGphkOsRK2ZeD750=;
        b=riUcA41qwlHXo+IbXtU4f2GGtL76P+RBDCYMJGj6nE+vphGjBRYJ67tW9DBnbp+Uc6
         qMa4GtkvmVwVrtiW9jcmviJqseU0AbFPIF3HItqgnStji6pZtsP5a9LlFovkawU1J9y3
         EukBmZkKvJr3nUM1WKbhrHN7Csgv707bg9BiSwiLH/cb8dTNmhDvF9i9WX7NYE9vYLlb
         67bswnRRtk+MuEPTEbGZurY7ZnF8y2PK8IeGpd6SWadjxP2T887UXDT5+kgYvnCmjZbn
         d2Pdgu4U1pIRCMROZC6pCKvhZHwLxdKYNXN4mhikQaV7I3zkG63zYaTv1MGZ995za2Tg
         /KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oA6gmttblv8OmG3VJbCFTsqSwJTzGphkOsRK2ZeD750=;
        b=SoX2KIdbZzSaJ7kX02HQBzE/PGhD6DnHjIvfKbi6qMTsIm5ZLuvtCh6IRBhdPbLYIl
         EisBwKXpMJKChlyheiMtwI4NI/EQHkC6rKbYCWcMZBxZIuYbg/SSopAyrpp+Tg26qb4U
         bL28lisw60KNMsBnbzACKeCVqDH3rJrXZA3nxpJ7V4Rg+9Hhp3/3HYvQ0KI2trEieSzh
         zDy6cFRCeiPYZdQkQJ6Zjq92T5fWDRSVT5mdr/n1UgIwbadXNSJeyg2YVaH9X4QRpOq6
         QnVWMWmFY1sYRtDJekaChnC0NQ0ZvFYIO31xendPH25zp6aFI9+htgRBhLTYAfI/BkZq
         LF9g==
X-Gm-Message-State: AOAM533puQDdB2peOEvOubOz2q9kSEQuYXDue182NfADQVO2jThvx+vW
        GqLwV/pXaySba9gFsJZs58xzf1xHl9B6lKAp
X-Google-Smtp-Source: ABdhPJydHYs3rFxR5kefdVO46E96R1YsrBKg8uYgB2EbErSVyLuzI4uP5LbcVSXSsiycAoCuQsO+loq4dLPI+D6H
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:ef02:: with SMTP id
 t2mr22391450qvr.7.1604333133885; Mon, 02 Nov 2020 08:05:33 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:08 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <5749501e35314228f1a6fbd385b7bf81da99ff56.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 28/41] kasan: kasan_non_canonical_hook only for software modes
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

