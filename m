Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA12F2D91FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 04:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438270AbgLNDB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 22:01:27 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:54610 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2438224AbgLNDBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 22:01:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 2A31320136F8;
        Mon, 14 Dec 2020 11:00:12 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TLFs9o6B741i; Mon, 14 Dec 2020 11:00:12 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 13A5720136F7;
        Mon, 14 Dec 2020 11:00:12 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 16FCEC01FAD;
        Mon, 14 Dec 2020 11:00:12 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 083B12000CF; Mon, 14 Dec 2020 11:00:12 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] devicetree: dtsi: rk3399-puma.dtsi, add "rockchip," vendor prefix
Date:   Mon, 14 Dec 2020 10:59:45 +0800
Message-Id: <20201214025946.25753-5-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214025946.25753-1-chris.ruehl@gtsys.com.hk>
References: <20201214025946.25753-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update rk3399-puma.dtsi with the vendor prefix referred in
vendor-prefixes.yaml.
Optional property: rockchip,drive-impedance-ohm

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 4660416c8f38..b715e73f9749 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -146,7 +146,7 @@
 
 &emmc_phy {
 	status = "okay";
-	drive-impedance-ohm = <33>;
+	rockchip,drive-impedance-ohm = <33>;
 };
 
 &gmac {
-- 
2.20.1

