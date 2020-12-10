Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183282D4F59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgLJAYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:24:02 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:41132 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLJAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:24:01 -0500
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1B30FA6083;
        Thu, 10 Dec 2020 08:21:44 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P20466T140379108411136S1607559696395890_;
        Thu, 10 Dec 2020 08:21:44 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <39b1b13616e26de086e413013b2f7368>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v16 3/8] MAINTAINERS: add maintainers to ROCKCHIP NFC
Date:   Thu, 10 Dec 2020 08:21:33 +0800
Message-Id: <20201210002134.5686-4-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210002134.5686-1-yifeng.zhao@rock-chips.com>
References: <20201210002134.5686-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers to ROCKCHIP NFC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v16: None
Changes in v15: None
Changes in v14: None
Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f474153dbec..413a60010ede 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2361,12 +2361,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
+F:	Documentation/devicetree/bindings/*/*rockchip*.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
-F:	Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
-F:	Documentation/devicetree/bindings/spi/spi-rockchip.yaml
 F:	arch/arm/boot/dts/rk3*
 F:	arch/arm/boot/dts/rv1108*
 F:	arch/arm/mach-rockchip/
+F:	drivers/*/*/*/*rockchip*
 F:	drivers/*/*/*rockchip*
 F:	drivers/*/*rockchip*
 F:	drivers/clk/rockchip/
-- 
2.17.1



