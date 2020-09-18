Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4226FB88
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIRLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:20 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29647 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgIRLeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:11 -0400
IronPort-SDR: WQX40KStidA4LE1qgAWsKRGLHa778IlO/uDUwhHqCro7NG9ExjARjhwC3wd/q/Z8iEw7+zMgiO
 r154hYkusxsjPNEIvsF5C6KispK5Fa82Gx6TPPWTqaSzkjrOY+qgICpJCAIIWgC6zR2gNDuAl1
 e4ltq323JdRxZdOS/AYIDazEF8tJTG4FF7a6uia/mgMXnlov22NSfnB/V7ygAJhdlUU5n0Rc5m
 XTrsW292LR9Wf0Uog5J5Idjb02NadO1AQ7Rutj7kDO5ynaC5uNqaLarlGvC3mTJXEk6VZfxk1r
 rSs=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924496"
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
  bh=V7NXnPVlHjtu5xGZx1DU3rEG1dtj/O+Su3A/9FPj2QI=;
  b=ntN61kLLVLy9sn0F2//er8KiDQmK2ne4qQrnogaO6223MACh62y51WaT
   yA9dAxhxM2zol/oBS2wscrOCxltX8hz2P7UXMvKG3a7V3s/24TOIerm1t
   a5xWSaap/GYx5lshF2OVzBo2WwVdhVcwUu6YVktpn4L+T1IQIIj+Y1p1G
   p4Kuyp1ioExmUwIdnxJ77tXlxQePCI1gngn7up5Mq6a0iwyz9Wx10J0uK
   /yu6IKCKdx88ux6d+7voE26FC4WFX2qzsx1YrHCjr8edRrB78ny8euTT7
   Hne0CD2t7uXRmu7c82Ny7lJUcnPqR9W1WriS29/Rmg5/qCh/Y7xhPxkTV
   Q==;
IronPort-SDR: ND2awgY5cY5AFXZmwUJ6k2HAAQ3JOwE5Kk5kpvdBLncTTJgLnFspNW+OCElJtN2kNH9PZ421iN
 VmEO6Q5Vza7DV39TlPFAwxjDm8KJZr2qobGzrAcRV6f+btxuaMkJGFoUFWpA5kKOflm/BxwMpb
 IJEVyvXiUsbPuqzhEr54AXLchc/fUDi+kJNRf4sRInoWVy6GkuS4xEFmUqAt9OK6pA/zHU1xGq
 aZybw66J4uCg/PpoBnkKVywhKR/fnYoUttGtBMJznU/2M5XAOewPl7EThyBCTk9/kHFfJNfZ29
 Uq4=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924495"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:14 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5B0BB280075;
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
Subject: [PATCH 12/13] ARM: dts: imx7-mba7: specify USB over-current polarity
Date:   Fri, 18 Sep 2020 13:29:41 +0200
Message-Id: <20200918112942.1367-12-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add over-current-active-low to usbotg1.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index cd29844bc76b..52b8f66f9982 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -610,6 +610,7 @@
 	srp-disable;
 	hnp-disable;
 	adp-disable;
+	over-current-active-low;
 	dr_mode = "host";
 	status = "okay";
 };
-- 
2.17.1

