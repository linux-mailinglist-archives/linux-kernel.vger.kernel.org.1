Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B0828B601
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbgJLNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:19:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56918 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388895AbgJLNTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A4E65BB5CE359F09560D;
        Mon, 12 Oct 2020 21:19:35 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:19:25 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 04/11] arm64: dts: hisilicon: remove unused property pinctrl-names
Date:   Mon, 12 Oct 2020 21:17:32 +0800
Message-ID: <20201012131739.1655-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012131739.1655-1-thunder.leizhen@huawei.com>
References: <20201012131739.1655-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart1 and uart5 are not used as pinctrl, so the property "pinctrl-names"
can be deleted. In fact, the property "pinctrl-names" depends on the
property "pinctrl-0". So the errors similar to the following will be
reported by pinctrl-consumer.yaml.

serial@fdf00000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 668977d1acba94c..85b0dfb35d6d396 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -213,7 +213,6 @@
 			clocks = <&crg_ctrl HI3670_CLK_GATE_UART1>,
 				 <&crg_ctrl HI3670_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
-			pinctrl-names = "default";
 			status = "disabled";
 		};
 
@@ -260,7 +259,6 @@
 			clocks = <&crg_ctrl HI3670_CLK_GATE_UART5>,
 				 <&crg_ctrl HI3670_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
-			pinctrl-names = "default";
 			status = "disabled";
 		};
 
-- 
1.8.3


