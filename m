Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F052F6B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbhANTew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhANTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:34:51 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2FCC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:34:10 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 4so1008157wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TionkskhfJFUpeI/OKXUNvEID4OHoy9zg6Ffh7JmH8U=;
        b=Tmcmrez4gPLu4Ao5W6Ccspbbz/R7JDIQvAnzbn+3G4Nl+qd6kld//XQZFt8zyyKRHg
         yOZ6Hu2PtRCHValTBXFNafp8KmlGrnUDUAXIIy2UqKUlLWABYeG9e1tSa5OwJT7R1/P7
         Rl6SImK21+uKZNX8VftBxTn6OW6YV9Aaog4tVh9+FKNf0qqtQzHnB2JVq8UfhfrB2ubN
         Q2jDUtL3U4qTeMG5T6Ebd7+wLZB4itXhgaGrwHMrFb5yfK+U6ZC9NWkwlcdo68gvP7YH
         W/Ko5xuUT7nB5U95hBn1BCKSkOqOiq7PFoxyUYHGWJ4/r702Cvk4YkGK2S/Rl6thA4Aj
         lk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TionkskhfJFUpeI/OKXUNvEID4OHoy9zg6Ffh7JmH8U=;
        b=YBbj3/ttYvYDQk9oSBlUrT2NiiwMKPXuWQy334uDklcOe//eFqJZ+0snyembAKaZbh
         yC3mr/EQIsJplLX046VAswrIGXkRY0yJcqB7/W+xwKo98LZ0njmbblCGlPpMPg3TlRbn
         uWoh1A+RUTcg42yLe/6ZqXiMnwhaKEBW4KzuWvgPb23+YKMUGKJjEXyeA6IrLM6ZWPS/
         DAAJGD64otJPhfblRMOnDZ2sdIuGldpuSGfyvwgCWTt3lx4lYupqc5V+BwKGmfQYI68H
         Jk6DmZEWapS6Erah+AIXYTWPaELAmoQ2bpbz3X82Wq2S9uWmfLNR4yyLc1dMwOFLlatS
         7Ohw==
X-Gm-Message-State: AOAM532s6iQM7BJ8bCyztQTRv/LQsnzTfyCVhFQxbICtULQrotwARUwy
        QkdgQnlPuA2JxankDmHpqErhC7JZEtXgE/sl
X-Google-Smtp-Source: ABdhPJylLY1qXjASFBn9qVlbl1hTVHoUqtlGUBIy0x809OMseLmfOem7fnoyJjhZNOnosh+W97YAAaV/IKXRcqtt
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:258:: with SMTP id
 24mr5507364wmj.16.1610652849704; Thu, 14 Jan 2021 11:34:09 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:33:57 +0100
In-Reply-To: <cover.1610652791.git.andreyknvl@google.com>
Message-Id: <3d9e6dece676e9da49d9913c78fd647db7dad552.1610652791.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652791.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 2/2] kasan, arm64: fix pointer tags in KASAN reports
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

As of the "arm64: expose FAR_EL1 tag bits in siginfo" patch, the address
that is passed to report_tag_fault has pointer tags in the format of 0x0X,
while KASAN uses 0xFX format (note the difference in the top 4 bits).

Fix up the pointer tag before calling kasan_report.

Link: https://linux-review.googlesource.com/id/I9ced973866036d8679e8f4ae325de547eb969649
Fixes: dceec3ff7807 ("arm64: expose FAR_EL1 tag bits in siginfo")
Fixes: 4291e9ee6189 ("kasan, arm64: print report from tag fault handler")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3c40da479899..a218f6f2fdc8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -304,6 +304,8 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
 {
 	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
 
+	/* The format of KASAN tags is 0xF<x>. */
+	addr |= (0xF0UL << MTE_TAG_SHIFT);
 	/*
 	 * SAS bits aren't set for all faults reported in EL1, so we can't
 	 * find out access size.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

