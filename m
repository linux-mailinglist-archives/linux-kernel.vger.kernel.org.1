Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C42E8D97
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbhACRN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 12:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbhACRN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 12:13:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B209C0617AB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 09:12:56 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v3so13137322plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcihLP7J+zvmlqvpCHNLNMn5gBB4sRocIGyVUTdgvis=;
        b=ZscOQ6cT7SGXbsyGrP7LqEThhcvbyy24898khh22BD7Fu/H0UxOpAIELLl3r+EqjD7
         MmnJYZc49kc7pL7yKi1xo/2qhiZZ+0X1+MVIfgQNAsvP2sFwzT84vkyO6I5ONCJTbTSA
         G79jEqpmI2sQOlFc68ao4aNRrxodHsahsS7kKJ7TBlKcI8YUvOW0NTI8yKQ968Ftun8g
         uwVYk3EctRRNVm2qc93TxvUWOKJc7aY3l3bKw6FXmIrhhn7r0juvJyrnQXXkLWIARE2/
         /6qCzhwFqYOadxbxxYaXpADRfBlmX2B07/v2mKz5p/V5zdxbJnqK3iMtUzqudxPO3eEN
         MQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcihLP7J+zvmlqvpCHNLNMn5gBB4sRocIGyVUTdgvis=;
        b=riAmS8Xz2zc/igIzNMl78kMlFZBJPee9TybA/86oKcjLGeRxmPHENN1fiK/hzE9Zv+
         zrrX63O0OdIoKwr+Z4nbxEWUGyuwFC2+84jYZXD+dfdfZsEw+tyVxlYqRWAoJwpHBeQS
         GeVf86DWjjBzQ3Z4ULo52Ip5KEJMifJ1C1/yV6VkiXZIyir7ssYHDzpXM/0xIldyhYkC
         MM5ngz5+FRgfIR1Pe67albBDHE0hZq/nbS7kbZ0lwNMX5310CYO/YZKGxQHE7RYaL+NO
         bUT9EOvs+L/ZARmbqH1tVR7kszmoUV1HWSAEs9DRQIV2Gj15Xc9JPBkWRsbXT4o9uOej
         6mNg==
X-Gm-Message-State: AOAM533phe+Z1gC37ncyByVBpVSe2AbGrQTZKDJjjrdnlDoMXJ/Kyqm8
        Jg5E4HJ/pC6VSbIPqfPzKDlVlQlHAvU=
X-Google-Smtp-Source: ABdhPJx+iEuKqbcGx4lndjhagQr1+v/81mg079S4Dgf37vjcORpgsvukDld0Xa8LwJHTq8YbzLCBow==
X-Received: by 2002:a17:90a:4209:: with SMTP id o9mr26729316pjg.75.1609693975741;
        Sun, 03 Jan 2021 09:12:55 -0800 (PST)
Received: from localhost.localdomain (61-230-37-4.dynamic-ip.hinet.net. [61.230.37.4])
        by smtp.gmail.com with ESMTPSA id y3sm19771657pjb.18.2021.01.03.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:12:55 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        will@kernel.org, catalin.marinas@arm.com,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH 2/3] arm64: kasan: abstract _text and _end to KERNEL_START/END
Date:   Mon,  4 Jan 2021 01:11:36 +0800
Message-Id: <20210103171137.153834-3-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103171137.153834-1-lecopzer@gmail.com>
References: <20210103171137.153834-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 provide defined macro for KERNEL_START and KERNEL_END,
thus replace by the abstration instead of using _text and _end directly.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/mm/kasan_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d7ad3f1e9c4d..acb549951f87 100644
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

