Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496212F0965
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbhAJTtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbhAJTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:49:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F25AC061786;
        Sun, 10 Jan 2021 11:49:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lt17so21827368ejb.3;
        Sun, 10 Jan 2021 11:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=09fSf3CYaRKd+lizyu6R+MPMNC+3QROBV5c96As/hCA=;
        b=fl0PW4s7ManJVu9VHMp+EvJvjoGt6rWz1YFeR+iCO61JN3AgGK9UsOM3lDTWsNzcjX
         pR0pxumLTzqJae3EsU3wKX3xJm9gkB9tNAjiC6qJqvdkUBZ+FNhnueOSAMi2oMzuMC+W
         jH3rHB8rQVEN5sGsqCEF6C8QTdaTYhK/lvbrCQyn5FQxwOxgp6fn5skCKkTWduLib67s
         t/WuMSBXtAeL8SS7asOnz3uGddnqWbkNgu4I3qPYqF7p9Z9r7P2hDzqNd2pLassNJb0N
         uVS7oAd4uMoCH0p75BUN4I4RC5QMgT4IogBf8aTCShEK3o5HKSPQw7dGak5V0kmX9gRQ
         c+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=09fSf3CYaRKd+lizyu6R+MPMNC+3QROBV5c96As/hCA=;
        b=Teziyatnv0XsYAkynf+TzwzGQ3ffCIX6B2UAZkRuR+IcbSAxOIAB7Ulcs2vHBokac5
         hHG89gb0sKJb9AAeRpQcjaw5+K31wZXNdAbXczfY6/KoWmFf0rZ0ScZ1S5ToOQR6oGZz
         HnaHg0EZDmMEwir3s8DBi7FPpSkqyCib/Yix3Ryrv2CWpDviCSk3kYmU0l1oUNGr0PXl
         GR3482BQy7evRmRCUQUmKWgvyfERy1ai7u6rpDOHDCdPbDoTKbqLUXZlsBSSUEElREIj
         x5K+zR0dBJIwaVWXTka5z+6nJIVp1+LiUzYe6cH3GXOEatopT6DVE5/crg3piZ0LzAGR
         jufw==
X-Gm-Message-State: AOAM5318ah00SvNs9NK8KUGMlmXG04gHXBylPKoNUewKoBpG7bzDD7Q5
        7QP+rsvukHrUfJ4YGSMPiTlSQifwjiJRNg==
X-Google-Smtp-Source: ABdhPJxZrBTlfwdY0Md+scUpm1TSyYpdw1RT6bm83UKxWSJ/tn0GN7b2F2c10Am+sj5dJTQfcGO2dg==
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr8829434ejc.529.1610308138914;
        Sun, 10 Jan 2021 11:48:58 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b19sm6744898edx.47.2021.01.10.11.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 11:48:58 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rename pinctrl nodename to gmac2io for nanopi-r2s board
Date:   Sun, 10 Jan 2021 20:48:51 +0100
Message-Id: <20210110194851.10207-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:
/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dt.yaml:
ethernet-phy: 'reg' is a required property

The pinctrl nodename "ethernet-phy" conflicts with the rules
in the "ethernet-phy.yaml" document, so rename it to "gmac2io".

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/ethernet-phy.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index 2ee07d15a..86732b45d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -280,7 +280,7 @@
 		};
 	};
 
-	ethernet-phy {
+	gmac2io {
 		eth_phy_reset_pin: eth-phy-reset-pin {
 			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
-- 
2.11.0

