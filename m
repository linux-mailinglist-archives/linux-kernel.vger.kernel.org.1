Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A2527C0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgI2JQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:16:11 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:47732 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgI2JQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:16:07 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id D912FA4D84;
        Tue, 29 Sep 2020 17:08:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1665T140084565235456S1601370489886989_;
        Tue, 29 Sep 2020 17:08:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7c93c6f4907ea50fab47897f9a94730b>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v9 3/8] MAINTAINERS: add maintainers to ROCKCHIP NFC
Date:   Tue, 29 Sep 2020 17:08:06 +0800
Message-Id: <20200929090807.21511-4-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929090807.21511-1-yifeng.zhao@rock-chips.com>
References: <20200929090807.21511-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers to ROCKCHIP NFC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

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
index 1d4aa7f942de..187634a085a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2344,12 +2344,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
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



