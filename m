Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40CD26FB94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgIRLeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:50 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29642 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgIRLeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:03 -0400
IronPort-SDR: AexJelam2qld6QjrpKSNqfwZD/xB40AnfrwaEY1zxgINMAwzXwarx6BgzBRsFJx/lasnwY84Dz
 /alXmTwsAFncxYqg1/Y5beA8bfpAZC8jKwYvNh+s7rEIFCCUEEawbHpNNR9NHzlTa4zH9j7HPS
 mj3Og+SFAyWfF6HRC8VHJYEQfRipPBq3gIhr9ENlPJEBvPy0/dCsoltmG6T9L6PkvepF633Qwv
 e03yGd1rrlqYZ5CIC4Oe6C5iZW/WPRv8uy1W9lIQvjBoU3N9lp9BY3hsd/7IT3wVOxxi6EoiIE
 TJM=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924484"
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
  bh=ddjt2GOKc9dVHenoAL0RhtQg5EQPnlY5ATXTCj0FKbY=;
  b=GWfHhG/Rp0hz3JJXFB4kphQehb3GedpBanVMQV2MiFrpDFic/70Tstdg
   jO/MR5dqHd79eDYhCuOuLbbFxd2iGgmCE8lOSFsmiudPF8b27mPeISYdf
   USLvNUtVLpIv4GJCC67yK/QMIt+6sH8gBC/UruPXURNLF9BsPIB6f3dfP
   ATt9zqw5TWpE/rA0y4zTfXIOD6Vnc1XDdbYmJ7qXdtcvWFnjZvr8GE0Tr
   /Tz/M6eWbLsXum0jyFmHVvMp0ikKnETjgskWm2kGTvGFGYlmDUsBG9FII
   L2T9v/JhgzT0zqnfdRcO98YUbZlnqSSOzYW8v36pGaSnfQcEftYfJTdix
   w==;
IronPort-SDR: iaOt9MJCBopC0y/yl1PdEygVSWqaz8bWI6wflklSHwRwFa1h6CVdC6KzX0uvb+XHSgMS8/GvIH
 XkJF7H6axCWHchCSyIStZTcyC+lnuCsaD8fndXXqTC/ZhVlpVx8tnf5uJcV+os5E49sxGpKbij
 SEESsavsLa6Z9cQGJXYI4ASNh4DzcnY6tnOkRtTzEhzSIzC8XlEAnuB+HpXoLJy4+WGvZuSsVg
 qTCGhhXzI4i95+N9EilOOYktNBMov8+eNFapfYniAe2ChrLmeLSsevDPI5ltgM/7qwmUxiyR/q
 HC0=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924483"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:13 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0411B280075;
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
Subject: [PATCH 06/13] ARM: dts: imx7-mba7: disable ethernet PHY clock outputs
Date:   Fri, 18 Sep 2020 13:29:35 +0200
Message-Id: <20200918112942.1367-6-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock outputs are not connected. Disable them to improve EMI
behaviour.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 1 +
 arch/arm/boot/dts/imx7d-mba7.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 1af40032ab17..9be225bb135a 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -212,6 +212,7 @@
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-mba7.dts b/arch/arm/boot/dts/imx7d-mba7.dts
index 1101be373ddf..5ef86de53013 100644
--- a/arch/arm/boot/dts/imx7d-mba7.dts
+++ b/arch/arm/boot/dts/imx7d-mba7.dts
@@ -39,6 +39,7 @@
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 		};
 	};
 };
-- 
2.17.1

