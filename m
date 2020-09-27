Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1385279EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgI0G07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:26:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729740AbgI0G0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:26:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA2E3BD38244D8610FE3;
        Sun, 27 Sep 2020 14:26:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 27 Sep 2020 14:26:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 01/21] ARM: dts: remove a unused compatible name in hip01-ca9x2.dts
Date:   Sun, 27 Sep 2020 14:21:09 +0800
Message-ID: <20200927062129.4573-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200927062129.4573-1-thunder.leizhen@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible name "hisilicon,hip01" does not exist in any C file, and
it is not mentioned in the description file "hisilicon.txt". Delete it.

Fixes: 56a9c909d88a ("ARM: dts: Add hip01-ca9x2 dts file")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hip01-ca9x2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hip01-ca9x2.dts b/arch/arm/boot/dts/hip01-ca9x2.dts
index f05e74eacfe0bf2..936acb301c55a10 100644
--- a/arch/arm/boot/dts/hip01-ca9x2.dts
+++ b/arch/arm/boot/dts/hip01-ca9x2.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "Hisilicon HIP01 Development Board";
-	compatible = "hisilicon,hip01-ca9x2", "hisilicon,hip01";
+	compatible = "hisilicon,hip01-ca9x2";
 
 	cpus {
 		#address-cells = <1>;
-- 
1.8.3


