Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94128152C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbgJBOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbgJBOby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:31:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E29C0613D0;
        Fri,  2 Oct 2020 07:31:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g4so2073108wrs.5;
        Fri, 02 Oct 2020 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0aTKJ5HZFsSQ+eCcPAw4QelVRGYoHt0VsuUcLv/a/yw=;
        b=bQ8HuosKyxmeQ3WbtUyTHC4zSKTW3v4sCj/w+hkIYKGWd7XdCAZD0GBPUL7DLxQLDJ
         36GQTQg2Y12jWPm3ewVItJvqSrnt9pR/Wr4JyKxDDhzlOlv8G5QRqWubIbQwQr90ENg4
         xkcTBaQMnQvTxw/WVhlSeiOvxfvKvNg74hMXch3/rxGQraMhMLKfZuaSE0Ekow9McZNk
         QjYDmuUq0K5MjR0uEv9zL8OH4ZpAEiS14ZCs2RdeERbOEkKIS0TiwcOKaqlSCj0WYvOa
         r3wmT06NDWs6sqL61W0oa2vup1/eknpbsQgIsbCX6pslMBVRdKxrpZ2aYAegl28QRqii
         61Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0aTKJ5HZFsSQ+eCcPAw4QelVRGYoHt0VsuUcLv/a/yw=;
        b=njNNypJRnarH7zEqi8HBVMGvz7WZQbIrLyfsKYBqU9dpHsaY7CmF32aFu75R96ACff
         mgL00+S/uflf5NSfJKrSYXpsSW5jUNusFzi0rfi7+cLubvSrVBAk4+TESbLFrq+bnpEr
         CuvZ+CnMBgY4YXIAWHhaAiXg6PqXpYEKXHAdKiiJZD9ju2LEaKujdNWOzxkXXMcZtdGg
         A0nJV1TnDsOyBZWe4nBTZDw0Jvw9TOdBd2VkOaGoS+3vLgN8ZAJrQH/PXc+wzjkN72/m
         DW3/ch67QXRV+3dy3tuMT5UCecKaxD5h/d03qidoX/2qk497n//g/co8svdVpPa+1MLO
         qzvg==
X-Gm-Message-State: AOAM530mA/1MVmr62vSK2Vv2IcKfCSqgjb4oiitWRVAxzy+ORQJxE8J2
        nd+5a33IcIytSXzauqlqH4A=
X-Google-Smtp-Source: ABdhPJzmGKTSVIyJKZrq/Ucd6LZFnwsseoUQA8ZLNCQLzqK4EYyKzRlzyq63/XFTwQCkOAT7QSFprw==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr3660294wrn.12.1601649112935;
        Fri, 02 Oct 2020 07:31:52 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:31:52 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 03/10] arm64: dts: meson: add audio playback to nanopi-k2
Date:   Fri,  2 Oct 2020 14:31:34 +0000
Message-Id: <20201002143141.14870-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7be3e354093b..8e5df00b06a2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -7,6 +7,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
@@ -130,6 +131,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-NANOPI-K2";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
-- 
2.17.1

