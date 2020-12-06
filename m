Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB512D02DC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLFKiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:38:01 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71CEC0613D1;
        Sun,  6 Dec 2020 02:37:20 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id d17so15187539ejy.9;
        Sun, 06 Dec 2020 02:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aM9iIOktHmsTxuO3hu40BJkplZLp0Yh807OLHKdklo=;
        b=a7ddm5nrcaYnaJQ3hhMtld0cfrNLDbmqlUy3j3nSjffAI1a/ZAlPZG5Wqb7Kdzexum
         TwbAXB01eLH6j5QKY5HF3IfemVSvyodPeFDM4m4ihJK0Q14uJFz8MXECNnZgIfCprARg
         YeL/A7IlIPhfodyRR5VFvhVVtNJau+tVICHceE9NV+Nh1G/LZu+4D1CqJuF1mkdlmDtw
         2SXBKatmkHLBPXSgIpRffqUeVBrYv8ZU/qMTgB4aJxkciqTZAZVIvreAue/iBgYPOShL
         wjinyO/IPICxtkMkPiwUYtEvefhmemvDOl0i6dZBPQbL4juUqV66xha/+qrYBlkjbYaJ
         wY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aM9iIOktHmsTxuO3hu40BJkplZLp0Yh807OLHKdklo=;
        b=qE8H+CjombZv5n//bg+C6p8dsClF/aJTVsNf2mIjmkadeVh4I6Gpup+HndVKVFlQVs
         zHulPfeI70YdXC9+Wek4uMOIZfCAqpOh6EfeEyzbr7RBQBcAuFc3i49wCGHdV+f34jXs
         S6OSptoL8h9rKBelVVg4oxD64K/OQtB0ivVqazA2hrmxgk5UcNfYMJsFlCAI1mdV8d4t
         cl4cip1KVZOB/a5wh3R0ljZGdcTuRSobA7UbwhdQjVM2tSBJoKhYGe3R7OvlNk6SFS8J
         DHBU7uf5tJfO1JXzJs8jsMi1fm4v8UmD1jOsOlnUShwaRJyjhlGomKJ1J6wd4Jz1omuP
         L/ww==
X-Gm-Message-State: AOAM53021ZBrC12GZPsFxniltlBYkvb5BvqfHjfcwxHl0oZz9f2k2cQQ
        hURS4lwBZ5NlaJsXjH1Tz3RKBSTQK8baLA==
X-Google-Smtp-Source: ABdhPJxGQ3BM6taSvVa9uhTTlEg7D/i46KNwGXDhJYoOt7bTLS7NomV1oF8AdHywDN74f3uRbww2tw==
X-Received: by 2002:a17:906:27d1:: with SMTP id k17mr15176498ejc.325.1607251039345;
        Sun, 06 Dec 2020 02:37:19 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cc8sm7811556edb.17.2020.12.06.02.37.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:37:18 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: rockchip: add QoS register compatibles for rk3288
Date:   Sun,  6 Dec 2020 11:37:09 +0100
Message-Id: <20201206103711.7465-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206103711.7465-1-jbx6244@gmail.com>
References: <20201206103711.7465-1-jbx6244@gmail.com>
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
Changed v2:
  add space
---
 arch/arm/boot/dts/rk3288.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 68d5a58cf..01ea1f170 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1329,72 +1329,72 @@
 	};
 
 	qos_gpu_r: qos@ffaa0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffaa0000 0x0 0x20>;
 	};
 
 	qos_gpu_w: qos@ffaa0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffaa0080 0x0 0x20>;
 	};
 
 	qos_vio1_vop: qos@ffad0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0000 0x0 0x20>;
 	};
 
 	qos_vio1_isp_w0: qos@ffad0100 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0100 0x0 0x20>;
 	};
 
 	qos_vio1_isp_w1: qos@ffad0180 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0180 0x0 0x20>;
 	};
 
 	qos_vio0_vop: qos@ffad0400 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0400 0x0 0x20>;
 	};
 
 	qos_vio0_vip: qos@ffad0480 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0480 0x0 0x20>;
 	};
 
 	qos_vio0_iep: qos@ffad0500 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0500 0x0 0x20>;
 	};
 
 	qos_vio2_rga_r: qos@ffad0800 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0800 0x0 0x20>;
 	};
 
 	qos_vio2_rga_w: qos@ffad0880 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0880 0x0 0x20>;
 	};
 
 	qos_vio1_isp_r: qos@ffad0900 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffad0900 0x0 0x20>;
 	};
 
 	qos_video: qos@ffae0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffae0000 0x0 0x20>;
 	};
 
 	qos_hevc_r: qos@ffaf0000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffaf0000 0x0 0x20>;
 	};
 
 	qos_hevc_w: qos@ffaf0080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3288-qos", "syscon";
 		reg = <0x0 0xffaf0080 0x0 0x20>;
 	};
 
-- 
2.11.0

