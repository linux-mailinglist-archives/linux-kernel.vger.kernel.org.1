Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762127DEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgI3DTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:19:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729943AbgI3DSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:18:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C863DB33977C52F6BA2;
        Wed, 30 Sep 2020 11:18:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 11:18:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v6 09/17] ARM: dts: hisilicon: fix ststem controller compatible node
Date:   Wed, 30 Sep 2020 11:17:04 +0800
Message-ID: <20200930031712.2365-10-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200930031712.2365-1-thunder.leizhen@huawei.com>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT binding for Hisilicon system controllers requires to have a
"syscon" compatible string.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hi3620.dtsi | 2 +-
 arch/arm/boot/dts/hip04.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index 355175b25fd6220..f683440ee5694b4 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -89,7 +89,7 @@
 		};
 
 		sysctrl: system-controller@802000 {
-			compatible = "hisilicon,sysctrl";
+			compatible = "hisilicon,sysctrl", "syscon";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x802000 0x1000>;
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index f5871b1d1ec452c..555bc6b6720fc94 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -213,7 +213,7 @@
 		};
 
 		sysctrl: sysctrl {
-			compatible = "hisilicon,sysctrl";
+			compatible = "hisilicon,sysctrl", "syscon";
 			reg = <0x3e00000 0x00100000>;
 		};
 
-- 
1.8.3


