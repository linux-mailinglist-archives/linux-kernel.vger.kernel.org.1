Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23C928AA51
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgJKUXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbgJKUXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:23:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB6C0613D2;
        Sun, 11 Oct 2020 13:23:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so16039206qkg.8;
        Sun, 11 Oct 2020 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=HA9IN0PmUIZofBmTY8XvM87K5i7WJRyPJNkD39W9ybemEznUZKpNd0xzHGhhPAOiT9
         DHTKBnGOqKa/SkKM+1cJzlnIGgimA6K3F3Gx42VPCslyfDapMd3k2EgEfj5dmfo6QQqo
         +Q0xOJVyFuNyNdcz74o/yAQhxVZMKXsSE66TGAdzBUstfB/2qb9CTskoB0oiyfcFSwGH
         ZZAZHYBZfluBZJrAs3dB+jewhpOy9cSOHAVdEXrMmzq8UFNNJxws0B97GQKuxSm6mFa1
         XwdAU8mW98pxQQs/vZOX/jarzAuXsID5l/mGzLOtAmWXiTCMPau1SUccSHOa3hNMellE
         JkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/UCGl1ZdUoHsUHtTTTH+r1dTXLa/BTl7CcT5LFzhtQ=;
        b=EeH3bdOdD+xmksQlaB7/4RlxlPaFasaHz3jL8mvi3jc4zsXoBDYDDLmAhIocwEaTIj
         zqLKvo7yZjCKFuIwrHJ2wnSuLtSYj5QY9eUAzz604cgEtgHssSqcFe3cm0+t71TsVFZ/
         fScRXQ4ZuXAkhpKgU4aV7IDydNZo/Yejf56vP6Wf2mRPLMNntcdUiC9KY0s8h5Zm1pyp
         h4LK5B2ef6+AVh5R7fXqgnJn9wMneC3qQUbSFll3OR9OB71PYFzHSUU8R6cypBGDjpJ/
         zRrqCa1Myg4rZx/GexwUpCEtpPDjxema3qwx305Y85xFQ+utlR1cYpRp3yXNecXeH5YY
         6new==
X-Gm-Message-State: AOAM531BwsmRooBCq8hkrvQayZHqVvpAW/0h6ePlCkP0QdmYqdQudXIu
        xkD3PFzY0G8oeAtlNPmJ97M=
X-Google-Smtp-Source: ABdhPJws5vyyslF2xzy4sBp8tTEWCRLz+Qwa9ZngcFbttqK5qxibjMacG+/w6rE7cqSZt5jDOfdWUQ==
X-Received: by 2002:a37:7286:: with SMTP id n128mr7137973qkc.423.1602447792683;
        Sun, 11 Oct 2020 13:23:12 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:23:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v7 14/14] arm: dts: sunxi: h3/h5: Add I2S2 node
Date:   Sun, 11 Oct 2020 22:22:24 +0200
Message-Id: <20201011202224.47544-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add H3/H5 I2S2 node connected to the HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..9be13378d4df 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -662,6 +662,19 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 27>;
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		codec: codec@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-codec";
-- 
2.25.1

