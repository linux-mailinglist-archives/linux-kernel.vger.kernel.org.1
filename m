Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A274E26FB84
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgIRLeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:05 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29642 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgIRLdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:33:04 -0400
IronPort-SDR: wOy+v5JpDb/LcbAl8xtyinD+S6cAH5E+5XE0ikyPPI49H4POuPSK+OXsaZ9jDVmWjSqYIh8P2l
 e9v2sxWt4oO0b8sLEkwChZEy9W9E7D3GKDr0D6Li8RwLDbXHpoTcV1MLaz2qwb6Btj280AH0Pa
 cbZWzr6c0ABDRoc0eo0zfsKAoddELywGEfMEVn0bnIpShYuPNQxOgM73H4ajp8jfZO40XzRnax
 4grEDahyiLriEQqsm+pHVXI0uJ7Mve9nX6H8oskkw2sbBS92v1QB7OV88o4ztSI6L9mDnNqA3m
 VJ8=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924478"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:12 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428672; x=1631964672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NF0YvsWmda4CKec14Q2X5WCpSORPKKfP43/LpiP0w6Q=;
  b=DjcW4jgKaRW3erKG/umTzhjL14dRSxYza6kWtc3rqiHIDEW2K0cqKdhB
   hHGcSX3nLOwFF4EVqTopjOyEnpAPaoMziqB4U5/DYbczpG7rTX95pVL3t
   GAy6t/4ADrd5Q6vZ83ppDeTDNH0qnodDwfGqUvTUbjCGZqaAVhSxft/h1
   bpTc3CPflHF+ReT1A1cgtjEq+NUnufsW9OwEshpGtzfd49UncwAdiomuu
   CJGn7+3GZIc4cTI41Qk8Ir5YwbBwQuo77QnyWSmv4982u+8jCetrzNbNI
   riqS2Q8biBIwFw9iQc5C8Y8jPjM9Y8ZziOn1bvg1np20GDXVJJ8tBMb0/
   Q==;
IronPort-SDR: OluljB94J6ZB3DAnGvMBFlzIUBil72KOd5p0fOGCzJmup0oYkBxRBXFnk7Fz2x9kSst3Q/5El0
 lcPnKqcm88bfaevEe2ntVlrmp1IQOvy6ajY15czn3JeIWzFlBRdFqgowW0fYF6Dog1N/5EzsUS
 Rqaeze0lcvlf+HA+ls2Rlat0inY9BtrN3nCcj0R+a5oYT6Pj/RWxLergM2dJxIKFZ5wI/4dCON
 pKYd3fGALD6xR8Tbunu/dd65Q96PMSqlW9UIn1j2jJN+4La1QlGzhh+fP0EsdOdJKlIeqOCcKM
 jKs=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924477"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5A9A2280070;
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
Subject: [PATCH 03/13] ARM: dts: imx7-mba7: update compatible strings
Date:   Fri, 18 Sep 2020 13:29:32 +0200
Message-Id: <20200918112942.1367-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the SoM compatible string.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7d-mba7.dts | 2 +-
 arch/arm/boot/dts/imx7s-mba7.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-mba7.dts b/arch/arm/boot/dts/imx7d-mba7.dts
index 221274c73dbd..9f4f7112e598 100644
--- a/arch/arm/boot/dts/imx7d-mba7.dts
+++ b/arch/arm/boot/dts/imx7d-mba7.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "TQ Systems TQMa7D board on MBa7 carrier board";
-	compatible = "tq,imx7d-mba7", "fsl,imx7d";
+	compatible = "tq,imx7d-mba7", "tq,imx7d-tqma7", "fsl,imx7d";
 };
 
 &fec2 {
diff --git a/arch/arm/boot/dts/imx7s-mba7.dts b/arch/arm/boot/dts/imx7s-mba7.dts
index a143d566a38b..d7d3f530f843 100644
--- a/arch/arm/boot/dts/imx7s-mba7.dts
+++ b/arch/arm/boot/dts/imx7s-mba7.dts
@@ -14,5 +14,5 @@
 
 / {
 	model = "TQ Systems TQMa7S board on MBa7 carrier board";
-	compatible = "tq,imx7s-mba7", "fsl,imx7s";
+	compatible = "tq,imx7s-mba7", "tq,imx7s-tqma7", "fsl,imx7s";
 };
-- 
2.17.1

