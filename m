Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE8F26FB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIRLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:33 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29647 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIRLeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:06 -0400
IronPort-SDR: izWv99CxLZ2JIs07+Nvcr9cJf//re/hMUAtj+fG5KksF2uMzJQd0F579CQ7p5gHqh48BRCkZQo
 4llbwUg8ljYA/wqWCRZtaiiHHkWrzN8DUefzMh82URjhEYj6FNCPwjkij8YaTLX21lz9ISG4xt
 Unou6hZorO3xicrTZjdhQYRmwuUL5bzpGCMT7kWgEQI0U5TZHlyD/ODsajXPoiYw+uCcGV3P1f
 HDsnJYictaW1YcoCLrIJOItowZKkuMr/dttbEVS/ETmG4cRlpO0jzXNIwxvA0kLKJTk+tD1x2D
 xdw=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924488"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:13 +0200
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
  bh=JQI6xbL70virulPbizeeQYBK9R3CtSD7XVsLGSoo+wM=;
  b=dSMoUL5OFk30C5wjsGFkxW5Hy7XAI4arUMRqUcUQ0n9UgRu8RpYe0rIx
   wPiMT+HAiWt8O7kBdPCVlDua4i5dZ+rKk31h6XWU0gyNmUPaD9fB/dcov
   lC0IWKByawQQQdvVo9nBYXFkNHkoIKcdyZ6LuYSLd5qAsF9qSYC8oPHfL
   QKK/9Uuy/Cmr4/fiS5LB0HamGtWsSA9n2V2w0CRfc7WjewDYfZFHWdz76
   PBfHHMimqv1SJMHinANC/kVKirYl20QI4l7Z7D4AgaB4EDv5yp9EN05QY
   SKM056HgvBOeI3cl+/UmnphFDqtPKFO0nQO+tv002iljQeaW1yw1NFayj
   g==;
IronPort-SDR: a3zpmwKwV4W8JPvk0W7AXoxAlMbDj0w/AwedC5MtTc5nFXh+NqQ6Fk7xim9OISSvJgnFseUN+t
 jT1LosuRoJniM/2G45gPVwRFA+f6EYnc76zuGkMyDCpq50sOjS8HoioUGFpj3W0RIZru1/mrlh
 O5fRysLTe98r6EoLkuv9DnO+my1dmL/+8CHOBj2weAjxHUL/4rVWaffPKKj9GapAJFZFPqKtEj
 pUz/fq19UpylEh7QJQNJ6/ojhM33h6jwH+T0S02dAv7z31yq4zlF3CMPXHIvCpJCyYeJNOMxBc
 IvY=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924487"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:13 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 73E9E280075;
        Fri, 18 Sep 2020 13:31:13 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 08/13] ARM: dts: imx7-mba7: update MMC aliases
Date:   Fri, 18 Sep 2020 13:29:37 +0200
Message-Id: <20200918112942.1367-8-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Together with the recently merged support for alias-based MMC host
numbering, this makes the MMC devices names match what the bootloader
expects.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 84b5809f384c..215730e0453e 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -14,6 +14,12 @@
 #include <dt-bindings/net/ti-dp83867.h>
 
 / {
+	aliases {
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc1;
+		/delete-property/ mmc2;
+	};
+
 	beeper {
 		compatible = "gpio-beeper";
 		gpios = <&pca9555 0 GPIO_ACTIVE_HIGH>;
-- 
2.17.1

