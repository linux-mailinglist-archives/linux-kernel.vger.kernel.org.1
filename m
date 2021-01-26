Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6978303BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405428AbhAZLmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404791AbhAZLDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:03:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C63C061573;
        Tue, 26 Jan 2021 03:02:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w1so22290987ejf.11;
        Tue, 26 Jan 2021 03:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tGus94grLYPWSUM0bMFUmChMXn+Sc5UCDSiVFm8Bk1g=;
        b=ReLxtoNk/T9yXEhHKg8pHbxSJw3aJoyT/IEKEoIyVyeulTYz+4TP45B5rr4TihDhhv
         17I+sgm2Ant/VgPBELLeO5DsCELkpNd8VASufye+/0aURAJIDZddTMAgWF7ImRzyxQEA
         rVq9VqepJAu29BhI3wx9AQTCzqmObuq5/kZH5Qu9GKKX5zBbOtfoawLHK57+eYd71VZm
         kH/TAv0BLQGfAcq04zf7TOp5jS+IlbY+qvgrzTUoVwHJDGAsmEEIla5U/PABcEf5J9NM
         hxSDeyQezd8wS6bI7OppyoHqfzpcNfjWa9NJUp+k2Szj5UKgvfcm/3cHrdv9ptGGBSpS
         yAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tGus94grLYPWSUM0bMFUmChMXn+Sc5UCDSiVFm8Bk1g=;
        b=ETS/UVs7nLTb+/wp+jZnnWr327SfBP/EJPS1PH+xuhOaoaNk53NWWzbqpR25I0Wq3A
         i9CkYaKtw78EyP7brTHiXAf2/rXO1EWw+/0YUNZpQLWngTvwqJDcdIWYyBLW2HapPjwe
         0oRP1Yn65lZTXxRkVfcdVT+FHLO3JilfMdpEvyeWZQT2yFVXS34OVQ9MywsSPBNw6SiY
         25ovuz7OGH0idvvOLSdoaKH5eh/xeE1gyFnsr7cQs+i/mctXUdbz6lcoY6wiI5hO2Gyd
         +3zuWqdEMSXlAEH5YuZl0CQBhGQqRuoYz0SIvq/nsUdaBgE/1dC6n8mOZAO4R/eAY5Ha
         PR5g==
X-Gm-Message-State: AOAM531U4nnS7O4Or4naFJzRBS2DaeUv1hYqyTAfZHWE/bGVXt1AMoGE
        9FcyrfvzXAQD4FnaNEA0PYgZHnmkS+E=
X-Google-Smtp-Source: ABdhPJweKLVCgdb55W52Fgzza7M8uQ3muJw6gFw6GteiCpKniAv8SkhaI6jSnMSRGamCzzANptF5tQ==
X-Received: by 2002:a17:906:c954:: with SMTP id fw20mr3076916ejb.342.1611658949575;
        Tue, 26 Jan 2021 03:02:29 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a2sm9533408ejk.80.2021.01.26.03.02.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 03:02:28 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: fix pinctrl sleep nodename for rk3036-kylin and rk3288
Date:   Tue, 26 Jan 2021 12:02:20 +0100
Message-Id: <20210126110221.10815-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below aimed at powerpc generates
notifications in the Rockchip ARM tree.

Fix pinctrl "sleep" nodename by renaming it to "suspend"
for rk3036-kylin and rk3288

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036-kylin.dts | 2 +-
 arch/arm/boot/dts/rk3288.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 7154b827e..e817eba8c 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -390,7 +390,7 @@
 		};
 	};
 
-	sleep {
+	suspend {
 		global_pwroff: global-pwroff {
 			rockchip,pins = <2 RK_PA7 1 &pcfg_pull_none>;
 		};
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 29ffe2eb9..7dec6935f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1593,7 +1593,7 @@
 			drive-strength = <12>;
 		};
 
-		sleep {
+		suspend {
 			global_pwroff: global-pwroff {
 				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_none>;
 			};
-- 
2.11.0

