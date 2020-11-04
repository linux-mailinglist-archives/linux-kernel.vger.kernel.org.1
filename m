Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446772A6EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgKDUaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731959AbgKDUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:30:17 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DED0C0613D3;
        Wed,  4 Nov 2020 12:30:17 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so20674339qkf.0;
        Wed, 04 Nov 2020 12:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff/WO+uHKSsq5M7NiOl77UHLv2rHMqjyLiAZVTx8svo=;
        b=FsXD1lfau0bat3h18xuf+E2Y7QVMbLfzqLLheVRiMQEFgIoY1qchMStWqFTYFnfkck
         0uq8jAVnpHJ68QNuaZkn0WefYihojbVOiB3Sr8keMPQHSbDj/9k4Z2z2fzpL/sR9g4sU
         EU26eE9b8tnjLW5HIJgmw2Crf7CnsOaig8typDIwjEt9v6zL6mnaSvlECp7erZWsrZmF
         FDoKF/ff3qYznau61szNPTS05OOOhVivW9aIeST9hu2DvXK2wyiZFn9EGI5y0SP1Ak6v
         w0Q6GlDnrQQ+S2xq0D27zmxi6fZC6XKTRTwyn+/AV5+VPBgsyG+WBdPdHzzqGRwTluVU
         kSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ff/WO+uHKSsq5M7NiOl77UHLv2rHMqjyLiAZVTx8svo=;
        b=hmnIxrl50EpRBEbjR7mFNqTsyPeBXrNcWehe3lDmUWgSa2zv/HRVQFkLxt+zne6/vy
         xmjOkYnbCpLlryOl/N+sEpzpmEHTETFyKlE50GsKGfTyFxmGpYX6PORwKb/zmAA9OEHX
         3x7wUvdTIAJpeOIFRbW4NLNRSeMwottF2xAxQOC5mPO4oBrFrTEJfNOtdxoSWjMnQhKR
         NTv7k0oJaZpZbjmE1UJUWQmy2991e0H2TifNHf6V9gx2aylIBETAYqgbntzMK/3vW8KD
         X4tYOC/GNvi61ZdQ7LjAp5Yh7dbEsd9DjQZa+14FEDq3dJkSPm0cQP05gCAoGgG+2oT4
         gzdg==
X-Gm-Message-State: AOAM531OSQ7lQWH3C4u8grHIYY/9tNTyOnGnqxgL0P7YR8M0o3GGwSEO
        Pa66JRWIt/bBdqI0Sjr4wyU=
X-Google-Smtp-Source: ABdhPJzAajEKRxvQ0TaahiYAQtsS7M0Rn3EjC/uEUDTxuekUKERf+z073ojzJtGIirpqwKibDqYzpw==
X-Received: by 2002:a05:620a:856:: with SMTP id u22mr27485269qku.84.1604521816569;
        Wed, 04 Nov 2020 12:30:16 -0800 (PST)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id q14sm930435qtr.20.2020.11.04.12.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:30:16 -0800 (PST)
From:   Vivek Unune <npcomplete13@gmail.com>
To:     florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl
Date:   Wed,  4 Nov 2020 15:29:52 -0500
Message-Id: <20201104202952.783724-3-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104202952.783724-1-npcomplete13@gmail.com>
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a pin controller, use that instead of manuplating the
mdio/mdc pins directly. i.e. we no longer require the mdio-mii-mux

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 .../boot/dts/bcm47094-linksys-panamera.dts    | 26 +++----------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 507af23e227f..3bb3fe5bfbf8 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -123,33 +123,13 @@ bluebar8 {
 		};
 	};
 
-	mdio-bus-mux {
-		#address-cells = <1>;
-		#size-cells = <0>;
+	mdio-bus-mux@18003000 {
 
 		/* BIT(9) = 1 => external mdio */
-		mdio_ext: mdio@200 {
+		mdio@200 {
 			reg = <0x200>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-		};
-	};
-
-	mdio-mii-mux {
-		compatible = "mdio-mux-mmioreg";
-		mdio-parent-bus = <&mdio_ext>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x1800c1c0 0x4>;
-
-		/* BIT(6) = mdc, BIT(7) = mdio */
-		mux-mask = <0xc0>;
-
-		mdio-mii@0 {
-			/* Enable MII function */
-			reg = <0x0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 
 			switch@0  {
 				compatible = "brcm,bcm53125";
@@ -159,6 +139,8 @@ switch@0  {
 				reset-names = "robo_reset";
 				reg = <0>;
 				dsa,member = <1 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinmux_mdio>;
 
 				ports {
 					#address-cells = <1>;
-- 
2.25.1

