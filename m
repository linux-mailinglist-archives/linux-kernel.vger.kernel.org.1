Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3732AA6C7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 18:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgKGRBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 12:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgKGRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:01:19 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DA6C0613CF;
        Sat,  7 Nov 2020 09:01:18 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so6339645ejy.6;
        Sat, 07 Nov 2020 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6WYOik1eFyWW6JqEZgzc6DFTvnTKfIu799c+q/dYFM=;
        b=q+82+2gk8fgkYlS2QZOF2NaxgnuobdnDkv+5oGgY0Hemy1U06GzPfkKi5lEEhS8Koi
         IDEoQ9qmuM/CMyL8JjAZb4ywVQe/wDNfe6VcSU77cTbp9ooP6qYkgLo/JHB+qxJm3enM
         6OtSxEGACqv1U+S8jxCbr7bK76tCiye6w/Z98DLE+7i1I4j1mlwxz+fVyU400MHyPLRA
         voNy4ISMofTwnIbUEfRbon42l6ph541aP5jCNxOMir++GsS//EbCb60CBDPN7C2yVvff
         jqaLehFlLy183NVEt8wy3RYDIy4lhsDEfKcgxUYbxCcvgRm/wdFp0Pj8K5KgHLLSphXs
         eUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6WYOik1eFyWW6JqEZgzc6DFTvnTKfIu799c+q/dYFM=;
        b=fiedN17DylWiM28OWI68/9wKhtnXCgMyEoh0E7jbn+uG74/wmX4MqOgi3sOatstok1
         LqwograqCTYRx0kh3mh9U1BZipcIXhvS24qifcVIlk7uQs1D37wcIwbWZPxZjlZ0+APC
         7b4dE139eHkUgUWfKrsm0E7+VHzY/IpsJO2j5U2DVqwQwT4D9pvLPQnbJd3oMEbxNp5K
         jxajl3inVBZ5EIAB57fKpHWySuxnCs+Sm+jnlUmuZBpivtokmFBkTwInfItiZuDoqGD6
         D1Df+bcMwZ7klS7z7IGbik89ntphkMV0RmOu78xF8tEyGYqbwdm3ZKh+4lRXQV08DNWp
         kakw==
X-Gm-Message-State: AOAM532XoAusQi3mY6U0ImE+lo6y/zNllgMH2TdQl8N/5no0VQIsc9O0
        Gh7TfdgCHuFy9MyG5OyRXWk=
X-Google-Smtp-Source: ABdhPJxTEYdXvym049Q3hFtyHNLtuX5TdVJVleljfpGwRWjM/CEpq3LAo8d7e3RNXZX+TQe3O0kl+Q==
X-Received: by 2002:a17:906:5a8b:: with SMTP id l11mr2679338ejq.99.1604768477507;
        Sat, 07 Nov 2020 09:01:17 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t22sm3729700edq.64.2020.11.07.09.01.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 09:01:17 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm64: dts: rockchip: add QoS register compatibles for rk3399
Date:   Sat,  7 Nov 2020 18:01:02 +0100
Message-Id: <20201107170103.25608-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201107170103.25608-1-jbx6244@gmail.com>
References: <20201107170103.25608-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip dtsi files only use "syscon" for
QoS registers. Add Rockchip QoS compatibles for rk3399
to reduce notifications produced with:

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 50 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index ada724b12..32e867179 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -855,127 +855,127 @@
 	};
 
 	qos_emmc: qos@ffa58000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa58000 0x0 0x20>;
 	};
 
 	qos_gmac: qos@ffa5c000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa5c000 0x0 0x20>;
 	};
 
 	qos_pcie: qos@ffa60080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa60080 0x0 0x20>;
 	};
 
 	qos_usb_host0: qos@ffa60100 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa60100 0x0 0x20>;
 	};
 
 	qos_usb_host1: qos@ffa60180 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa60180 0x0 0x20>;
 	};
 
 	qos_usb_otg0: qos@ffa70000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa70000 0x0 0x20>;
 	};
 
 	qos_usb_otg1: qos@ffa70080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa70080 0x0 0x20>;
 	};
 
 	qos_sd: qos@ffa74000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa74000 0x0 0x20>;
 	};
 
 	qos_sdioaudio: qos@ffa76000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa76000 0x0 0x20>;
 	};
 
 	qos_hdcp: qos@ffa90000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa90000 0x0 0x20>;
 	};
 
 	qos_iep: qos@ffa98000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffa98000 0x0 0x20>;
 	};
 
 	qos_isp0_m0: qos@ffaa0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffaa0000 0x0 0x20>;
 	};
 
 	qos_isp0_m1: qos@ffaa0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffaa0080 0x0 0x20>;
 	};
 
 	qos_isp1_m0: qos@ffaa8000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffaa8000 0x0 0x20>;
 	};
 
 	qos_isp1_m1: qos@ffaa8080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffaa8080 0x0 0x20>;
 	};
 
 	qos_rga_r: qos@ffab0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffab0000 0x0 0x20>;
 	};
 
 	qos_rga_w: qos@ffab0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffab0080 0x0 0x20>;
 	};
 
 	qos_video_m0: qos@ffab8000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffab8000 0x0 0x20>;
 	};
 
 	qos_video_m1_r: qos@ffac0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffac0000 0x0 0x20>;
 	};
 
 	qos_video_m1_w: qos@ffac0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffac0080 0x0 0x20>;
 	};
 
 	qos_vop_big_r: qos@ffac8000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffac8000 0x0 0x20>;
 	};
 
 	qos_vop_big_w: qos@ffac8080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffac8080 0x0 0x20>;
 	};
 
 	qos_vop_little: qos@ffad0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffad0000 0x0 0x20>;
 	};
 
 	qos_perihp: qos@ffad8080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffad8080 0x0 0x20>;
 	};
 
 	qos_gpu: qos@ffae0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos","syscon";
 		reg = <0x0 0xffae0000 0x0 0x20>;
 	};
 
-- 
2.11.0

