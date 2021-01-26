Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6060D303E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391651AbhAZNJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403922AbhAZMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FCC0698E6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id u14so2627650wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0Ike944NkRAuPgkxrxuW8S6aKRu/hdxaXcbNq0mdiY=;
        b=oMuqC7H6vpZMq0xrtf4h9+YqRZYqNaIxxNUO+YL9xq2Uyj3Wxxv1OKhVBxslEfWw6+
         Onaln1RQf3T2JxLxmRGSb+irSkYcE4aw65l8UvO5p6c8ek0dVT94HHyEguvOepYY37lP
         6Wt2ORbsweCvaV+IDoukfJC9CPN/3RBo/Z/m3bswOB2ETZyINXZ+/QBIYdDyeMVATuRK
         4mx5KkhOzidfYJxllyaJd0z36EEaMUdtU+E4Kgm6ERMGE+4iJxNmCA/90sVsbnJfDBEx
         2L9fSfCOmhz0rr8k3WBrUVR+cw9YfYHXAp3uJtChnK7yQJAAJEsjFGSkojX2XGZItDcG
         MEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0Ike944NkRAuPgkxrxuW8S6aKRu/hdxaXcbNq0mdiY=;
        b=SF9p/aPIKtxfbeLi9kdWYe5/6LoQCx0Od8ju7Du5HhG4XeCP5bogQNhXZRQpIoESzO
         h6+bp7hMt10cHC1nueilbTKVkCkeOXR3HWFE7/6UoKn8GeipWFPVKtsjiBIPhQs40+SS
         VM7y/ZGGIB5eY/jjVZo6JZfJKPQyy4/IsjOmFBQY61m7V4XcCwz7UQXqdAtxFD4T3mW2
         4X2BmYP19eAGooAw7V6217mi5+kueyHwyuFZysSGmI1OKMFzLgb0AkIMbqyM/HoF++AF
         qk8EGZzllsiF4RxEoVYE+vup1pzqa094vdO868G6fHZqdaTWMvANfFtcWwbe9s35bXMv
         trDA==
X-Gm-Message-State: AOAM531kVKl5oPNTxcIeJm0emr8OnwSgMtp7b6H6q19yKbyeUSd0z0XF
        v/+T340roarO+G0gpH25/de9Bw==
X-Google-Smtp-Source: ABdhPJxuJVv0MwQsAM6z/D0PIPLHRlfjT3l5zRNHHf84f5J/noC/V3qyelGNBnG29wT4mCKpAyKMGw==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr4668212wmc.68.1611665162317;
        Tue, 26 Jan 2021 04:46:02 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:46:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nuvoton Technologies <tali.perry@nuvoton.com>,
        openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org
Subject: [PATCH 15/21] clk: clk-npcm7xx: Remove unused static const tables 'npcm7xx_gates' and 'npcm7xx_divs_fx'
Date:   Tue, 26 Jan 2021 12:45:34 +0000
Message-Id: <20210126124540.3320214-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/clk-npcm7xx.c:438:43: warning: ‘npcm7xx_gates’ defined but not used [-Wunused-const-variable=]
 drivers/clk/clk-npcm7xx.c:365:48: warning: ‘npcm7xx_divs_fx’ defined but not used [-Wunused-const-variable=]

Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Patrick Venture <venture@google.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Benjamin Fair <benjaminfair@google.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Nuvoton Technologies <tali.perry@nuvoton.com>
Cc: openbmc@lists.ozlabs.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk-npcm7xx.c | 108 --------------------------------------
 1 file changed, 108 deletions(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index 27a86b7a34dbf..e677bb5a784b9 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -361,13 +361,6 @@ static const struct npcm7xx_clk_mux_data npcm7xx_muxes[] __initconst = {
 	dvcssel_mux_parents, ARRAY_SIZE(dvcssel_mux_parents), 0, -1},
 };
 
