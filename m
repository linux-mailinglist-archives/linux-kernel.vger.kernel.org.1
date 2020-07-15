Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71032205E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 09:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgGOHKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgGOHKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:10:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074B8C061755;
        Wed, 15 Jul 2020 00:10:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so1054256ejq.6;
        Wed, 15 Jul 2020 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J7EhmJLOXoR6ivw1nmOrrsw0zOP4ePzGp0qct+HI630=;
        b=f+ks6Z9sOUkvj9G4ZFQQm/3XaWceBKwYn53qt/D9Pz6Olh+nVFNxhQbfcXKD0du2yz
         50M2VaSk0/V2DH/5zNuKIg0g1eZ1sCDr5zpWVCY83OqCxVoOHCD6WI7qtFxhNSllOslk
         BuWxsU4bnDbuLIJQj6XIggi0G2LGa0fIUqECJ6TnUFXO1K1JH/dS3F38kI1tGymuvfex
         n7j9wUznAzq8WtGZZoMXpDfBe4X4dGs0Y+rN/jm/woU1oEXLPpIefIi4IAZJLFWvo6Cf
         RhK8MPGdzW9zM8GPJHYNqGOivSMsbJYWVZQ3vTgs6ErT5LYQLrBHWLzm6OqRlDqA41q2
         GFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J7EhmJLOXoR6ivw1nmOrrsw0zOP4ePzGp0qct+HI630=;
        b=buKEJae9XIIHYXiAyTxbM6RULd4p6+0u+pXLoedst03If+mTolEdkzJI2YYS5M9/C9
         YpdCp2w5r18COjKADZ8dyUTwJ5d2W3D5UphevMqip2AIO5xBY40h17NQZjcv+xPofpsu
         g44Bs90laoOAz573lUZYT6hxs699f4Bfmm7A0SDtbRH34/v1tuTlhcDry8gY7oAXUO1k
         QlXQzpCIiC2fwkIuWJhZqejANpyoeSzS9zTHvTmlfSOReyoklzM8XGVPk2zup5MXATeu
         yaMxmy8iYrkR2W3M+N12ocHYt+oMiTJh8DP4PL7NhKLVVCbDTdEzrxkA8AHbdkPyII2Q
         /akg==
X-Gm-Message-State: AOAM532jvOm+M4Zzj4KLaK5OG3FRP61tTGN9xjGJIHek13Wb5ljviX+3
        GShb+eiZpEz5h4S2w6+ili7n016jxFM=
X-Google-Smtp-Source: ABdhPJxN0fKh3jwNnc7Vddxa/9pCDC4VfYGYCRPCA+NthkOFO8WPBnLU9z7/13w2iGz3K03zOzsp1Q==
X-Received: by 2002:a17:906:86d4:: with SMTP id j20mr8478955ejy.68.1594797002811;
        Wed, 15 Jul 2020 00:10:02 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o15sm1226850edv.55.2020.07.15.00.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 00:10:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in px30 dts files
Date:   Wed, 15 Jul 2020 09:09:54 +0200
Message-Id: <20200715070954.1992-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bus-width' has been added to px30.dtsi mmc nodes, so now it can be
removed from the dts files that include it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts          | 3 ---
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 0a680257d..5fe905fae 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -145,7 +145,6 @@
 };
 
 &emmc {
-	bus-width = <8>;
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 	non-removable;
@@ -499,7 +498,6 @@
 };
 
 &sdmmc {
-	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	card-detect-delay = <800>;
@@ -513,7 +511,6 @@
 };
 
 &sdio {
-	bus-width = <4>;
 	cap-sd-highspeed;
 	keep-power-in-suspend;
 	non-removable;
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index b3a8f9365..35bd6b904 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -445,7 +445,6 @@
 };
 
 &sdmmc {
-	bus-width = <4>;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>; /*[> CD GPIO <]*/
-- 
2.11.0

