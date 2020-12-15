Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87872DA5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 02:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgLOBpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 20:45:22 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:59386 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1730914AbgLOBpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 20:45:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 7649120138C6;
        Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0gcxjvr6xVlo; Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 5D39520139A0;
        Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 6094AC01FAD;
        Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 4D3A02000CF; Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 1/2] devicetree: phy: rockchip-emmc optional add vendor prefix
Date:   Tue, 15 Dec 2020 09:44:07 +0800
Message-Id: <20201215014409.905-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
References: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation and add the vendor prefix to the optional
properties referred in vendor-prefixes.yaml.
Follow up with
commit 8b5c2b45b8f0a ("phy: rockchip: set pulldown for strobe line in dts")
commit a8cef928276bb ("phy: rockchip-emmc: output tap delay dt property")

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
index 00aa2d349e55..57d28c0d5696 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
@@ -16,11 +16,11 @@ Optional properties:
  - drive-impedance-ohm: Specifies the drive impedance in Ohm.
                         Possible values are 33, 40, 50, 66 and 100.
                         If not set, the default value of 50 will be applied.
- - enable-strobe-pulldown: Enable internal pull-down for the strobe line.
-                           If not set, pull-down is not used.
- - output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
-                           If not set, the register defaults to 0x4.
-                           Maximum value 0xf.
+ - rockchip,enable-strobe-pulldown: Enable internal pull-down for the strobe
+                                    line.  If not set, pull-down is not used.
+ - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
+                                    If not set, the register defaults to 0x4.
+                                    Maximum value 0xf.
 
 Example:
 
-- 
2.20.1

