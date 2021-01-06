Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9152EBB40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbhAFIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbhAFIrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:47:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D8EC06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:46:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l23so1247322pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53HmeNCId56TyprTPiCTxLLId7kfWvnwGYjjv2jFeKo=;
        b=AdVNFfI6g/+Peyo3N6YUcwALG9C/6Lg12CpHr1ce54Xw8HxwCQXNqc3DVReRHnmnV4
         Z9HmRiOLTAOiAHowNoy6ri4ooZZwaHOOfig7ryMSQNUOt+5CMMUCfOUyVWfWfGIlUf62
         3Ave4W3jFHywlocQErtqPoiDtzCzi1JS1NYB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53HmeNCId56TyprTPiCTxLLId7kfWvnwGYjjv2jFeKo=;
        b=YzuGuG1j9mg/q0brStRKfkx3y4uOX30rfCrsuNXm9ibf7UYjBGjIuWuJNiLH48wbu1
         LvpH9K2x7ttqx7q5gCwdEL9s0r7vPnJZFAghnIZD6qUiH25mAZXkeFcghSiPHKD7qeOK
         JYMRfA/G0Lzn/iNFakDeZfOUPAKQjIgxsT2wh7TLhMUykVm9yvIduzfsxXKEG5rWl3zn
         AQZV3LtJ+ouNnGix6chZUuHdBmAxmRC3QtvKEiC+h2tO/ucVDOpDcqrkOF4tYM8RiJBt
         lw5hjN+hHIRU4S3bfO3ZtCFxCZCspK3D1TST6AsjF3Y41Dnb4TYANYDuMsdL/YQbwCYq
         7dMA==
X-Gm-Message-State: AOAM531M2DRnzjn9iN3jCN4jjoPIPUOyAuI20Schly7vFgaHewBumqMb
        3boKCsC7A4fwgO48PbjWrmKOoQ==
X-Google-Smtp-Source: ABdhPJziHVDPeUCi5Utppw8W+tY+4u1RlOrf2iChI9GgDLMJYKK8sUvnaovvgCjgcxX6igQIICAzlg==
X-Received: by 2002:a17:90a:6d62:: with SMTP id z89mr3337414pjj.71.1609922792324;
        Wed, 06 Jan 2021 00:46:32 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id a31sm1913401pgb.93.2021.01.06.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 00:46:31 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: mt8183: config dsi node
Date:   Wed,  6 Jan 2021 16:46:25 +0800
Message-Id: <20210106084626.2181286-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Config dsi node for mt8183 kukui. Set panel and ports.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index bf2ad1294dd30..4cfb3560e5d11 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -249,6 +249,36 @@ &cpu7 {
 	proc-supply = <&mt6358_vproc11_reg>;
 };
 
+&dsi0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	panel: panel@0 {
+		compatible = "boe,tv101wum-nl6";
+		reg = <0>;
+		enable-gpios = <&pio 45 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_pins_default>;
+		avdd-supply = <&ppvarn_lcd>;
+		avee-supply = <&ppvarp_lcd>;
+		pp1800-supply = <&pp1800_lcd>;
+		status = "okay";
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+
+	ports {
+		port {
+			dsi_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
@@ -547,6 +577,14 @@ pins_clk {
 		};
 	};
 
+	panel_pins_default: panel_pins_default {
+		panel_reset {
+			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
+			output-low;
+			bias-pull-up;
+		};
+	};
+
 	pwm0_pin_default: pwm0_pin_default {
 		pins1 {
 			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
-- 
2.29.2.729.g45daf8777d-goog

