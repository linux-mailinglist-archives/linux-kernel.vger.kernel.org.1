Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865642B4BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgKPQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbgKPQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:59:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F669C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:59:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so19495709wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4o16G5GsEBzaMz1BZ2zcZ9qXzaDUaxARAp7qkrnK8s=;
        b=hNwjUvnNzsCBml6kwZR5iJ51i0E49/ZIjaKRBb1DOl8pzpI8wYtdpV0caP4OVb5U80
         0XpHY1GljQ7vMNY7oOd12FMDQ+6LqgibOD94hI4msC7PYt2OnDmSLDTcdY+ej4CX8ab2
         78PEbC3Bkm8WgVHwoJLEQO8Yhwarz9BgTPF25YYXGTxM7dFXIhImveocO541qB251SCW
         UBXQODA2HyU+f0eB0zyn7A74k8ocGocUMj8AiZBKWR0g/JUPB16wRtVhuJ3RyfYiYxwY
         CLD+lIXOFBdCdsIeEAXFDJjT73OCqZ0Dtp1CnuFsaDP89kh6mc2E52a7x+2u+7mO0a9K
         iqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4o16G5GsEBzaMz1BZ2zcZ9qXzaDUaxARAp7qkrnK8s=;
        b=pDHeznPxdlktEDjI4pGuHKoDFKlXZdFNUY0aKixwiFiqjR+ZGjq35iVY3tcVlm2UTp
         c80Spw98oP/+j+aIonegXdnZzrtQfJwK5le9FVvYR/yGSK+of034qEN1Jf5ux5Rkiguo
         5y0ObnvtY/BKiT7cZcS/f6z3tucNka0PhJ1tUTCJCupp8VOBTtx6o2cDt1x/cwVVtNHt
         t5i41kxEVPkEX5WQ/dUpypusJVaT/BrFga8+b4LH/HWciAOes7i0NxDUpHQU1RBz9N6B
         IEBINSTQFHkcCyidz9Xj+NU5MEU95ZhXhdehmvcjRG8piOiiYdUL62hdDSzOKoEX2Iki
         U+PA==
X-Gm-Message-State: AOAM530Vty4biFSCcjQkLSbxdPdOfMp5ZCryMSCdu/GnXCCSrgYAn7lB
        rdH/e13LJXX/vCGhJVaOX6O8Ow==
X-Google-Smtp-Source: ABdhPJxAVdffrUmZu/MYmWLDC1IA4nYoGvNkWJgPrDQlADP0wxYuEUxekdaZMa9gUe34hcpIdfhD5Q==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr21892549wrt.158.1605545941309;
        Mon, 16 Nov 2020 08:59:01 -0800 (PST)
Received: from starbuck.lan (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.googlemail.com with ESMTPSA id a14sm3582188wmj.40.2020.11.16.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:59:00 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: meson: select COMMON_CLK
Date:   Mon, 16 Nov 2020 17:58:53 +0100
Message-Id: <20201116165853.544263-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix the recent removal of clock drivers selection.
While it is not necessary to select the clock drivers themselves, we need
to select a proper implementation of the clock API, which for the meson, is
CCF

Fixes: ba66a25536dd ("arm64: meson: ship only the necessary clock controllers")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 
 This fix is a side effect of this 0day report:
 https://lore.kernel.org/r/202011151309.DVCsUlLh-lkp@intel.com
 It shows that we need to select an implementation of clk.h

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 329e22c09cad..484e81f39db7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -151,6 +151,7 @@ config ARCH_MEDIATEK
 
 config ARCH_MESON
 	bool "Amlogic Platforms"
+	select COMMON_CLK
 	select PINCTRL
 	select PINCTRL_MESON
 	select MESON_IRQ_GPIO
-- 
2.28.0

