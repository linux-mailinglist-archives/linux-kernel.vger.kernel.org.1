Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390252EFEFC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 11:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbhAIKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAIKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:34:25 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C1EC0617A4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 02:33:45 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id c132so9319076pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjESqlUb86RQ6iRPUx+QrIUmLWqLivYfrQTN5THOZlI=;
        b=BPZllgi5j123yuQfqVOrYEdSznE7JM0iGEn20PN86SJp5LuMZ02GpJIdXxKU5f06lo
         v0sdJbXah37egbezScUS75h3gFsVDu2TvXVT4wFU6e07EoexWe5Bfxd5/0DXNT9OF4Ak
         0BfyFOyQpbC+ZIru/6UpoqCsDY1grAObtZGP4e+3+b78hIzVb7r8kKLhNZM+whZ+dUr5
         8rwbKK0V3+7uN+aKrVU+tVUCiBK/hwZjD/3DnB0SKZVrL8zaqHjoCai9Dw9i0EwI4+pF
         J7hzl7aC7QzoLIXtNAXCicyX085vdBopmyvdwudeQrwfrw2GsvrRfZ4MxlvBZnY5DQ8f
         DKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjESqlUb86RQ6iRPUx+QrIUmLWqLivYfrQTN5THOZlI=;
        b=gy20s68bAuVCpYkmvN8AD2XZ4j8Xuo4K43kvxxKWlPdl+//h3qxa+YTDmG8Zy6Kk+7
         6KNDLow4wd4qO9Fsz3OtBw3/hD9KJtmsCFgF+7rX6hoNDNHKLltPHa93Xjh2TJOE+m3O
         EJLTGJ+10suKwOAw86Ch+gXRyF4tMM2gS3/uvJCF7dQTJTJUz1rleWeQHV+yLb64w2cM
         RBlSsjr4o2yzg6IaWKzGD5Q416qWOOEAlXjypCl3klS1cdAPg+RMv3FRpRjk0zDkECci
         qZh9PpXgWesK/dxcxIWMipJo+DkUCmd6cDhTTONKTJsZuo7JJqU1z5VBnQMoLccf89Er
         +tlw==
X-Gm-Message-State: AOAM531P6wRMr2bwLfsIckKFGLhxpjZp8ff7T4gbDRV/0ZeYGLLZ/yxf
        oQfsT+++79yhuHXkL3S04jWZybOLbXk=
X-Google-Smtp-Source: ABdhPJxnAfGcjjOzp0O5bC+zZRpiwF3pGnF0uWlC/oLTtAZ685s5ouGYEu3QKd0emh/MPnfAeJ4Z0Q==
X-Received: by 2002:a62:25c1:0:b029:1a9:ee40:3fd3 with SMTP id l184-20020a6225c10000b02901a9ee403fd3mr7620101pfl.58.1610188424692;
        Sat, 09 Jan 2021 02:33:44 -0800 (PST)
Received: from localhost.localdomain (61-230-13-78.dynamic-ip.hinet.net. [61.230.13.78])
        by smtp.gmail.com with ESMTPSA id w200sm11691572pfc.14.2021.01.09.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 02:33:44 -0800 (PST)
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
Subject: [PATCH v2 4/4] arm64: kaslr: support randomized module area with KASAN_VMALLOC
Date:   Sat,  9 Jan 2021 18:32:52 +0800
Message-Id: <20210109103252.812517-5-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
References: <20210109103252.812517-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After KASAN_VMALLOC works in arm64, we can randomize module region
into vmalloc area now.

Test:
	VMALLOC area ffffffc010000000 fffffffdf0000000

	before the patch:
		module_alloc_base/end ffffffc008b80000 ffffffc010000000
	after the patch:
		module_alloc_base/end ffffffdcf4bed000 ffffffc010000000

	And the function that insmod some modules is fine.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
 arch/arm64/kernel/module.c | 16 +++++++++-------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 1c74c45b9494..a2858058e724 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -161,15 +161,17 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
 
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
-	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
+	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
+	     IS_ENABLED(CONFIG_KASAN_SW_TAGS)))
 		/*
-		 * KASAN does not expect the module region to intersect the
-		 * vmalloc region, since shadow memory is allocated for each
-		 * module at load time, whereas the vmalloc region is shadowed
-		 * by KASAN zero pages. So keep modules out of the vmalloc
-		 * region if KASAN is enabled, and put the kernel well within
-		 * 4 GB of the module region.
+		 * KASAN without KASAN_VMALLOC does not expect the module region
+		 * to intersect the vmalloc region, since shadow memory is
+		 * allocated for each module at load time, whereas the vmalloc
+		 * region is shadowed by KASAN zero pages. So keep modules
+		 * out of the vmalloc region if KASAN is enabled without
+		 * KASAN_VMALLOC, and put the kernel well within 4 GB of the
+		 * module region.
 		 */
 		return offset % SZ_2G;
 
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index fe21e0f06492..b5ec010c481f 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -40,14 +40,16 @@ void *module_alloc(unsigned long size)
 				NUMA_NO_NODE, __builtin_return_address(0));
 
 	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
-	    !IS_ENABLED(CONFIG_KASAN_GENERIC) &&
-	    !IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+	    (IS_ENABLED(CONFIG_KASAN_VMALLOC) ||
+	     (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+	      !IS_ENABLED(CONFIG_KASAN_SW_TAGS))))
 		/*
-		 * KASAN can only deal with module allocations being served
-		 * from the reserved module region, since the remainder of
-		 * the vmalloc region is already backed by zero shadow pages,
-		 * and punching holes into it is non-trivial. Since the module
-		 * region is not randomized when KASAN is enabled, it is even
+		 * KASAN without KASAN_VMALLOC can only deal with module
+		 * allocations being served from the reserved module region,
+		 * since the remainder of the vmalloc region is already
+		 * backed by zero shadow pages, and punching holes into it
+		 * is non-trivial. Since the module region is not randomized
+		 * when KASAN is enabled without KASAN_VMALLOC, it is even
 		 * less likely that the module region gets exhausted, so we
 		 * can simply omit this fallback in that case.
 		 */
-- 
2.25.1

