Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A321ACF78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 20:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbgDPST6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDPSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:19:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FF4C061A0F;
        Thu, 16 Apr 2020 11:19:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so5960360wrs.9;
        Thu, 16 Apr 2020 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kuhunWoWNKSSnJBSD5mXFTqsJ1kOHO8My6Abd5FOVlI=;
        b=XtjV6oRMo9f1fiyooxFRAsKStn1YM6uA4LfKKHLAMBFup+vHUfD6hePncAg8p1ApDO
         ucGxJWYm8h9ZSvixP78pVzp9opq9BMqLcmm+j3YzL5LoXvvb49Hc3LSNHrAAS8xwCgRO
         cUTDoSi+MPcbBL0yftolbIfMgcNKsJa4az1NWbBR0DU7buWwOn5u3sYV6+ojBWSjsKVI
         NDarSF2qUg4TJHFg9k1fAh50yRSmF3zSxCALYN8Cmou1gYMl1lVNQjAbJVioM+zyyhub
         gGPZ3JM4kQI3XcNMD9c2ek3KiIv5rzQn8R4T1MF5utlrXzWMV20jDG7TnU4Ik/gM6jYN
         zdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuhunWoWNKSSnJBSD5mXFTqsJ1kOHO8My6Abd5FOVlI=;
        b=VKZUfDbFzipcNFeDB+tw3JTuZLbwQtI7XAbxgEjGRkHPoGrNlhWFKZrhHp7GC2WCVR
         hJoe1I0HION/1acbsR/7Lrdnz9sZgY5ZKdWVeqfTfWJIbf2BMDBq+Pe0aTA8/nCeUCNG
         ZT7WjkDCTfP7st6OxTxDi4hbZP5glBcyv31C45wJlsL85GVk/DU2snCxEvWSCPeUMlNE
         +ZHiW4otSGDiYTXc2WrS8GQLHETFOB2Qmtcw8QZXDRkKRrEuk/0F1hQgskyMK4sxfDvC
         8z1kTrZLJIiIbinh/FUoWY+ew3hCSr5chr0wws1mNpZYPcR902phSdHPN5sOfSaKxrJg
         gUag==
X-Gm-Message-State: AGi0PuZ0GgALA8EO6PyFfqeGvFp4rYbtLOE39EXuuoHWuDTEqOfROL9Z
        ZEPlLpG4w9ss47VogdgaC9w=
X-Google-Smtp-Source: APiQypKYaWHYHbmMKObbxWQNX1u/cnJOszq4uhvMc3wS+RLncPRSwrGCexb4iivhEwhF6PKyf8WwcA==
X-Received: by 2002:adf:e681:: with SMTP id r1mr15086891wrm.213.1587061194054;
        Thu, 16 Apr 2020 11:19:54 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u17sm31317719wra.63.2020.04.16.11.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 11:19:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: add bus-width properties to mmc nodes for rk3399.dtsi
Date:   Thu, 16 Apr 2020 20:19:44 +0200
Message-Id: <20200416181944.5879-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200416181944.5879-1-jbx6244@gmail.com>
References: <20200416181944.5879-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bus-width' and pinctrl containing the bus-pins
should be in the same file, so add them to
all mmc nodes in 'rk3399.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 123b7402a..9cf22e648 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -299,6 +299,7 @@
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		resets = <&cru SRST_SDIO0>;
@@ -317,6 +318,7 @@
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		power-domains = <&power RK3399_PD_SD>;
 		resets = <&cru SRST_SDMMC>;
-- 
2.11.0

