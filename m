Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4926FB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIRLe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:28 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29642 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIRLeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:11 -0400
IronPort-SDR: jompOC73E2A9Ipiw7YSsWyCGNrwBCI7t6sOCQltbwzNeimstlPUA66SVBLm68N/aNnMOVr2tNQ
 5qtwO3S2eBOtRufSDCRxWlKR+NLwjfW4dvMbAFFDQXH4qtV/wp9d6Ln/Cpgn8hp68Z45vlXaoN
 +d3QnSCUk+3zz3+gfZ7NS6h57cqYLLg0LjrSrAW4mNWzP1vrPHLWqMbcigSrAioOkH4JpbGCIM
 DaJlzhwUXD3VYfM5ZIJ31wSXHA4IMfwCzF1RkJ2yIXwVcE3SckFLCT+Izwhzicjw2ra8VsEmYo
 LfI=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924498"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428674; x=1631964674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tro6chrWNkLJQgWJ5Odl4/yB/h1NcrKrUYcG7htP45s=;
  b=QUCuzBywEHpr3ruTledS3wT8ElYzHNYkmPnRDnbyWN3uldkP/K/neWL2
   UU3qu12VB1+j7Szy2Sut/UZA4HtE8BpyUL0/pSU7oSOOGC/uyia9wJ0Ir
   kP0UWYeCrScYRtZbOyOShsexOsfSFWQp1qowbSZQj0Oit1ergvU+Q7G1w
   bbBnuss49WDo7kj89TZIAPXe4wP549MFqold4lbcz0BWyDPU/9T7gjQCB
   t+UaVLg3x8QRlVJHxSkNVqwxbuSpiQ4Tz6m1s8icZMbm899nCAQUJumk0
   JFjkNPVy6pvISgmlb7/2Be1CvnHS5uh/XpOF8CrpG2vm6no7Qx9mfVWMW
   w==;
IronPort-SDR: 49gnqfX9SoHF8Ja0tUVOc438dwM0a3oeU50Y7yjC38KisAZteS0BgI2lurAonZz0nirUpEB5C0
 IuHhlnZ64a2YblbFia/WvkvOq/3aETlvt5ZP/Ztb94tfLWXB/ncX/AkRKNYkJ6WC4pCtf/m2f1
 frJOb97ATxK5pNkuwvcWoajHCNq0uTw9edOlpvXRaxemVPzHJ6aPgZyYR3p+6ejkSzomTzSZPe
 QzO6V9D5VRxV19EXII72WyH10lGgOz1QJlCtor8HCDiOOUpMWXlCuugjfbUztlszGZEh1Nv/G+
 SHM=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924497"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:14 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 946DC280070;
        Fri, 18 Sep 2020 13:31:14 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 13/13] ARM: dts: imx7-mba7: set dr_mode to otg on usbotg1
Date:   Fri, 18 Sep 2020 13:29:42 +0200
Message-Id: <20200918112942.1367-13-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USBOTG1 has a Micro-USB port that can be used in host mode (using an OTG
cable) or device mode.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 52b8f66f9982..3683f97f946f 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -611,7 +611,7 @@
 	hnp-disable;
 	adp-disable;
 	over-current-active-low;
-	dr_mode = "host";
+	dr_mode = "otg";
 	status = "okay";
 };
 
-- 
2.17.1

