Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA528AE24
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgJLGNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:13:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727260AbgJLGMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:12:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E812157BB096393EC4E3;
        Mon, 12 Oct 2020 14:12:45 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 14:12:38 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 06/10] ARM: dts: hisilicon: fix errors detected by synopsys-dw-mshc.yaml
Date:   Mon, 12 Oct 2020 14:12:21 +0800
Message-ID: <20201012061225.1597-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012061225.1597-1-thunder.leizhen@huawei.com>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look at the clock-names schema defined in synopsys-dw-mshc.yaml:
  clock-names:
    items:
      - const: biu
      - const: ciu

The "biu" needs to be placed before the "ciu".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 8fdfde492919407..9a513893758bf89 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -423,7 +423,7 @@
 			interrupts = <0 35 4>;
 			clocks = <&clock HIX5HD2_MMC_CIU_RST>,
 				 <&clock HIX5HD2_MMC_BIU_CLK>;
-			clock-names = "ciu", "biu";
+			clock-names = "biu", "ciu";
 		};
 
 		sd: mmc@1820000 {
@@ -432,7 +432,7 @@
 			interrupts = <0 34 4>;
 			clocks = <&clock HIX5HD2_SD_CIU_RST>,
 				 <&clock HIX5HD2_SD_BIU_CLK>;
-			clock-names = "ciu","biu";
+			clock-names = "biu", "ciu";
 		};
 
 		gmac0: ethernet@1840000 {
-- 
1.8.3


