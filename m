Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89642B2800
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKMWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMWQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:21 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970EC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:20 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id k1so4653038wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0h4ZiQVa03qeRcJlTu8FgXI56j5Z1qnhf08CuZFwLPY=;
        b=M3qWP0rHfTQk2jcgEfqgkakopE2+vK0SlmyGJK9pC4J8uXGmgpQoXM+4RKiTR2u3AL
         dY1QfKMiib7IggcnHSankwEPcWCmpo83cRgm146FaTvfh3P42P5LiTRroZV59FOQ219b
         a9iYmCEjfX0GTASJDOt3WF73FED6rtSBfINDeVSsCsuyl1p5Q5c1RmM/qgVtYGEeddQz
         pC1seCPTpYGwgBusn8cVsHlOLXJiGbsbi1/t5um/Fh8lluTgualAMtPPPYnSnellRIKb
         3T9BuMVDhjV6UTAWkepuDNnWxOpg+bVG3nYfnPWshMBup33tb7asm2GPI4mDujD70mCj
         0Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0h4ZiQVa03qeRcJlTu8FgXI56j5Z1qnhf08CuZFwLPY=;
        b=pYBpEatQK0KPwu2Wwn9RHUxqbu+pVpGeuOXtF/R/iPEiFn2xKgEA6SNznp+hGjk26Q
         mOirTzZ6jOGBBj8qb3KniuYIPgRjHW5VFkg0KTb2hO75gtWmM9dZCzt8LP4FOVYIaOzN
         NGXnq1v9atUzuNAdNEIdRytNnfib1dKT7QrWO0Y3v3QktSUA1r47CFvbCX1ta0hy2jqL
         kiBLgXCdY9nEWU3+zUY4DPU8uXPhgqBteOAxpF4sOmyweVlt+LH6cmn24v2/kTve95q7
         MwXyXa8pP8ojCfCsj34QV9y8qtzW3VNKtjNPgR+lpSEU5titl2VYAiZDu5Yjy5/jHTB8
         LriA==
X-Gm-Message-State: AOAM533386vlOvieWAvHRN23i7lxMgBroRHyNnDwhCmfUWqVPASLbXIK
        cS80LObwEwWY2ECCkAOec6cO3PkiC5IU+QTn
X-Google-Smtp-Source: ABdhPJyAZ0UIxB9J4bgdN99GXrf34dCcbSY/XBwdRljymNk4BfgvZIogxL5MEFsmqXv+lyE1fI8/dfU7LefRJdfp
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:9e48:: with SMTP id
 v8mr6446890wre.55.1605305779525; Fri, 13 Nov 2020 14:16:19 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:30 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <23b7935ec33e425f66ab736f6cf2bf74af542ac0.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 02/42] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

Currently only generic KASAN mode supports vmalloc, reflect that
in the config.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I1889e5b3bed28cc5d607802fb6ae43ba461c0dc1
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 8fb097057fec..58dd3b86ef84 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -146,7 +146,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.29.2.299.gdc1121823c-goog

