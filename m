Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D891ACF76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 20:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgDPSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDPSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:19:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C1C061A0C;
        Thu, 16 Apr 2020 11:19:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so5948974wrv.10;
        Thu, 16 Apr 2020 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cEAaXqjbvarVunGK5EIaoB/gFSYviCQxW9/KrEgduNU=;
        b=jOjIXOUNpqV4vgS2P0e/NN2SML1NfcNU4agJ7hlenV8vJ7aS6bhAXCz9Dn8fBKcD2f
         pIUPxsoWthEWnS4sy/30qAJcaI/VnP89Z7M4clcCSzK4EWGRkrfyAKAYv3rIE5q+P3IJ
         aiBiLZQVWgMSSpNy93+Z7GpGHJAQP7b0choQXL0MTXBufxCV39OGP6fUGq71G3bWrUxI
         EpBvR5rWusmBgI/JJ/S5CFobq7Ublms2NXQc+XRR0K0UnL5QQoSV6o1AzH7IW/68HOuZ
         682Mt6jHr3UuW+h+3JIIi1bPTcecaos3iPweLmD7GXtMRR7ZUCEbvr5yYlFxqcgBik0f
         RfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cEAaXqjbvarVunGK5EIaoB/gFSYviCQxW9/KrEgduNU=;
        b=r0zdtbRDfB3Alv7nSsCnA2jpGBUFcTCrfXPJIlQikDYz97qLnFjqvRg/orhCrB5L6i
         ctP0YY6xcqr73f4vt3TTQnXM47kT3Dq8TqQsjwE46kHa77nc9ogHNsPKALsJ2WndCwKK
         eB2f1mwYlIGrtbxDMiVPJ6jbH94mPFiNzbMaDrSeHIezHsBB3WO6YkGcIc+Oj9S6UL4P
         W+V+Q2kl0uCFyLIFxBSshdpOXUySYU27SbnKeI1Hn6tn2RA56BYM0vR6KsOfVoJd6goS
         caTHSPjTKPsQXP0mnjkZNhxcO8DP2kg8y9Di7/mNfQ5pFcA3unAOvDvDuUK+S1W9c6+r
         UnAA==
X-Gm-Message-State: AGi0PuYU0ys7LZyll0JABP+vMeErJl5My1Q62ytlOoSjM8/0tZeYw3kx
        BM4ddZ8dM9SXiebLV/bcc92b3nM5
X-Google-Smtp-Source: APiQypK1DEot7c5BxCRkgoBTWKxlQTrfIXgs2pj3dVp4kUGCzv4aCzV9FQqfjF1BDwwMYWgvn4Cfpw==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr32028157wru.325.1587061192033;
        Thu, 16 Apr 2020 11:19:52 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u17sm31317719wra.63.2020.04.16.11.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 11:19:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: add bus-width properties to mmc nodes for rk3328.dtsi
Date:   Thu, 16 Apr 2020 20:19:42 +0200
Message-Id: <20200416181944.5879-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'bus-width' and pinctrl containing the bus-pins
should be in the same file, so add them to
all mmc nodes in 'rk3328.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 175060695..db2c3085e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -861,6 +861,7 @@
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		status = "disabled";
@@ -873,6 +874,7 @@
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <4>;
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		status = "disabled";
@@ -885,6 +887,7 @@
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		bus-width = <8>;
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
 		status = "disabled";
-- 
2.11.0

