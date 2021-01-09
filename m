Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E982EFEFA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 11:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbhAIKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 05:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAIKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:34:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C3C0617A2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 02:33:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iq13so5034560pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 02:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UgUJ81KV4RLYeQfSGzwX3AUr5zkvCkqoF7/Wom4eVQ=;
        b=tIBodBVvD3dM/tPcoS7jhBbToG4VyWQROjl7yols9+8ORS/CcPAm5b20IC5Jbs9tWr
         yVOLQtwCCXvMimceRWBUO3zhKGWQjw7EHrfg5RSASgGqK8LLFbezIk2DCr5vc/pfiFnF
         JV6iQ2JA+Tw6kQMauQ4Z99oHP/u9IuHGhrJnVZaraWhMs00rxoSZ3aZ/hnNT+XYPjx/e
         UKfTzi1j/93nWOO+MObZpu/CQ5vP357FBpGxyOqQ4YFTPgngWp8raasL/lH/dTgxRD7p
         PLNtLI5oX9npD+u8BZKHa2tHKv0Fubd+WvDVhI9ejaqOXD0W5NgE6ZHTUmiYwluIMzHv
         lwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UgUJ81KV4RLYeQfSGzwX3AUr5zkvCkqoF7/Wom4eVQ=;
        b=Tr780awrOy+WcHXVEtEkgI38qmwelZm80kFNDguzZS3+XVXlMbVUJe+GllINypdEcj
         LhYL5djjPRRQ79PyYEXExMlE3IPEeOCbhlAJXA/gbFmzN9OONRX3XPhA4nRNRDqRoATn
         X7ZFHf5DD79lvE58aNaoHdiSOx5FzOAg3gr2ysi6RxAMVL0BvWQsIRGaz53sodjGlJAO
         0CzIsBfbbS2yhtPCnyQ1C7ARJjZlbfq7PRZ/3RiIF+jEv98r1ip94XDvvx0b8gNqa2pI
         Wzxfbc0sIKhCF0StNCmtJ+0Sh+h7FswOf8ZH+DIBg4JB71YBoHgD3A8z+aqjiABpeouF
         5oZw==
X-Gm-Message-State: AOAM530ZGR9kRmcOVUW5HmoQXGDEG5pMjiHKNV+mjF2EbtY4pYJUvjus
        JjP1bjapUWXWrcFEZzbI1oSMKVA+Tghr4g==
X-Google-Smtp-Source: ABdhPJy4QsiaNLvy4Wi6V3VyP08TTOZIk5pdsPpG8vK4ovPwJSYRAs9Lig3+CqO4Uia7rBMWDffypA==
X-Received: by 2002:a17:902:9a02:b029:dc:3481:3ff1 with SMTP id v2-20020a1709029a02b02900dc34813ff1mr11034416plp.28.1610188407451;
        Sat, 09 Jan 2021 02:33:27 -0800 (PST)
Received: from localhost.localdomain (61-230-13-78.dynamic-ip.hinet.net. [61.230.13.78])
        by smtp.gmail.com with ESMTPSA id w200sm11691572pfc.14.2021.01.09.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 02:33:26 -0800 (PST)
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
Subject: [PATCH v2 2/4] arm64: kasan: abstract _text and _end to KERNEL_START/END
Date:   Sat,  9 Jan 2021 18:32:50 +0800
Message-Id: <20210109103252.812517-3-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
References: <20210109103252.812517-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 provide defined macro for KERNEL_START and KERNEL_END,
thus replace them by the abstration instead of using _text and _end.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/mm/kasan_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 39b218a64279..fa8d7ece895d 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -218,8 +218,8 @@ static void __init kasan_init_shadow(void)
 	phys_addr_t pa_start, pa_end;
 	u64 i;
 
-	kimg_shadow_start = (u64)kasan_mem_to_shadow(_text) & PAGE_MASK;
-	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(_end));
+	kimg_shadow_start = (u64)kasan_mem_to_shadow(KERNEL_START) & PAGE_MASK;
+	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(KERNEL_END));
 
 	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
 	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
@@ -241,7 +241,7 @@ static void __init kasan_init_shadow(void)
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
-			   early_pfn_to_nid(virt_to_pfn(lm_alias(_text))));
+			   early_pfn_to_nid(virt_to_pfn(lm_alias(KERNEL_START))));
 
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
 				   (void *)mod_shadow_start);
-- 
2.25.1

