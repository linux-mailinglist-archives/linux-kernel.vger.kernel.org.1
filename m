Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31B12AA6C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgKGRBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 12:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgKGRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:01:18 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8BC0613CF;
        Sat,  7 Nov 2020 09:01:17 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o21so6346494ejb.3;
        Sat, 07 Nov 2020 09:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieXuoaRLe75wW+v2XILXUGMGBXmYTfCH1LnRyaQZz24=;
        b=IMymneUlVsgmwBGy+Sba8XB11v6voMGhcviGnsGxeliL/aOkPbX86fTs2CjbYbMKyX
         aAWFldK05YJv+IbqYLy0W9Y2pwrNH4iyz9/rS0wfMQguNswH3R8Fj4VQy3d/jV+MHBB0
         ixmJ9iHo0SvnSLaEXXLcrnBHmEFlMPO3CvKyAFT2waNmY5iheXu+qwJjY9tVo6Gm3ynV
         6uKaitGJGKsCFj5PN7wkdiAim5uCNNulv1nTfSQKgHWpIlUAMCMQFVkeOLmIgZEdV2+i
         1/7yRMrXLvaxcZnPmpOVEvXEpZpSwJjphOis6WfK6MqPuhCrLDlX6izV3W+TyX1zSI9M
         iP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ieXuoaRLe75wW+v2XILXUGMGBXmYTfCH1LnRyaQZz24=;
        b=KK73oT3g9+eNLWz0il+Xl14sFC5ccAxGw1DT+LKlq0Q5WYeVg+Yvlzn8oNIgkwSkYi
         lHmXxYcD+5KS6b2e89qmr85tdzDzJaz0X/ZIGkA1ypU1jRW/bOomwlJOvSuMj0lJZl+k
         ToHp4HwqHt1UYEbekhZ6g92LyYDuJ/YPTd7ONb4UJLHQPLIRgM2+sbv8x6z+ACF+H7AQ
         6ap7CvUxoBf2OvKgseV0RObiJqeCo4F/QA23eJj3SZxS47Djge4nvIVX/oeIhFFMNhu+
         t4dN93IsG4kspgd4AArg4eIAdLC+dRh5LwY8zG+gXiwgkqLsC7GCPcJBEdn/ls37ZQlm
         QpBg==
X-Gm-Message-State: AOAM532UGUAoexzSJc3CTNrdDzB6G/f6Mm9E0KQhPWsUYd20FSoi+dCQ
        v1ePiiGwHZbIpKEHEOdqNP15vXUcfv1uMQ==
X-Google-Smtp-Source: ABdhPJxMCCqsWil0e2tUXcUcEaUmgB+bjMd1ick/fAe7iO79ry1SM4aUsiAahJPSXP7yKJncZex5Lg==
X-Received: by 2002:a17:906:5e02:: with SMTP id n2mr7014215eju.295.1604768476492;
        Sat, 07 Nov 2020 09:01:16 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t22sm3729700edq.64.2020.11.07.09.01.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 09:01:16 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] ARM: dts: rockchip: add QoS register compatibles for rk3288
Date:   Sat,  7 Nov 2020 18:01:01 +0100
Message-Id: <20201107170103.25608-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201107170103.25608-1-jbx6244@gmail.com>
References: <20201107170103.25608-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip dtsi files only use "syscon" for
QoS registers. Add Rockchip QoS compatibles for rk3288
to reduce notifications produced with:

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 68d5a58cf..d65f3b7b3 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1329,72 +1329,72 @@
 	};
 
 	qos_gpu_r: qos@ffaa0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffaa0000 0x0 0x20>;
 	};
 
 	qos_gpu_w: qos@ffaa0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffaa0080 0x0 0x20>;
 	};
 
 	qos_vio1_vop: qos@ffad0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0000 0x0 0x20>;
 	};
 
 	qos_vio1_isp_w0: qos@ffad0100 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0100 0x0 0x20>;
 	};
 
 	qos_vio1_isp_w1: qos@ffad0180 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0180 0x0 0x20>;
 	};
 
 	qos_vio0_vop: qos@ffad0400 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0400 0x0 0x20>;
 	};
 
 	qos_vio0_vip: qos@ffad0480 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0480 0x0 0x20>;
 	};
 
 	qos_vio0_iep: qos@ffad0500 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0500 0x0 0x20>;
 	};
 
 	qos_vio2_rga_r: qos@ffad0800 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0800 0x0 0x20>;
 	};
 
 	qos_vio2_rga_w: qos@ffad0880 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0880 0x0 0x20>;
 	};
 
 	qos_vio1_isp_r: qos@ffad0900 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffad0900 0x0 0x20>;
 	};
 
 	qos_video: qos@ffae0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffae0000 0x0 0x20>;
 	};
 
 	qos_hevc_r: qos@ffaf0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffaf0000 0x0 0x20>;
 	};
 
 	qos_hevc_w: qos@ffaf0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos","syscon";
 		reg = <0x0 0xffaf0080 0x0 0x20>;
 	};
 
-- 
2.11.0

