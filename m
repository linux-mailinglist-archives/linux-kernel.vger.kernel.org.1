Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ABA28AE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgJLGMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:12:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbgJLGMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:12:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BA150B73366EE4340348;
        Mon, 12 Oct 2020 14:12:45 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 14:12:35 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 00/10] clean up all Hisilicon-related errors detected by DT schema on arm32
Date:   Mon, 12 Oct 2020 14:12:15 +0800
Message-ID: <20201012061225.1597-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
Too deep in arm32. I forgot arm64. Add property "#reset-cells" into sysctrl.yaml (Patch 9).


v1:
These patches are based on the latest linux-next.

Zhen Lei (10):
  ARM: dts: hisilicon: fix errors detected by snps-dw-apb-uart.yaml
  ARM: dts: hisilicon: fix errors detected by pl011.yaml
  ARM: dts: hisilicon: fix errors detected by usb yaml
  ARM: dts: hisilicon: fix errors detected by simple-bus.yaml
  ARM: dts: hisilicon: fix errors detected by root-node.yaml
  ARM: dts: hisilicon: fix errors detected by synopsys-dw-mshc.yaml
  ARM: dts: hisilicon: fix errors detected by spi-pl022.yaml
  ARM: dts: hisilicon: fix errors detected by syscon.yaml
  dt-bindings: arm: hisilicon: add missing properties into sysctrl.yaml
  dt-bindings: arm: hisilicon: add missing properties into cpuctrl.yaml

 .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 27 +++++++++++++-
 .../bindings/arm/hisilicon/controller/sysctrl.yaml | 28 +++++++++++++--
 arch/arm/boot/dts/hi3519-demb.dts                  |  2 +-
 arch/arm/boot/dts/hi3519.dtsi                      | 32 ++++++++---------
 arch/arm/boot/dts/hi3620-hi4511.dts                | 24 ++++++-------
 arch/arm/boot/dts/hi3620.dtsi                      | 32 ++++++++---------
 arch/arm/boot/dts/hip01-ca9x2.dts                  |  2 +-
 arch/arm/boot/dts/hip01.dtsi                       | 26 +++++++-------
 arch/arm/boot/dts/hip04-d01.dts                    |  2 +-
 arch/arm/boot/dts/hip04.dtsi                       |  6 ++--
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts               |  2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  | 42 +++++++++++-----------
 12 files changed, 136 insertions(+), 89 deletions(-)

-- 
1.8.3


