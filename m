Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC512FDA59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392910AbhATUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392827AbhATUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:02:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:02:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id r4so13099955pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiD8RpZTIFK5j3W5qhSV2+uN/hsQKts7HfplE7oc/zo=;
        b=aIot3t/VfPq4sMvHLYwNMNL9jgSClbbIMntR2bz9vDg/3j0cBuJEuB//Zm/KJu/+W1
         NyJMpX8VBG52wLJLwd1SDOdtDMJInXMgKBTBomjXMZH/V+jvzqHw4AjEexq/xtLi/pMv
         1eEpAnOYkdK8F/0vEGfIfXDnJDWSryExhzpoZevDN7sGlrkJ0ilmGUdq+AI/sqPU5FU/
         HPz+RfRNvfRzMrD2EScR/8X2vY9fr/MxeBRQwVotA6DEN1yUGt0FodqaJo4q7zYrQi2D
         OUDf7ZEDtktCIBgo5nIyfbgbPmDfuUea0niBy6gQFrYRaiaXPE+ZbxWgtgOGmQlYDfcT
         gPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiD8RpZTIFK5j3W5qhSV2+uN/hsQKts7HfplE7oc/zo=;
        b=cE7D7CmeQWvxJZszOz0Vkxi33ZkMwGsYisPBOQt+Hl8wn7ohzXqMNk3KRNd+Dz3mm9
         CXjUPXfIsbXe3AXfe987mtEuoyH1+oEvxyQ5A4nk4ue68puc3bO6UPaKyZtWSX5hv1m1
         caJ1NraspwdbinqP2k3OFwPUtO82n1sCMlJCdStKfBGBzNR+LcabBxxs84gGUDR7MeEr
         ZpRxvYeBhyGX6SaMFn2hA9oClMQrOlbaLvRY8HLCs2xeHA3E4yB4PGd6x5brUt3skWtG
         zidF+rTqOwqDiHnqprd7YIVy+MADd4WtOtPGUc1n2l2QMzsfkTUaaw4QVTdmVM8nq7L/
         FXKg==
X-Gm-Message-State: AOAM5329qh3C2yjIKztcK16ZRg8tyZSkjERMaReJ4z41YwCYKwu/HrkF
        z3O3DFVMw9hiLzmjj82KMOQ=
X-Google-Smtp-Source: ABdhPJwXDepRwRf3OQ8/iTXZW1XTaeXynKVC+8tIPCuux6rXZMPFHMFKmmbx7jv8je4UXFSkcrHRww==
X-Received: by 2002:a17:902:7205:b029:db:d2d5:fe79 with SMTP id ba5-20020a1709027205b02900dbd2d5fe79mr11588246plb.30.1611172924944;
        Wed, 20 Jan 2021 12:02:04 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gg22sm3221072pjb.24.2021.01.20.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:02:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: brcmstb: Add debug UART entry for 72116
Date:   Wed, 20 Jan 2021 12:01:53 -0800
Message-Id: <20210120200156.2782528-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

72116 has the same memory map as 7255 and the same physical address for
the UART, alias the definition accordingly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index 0ff32ffc610c..f684e3a815f6 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -25,6 +25,7 @@
 #define SUN_TOP_CTRL_BASE_V7	REG_PHYS_ADDR_V7(0x404000)
 
 #define UARTA_3390		REG_PHYS_ADDR(0x40a900)
+#define UARTA_72116		UARTA_7255
 #define UARTA_7250		REG_PHYS_ADDR(0x40b400)
 #define UARTA_7255		REG_PHYS_ADDR(0x40c000)
 #define UARTA_7260		UARTA_7255
@@ -85,20 +86,21 @@ ARM_BE8(	rev	\rv, \rv )
 
 		/* Chip specific detection starts here */
 20:		checkuart(\rp, \rv, 0x33900000, 3390)
-21:		checkuart(\rp, \rv, 0x72160000, 7216)
-22:		checkuart(\rp, \rv, 0x07216400, 72164)
-23:		checkuart(\rp, \rv, 0x07216500, 72165)
-24:		checkuart(\rp, \rv, 0x72500000, 7250)
-25:		checkuart(\rp, \rv, 0x72550000, 7255)
-26:		checkuart(\rp, \rv, 0x72600000, 7260)
-27:		checkuart(\rp, \rv, 0x72680000, 7268)
-28:		checkuart(\rp, \rv, 0x72710000, 7271)
-29:		checkuart(\rp, \rv, 0x72780000, 7278)
-30:		checkuart(\rp, \rv, 0x73640000, 7364)
-31:		checkuart(\rp, \rv, 0x73660000, 7366)
-32:		checkuart(\rp, \rv, 0x07437100, 74371)
-33:		checkuart(\rp, \rv, 0x74390000, 7439)
-34:		checkuart(\rp, \rv, 0x74450000, 7445)
+21:		checkuart(\rp, \rv, 0x07211600, 72116)
+22:		checkuart(\rp, \rv, 0x72160000, 7216)
+23:		checkuart(\rp, \rv, 0x07216400, 72164)
+24:		checkuart(\rp, \rv, 0x07216500, 72165)
+25:		checkuart(\rp, \rv, 0x72500000, 7250)
+26:		checkuart(\rp, \rv, 0x72550000, 7255)
+27:		checkuart(\rp, \rv, 0x72600000, 7260)
+28:		checkuart(\rp, \rv, 0x72680000, 7268)
+29:		checkuart(\rp, \rv, 0x72710000, 7271)
+30:		checkuart(\rp, \rv, 0x72780000, 7278)
+31:		checkuart(\rp, \rv, 0x73640000, 7364)
+32:		checkuart(\rp, \rv, 0x73660000, 7366)
+33:		checkuart(\rp, \rv, 0x07437100, 74371)
+34:		checkuart(\rp, \rv, 0x74390000, 7439)
+35:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.25.1

