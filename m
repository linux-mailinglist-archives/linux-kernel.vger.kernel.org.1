Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA42AA6C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 18:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgKGRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 12:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgKGRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:01:21 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BCDC0613D2;
        Sat,  7 Nov 2020 09:01:19 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o23so6321858ejn.11;
        Sat, 07 Nov 2020 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zq1Ou0jMvIjoZ2w0wOmMCC/GKFzl+UGGCZWv6JD39N4=;
        b=Gzm0iFj0EB4BO95L4Ks/rc61eoroyvAr7tN49rVECqj1v7qRRd+w2q3F1TtfcsE5+i
         XaLL+iD++Y5O7zBEdQTgnqK0ReL+7HI8gvbaQO7oRthD32lPNtAcJnJCljhHLHPinxKo
         l8WxxE66HE6aQyUDbbx5i3iKiEX6FhixjiBW0dk7eXDd1wKtHr9gS2tNTxHknWYfcY3T
         0UUJxMlxFc8hIYLFnXFNMTwgA7fSeaLu0JYOgNsZp1g6t8oTowCFYEJ+KYR2cogHN2Kt
         W6KW3ipftVulNSHs39UoiTx0zCmIHIydwsJoc1IgbWcP4OGzut8JAFJ3tdbZ8IGwGKYy
         6W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zq1Ou0jMvIjoZ2w0wOmMCC/GKFzl+UGGCZWv6JD39N4=;
        b=NbvUOO2SmcfNlespORd8f0OwLn7sENHhdAmBCDRIy0VGAH25sbu2U3X2IAHsuMwJNW
         +H5jJEL8eZ49TvBItwNM0bS0k9+gJ4kxouFaWOuWgb1f0SJFF/GHlWtpovhF9uW1YspL
         vtynlJthNQAyURdZxwCh0FlS8rTxIq6wt8YpE8QD4FMnCUQsF09/JxkO8g4GlaTNUL5C
         IxpldB/oGumgBPJmYJb2ByWrYVQ7lqpLD7VdfMJiQ/TZK436jEqQ00XMZKhCp+5Az6NT
         KXlXL6BYIfBP6+9k1pDRFxqJkVh7hrMH+zGH2nLztgwx+m9wkIzIZ8F1S/T+V8+H5L+8
         kWfw==
X-Gm-Message-State: AOAM532GsGpVftC4nzC9lcLrT5D0x6FlJJE91Qztj+alEIpztn8ck14/
        KjzlWtbISY5dh/HPXJTX8JAHM0uFQF6guA==
X-Google-Smtp-Source: ABdhPJy4JdaWQPpM6V8tQo4sHCMhIpf87AT6eKdwGjbetI6Rw6KidtH7UeEFpuc0Fyv4/Nn7C4ZIxQ==
X-Received: by 2002:a17:906:840e:: with SMTP id n14mr7246795ejx.147.1604768478455;
        Sat, 07 Nov 2020 09:01:18 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t22sm3729700edq.64.2020.11.07.09.01.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 09:01:18 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] arm64: dts: rockchip: add QoS register compatibles for px30
Date:   Sat,  7 Nov 2020 18:01:03 +0100
Message-Id: <20201107170103.25608-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201107170103.25608-1-jbx6244@gmail.com>
References: <20201107170103.25608-1-jbx6244@gmail.com>
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
 arch/arm64/boot/dts/rockchip/px30.dtsi | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 2695ea8cd..7317bca2e 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1107,102 +1107,102 @@
 	};
 
 	qos_gmac: qos@ff518000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff518000 0x0 0x20>;
 	};
 
 	qos_gpu: qos@ff520000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff520000 0x0 0x20>;
 	};
 
 	qos_sdmmc: qos@ff52c000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff52c000 0x0 0x20>;
 	};
 
 	qos_emmc: qos@ff538000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff538000 0x0 0x20>;
 	};
 
 	qos_nand: qos@ff538080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff538080 0x0 0x20>;
 	};
 
 	qos_sdio: qos@ff538100 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff538100 0x0 0x20>;
 	};
 
 	qos_sfc: qos@ff538180 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff538180 0x0 0x20>;
 	};
 
 	qos_usb_host: qos@ff540000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff540000 0x0 0x20>;
 	};
 
 	qos_usb_otg: qos@ff540080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff540080 0x0 0x20>;
 	};
 
 	qos_isp_128: qos@ff548000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff548000 0x0 0x20>;
 	};
 
 	qos_isp_rd: qos@ff548080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff548080 0x0 0x20>;
 	};
 
 	qos_isp_wr: qos@ff548100 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff548100 0x0 0x20>;
 	};
 
 	qos_isp_m1: qos@ff548180 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff548180 0x0 0x20>;
 	};
 
 	qos_vip: qos@ff548200 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff548200 0x0 0x20>;
 	};
 
 	qos_rga_rd: qos@ff550000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff550000 0x0 0x20>;
 	};
 
 	qos_rga_wr: qos@ff550080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff550080 0x0 0x20>;
 	};
 
 	qos_vop_m0: qos@ff550100 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff550100 0x0 0x20>;
 	};
 
 	qos_vop_m1: qos@ff550180 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff550180 0x0 0x20>;
 	};
 
 	qos_vpu: qos@ff558000 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff558000 0x0 0x20>;
 	};
 
 	qos_vpu_r128: qos@ff558080 {
-		compatible = "syscon";
+		compatible = "rockchip,px30-qos","syscon";
 		reg = <0x0 0xff558080 0x0 0x20>;
 	};
 
-- 
2.11.0

