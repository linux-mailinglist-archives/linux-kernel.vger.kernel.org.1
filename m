Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460EC2CD51A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgLCMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:03:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9364 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgLCMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:03:37 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmvbR5b1Vz785x;
        Thu,  3 Dec 2020 20:02:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 20:02:45 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/4] dt-bindings: reset: correct vendor prefix hisi to hisilicon
Date:   Thu, 3 Dec 2020 20:02:11 +0800
Message-ID: <20201203120212.1105-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201203120212.1105-1-thunder.leizhen@huawei.com>
References: <20201203120212.1105-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
stated in "vendor-prefixes.yaml".

Fixes: 836e23549583 ("dt-bindings: Document the hi3660 reset bindings")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
index 2df4bddeb688918..aefd26710f9e87d 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
@@ -11,7 +11,7 @@ Required properties:
 - compatible: should be one of the following:
 		 "hisilicon,hi3660-reset" for HI3660
 		 "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
-- hisi,rst-syscon: phandle of the reset's syscon.
+- hisilicon,rst-syscon: phandle of the reset's syscon.
 - #reset-cells : Specifies the number of cells needed to encode a
   reset source.  The type shall be a <u32> and the value shall be 2.
 
@@ -29,7 +29,7 @@ Example:
 
 	iomcu_rst: iomcu_rst_controller {
 		compatible = "hisilicon,hi3660-reset";
-		hisi,rst-syscon = <&iomcu>;
+		hisilicon,rst-syscon = <&iomcu>;
 		#reset-cells = <2>;
 	};
 
-- 
1.8.3


