Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46C2C780F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 06:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgK2Fq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 00:46:29 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:39792 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgK2Fq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 00:46:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 3F76B2002390;
        Sun, 29 Nov 2020 13:45:43 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id meYs45fgQ6dV; Sun, 29 Nov 2020 13:45:43 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 24F5E20020FC;
        Sun, 29 Nov 2020 13:45:43 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 1E2AFC019E2;
        Sun, 29 Nov 2020 13:45:43 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 2005C200756; Sun, 29 Nov 2020 13:45:43 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/2] devicetree: phy: rockchip-emmc: pulldown property
Date:   Sun, 29 Nov 2020 13:44:15 +0800
Message-Id: <20201129054416.3980-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
References: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation and add the bool property
enable-strobe-pulldown used to enable the internal pull-down for the
strobe line.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
index e728786f21e0..3e4d2d79a65d 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
@@ -16,6 +16,8 @@ Optional properties:
  - drive-impedance-ohm: Specifies the drive impedance in Ohm.
                         Possible values are 33, 40, 50, 66 and 100.
                         If not set, the default value of 50 will be applied.
+ - enable-strobe-pulldown: Enable internal pull-down for the strobe line.
+                           If not set, pull-down is not used.
 
 Example:
 
-- 
2.20.1

