Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9982EFEF9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 11:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbhAIKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 05:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAIKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:34:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE0C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 02:33:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e2so6998247plt.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 02:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xLmuarIgQdWn84D3wx5rQsfGRtDVE6UQliEht6Oq48=;
        b=tznSyNRiMyzItLUMQF6oR/88pqEwX9kk7kTQfKdCANR4RIg/jSGWow+vKdXCem/hFb
         3hSA000zXc3fyKUBdl/ZjSgR2sEYKmFdqPf4S63Pq3QJjj+bNy413T645P3RQ23jgmVt
         3J3FN8KfuLI2UcJsPN3IuNUC+xuBK2yRVHcTCAS5lB5ZR5KUApOT3cZsVhs984Mmsz+/
         V4Z6OZsDrFjz+MRDH1hiEauKdGXjagzEXCWcgckQrokmREpHGU7Y6/Z2qKMRYnBqpqtE
         iEY5t/mq3PAmOu1pAJ8pySebW15PR/thBHPuWzHkZqim021luT+y9tkl8tBRN4AkugJS
         Vpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xLmuarIgQdWn84D3wx5rQsfGRtDVE6UQliEht6Oq48=;
        b=jL2Tl0nsLycyoqSAc+e2QFmgIG1wapKqyEGm2Cf3CqHvgPZE+FT5qXRJh19cWRuUly
         noyktAZQ0EMNMXKbN4hlguyQ5i6PFXFY7v0uwNOwqxVzuQsepUsH8YpZktsxvEucT6vE
         InAhtg6iwHY3lG2AC7QVAwXV+q3J1QxYIeP0o4fNWjQcxH0jTEN516QnJ994pM+drtXz
         Z7Z6xp1zA1+nLqRMPBc6pM+ZW3ODEozln0bTGD25h4BQJRVyBISxKGCYk53wGyEznQyZ
         kGkeydG7W2QuIauoMam6B5uSmJloD5Q9QH6r315MZ8j7YvM6JqosOheeLu4U8bA+HS0F
         OqKw==
X-Gm-Message-State: AOAM5336M8Bz4HemJmEJgJt+hjZKRAWxiofaS4TJgBJ8YPdXiOWn1c3Q
        eNuq+PQ9WaFch0BeWd1E6TA1SrwvsTk6zg==
X-Google-Smtp-Source: ABdhPJwBW139zzmCSB7i8s5twWc31e2pZPSPq4BBWMA49N6/L9k08yfNKeLBW6qnhsn2aMKeT1auFA==
X-Received: by 2002:a17:902:b189:b029:dc:4102:4edf with SMTP id s9-20020a170902b189b02900dc41024edfmr8031040plr.80.1610188399222;
        Sat, 09 Jan 2021 02:33:19 -0800 (PST)
Received: from localhost.localdomain (61-230-13-78.dynamic-ip.hinet.net. [61.230.13.78])
        by smtp.gmail.com with ESMTPSA id w200sm11691572pfc.14.2021.01.09.02.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 02:33:18 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        will@kernel.org, catalin.marinas@arm.com, ardb@kernel.org,
        andreyknvl@google.com, broonie@kernel.org, linux@roeck-us.net,
        rppt@kernel.org, tyhicks@linux.microsoft.com, robin.murphy@arm.com,
        vincenzo.frascino@arm.com, gustavoars@kernel.org,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
Date:   Sat,  9 Jan 2021 18:32:49 +0800
Message-Id: <20210109103252.812517-2-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
References: <20210109103252.812517-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
("kasan: support backing vmalloc space with real shadow memory")

Like how the MODULES_VADDR does now, just not to early populate
the VMALLOC_START between VMALLOC_END.
similarly, the kernel code mapping is now in the VMALLOC area and
should keep these area populated.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d8e66c78440e..39b218a64279 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
 {
 	u64 kimg_shadow_start, kimg_shadow_end;
 	u64 mod_shadow_start, mod_shadow_end;
+	u64 vmalloc_shadow_start, vmalloc_shadow_end;
 	phys_addr_t pa_start, pa_end;
 	u64 i;
 
@@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
 	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
 	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
 
+	vmalloc_shadow_start = (u64)kasan_mem_to_shadow((void *)VMALLOC_START);
+	vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
+
 	/*
 	 * We are going to perform proper setup of shadow memory.
 	 * At first we should unmap early shadow (clear_pgds() call below).
@@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void)
 
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
 				   (void *)mod_shadow_start);
-	kasan_populate_early_shadow((void *)kimg_shadow_end,
-				   (void *)KASAN_SHADOW_END);
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+		kasan_populate_early_shadow((void *)vmalloc_shadow_end,
+					    (void *)KASAN_SHADOW_END);
+		if (vmalloc_shadow_start > mod_shadow_end)
+			kasan_populate_early_shadow((void *)mod_shadow_end,
+						    (void *)vmalloc_shadow_start);
+
+	} else {
+		kasan_populate_early_shadow((void *)kimg_shadow_end,
+					    (void *)KASAN_SHADOW_END);
+		if (kimg_shadow_start > mod_shadow_end)
+			kasan_populate_early_shadow((void *)mod_shadow_end,
+						    (void *)kimg_shadow_start);
+	}
 
-	if (kimg_shadow_start > mod_shadow_end)
-		kasan_populate_early_shadow((void *)mod_shadow_end,
-					    (void *)kimg_shadow_start);
 
 	for_each_mem_range(i, &pa_start, &pa_end) {
 		void *start = (void *)__phys_to_virt(pa_start);
-- 
2.25.1

