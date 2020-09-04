Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0533D25E2F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgIDUmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgIDUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:42:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6591C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:42:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so1705539plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMze2fXloWRfhFZlDUnAHV5dL0ihqAvcWM32yNx+a/g=;
        b=s6+S3BknaXDUfFZJwa8SaBEgJc4qe4SQsYlU0qotL1o2f4OfnG0BAjGG9632khkTVa
         KuefaNF4rH8N2/gfaNy2rSPo+B6LXahip/hUtA6dNwJoFtHCMDjv1B0G+1ZVaJBIuJ6a
         0JPDw9TIMhxwY4EpGhr+U/E4U1cLIE18xSWBqm+BAqQOyFe2MtYWm8988mRIXPNJYeC9
         rT9E7cKFhu2rpsTsmJnc/hKOVEgo+oLXKXAZHk5pf3HlM0MR5WQ5oEsrX9SrkrDUKEIa
         JcRDPfq+wWRPD34Rx10w3U4/s6+Ev0nYF93hwWBMnBSPPWkd4J0gZ8ZLG8UeisztLQTX
         fQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMze2fXloWRfhFZlDUnAHV5dL0ihqAvcWM32yNx+a/g=;
        b=V4VXl1bLX4gGopH6t+xEsh1xlyBxlyRMbYEoWUhcMh2PJCrV10H+hfAzhGdv+bd3t4
         xeg3x7bedllvKalhUGxM9VMsdqVFei+gOGAsrM+NMdaNF6+wBiSqDdWDthL0M8EmYXlY
         20VEqhOke+bIE4e6mJvVMKr/q84x/Zpd3KcKwRLXVTGUt1JzUeKim6B+pYZvAbH+fflk
         e8rLQIQlXr07zuzh/mE27bMBAuVNEe7M66ji01FVOaR7uybSH2vtpjJjjQ2pcJVWLNLD
         fzHkc+AvMC81mb+c6v2yhyXlbpx2tFwIwFPAqWZhZ/8frXdazYGvlkRe5+GCrkDW5nK3
         r2Bw==
X-Gm-Message-State: AOAM532kFcWiOsFdB3GchgxPCc2xa0uOFup78uhVC4XBnhsPwD+JvIRu
        WOsVKm4Lj2OgFvzXATo5cAE=
X-Google-Smtp-Source: ABdhPJxgVR5TjnQMp0XDMSYVXe0rYHaNCDVFme9N+F5ABKOvK3FiQSVql/EXBrrmfP9sTPOfLe4Fig==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr10215569plb.105.1599252171678;
        Fri, 04 Sep 2020 13:42:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w6sm5469444pjj.33.2020.09.04.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:42:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Justin Chen <justinpopo6@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: brcmstb: Add debug UART entry for 72615
Date:   Fri,  4 Sep 2020 13:42:47 -0700
Message-Id: <20200904204248.3307516-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

72165 has the same memory map as 7278 and the same physical address for
the UART, alias the definition accordingly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index 79223209d3f4..d693565af23c 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -33,6 +33,7 @@
 #define UARTA_7278		REG_PHYS_ADDR_V7(0x40c000)
 #define UARTA_7216		UARTA_7278
 #define UARTA_72164		UARTA_7278
+#define UARTA_72165		UARTA_7278
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
 #define UARTA_7366		UARTA_7364
 #define UARTA_74371		REG_PHYS_ADDR(0x406b00)
@@ -86,17 +87,18 @@ ARM_BE8(	rev	\rv, \rv )
 20:		checkuart(\rp, \rv, 0x33900000, 3390)
 21:		checkuart(\rp, \rv, 0x72160000, 7216)
 22:		checkuart(\rp, \rv, 0x07216400, 72164)
-23:		checkuart(\rp, \rv, 0x72500000, 7250)
-24:		checkuart(\rp, \rv, 0x72550000, 7255)
-25:		checkuart(\rp, \rv, 0x72600000, 7260)
-26:		checkuart(\rp, \rv, 0x72680000, 7268)
-27:		checkuart(\rp, \rv, 0x72710000, 7271)
-28:		checkuart(\rp, \rv, 0x72780000, 7278)
-29:		checkuart(\rp, \rv, 0x73640000, 7364)
-30:		checkuart(\rp, \rv, 0x73660000, 7366)
-31:		checkuart(\rp, \rv, 0x07437100, 74371)
-32:		checkuart(\rp, \rv, 0x74390000, 7439)
-33:		checkuart(\rp, \rv, 0x74450000, 7445)
+23:		checkuart(\rp, \rv, 0x07216500, 72165)
+24:		checkuart(\rp, \rv, 0x72500000, 7250)
+25:		checkuart(\rp, \rv, 0x72550000, 7255)
+26:		checkuart(\rp, \rv, 0x72600000, 7260)
+27:		checkuart(\rp, \rv, 0x72680000, 7268)
+28:		checkuart(\rp, \rv, 0x72710000, 7271)
+29:		checkuart(\rp, \rv, 0x72780000, 7278)
+30:		checkuart(\rp, \rv, 0x73640000, 7364)
+31:		checkuart(\rp, \rv, 0x73660000, 7366)
+32:		checkuart(\rp, \rv, 0x07437100, 74371)
+33:		checkuart(\rp, \rv, 0x74390000, 7439)
+34:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.25.1

