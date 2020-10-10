Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3675F28A084
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgJJNF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 09:05:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbgJJKQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:16:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 930ADBC087A0E2A1C59C;
        Sat, 10 Oct 2020 17:57:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 17:57:35 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 03/10] ARM: dts: hisilicon: fix errors detected by usb yaml
Date:   Sat, 10 Oct 2020 17:57:02 +0800
Message-ID: <20201010095709.1340-4-thunder.leizhen@huawei.com>
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

1. Change node name to match '^usb(@.*)?'

These errrors are detected by generic-ehci.yaml and generic-ohci.yaml.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index f645487402f6e86..0c1708945813346 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -453,14 +453,14 @@
 			status = "disabled";
 		};
 
-		usb0: ehci@1890000 {
+		usb0: usb@1890000 {
 			compatible = "generic-ehci";
 			reg = <0x1890000 0x1000>;
 			interrupts = <0 66 4>;
 			clocks = <&clock HIX5HD2_USB_CLK>;
 		};
 
-		usb1: ohci@1880000 {
+		usb1: usb@1880000 {
 			compatible = "generic-ohci";
 			reg = <0x1880000 0x1000>;
 			interrupts = <0 67 4>;
-- 
1.8.3


