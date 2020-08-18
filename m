Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9F2487D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHROho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgHROhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:37:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6582BC061342;
        Tue, 18 Aug 2020 07:37:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p24so22326012ejf.13;
        Tue, 18 Aug 2020 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qW/vPODydHKoIxWkakc/8MljLCi8kAbWI/+HlLycii8=;
        b=uCU2VExUgkOdf0CSnU7p7Lwj0HwQv0QnvrEuM3Q4DtTmfgcqJv7lIMg6wtWsqdRNtr
         g5qApET1RisUjddrmMDVQXhqZkK6RUrIg+S1ft2ZwrIEdCpyOHTTzGA/R5EGMsKRwzj4
         SsCX3rMM8bGiFd+wOqh1oFq4CbRFWaVCVBrrUQDeKee+Pz58Bzul52OIZy27Wlrou1/g
         ECjwdYXY1HW5YzJlKL4uu7XevB8c/LCNUHqQtYNviTU3EXem5NfnQcAJiDbq94SJ3owE
         fDqvczWzkV4IwcqGoE3pAqhNbOppeAUqbJV6zwa33ANkAs+92H9Szw3wOmS0e3n3/6YG
         3HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qW/vPODydHKoIxWkakc/8MljLCi8kAbWI/+HlLycii8=;
        b=e7rmFQTxaieWmrAADA3zqZ5Cop+wzjlaVuW1z9Jlw1HYUsRr2BhA2EqsewqoJMetEQ
         RohJpUTEOcvvohm4X1nO4ZoiST1e+Vthf2tuC8kJPMgTbOIXMWxCCVwFvka+BzQIzH/x
         /Fs6/mTHQ+3mXrJvvg0Hn1M9+4XIqAaMCraJ7zYE/emdY/7tTrzibaHNq+opu6dXJ47o
         /aNdoMbnIECs5tPaK39UJXMU7dfAbQFeVylsgOhcFNgWPSxy5U4hH5D9n5kDji3ubuNc
         ZzNm40ljQxLAqENpHvf2ISguu000X9U1ck3zHfyiL6DQKTQCur4nq7Pg/a8BUreqZkn+
         6L2Q==
X-Gm-Message-State: AOAM533fTgyjDU1tBVRY8U0s2cV8/aT7MnfCCz1O4HEOs5x/9AAVAswC
        Rd9rJHkzgs1gHkTsdpzvKOYndTAjPy8=
X-Google-Smtp-Source: ABdhPJwoKdEOnV0Xt2tgEw82my/fzFI9XtM+fHHICmtVeMhwZPUpUjoZ/RyxXNw3xpoCDJrZ+yHTpw==
X-Received: by 2002:a17:906:a18e:: with SMTP id s14mr20008133ejy.168.1597761456090;
        Tue, 18 Aug 2020 07:37:36 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r25sm16222575edy.93.2020.08.18.07.37.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:37:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        sugar.zhang@rock-chips.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: change fallback string rockchip,rk3308-spdif
Date:   Tue, 18 Aug 2020 16:37:27 +0200
Message-Id: <20200818143727.5882-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200818143727.5882-1-jbx6244@gmail.com>
References: <20200818143727.5882-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below shows that the compatible string

"rockchip,rk3308-spdif", "rockchip,rk3328-spdif"

is already in use, but is not added to a document.
The current fallback string "rockchip,rk3328-spdif" points to a data
set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
in the mainline as in the manufacturer kernel.
(Of the enum only RK_SPDIF_RK3288 is used.)
So if the properties don't change we might as well use the first SoC
in line as fallback string and add the description for rk3308 as:

"rockchip,rk3308-spdif", "rockchip,rk3066-spdif"

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index e8b754d41..2560b9877 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -574,7 +574,7 @@
 	};
 
 	spdif_tx: spdif-tx@ff3a0000 {
-		compatible = "rockchip,rk3308-spdif", "rockchip,rk3328-spdif";
+		compatible = "rockchip,rk3308-spdif", "rockchip,rk3066-spdif";
 		reg = <0x0 0xff3a0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_SPDIF_TX>, <&cru HCLK_SPDIFTX>;
-- 
2.11.0

