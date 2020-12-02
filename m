Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0E2CB711
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbgLBI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:26:11 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:49120 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:26:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id B6F6D200D28A;
        Wed,  2 Dec 2020 16:25:24 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OEkpvfX_SFVv; Wed,  2 Dec 2020 16:25:24 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9CB72200D287;
        Wed,  2 Dec 2020 16:25:24 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 9486AC019F3;
        Wed,  2 Dec 2020 16:25:24 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 93BA8200756; Wed,  2 Dec 2020 16:25:24 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 2/2] devicetree: phy: rockchip-emmc add output-tapdelay-select
Date:   Wed,  2 Dec 2020 16:25:07 +0800
Message-Id: <20201202082507.3536-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
References: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the rockchip-emmc-phy.txt and add the u32 property
'output-tapdelay-select'. This allow to set the otapdlysec register.

Tested with our customized rk3399 board to tune eMMC.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
index 3e4d2d79a65d..00aa2d349e55 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
@@ -18,6 +18,9 @@ Optional properties:
                         If not set, the default value of 50 will be applied.
  - enable-strobe-pulldown: Enable internal pull-down for the strobe line.
                            If not set, pull-down is not used.
+ - output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
+                           If not set, the register defaults to 0x4.
+                           Maximum value 0xf.
 
 Example:
 
-- 
2.20.1

