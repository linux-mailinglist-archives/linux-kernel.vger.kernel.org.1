Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF6293613
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405485AbgJTHup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgJTHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:50:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8851C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:50:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c16so768330wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2CHqTGmRLFM8SxH14NrAbLcG1auMYs1HJe8WWLSeMk=;
        b=H0t6yH47JSVHOZlqce1pEiVYeAw1UwR6yx2vbm3nBHzeVAM2+d3vvklhylW7AhkVln
         iYJQrUMHfnVROfl7zgROAiTkUrE+Jq/RhFhczaJ2dd3B5uy4I2eTIaoZozNBA8x+VZDe
         Ro125OKGKSWFwAuFIHvgRTgjcaorXXX1NnjgZxVNDStq/nxnKTfceo7JLPPJg9oYqi4h
         drfTNXjAD9SsygCzkl5euU4pOPlVNOQknL47COvnqQ9RkNLuTUADL78RpIr2KIJClxSx
         7KiPxbGiHF2+1zOV+agG8LNm6R1831pkLUgDActZ6A+mXOHbGEf6JK+5MSUOMc42Rb5x
         ehKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2CHqTGmRLFM8SxH14NrAbLcG1auMYs1HJe8WWLSeMk=;
        b=XolIUgQjFPwuogtj5by+5ZPeK7oWAt5Au5gay4fM8tLuCVf4e5ZPUuV9DGTm//Y5S1
         1GQyKHAg9enAX73es/bsGCiUrz/ib2GFByihD177X/Nqo31PwUDjXB4dpxsV8KTEW9Cb
         YyJj5djE7V5oh2WJf0nw/zy5kjBVOWg6vcCJR3GTS5UmxkIcdjFlWgzJTMrcCwxTkoTo
         P5uziD9lae4qjIBexADW52EJUKVeqwgX07oqsRTOtx99h1KEujVRTZoE1ttAGoRf0R2P
         i2qcfgmSlFgEZUYX4jm16v+so3fly3WmX23tJFDldiPrJXSx4FVa7cCe4Aph0UnwfjFZ
         GKkg==
X-Gm-Message-State: AOAM5303iID5z3ciZ6n37yIqLt6geV5k3clnZfEU77COEja5OIqOSAZj
        fpudBqsKnwJRqh1OtXpcdlLSQQ==
X-Google-Smtp-Source: ABdhPJxAp0T8Wu0nof3FUngVbIlSCx4PXBGnHY1SZVmSy0ucqgnYFErytdl+DC/K5fnC/RR5+maKLQ==
X-Received: by 2002:a1c:254:: with SMTP id 81mr90965wmc.21.1603180245337;
        Tue, 20 Oct 2020 00:50:45 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id t19sm1504703wmi.26.2020.10.20.00.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 00:50:44 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: meson: ship only the necessary clock controllers
Date:   Tue, 20 Oct 2020 09:50:34 +0200
Message-Id: <20201020075034.172825-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There now the menu entries for the amlogic clock controllers.
Do not select these when ARM64 is enabled so it possible to ship only the
required.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cd58f8495c45..b22d1bdd6eb6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -154,9 +154,6 @@ config ARCH_MESON
 	bool "Amlogic Platforms"
 	select PINCTRL
 	select PINCTRL_MESON
-	select COMMON_CLK_GXBB
-	select COMMON_CLK_AXG
-	select COMMON_CLK_G12A
 	select MESON_IRQ_GPIO
 	help
 	  This enables support for the arm64 based Amlogic SoCs
-- 
2.25.4

