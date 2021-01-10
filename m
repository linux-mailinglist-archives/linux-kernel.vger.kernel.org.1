Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE42F08B2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbhAJRUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:20:18 -0500
Received: from m12-18.163.com ([220.181.12.18]:35004 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbhAJRUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=PDPR1EvJ8p2jFoEYZJ
        /H6tQbh9r5SwukeSGEZ5VrZLI=; b=mq1FUfXU8lXDbDQ7i3hxQhBuRsebQrJcpp
        6A+bvaObtO2SGNuk4uGtyFPVd2ZChZ4rgKUa9Su9INy9PIldmGBYti0XK5il3eSJ
        dEO7LTO9njjT6PK2G7kfO+wp3DCbgksZ0F7EN9ccBY80hq6/cxjd2W+pFHm2xfxP
        +KZ4Yw8hg=
Received: from localhost.localdomain (unknown [36.170.32.128])
        by smtp14 (Coremail) with SMTP id EsCowACXmPbp_fpfpmHJOQ--.54130S2;
        Sun, 10 Jan 2021 21:15:22 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>, linus.walleij@linaro.org
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, liuhailongg6@163.com,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] arm/kasan: kasan_alloc a more precise size for pte
Date:   Sun, 10 Jan 2021 21:15:00 +0800
Message-Id: <20210110131500.12378-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowACXmPbp_fpfpmHJOQ--.54130S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWkZw1fGr43tryfGr4xCrg_yoWfXFXEg3
        Waqw4I9rySyrZ09asrXF4fXr1Syan2vw1kJF13KFyUZryjqwn5Ww1vq3y3Way8Wr429rWa
        yrWYqr1ayw1j9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnkOz7UUUUU==
X-Originating-IP: [36.170.32.128]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/xtbBFQwWYFXlna-WSAABsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

The *PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE* may be a more accurate and
meaningful size for PTE tables than *PAGE_SIZE* when populating the
PMD entries for arm.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 arch/arm/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 9c348042a724..c2a697704d6c 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -99,7 +99,7 @@ static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
 			 * allocated.
 			 */
 			void *p = early ? kasan_early_shadow_pte :
-				kasan_alloc_block(PAGE_SIZE);
+				kasan_alloc_block(PTE_HWTABLE_OFF + PTE_HWTABLE_SIZE);
 
 			if (!p) {
 				panic("%s failed to allocate shadow block for address 0x%lx\n",
-- 
2.17.1


