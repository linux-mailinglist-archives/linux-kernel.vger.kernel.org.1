Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708C427D0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgI2OQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:16:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728599AbgI2OPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 694F2DF4E77E81DA352A;
        Tue, 29 Sep 2020 22:15:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 22:15:11 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 01/17] dt-bindings: mfd: syscon: add some compatible strings for Hisilicon
Date:   Tue, 29 Sep 2020 22:14:38 +0800
Message-ID: <20200929141454.2312-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200929141454.2312-1-thunder.leizhen@huawei.com>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some compatible strings for Hisilicon controllers:
hisilicon,hi6220-sramctrl  --> Hi6220 SRAM controller
hisilicon,pcie-sas-subctrl --> HiP05/HiP06 PCIe-SAS subsystem controller
hisilicon,peri-subctrl     --> HiP05/HiP06 PERI subsystem controller
hisilicon,dsa-subctrl      --> HiP05/HiP06 DSA subsystem controller

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 049ec2ffc7f97e4..fc2e85004d363bf 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -40,7 +40,10 @@ properties:
               - allwinner,sun50i-a64-system-controller
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
-
+              - hisilicon,hi6220-sramctrl
+              - hisilicon,pcie-sas-subctrl
+              - hisilicon,peri-subctrl
+              - hisilicon,dsa-subctrl
           - const: syscon
 
       - contains:
-- 
1.8.3


