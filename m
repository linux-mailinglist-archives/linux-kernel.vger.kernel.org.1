Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904B926FB89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIRLeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:23 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17964 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgIRLeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:11 -0400
IronPort-SDR: G7j0W4fCsT7C3T6UaBY3zZKbSyRGh6sd3ko6ZhVFwyoeW2HAfDhYxWsVbRiyW/p6ybkIz3+K9T
 g9dlSmvyTmnyrRT3vC5puX21sY+wCC2YKDbAILq3xW+8ery9Bt2l+gg2ksI865eMCP+2rraB46
 +rk+1g6m93PMMEL41JHQ9L1izVgDr7gHUtEi5LlUbJATCwa4fgwqErJ+PTD494B6vHJQyUHOLz
 AVB+w7irAB2mSP7NAFiXgIsih/4P03uSa23tzZnbkdl8xeHOKA5RXmHRGhHknLlZc3lDoCXHVM
 Ntw=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924494"
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
  bh=FoLkcmY127+RUssziJZwJi9JWiupcp2leD+aU+pwW0Y=;
  b=aQQS0YLlSy7OfH1no9d5YnrKU9JeVyfZ0P7g8bnYLCuJhjsoY/uQXtPd
   mZ42JLEJIaapG6TX7NECyHOrJ4HpJyTZRAybWpJ9KX94vY/1n4PSrxTta
   93nqQhCes5IlXShGEfsqX3AwVdEfwcYhHSpuyLT0LxLiIJWAaS+ZfX2/G
   7qU6wUoUooeN2vHLBrWQ+qigY+yzKv+TDoejvejLFexpAOFn16jkq7XJN
   PhzPrCfGvJ9TNbQj78aucieRe67CVRHjfEShzFLDYVwwUpx9QkYX9P2PI
   8nsdUf2nnnkV5s3Y57tFnVI0J4Hf7/QZFerpLxfdf4RR7ljuGwthCfKPs
   Q==;
IronPort-SDR: sjxSsLmZQiNzfU+uIBJFif/iFo0vydvvp0Dv4vDDlh/tZUtlCB9ejoLB/ViA9UHpuvfGcqAnV4
 uWYFCNVRxq1nZ9N0O7p9hdOL7ubeCODbqDrnSNW3fGqun6sqZXyn7JkS55CeNUafDVeO/PjYCc
 DnzOnMaWgEK1TQSHIrd8StwynIh27On1MN8n4qyla3wtmUyvB7qsTWfi/RNKSvx0O2ETiCMgHY
 jgHJMK63My5ZXaKilZFsyFTxDuwtuJQzojjPhFYN6DR4Mw7eDMAw0PvvLIE0EFDM3YLpJcoCT+
 ET0=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924493"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:14 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 23423280070;
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
Subject: [PATCH 11/13] ARM: dts: imx7-mba7: enable RS485 on UART7
Date:   Fri, 18 Sep 2020 13:29:40 +0200
Message-Id: <20200918112942.1367-11-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART7 interface is connected to a full-duplex RS485 transceiver.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index f1e50bcd21a5..cd29844bc76b 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -593,6 +593,9 @@
 	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
 	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
 	uart-has-rtscts;
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-active-low;
+	rs485-rx-during-tx;
 	status = "okay";
 };
 
-- 
2.17.1