-/* fixed ratio dividers (no register): */
-static const struct npcm7xx_clk_div_fixed_data npcm7xx_divs_fx[] __initconst = {
-	{ 1, 2, NPCM7XX_CLK_S_MC, NPCM7XX_CLK_S_MC_MUX, 0, NPCM7XX_CLK_MC},
-	{ 1, 2, NPCM7XX_CLK_S_PLL1_DIV2, NPCM7XX_CLK_S_PLL1, 0, -1},
-	{ 1, 2, NPCM7XX_CLK_S_PLL2_DIV2, NPCM7XX_CLK_S_PLL2, 0, -1},
-};
-
 /* configurable dividers: */
 static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 	{NPCM7XX_CLKDIV1, 28, 3, NPCM7XX_CLK_S_ADC,
@@ -435,107 +428,6 @@ static const struct npcm7xx_clk_div_data npcm7xx_divs[] __initconst = {
 
 };
 
-static const struct npcm7xx_clk_gate_data npcm7xx_gates[] __initconst = {
-	{NPCM7XX_CLKEN1, 31, "smb1-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 30, "smb0-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 29, "smb7-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 28, "smb6-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 27, "adc-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 26, "wdt-gate", NPCM7XX_CLK_S_TIMER, 0},
-	{NPCM7XX_CLKEN1, 25, "usbdev3-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 24, "usbdev6-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 23, "usbdev5-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 22, "usbdev4-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 21, "emc2-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 20, "timer5_9-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 19, "timer0_4-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 18, "pwmm0-gate", NPCM7XX_CLK_S_APB3, 0},
-	{NPCM7XX_CLKEN1, 17, "huart-gate", NPCM7XX_CLK_S_UART, 0},
-	{NPCM7XX_CLKEN1, 16, "smb5-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 15, "smb4-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 14, "smb3-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 13, "smb2-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN1, 12, "mc-gate", NPCM7XX_CLK_S_MC, 0},
-	{NPCM7XX_CLKEN1, 11, "uart01-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 10, "aes-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 9, "peci-gate", NPCM7XX_CLK_S_APB3, 0},
-	{NPCM7XX_CLKEN1, 8, "usbdev2-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 7, "uart23-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 6, "emc1-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 5, "usbdev1-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 4, "shm-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 3 is reserved */
-	{NPCM7XX_CLKEN1, 2, "kcs-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN1, 1, "spi3-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN1, 0, "spi0-gate", NPCM7XX_CLK_S_AHB, 0},
-
-	{NPCM7XX_CLKEN2, 31, "cp-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 30, "tock-gate", NPCM7XX_CLK_S_TOCK, 0},
-	/* bit 29 is reserved */
-	{NPCM7XX_CLKEN2, 28, "gmac1-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 27, "usbif-gate", NPCM7XX_CLK_S_USBIF, 0},
-	{NPCM7XX_CLKEN2, 26, "usbhost-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 25, "gmac2-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 24 is reserved */
-	{NPCM7XX_CLKEN2, 23, "pspi2-gate", NPCM7XX_CLK_S_APB5, 0},
-	{NPCM7XX_CLKEN2, 22, "pspi1-gate", NPCM7XX_CLK_S_APB5, 0},
-	{NPCM7XX_CLKEN2, 21, "3des-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 20 is reserved */
-	{NPCM7XX_CLKEN2, 19, "siox2-gate", NPCM7XX_CLK_S_APB3, 0},
-	{NPCM7XX_CLKEN2, 18, "siox1-gate", NPCM7XX_CLK_S_APB3, 0},
-	/* bit 17 is reserved */
-	{NPCM7XX_CLKEN2, 16, "fuse-gate", NPCM7XX_CLK_S_APB4, 0},
-	/*  bit 15 is reserved */
-	{NPCM7XX_CLKEN2, 14, "vcd-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 13, "ece-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 12, "vdma-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 11, "ahbpcibrg-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 10, "gfxsys-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN2, 9, "sdhc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 8, "mmc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN2, 7, "mft7-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 6, "mft6-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 5, "mft5-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 4, "mft4-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 3, "mft3-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 2, "mft2-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 1, "mft1-gate", NPCM7XX_CLK_S_APB4, 0},
-	{NPCM7XX_CLKEN2, 0, "mft0-gate", NPCM7XX_CLK_S_APB4, 0},
-
-	{NPCM7XX_CLKEN3, 31, "gpiom7-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 30, "gpiom6-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 29, "gpiom5-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 28, "gpiom4-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 27, "gpiom3-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 26, "gpiom2-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 25, "gpiom1-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 24, "gpiom0-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 23, "espi-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 22, "smb11-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 21, "smb10-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 20, "smb9-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 19, "smb8-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 18, "smb15-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 17, "rng-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 16, "timer10_14-gate", NPCM7XX_CLK_S_APB1, 0},
-	{NPCM7XX_CLKEN3, 15, "pcirc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 14, "sececc-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 13, "sha-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 12, "smb14-gate", NPCM7XX_CLK_S_APB2, 0},
-	/* bit 11 is reserved */
-	/* bit 10 is reserved */
-	{NPCM7XX_CLKEN3, 9, "pcimbx-gate", NPCM7XX_CLK_S_AHB, 0},
-	/* bit 8 is reserved */
-	{NPCM7XX_CLKEN3, 7, "usbdev9-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 6, "usbdev8-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 5, "usbdev7-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 4, "usbdev0-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 3, "smb13-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 2, "spix-gate", NPCM7XX_CLK_S_AHB, 0},
-	{NPCM7XX_CLKEN3, 1, "smb12-gate", NPCM7XX_CLK_S_APB2, 0},
-	{NPCM7XX_CLKEN3, 0, "pwmm1-gate", NPCM7XX_CLK_S_APB3, 0},
-};
-
 static DEFINE_SPINLOCK(npcm7xx_clk_lock);
 
 static void __init npcm7xx_clk_init(struct device_node *clk_np)
-- 
2.25.1

