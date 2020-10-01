Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FA280B21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgJAXLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbgJAXL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:29 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38811C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:29 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o13so94532qtl.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yqrr7BPrg0ain92TsQQXnoY0LyVu+DXBA9LKavF3UYw=;
        b=j/BtkqqSfeFD8zvFPsrgRyBDosPbPKVMwS5cM+k5esHH/YoBl85ibcdhix7GcX3sbm
         4LCwG0CaoNe03HO9W0jsuSqG0ZbGwoLpTF9bfy56czJkvR+cAa+E7capiXY1z1BlRm/p
         2p0yo8jgQXTVQ1me3eTk0BsRrm8RpH71AMDZ1nMAI15Fy5OGyAF0I/qLHtUtqTk2eVl4
         NV7guz0vGOSk42+iEqljg4AxQPFBXYE44fZ7JKfAPw32AD+QRqk/XB8wZF20vuPciiWn
         TwfQawKj2l2vN502Xlo6O2wWsVUrK4IEFnIEwmvYYDU/NDidRl4zmGunsGiJwKuXippA
         I/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yqrr7BPrg0ain92TsQQXnoY0LyVu+DXBA9LKavF3UYw=;
        b=C2LFbegJnbWLKIg8sozH0PgRjhQNsMD4a8OE0ZRrdUwATzThGkgrZD+D4qk3+jDi1E
         e5Fi0wcOYtMG0ldmsBlGg8ifs2h9wmxPwnBAAnv/OXnHn7250GFJd0ReSHA94JCJiE7K
         IjiI95UdlwscDG66CY3EEzc7QpqiwhTsnmXKI0hmSUwWw5I9whBIeQ8UhQtBrscBeCAQ
         W81BCLojn9mIdX/NSXjDsesOzgSa9Xaww2TTjpqgcRT6yvDH4OlopY9jizXQ13jBUVXg
         Ol4R856k1DjhO1bXqRkR8dC/NDUR/Un2PPmSE9ZiFxqs5XLLZYJffvPzJUCQymaG1R9M
         pWiA==
X-Gm-Message-State: AOAM531m4WXY/GENmapY6zGcT/wROQgdShjI9Nf3rWb5nObw8+bx+OVa
        kpLZLe7fl9ft+O49k1Wm/Ou50BNJgip1Lrz8
X-Google-Smtp-Source: ABdhPJw+2Prun9yrGhNHy9+mbWph39+U2d5qxUVW0nEn52bp9vz9c6wVWkqjunHZVewFD6CkRzRTvfTqor0Z8Nn8
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:abc5:: with SMTP id
 k5mr10212554qvb.40.1601593888265; Thu, 01 Oct 2020 16:11:28 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:19 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <32076774a3cb7307410532deb902716411a2dc52.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 18/39] kasan: kasan_non_canonical_hook only for software modes
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
2.28.0.709.gb0816b6eb0-goog

