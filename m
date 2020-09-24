Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECA8277C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIXWxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgIXWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:36 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90831C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:36 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id a25so276709wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zaZ7iYa2nX/LEWBkDi8yCOPbi1dUYelfO4W8YWr1Gms=;
        b=j8tE91TvJHJBOvQpFHNGYBONEegYnZ4hHZsE0Hbr1aPcU1QnmZj1Ro70x8tbeWRBD2
         abfvI8mGbWhSjXR73sATl1AYDxXcj7d0JPvYf33BilE7fi/fstExDe035O3erTMoRjJs
         uBg1DgaQUyWb6bSln8Am0uFcPvOxnk10WD6wDqEarvqvmB7zOHQ73PIeDPFmH3YOC4KL
         9PDQElUNJxQfPDFFjnwBJAAtHFNratoI1taMyxuGxjiwsMIzxtI8pQc3WQDMIyGGocdo
         m2VfR58vQ/OuU5Pwgw1dzjGxMnB/8vOZOSOq/KOH2cPtXpXBr0ald/bVeBvLEwrm3Vpm
         Fg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zaZ7iYa2nX/LEWBkDi8yCOPbi1dUYelfO4W8YWr1Gms=;
        b=MWW+eYXiN2k0npzgRAuMRzifG7H4s+7YAwray7jGaRmGtBmDZItnOEg/+DgUWIHnWy
         jGwgNeID3EYCkoWhYABuAbeeIXXgYQ27WxgFtCuOMtbJiJr814Z90n6M8fZT+8YfZYBY
         SrbwPyM5Ct72BheGYyYtMpIY1xLSp5YC+kc5BznGrnkRzIXSv+43PODCAFwdJGL9XOdR
         IAXiaTCKJGWMnBN3p2MXBmnJ9QQwYiBmUybh5aVefG6eW1YT8wd/AQYe/LZSA8FN9Qdh
         QDq7Jbo57myBj19eFveWDu8UI0mULnjDQox/ZK0Mdqr/StgmoxT/ELTJyoi1kqnvsbnO
         xdsw==
X-Gm-Message-State: AOAM5317bITRw0xeGVdIlOdl6pz2MVy1YvmLAFuNJI8QDYWTX0ZT29SH
        KTX5KAYJptl8kphDnfraRANKdHMm7eWwsb/6
X-Google-Smtp-Source: ABdhPJz+QUgec2lUVcmzRzhZbOow06eibxJtc0wMebDet6dJiBG69rlY2XkCGlU46o6OTwczMiNPRY//0VTRByO9
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:d4c1:: with SMTP id
 w1mr1209062wrk.108.1600987894827; Thu, 24 Sep 2020 15:51:34 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:25 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <ff0f9a3bab9d2b99580f436121812d1eee560b44.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 18/39] kasan: kasan_non_canonical_hook only for software modes
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
2.28.0.681.g6f77f65b4e-goog

