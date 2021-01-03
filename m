Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1DF2E8D8A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 18:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbhACRNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 12:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbhACRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 12:13:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0455AC0617A7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 09:12:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lb18so8352228pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qF0SijNFO/T+7vPigxBwLWfcVu8oPsZO7isaPG+ku8=;
        b=OMdVh9zxiZv9azAo9+0yvKEkkHlQiRNekWETEHuEwCBvQ/iy+NnfWuO6Su8nvxl4TR
         sVszfeEmM3v6ig7Bfge2C/f8TMwms22mkgt/r+S1gm5pQD30UUMNB1ccdgcJe+m94I5t
         J15E8JULz9YMpwuHH0YoR8QOJTPyYKmqYBUcuJIUOFiTqlTiqFCwcJhW5+bclo1I1bHh
         xSrS1+tkxQklhB+96h6QdMKFDflPTJ8CCmoRsXLd3RrPWQf+NVhZwQFHDjjueJLgPXkC
         s6/eYfDfshOnGDGGwAocvHfl7zfhoVnfeXVVnTl77GfSS2IZjeyhhVx+kDPivmTfxEFY
         NCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qF0SijNFO/T+7vPigxBwLWfcVu8oPsZO7isaPG+ku8=;
        b=OIIiV186NkP9YiD4Qk7Cbbzs6enh8e5g/5w/JAmjgisbkCETkmflOBN8cpNr4cI1Nu
         AVcVLGMauzzXOVXX8jQMMO1kf3NnxvS5ogIfiWeqsxUVeVQzTtc5NY8CnugC++AqNXuH
         dsd6I/3T9SCO20auzvpO73YFYc6YhWL0Mm895NpFti4MNQVw2BZp9+0O/qGLM81lv/vn
         mIdfCy5zRzc5Ja9/fcbf8i/DBjfCKYC3y0L42UJwPGHibM9qsoJYbaOG5hF1hP2XI7CN
         yx4bJxjeTcAn0a/s629DsPxVzMytto3CJ+LYoAEZv57IJmEivrIeOQtUATV3W8CSv4aV
         NS7A==
X-Gm-Message-State: AOAM532dQSpuUkVSWZlECSM1t7ugILx574/AiQmK3jdRolDbKVoycLXa
        eEgbhd0srzz+HtlijmDgcqle4pIyrgs=
X-Google-Smtp-Source: ABdhPJw3OQwhq9OxHmMcioQgHt+p48eMqxA1ZNlpDr311WozdKIFyTrL8TttCW0PNA95g+ifOua7dw==
X-Received: by 2002:a17:902:7207:b029:da:fd0c:521a with SMTP id ba7-20020a1709027207b02900dafd0c521amr68665365plb.45.1609693967387;
        Sun, 03 Jan 2021 09:12:47 -0800 (PST)
Received: from localhost.localdomain (61-230-37-4.dynamic-ip.hinet.net. [61.230.37.4])
        by smtp.gmail.com with ESMTPSA id y3sm19771657pjb.18.2021.01.03.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:12:46 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        will@kernel.org, catalin.marinas@arm.com,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH 1/3] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
Date:   Mon,  4 Jan 2021 01:11:35 +0800
Message-Id: <20210103171137.153834-2-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103171137.153834-1-lecopzer@gmail.com>
References: <20210103171137.153834-1-lecopzer@gmail.com>
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
index d8e66c78440e..d7ad3f1e9c4d 100644
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
+					   (void *)KASAN_SHADOW_END);
+		if (vmalloc_shadow_start > mod_shadow_end)
+			kasan_populate_early_shadow((void *)mod_shadow_end,
+						    (void *)vmalloc_shadow_start);
+
+	}	else {
+		kasan_populate_early_shadow((void *)kimg_shadow_end,
+					   (void *)KASAN_SHADOW_END);
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

