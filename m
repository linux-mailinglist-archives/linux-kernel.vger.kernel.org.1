Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426922C63BA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgK0LO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgK0LO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:14:57 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981DC0613D1;
        Fri, 27 Nov 2020 03:14:57 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 142so5501867ljj.10;
        Fri, 27 Nov 2020 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDWcuAGJpVIB8jmN1qUTefyqwOuMfUN9elWty78uNLY=;
        b=mS9fRCBRWyl0XMX4oSvM+Q8kaLnTBcvNMKSossAvlAlcQNz8bjQQQ2Akp6JtWUWJ/t
         4AXAPAqU2E3XYmxqpuxlo90V/7XkO4INXvCCYKWK5tEWuU/kvltjy5GE9Wep/O7B1PyW
         +Fp+fioQbWAQ95MDehgSS2CYL/eHck1cy0o+ZBF0m8goTE8GIuAFNEYiKGR1PBJjywQf
         b4s/hASjJcqzcMbVjij8CtSiomj63Q4zuZav+5/UWbnHNW5jXLDKNXcAE60HTF2ZchwY
         pjVnqyIaqECv9PzQN+eDTMnnzWlnsqp7Ygo3ZBuWPwxoJbmKtipUJgVdxxF8VEdjPqEB
         aNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDWcuAGJpVIB8jmN1qUTefyqwOuMfUN9elWty78uNLY=;
        b=sJ6Q9vnBKawvb8Au1N1UIu56TQs1CoMK89iQw3OTYiDierL+gffmKyPj/L1P3zIhDf
         NAZ3yvmdGM/KyBWKaDGjWjgXXM7QKXK8zIXz148bi9NBct3sDmrgeDKp2spdcIOIjtrg
         EyVls6yuvIcjiZ4XXxlSZlh+HDkRLJwoaDEZbQ+QdX0pSPCKfNFXJGXpMPhnAHKfl9z/
         mjXUhEcWxUOqwheDjtcalmfLMhKX2e7K3Z82FadCdYy9p+N8F3FfQRktvEtqEF9T0m7G
         uaqQSWAjpI738nBBTt20lU59RP3cRchyr2fp5CbLgDVZW/EhC/nB3HztdipofYCjjqS/
         /2zQ==
X-Gm-Message-State: AOAM533YWc72+eKJyYKZ8Eg0DlbUdV9keEhHhEHTETJ7xTsZyDvYYbfT
        k42NP7z2X4TIpLnaZRGluBNLv4bfRyA=
X-Google-Smtp-Source: ABdhPJwq4yuMS2CfUYhmRKfw0eg7DOGOi1fdexGaLty3eXtS7m2dO3ieqrD2jjYFLrGLrgzpm279pw==
X-Received: by 2002:a2e:b055:: with SMTP id d21mr3283608ljl.131.1606475695535;
        Fri, 27 Nov 2020 03:14:55 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o7sm921105ljg.41.2020.11.27.03.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 03:14:54 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] reset: simple: add BCM4908 MISC PCIe reset controller support
Date:   Fri, 27 Nov 2020 12:14:42 +0100
Message-Id: <20201127111442.1096-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201127111442.1096-1-zajec5@gmail.com>
References: <20201127111442.1096-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

It's a trivial reset controller. One register with bit per PCIe core.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/reset/Kconfig        | 2 +-
 drivers/reset/reset-simple.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index b7e377a32c92..f393f7e17e33 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -173,7 +173,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
+	default ARCH_AGILEX || ARCH_ASPEED || ARCH_BCM4908 || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index e066614818a3..4dda0daf2c6f 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -146,6 +146,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "aspeed,ast2500-lpc-reset" },
 	{ .compatible = "bitmain,bm1880-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "brcm,bcm4908-misc-pcie-reset",
+		.data = &reset_simple_active_low },
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },
-- 
2.26.2

