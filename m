Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD7E2D02E0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLFKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:38:01 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D83C0613D4;
        Sun,  6 Dec 2020 02:37:21 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so11431155ejb.8;
        Sun, 06 Dec 2020 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFioyBuaA7P/CaN8KPNLk/A238y67VVNWx1+jOsbupc=;
        b=CMCpSGLniD9j7BmFIwiijydumPCSv/E2QSiv93q5nF6/NEk2wD3AN5xCfExB3Uf9f7
         55egz1RGQwlgNO6h76SWHWusYQ3JgpempD7ku65HViJCZo9BkhJx5Cso2bkF7aiXkJHE
         4iSXESvj1UCDwBe7Za+QRzlu09bMXhhrqBNo2PC6MhfhydkQLRzZLVM6UTNqSjRcZ/VA
         wEL9xu1ZfZ2JjtVMXc8blzNgP+jX45mXcxAnnQ3n1AiTS849FqVv/VtaPVXNbThjgKsF
         EPLa5poFNoX7dJs+btSBtC2FAWsHQkCXnAOuBziPAm+HDT/zHCXOOkxcaDWwotf50+c9
         FVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFioyBuaA7P/CaN8KPNLk/A238y67VVNWx1+jOsbupc=;
        b=a3xCst1qzZM+KK0LClkoMjFKW6R4xNzDnBZRhe25rx3ClHCaGvnKuM/cTVHxPxv+Uu
         k2Y5G8uGUovOrB3eFHBCG9VZ9sYjK3sGR1NyQBoq1E+F2PgHpSFT3UMk11N9hAnhk6sF
         VcqEUw39KgJT1OK8Gpo4DvsviH2cpodSHrowOKcA2K+t+R8YnVE4zQSi7ZHauxDPdKnB
         4kni71UutIhEeedyfs72bHcMaBFqBa98e5wjG5mxGmZvO9jXMfDz5c8nGgwG+2jfWPrH
         sqs/Fet1VAbhqEcp7cdIixoZ788BRFLvu2//51cNSYDF4vu4WLSncXpJXHul1tCTY8vt
         4a6A==
X-Gm-Message-State: AOAM530CPlXPBFexrHGZm8C0w5pM0dOWNtCr8JTQwB3fepLG2rHZbg+e
        bdnXbsATWrOYpuSSP7asect5ok+/63vxYw==
X-Google-Smtp-Source: ABdhPJyqhTPmdai0VekCVvi2CAKqTIRE3l2PC1YeXkVgIX1oIIfbg4WX3lvFeqEcE3vOEpvfM4I2VQ==
X-Received: by 2002:a17:906:f0c3:: with SMTP id dk3mr14441372ejb.366.1607251040277;
        Sun, 06 Dec 2020 02:37:20 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cc8sm7811556edb.17.2020.12.06.02.37.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:37:19 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add QoS register compatibles for rk3399
Date:   Sun,  6 Dec 2020 11:37:10 +0100
Message-Id: <20201206103711.7465-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206103711.7465-1-jbx6244@gmail.com>
References: <20201206103711.7465-1-jbx6244@gmail.com>
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
Changed v2:
  add space
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 50 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1aa52ec93..2b99480ea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -855,127 +855,127 @@
 	};
 
 	qos_emmc: qos@ffa58000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa58000 0x0 0x20>;
 	};
 
 	qos_gmac: qos@ffa5c000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa5c000 0x0 0x20>;
 	};
 
 	qos_pcie: qos@ffa60080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa60080 0x0 0x20>;
 	};
 
 	qos_usb_host0: qos@ffa60100 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa60100 0x0 0x20>;
 	};
 
 	qos_usb_host1: qos@ffa60180 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa60180 0x0 0x20>;
 	};
 
 	qos_usb_otg0: qos@ffa70000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa70000 0x0 0x20>;
 	};
 
 	qos_usb_otg1: qos@ffa70080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa70080 0x0 0x20>;
 	};
 
 	qos_sd: qos@ffa74000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa74000 0x0 0x20>;
 	};
 
 	qos_sdioaudio: qos@ffa76000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa76000 0x0 0x20>;
 	};
 
 	qos_hdcp: qos@ffa90000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa90000 0x0 0x20>;
 	};
 
 	qos_iep: qos@ffa98000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffa98000 0x0 0x20>;
 	};
 
 	qos_isp0_m0: qos@ffaa0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffaa0000 0x0 0x20>;
 	};
 
 	qos_isp0_m1: qos@ffaa0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffaa0080 0x0 0x20>;
 	};
 
 	qos_isp1_m0: qos@ffaa8000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffaa8000 0x0 0x20>;
 	};
 
 	qos_isp1_m1: qos@ffaa8080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffaa8080 0x0 0x20>;
 	};
 
 	qos_rga_r: qos@ffab0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffab0000 0x0 0x20>;
 	};
 
 	qos_rga_w: qos@ffab0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffab0080 0x0 0x20>;
 	};
 
 	qos_video_m0: qos@ffab8000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffab8000 0x0 0x20>;
 	};
 
 	qos_video_m1_r: qos@ffac0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffac0000 0x0 0x20>;
 	};
 
 	qos_video_m1_w: qos@ffac0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffac0080 0x0 0x20>;
 	};
 
 	qos_vop_big_r: qos@ffac8000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffac8000 0x0 0x20>;
 	};
 
 	qos_vop_big_w: qos@ffac8080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffac8080 0x0 0x20>;
 	};
 
 	qos_vop_little: qos@ffad0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffad0000 0x0 0x20>;
 	};
 
 	qos_perihp: qos@ffad8080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffad8080 0x0 0x20>;
 	};
 
 	qos_gpu: qos@ffae0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3399-qos", "syscon";
 		reg = <0x0 0xffae0000 0x0 0x20>;
 	};
 
-- 
2.11.0

