Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67528153A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgJBOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgJBOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:32:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C800C0613D0;
        Fri,  2 Oct 2020 07:32:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so2089869wrv.1;
        Fri, 02 Oct 2020 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+sbzGxZrB59pV6U+pYub8QGMoi1y6WlUsM0RAR+NpTo=;
        b=pj+8VvXslvuR3nz30A+DMvVhA7P3mGzEZM4S+FepgZ31cslIdvG/+u0VyLgbloPvMK
         veU5sTbMR3FEVFx2IM58C0rYfDnujRBsIKrfgBaV0Gd91zjNkwYoKtSl5p9D+QSfbNmr
         ZiB75D6poMj95qN/gRi3fBbLFrfv6XJseAhKryMINkwN1JxPvwt+R2mvshlnxUP8/KVB
         Z/qd07ahj+xSmBYdyvaS4SJ6F7EtiDMRUegW7w1g4JEzEBMSWGV8InJSe1uNOVeZUkQg
         ESgtpboIla6tU69jWn6uN3XqOmy6mFH5EU+cBQu+kzAn0dQH6hieWfdgUktRKFIOW9Rx
         ur0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+sbzGxZrB59pV6U+pYub8QGMoi1y6WlUsM0RAR+NpTo=;
        b=jjjkJB2m4y4otHBL6W7mXMuvnTI34QhQQPctHQr5yW8WU5zs9DQ4h7G+p14jxlowLq
         Kd7RRKBkFzfVh5xCqUPd31NzS/Hl8wTPIZFOm7vjrVF2XivG0N6M/7y2QN8JhKHyTj1l
         nqQx7ayFQ6BwO3K6HIOdmPJmX5OuyU1Vy+3Y95aRodZWkkSGtYOmf9b6Ajw7+fv7jfHw
         jt0Co8CEEX1kuOXT/S6kFRm4RPshx8pb+DSwncJZxizOkQFyKwBWpOwsXcTnOswxYwRX
         xRnhTZFKg4OYq3q7D4eJ8XYF1pGFHDZQiTlbZs7rWCQEOAgk7SIi6jUPlZq5KU6arehA
         c6dQ==
X-Gm-Message-State: AOAM533GzlyWIY0IGmPZzKqwZQxs97C38OHLsION3N1pTR3inss8qj4g
        Q31pqw8AkZ2J+BMbf8H3cec=
X-Google-Smtp-Source: ABdhPJyAARAGtC9AIxB8XDdTw4yZaEo0GlJvTcgHnIwHrklz8Y0xB7FJfZCmlZBWWSx6HDVfZUzXaA==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr3284284wrs.232.1601649127049;
        Fri, 02 Oct 2020 07:32:07 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:32:05 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 09/10] arm64: dts: meson: add audio playback to wetek-hub
Date:   Fri,  2 Oct 2020 14:31:40 +0000
Message-Id: <20201002143141.14870-10-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002143141.14870-1-christianshewitt@gmail.com>
References: <20201002143141.14870-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index 83b985bb015e..0c1570153842 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -7,10 +7,50 @@
 /dts-v1/;
 
 #include "meson-gxbb-wetek.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "wetek,hub", "amlogic,meson-gxbb";
 	model = "WeTek Hub";
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-WETEK-HUB";
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
 
 &ir {
-- 
2.17.1

