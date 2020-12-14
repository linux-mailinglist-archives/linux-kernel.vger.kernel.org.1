Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AF2D91D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 03:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438031AbgLNCtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 21:49:36 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:53920 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2438018AbgLNCt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:49:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 90F1620136F7;
        Mon, 14 Dec 2020 10:48:39 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id npWj4ONxUwwt; Mon, 14 Dec 2020 10:48:39 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 76AC520136DB;
        Mon, 14 Dec 2020 10:48:39 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 75857C01FAD;
        Mon, 14 Dec 2020 10:48:39 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 638232000CF; Mon, 14 Dec 2020 10:48:39 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Carlos de Paula <me@carlosedp.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] devicetree: dtsi: rk3399.dtsi, add "rockchip," vendor prefix
Date:   Mon, 14 Dec 2020 10:47:18 +0800
Message-Id: <20201214024720.24656-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214024720.24656-1-chris.ruehl@gtsys.com.hk>
References: <20201214024720.24656-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update rk3399.dtsi with the vendor prefix referred in vendor-prefixes.yaml.
Optional property: rockchip,drive-impedance-ohm

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index f5dee5f447bb..38284686aab0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1482,7 +1482,7 @@
 			clock-names = "refclk";
 			#phy-cells = <1>;
 			resets = <&cru SRST_PCIEPHY>;
-			drive-impedance-ohm = <50>;
+			rockchip,drive-impedance-ohm = <50>;
 			reset-names = "phy";
 			status = "disabled";
 		};
-- 
2.20.1

