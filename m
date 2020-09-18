Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027B226FB85
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIRLeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:08 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17964 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgIRLdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:33:45 -0400
IronPort-SDR: +cfp4UxovrzOkmB6BTF9Znx5eWUI92Nrl1bWzTC5elvRAZsGwElW/ryfSnhfnsIjgqRhXUVjT/
 GD+JlnVfks7p71dRP4jApL5Z3dzIhjJB/Viv+pVBQMxGQK1UfN/QvbuUbftcz7un8G4ntdy/pS
 M42yZUp1IuJ71Su+CKjrS/ApLYekFDJ9tjlNoJYdL6HeKNTSQqARLgtCj13+CdWYXCS4xg/rSH
 HWpmh2lYtohUggZHAnkaGy/yqtWcQ6MJR5k7PJIuecCmsPXO8riXSsU49pLkru3bZu+W26m92K
 zsI=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924480"
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
  bh=vUppWHzohIv1ACxC2fc6XdPyyQfU+wMqKz9wiAISGSg=;
  b=hj0M9rTLxPHaQlxVF8jZbDDYQXjG9l/4XcD+rwKcWjWXtvFA0Fd79DXY
   ZX3zyXB/3fkQ3WPsuYydXoZRyH1zDzntL8ww8azqmJYd72B1zGe5a5u6+
   bA041VKg8tg0qxnPln9EQq4ZXN+NplPHHfKZbEvkk54t5fdoeJVVzseg5
   O8nbnP28Pl0q8ZoREYwSNZ7gJK035foM2lezEaUte/tQimS9uXufqupup
   pAmmlLXFHrAmmMKKQJhCLej1imSR08/3fBRUK7z1I6FRcosdYG47BtmlF
   dn4+zqqYoM5eXt83FIZERMY9e9rmxZpkAYwWi86ITkavAX8m/AgxSDSQm
   w==;
IronPort-SDR: uWmaregTUIHTSLRjxviI+If8pKxu8l/zqRSEaXHzXSQ1Jw5eWzKp2TOfB1alKbIAasyNwCooeS
 lLAAbS86UBonnksRb/vlYnnijuOkYS92jyQgBZifOStJiufd4G4rh6zacJMKBsZL9bG0arGQbI
 RzWo81AFePQK4KhJLMqnVTWbGWJHj+fmuOybl3KRqGobMG+tMte2ZoHgZK7FSTK94v+IlmV0OP
 4rZGWdQw8yoL1KC8UkZTwbLbKwV86HGdbXbm52D3WOQGIzMhScMHQuxVF/Dtrsw0+POpTypkEx
 e0E=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924479"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:12 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 91311280075;
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
Subject: [PATCH 04/13] ARM: dts: imx7-mba7: drop incorrect num-chipselects property
Date:   Fri, 18 Sep 2020 13:29:33 +0200
Message-Id: <20200918112942.1367-4-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property was never set correctly; it should have been num-cs. As
num-cs support is being removed as well, simply drop it.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 50abf18ad30b..d99912ade947 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -179,7 +179,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	num-chipselects = <3>;
 	cs-gpios = <&gpio4 0 GPIO_ACTIVE_LOW>, <&gpio4 1 GPIO_ACTIVE_LOW>,
 		   <&gpio4 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
@@ -188,7 +187,6 @@
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
-	num-chipselects = <1>;
 	status = "okay";
 };
 
-- 
2.17.1

