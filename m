Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9828A08A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgJJNYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 09:24:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbgJJKQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:16:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3954681641ED91839EE;
        Sat, 10 Oct 2020 17:57:46 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 17:57:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 05/10] ARM: dts: hisilicon: fix errors detected by root-node.yaml
Date:   Sat, 10 Oct 2020 17:57:04 +0800
Message-ID: <20201010095709.1340-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201010095709.1340-1-thunder.leizhen@huawei.com>
References: <20201010095709.1340-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the momory node name match the regex "^memory(@[0-9a-f]+)?$" which
is described in memory.yaml. Otherwise, it will be treated as root node,
and misreported by root-node.yaml.

Errors misreported by root-node.yaml:
/: memory: False schema does not allow {'device_type': ['memory'], 'reg':

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hi3519-demb.dts    | 2 +-
 arch/arm/boot/dts/hi3620-hi4511.dts  | 2 +-
 arch/arm/boot/dts/hip01-ca9x2.dts    | 2 +-
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/hi3519-demb.dts b/arch/arm/boot/dts/hi3519-demb.dts
index 64f8ed126931099..f473fa22e9ce56a 100644
--- a/arch/arm/boot/dts/hi3519-demb.dts
+++ b/arch/arm/boot/dts/hi3519-demb.dts
@@ -14,7 +14,7 @@
 		serial0 = &uart0;
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/hi3620-hi4511.dts b/arch/arm/boot/dts/hi3620-hi4511.dts
index 29eedc7fef9861e..ce356c469e1e13e 100644
--- a/arch/arm/boot/dts/hi3620-hi4511.dts
+++ b/arch/arm/boot/dts/hi3620-hi4511.dts
@@ -17,7 +17,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/hip01-ca9x2.dts b/arch/arm/boot/dts/hip01-ca9x2.dts
index f05e74eacfe0bf2..031476304d94614 100644
--- a/arch/arm/boot/dts/hip01-ca9x2.dts
+++ b/arch/arm/boot/dts/hip01-ca9x2.dts
@@ -37,7 +37,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
index d55e9cd3b12b420..22b122d3f514e43 100644
--- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
+++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
@@ -35,7 +35,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000>;
 	};
-- 
1.8.3


