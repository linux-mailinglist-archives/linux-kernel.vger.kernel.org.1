Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2026FB96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIRLey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:54 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29647 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIRLeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:03 -0400
IronPort-SDR: qfTSYYcEddqVzQKJamUH4PoAaOGqoe/ziB+DfJQPrefKishttJqyoA1uhiCitAY8YSf8T3tSzy
 7h7GNf85WsSv6d69N8TAtcLn9En4dTFmol1TzMxVxD9veXq8Gdk/GObDjatbGvbrC2RfeaWfdm
 nWtuFzI2ezVvOSSMWUMsqi1EZ67EfS5ebfTQ1WYXXOFheSNp6c2xtWZhORry3VMYGyMd8arpik
 ifiyq3iJdXrbVhDl3b9ZcPBaMPzHx7eVJhlXQAXPniIAUDDmF/Kf3z9vAKjKHfWF6j0Gm7MzaL
 G1o=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924482"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428673; x=1631964673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8WgQQBytVJ9cv4WMvmj3JQi9zBj8OEePCmA+VEnbhOw=;
  b=LbF6fPRnW8OToWtee3euUm2S6rZ0z0mA4PPdlnWiiHziKU6DEEiA5MuL
   HalTntiu28yanXX0BEi0QahfjfLdXDfUCW9pJJGRutViBmPnzUBWnxNVt
   X8/gGJU9tjjKTDs3TLec/JdPWzZOWTCo9CU30hekPUJzZfM0jDlq1sIuZ
   7bgLmoQbI8sWQrRnKKLNKaUTsOq4uIMYRj3cD/enzLj/564HWTlKiAt3A
   n7EOE7Medj3rbH1I0bLvtBx5tUGO189HgCyLJq/Ppqw0gi0+TnMAOZN+5
   gFMlZHi2qQ7O7lkSpKgxgxKuNlgIDvygoFk8HKqMAsVeAAz6Vr+Sd6nd6
   A==;
IronPort-SDR: Qx5YdgyJ+KYPm2gluHxoPQLdEljKZJlZIVuiFDDb1IK+tyEeA/JW4mCFUhhBOeIptPbBtLY+Ec
 qKcIgG4wtPOlmX6IvJlobeNbjx8MqLno1fGUOjt1KjPNtA4rQd+KZRpqHAGkTRY/mR2TfqHtkk
 ksxyKulUqg1xBJMONLFVlfHnYXLkTRsLjT+ynapOAW6yJ6qSXDQQHEusuZ1aPdNZmbrM/uJkJe
 XDs2TQXYfswcZeaVktQ1PrPCEFV4enPF+BjdsRzdgAgH7bzEo0uRbqVgqNRpY8U7GnWyvuO3eq
 7Ns=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924481"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C97D2280070;
        Fri, 18 Sep 2020 13:31:12 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 05/13] ARM: dts: imx7-mba7: remove unsupported PHY LED setup
Date:   Fri, 18 Sep 2020 13:29:34 +0200
Message-Id: <20200918112942.1367-5-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These properties were never supported by the DP83867, and a patch
implementing them was rejected in favor of a different solution. Remove
them.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 4 ----
 arch/arm/boot/dts/imx7d-mba7.dts | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index d99912ade947..1af40032ab17 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -212,10 +212,6 @@
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			/* LED1: Link/Activity, LED2: Error */
-			ti,led-function = <0x0db0>;
-			/* Active low, LED1 and LED2 driven by phy */
-			ti,led-ctrl = <0x1001>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-mba7.dts b/arch/arm/boot/dts/imx7d-mba7.dts
index 9f4f7112e598..1101be373ddf 100644
--- a/arch/arm/boot/dts/imx7d-mba7.dts
+++ b/arch/arm/boot/dts/imx7d-mba7.dts
@@ -39,10 +39,6 @@
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			/* LED1: Link/Activity, LED2: error */
-			ti,led-function = <0x0db0>;
-			/* active low, LED1/2 driven by phy */
-			ti,led-ctrl = <0x1001>;
 		};
 	};
 };
-- 
2.17.1

