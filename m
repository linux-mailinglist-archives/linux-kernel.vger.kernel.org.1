Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D546E2995D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790901AbgJZSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37235 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790532AbgJZSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id c16so13575180wmd.2;
        Mon, 26 Oct 2020 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=u92gL6J5QB2wSKmArlF123sP8XwwWi+2NKdf4veonS68veeQLO6FOpGw3MyzwrD0T4
         4FgkFebcUrBd40EwOKP0QbEeccHu1cdWWL2jOWXmnvZTdJ3zkUdB0PxoB8ZHjzbsYrzP
         6jJ0UDiqaU6bZlX0dIKlRIjNbN1N63tu76uTKjfcz/rMaz7tVv93lytst3mUoe6f+qh6
         xeNDlgL3z7LFizkwxkw140LGmYuqMPHiW68mlbCBuLq8GZMu0rcf+3LmUhvNLlkA/O/X
         yOn1W1ItYbUuq1AwPFkU3wpkJOdb/d16IXEweZ27LDfiuEaUsz+HwvF+qOLy4OECvEku
         m4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QarSYS8sybXOFMHVXdp4I9fWDCgninS8jZ0IjR0OesA=;
        b=DKFdOcff59SdVfqCZNBxOVEC5aMOWm3PWPjh06b09AmKiDwhTBwqJLvsBZHoaOQ5td
         nngv7etoG4z7Nh0ByP3e0+pN++YfYqHhthWny2C+YUxjGNsfnAIcgQ7xv+D8tS08LTUM
         D437Yj7NumFxiknXuVVmiIXVbeYK6ybArXATolN6PXMgzqVDckVORNphlaGRjThgG78I
         AAHqC7BqtAg8mzcjD9URuQulJFHs0XNEtVEcXNA2dSeZJgboctUsYqiqF6HCOKoT+vLr
         sufaELMILWvyitnPatHaQeozSQCzSx23VARLGkLtEYJiwEF4B3NkXb9BBlw7Aulmpywl
         MEgA==
X-Gm-Message-State: AOAM533WigAjLAQmg0NI+POgbzecxOIckSm3e57Xvpqx3Ks3M/onTQKv
        J8PtdoJNk6XSfk7HvfNHw08=
X-Google-Smtp-Source: ABdhPJxgw5SMQfquJqSrV6lWqN6sjacFWgBT9bI/RfmLwJG2Tyts6s4IQJrbsVWk+LiwpvA8cNv+Tw==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr17326513wmj.52.1603738374351;
        Mon, 26 Oct 2020 11:52:54 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:53 -0700 (PDT)
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
Subject: [PATCH v8 10/14] arm64: dts: allwinner: h6: Add I2S1 node
Date:   Mon, 26 Oct 2020 19:52:35 +0100
Message-Id: <20201026185239.379417-11-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Add Allwinner H6 I2S1 node connected to HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 28c77d6872f6..d915aeb13297 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -609,6 +609,19 @@ mdio: mdio {
 			};
 		};
 
+		i2s1: i2s@5091000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-h6-i2s";
+			reg = <0x05091000 0x1000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 4>, <&dma 4>;
+			resets = <&ccu RST_BUS_I2S1>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spdif: spdif@5093000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-h6-spdif";
-- 
2.25.1

