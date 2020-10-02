Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC9281537
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgJBOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:31:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A8C0613D0;
        Fri,  2 Oct 2020 07:31:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q9so1908187wmj.2;
        Fri, 02 Oct 2020 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6vYF1uN6y1MEmfx/aSCmf3xT19pRJOVeWursMQGhdC8=;
        b=AaUyGK84xBFyPVOg0YZiTXYH5egnyUTDIGSp4B3YsaOkc9U3nnFYHcwiwY3ia2ZJd0
         zJjULreOxlvZEtIwUPLlPum3+szJpSsWj7kv7xETTJqISiBgjiQXMa5GSJKusmOmRibo
         Wsr7VJiQkaqQCPXqCr2FYuRfpYTH7pdIyrnjbPoWt4sPobl7CVYSfAXOqf3RGF5U6f1Q
         OCybM9VfznmPRqUuCcQe2vry+0WGUk7pj9HCOj6gU0H8l48UUzCOJs/2+adCV6S2whs6
         QcZPwp2MaJyAAURazMnjYt9KOtfw/mYobKtWrdixyRn/BGMKxUzCigAb+HmPkW4R7jmg
         xUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6vYF1uN6y1MEmfx/aSCmf3xT19pRJOVeWursMQGhdC8=;
        b=udwbQx8zLDApur7Cq/1LExOZpvo4QRTZub/1LozdXb5uJ105hgarQDX7O5KozuLo5K
         WKRAgysLEPOiNoCS0QZOvtKPsU0tuWx47T0ekl6DyYAkKiu/7G5GtVz5zZYOKv3t71zj
         diYHi2lwBnSOtd/ln/ZuKtBySispSDXhhamK8fcrlWygmp82F3t/CQdrC9ZABJ3G2WVM
         6ZeyeVxi5iuEQtngnl9Bhd4s3bknLmaz8eWbzErFVOFMWzPthgNQ1UzKMlQQt3SqZL8W
         KyT9rK+p0qpkhqMTPURkDBvpG+zmsxGUQG9/Hxe3kuOhoGdr/d/wNyTTwNyTJ9FmdycZ
         gOvQ==
X-Gm-Message-State: AOAM530IhlTNMzR8O5uJwoHvEUYOU+7IN2qoLGYkWz/nz6Vbu98QaAEN
        ClAxQxYZU+69UBMjLOfjkpI=
X-Google-Smtp-Source: ABdhPJzq2KLlz7Op/+6RpflhE0nKkBEmL5fs38a+YROdfaB2AoGUhFbZYrhx5MjHepSHaJ41Q7AYdA==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr3202779wme.18.1601649115216;
        Fri, 02 Oct 2020 07:31:55 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:31:54 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 04/10] arm64: dts: meson: add audio playback to odroid-c2
Date:   Fri,  2 Oct 2020 14:31:35 +0000
Message-Id: <20201002143141.14870-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 70fcfb7b0683..9d8c919c6e19 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -9,6 +9,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
@@ -172,6 +173,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-ODROID-C2";
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

