Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D722D02DE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgLFKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgLFKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:38:03 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C2C061A4F;
        Sun,  6 Dec 2020 02:37:22 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so15245685ejb.3;
        Sun, 06 Dec 2020 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDtc4U1SrIvcrwzir8Ie4AKFcuKd6oNqPV4vKCYPco8=;
        b=WRy+ipNvJGTRViTBfEjx35T2YHd0IZuAzVWsTyjivU/2fs+hHYIAb6Yl8wVEmETaFw
         COTR6/if4PysZyBA1QdxV1ypHn+3FZI9H2ihNNnlnYV8+bh8atI6XYUEyjSr4Ea15Km+
         bETK56Ui8EQEkToM/3O1CZ+kgtppvcbuybFq0yxYdE6HBRgTwpimHcv4CCbw3pbkoebP
         Oh/jxQjBtNQqQ0YPwJqCUtQc4O4ZsdgIX8NumkU5iwfMR6uxa8oAlMRItDt2pcpKln2s
         aGVyDHGoyUE9Eeh0ZZLJvVFThlpnddDXByfZdyeKjGL08Bi7lqadGZsP89VET6K3Fn1G
         ixpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDtc4U1SrIvcrwzir8Ie4AKFcuKd6oNqPV4vKCYPco8=;
        b=dOKFpTCSXPSV4pxcGpn17usTR7MnBz7Y2SwU+9tdNcIseaEz3t7bY3EdQ4RWRqqk9x
         S7i1tAlxlP+JQWvcwpfCJWM1BnGNzkDACElb5uzrtxPRRghhxdbAm3b8QeCVPeJfQcdw
         6qM3po91UsVSCVq2eEN/OrFkQBDAIkV5AtGs9FpsIXFOElvNIQhKs+IBdEW1Koy4WoxP
         8BcgT9sZgmHqlwxDTB6PZ9TQlBN1o3V86lZJZFcfpJtWna6ccs97t7tlH4Ljs2VTCj6d
         tu6ifu+ZLo8pSU8dBa5aj5yN5vouR5fHeCtAu2G1dqc1xj22ApW2Se7xZgFAZOcQ5x1A
         UiAw==
X-Gm-Message-State: AOAM533HK/LnYRdFQ0TiM7vA4SzyEGqQIgMkHIXYXRwFr0xp7jf6BN14
        JRWyF+REf5J4m60bzgMjoMg=
X-Google-Smtp-Source: ABdhPJxhINOqjGiap9E226COugIdGnCAK4PO/u3fv59IAkxDONMJv+V9zXK5MPOteqnqUmYaBMcNNw==
X-Received: by 2002:a17:906:48c1:: with SMTP id d1mr14560385ejt.123.1607251041297;
        Sun, 06 Dec 2020 02:37:21 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cc8sm7811556edb.17.2020.12.06.02.37.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:37:20 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: rockchip: add QoS register compatibles for px30
Date:   Sun,  6 Dec 2020 11:37:11 +0100
Message-Id: <20201206103711.7465-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201206103711.7465-1-jbx6244@gmail.com>
References: <20201206103711.7465-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip dtsi files only use "syscon" for
QoS registers. Add Rockchip QoS compatibles for px30
to reduce notifications produced with:

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed v2:
  add space
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 2695ea8cd..af6bcef9e 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1107,102 +1107,102 @@
 	};
 
 	qos_gmac: qos@ff518000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff518000 0x0 0x20>;
 	};
 
 	qos_gpu: qos@ff520000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff520000 0x0 0x20>;
 	};
 
 	qos_sdmmc: qos@ff52c000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff52c000 0x0 0x20>;
 	};
 
 	qos_emmc: qos@ff538000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff538000 0x0 0x20>;
 	};
 
 	qos_nand: qos@ff538080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff538080 0x0 0x20>;
 	};
 
 	qos_sdio: qos@ff538100 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff538100 0x0 0x20>;
 	};
 
 	qos_sfc: qos@ff538180 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff538180 0x0 0x20>;
 	};
 
 	qos_usb_host: qos@ff540000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff540000 0x0 0x20>;
 	};
 
 	qos_usb_otg: qos@ff540080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff540080 0x0 0x20>;
 	};
 
 	qos_isp_128: qos@ff548000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff548000 0x0 0x20>;
 	};
 
 	qos_isp_rd: qos@ff548080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff548080 0x0 0x20>;
 	};
 
 	qos_isp_wr: qos@ff548100 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff548100 0x0 0x20>;
 	};
 
 	qos_isp_m1: qos@ff548180 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff548180 0x0 0x20>;
 	};
 
 	qos_vip: qos@ff548200 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff548200 0x0 0x20>;
 	};
 
 	qos_rga_rd: qos@ff550000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff550000 0x0 0x20>;
 	};
 
 	qos_rga_wr: qos@ff550080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff550080 0x0 0x20>;
 	};
 
 	qos_vop_m0: qos@ff550100 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff550100 0x0 0x20>;
 	};
 
 	qos_vop_m1: qos@ff550180 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff550180 0x0 0x20>;
 	};
 
 	qos_vpu: qos@ff558000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff558000 0x0 0x20>;
 	};
 
 	qos_vpu_r128: qos@ff558080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff558080 0x0 0x20>;
 	};
 
-- 
2.11.0

