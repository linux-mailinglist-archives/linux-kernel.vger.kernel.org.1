Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1609A279EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgI0G0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:26:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729125AbgI0G0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:26:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8EA86B4CF5A0BF47F0A0;
        Sun, 27 Sep 2020 14:26:47 +0800 (CST)
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
Subject: [PATCH v3 00/21] add support for Hisilicon SD5203 SoC
Date:   Sun, 27 Sep 2020 14:21:08 +0800
Message-ID: <20200927062129.4573-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 --> v3:
1. Convert hisilicon.txt to hisilicon.yaml. Because there are many kinds
   of Hisilicon controllers in it, so split each of them into a separate
   file first. Then I convert all of them to DT schema format, and also
   convert the other files in directory "../bindings/arm/hisilicon/".
2. Add Patch 1: remove a unused compatible name in hip01-ca9x2.dts
   This error is detected by hisilicon.yaml.

   The merge window of 5.10 is narrow now, so please review Patch 1-7 first.


v1 --> v2:
1. add binding for SD5203 SoC, Patch 1
2. select DW_APB_ICTL instead of HISILICON_SD5203_VIC in Patch 2.
   Meanwhile, change the compatible of interrupt-controller to "snps,dw-apb-ictl" in Patch 4.
3. Fix the errors detected by dtbs_check. For example: add "reg" for cpu node, use lowercase a-f
   to describe address, add "baudclk" for "snps,dw-apb-uart".

v1:
Add SD5203 SoC config option and devicetree file, also enable its debug UART.

Kefeng Wang (3):
  ARM: hisi: add support for SD5203 SoC
  ARM: debug: add UART early console support for SD5203
  ARM: dts: add SD5203 dts

Zhen Lei (18):
  ARM: dts: remove a unused compatible name in hip01-ca9x2.dts
  dt-bindings: arm: hisilicon: split the dt-bindings of each controller
    into a separate file
  dt-bindings: arm: hisilicon: convert Hisilicon board/soc bindings to
    json-schema
  dt-bindings: arm: hisilicon: add binding for SD5203 SoC
  dt-bindings: arm: hisilicon: convert system controller bindings to
    json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,peri-subctrl bindings
    to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,pcie-sas-subctrl
    bindings to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,cpuctrl bindings to
    json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,pctrl bindings to
    json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hi3798cv200-perictrl
    bindings to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,dsa-subctrl bindings to
    json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hip04-fabric bindings
    to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hip04-bootwrapper
    bindings to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hi6220-aoctrl bindings
    to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hi6220-mediactrl
    bindings to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hi6220-pmctrl bindings
    to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hi6220-sramctrl
    bindings to json-schema
  dt-bindings: arm: hisilicon: convert LPC controller bindings to
    json-schema

 .../controller/hi3620/hisilicon,hi6220-aoctrl.yaml |  42 +++
 .../hi3620/hisilicon,hi6220-mediactrl.yaml         |  42 +++
 .../controller/hi3620/hisilicon,hi6220-pmctrl.yaml |  42 +++
 .../hi3620/hisilicon,hi6220-sramctrl.yaml          |  38 +++
 .../hipxx/hisilicon,hip04-bootwrapper.yaml         |  32 +++
 .../controller/hipxx/hisilicon,hip04-fabric.yaml   |  26 ++
 .../hisilicon/controller/hisilicon,cpuctrl.yaml    |  28 ++
 .../controller/hisilicon,dsa-subctrl.yaml          |  37 +++
 .../controller/hisilicon,hi3798cv200-perictrl.yaml |  45 +++
 .../controller/hisilicon,pcie-sas-subctrl.yaml     |  37 +++
 .../arm/hisilicon/controller/hisilicon,pctrl.yaml  |  34 +++
 .../controller/hisilicon,peri-subctrl.yaml         |  34 +++
 .../hisilicon/controller/hisilicon,sysctrl.yaml    | 115 ++++++++
 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 -
 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ---
 .../arm/hisilicon/hisilicon-low-pin-count.yaml     |  63 ++++
 .../bindings/arm/hisilicon/hisilicon.txt           | 319 ---------------------
 .../bindings/arm/hisilicon/hisilicon.yaml          |  81 ++++++
 arch/arm/Kconfig.debug                             |  11 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/hip01-ca9x2.dts                  |   2 +-
 arch/arm/boot/dts/sd5203.dts                       |  96 +++++++
 arch/arm/mach-hisi/Kconfig                         |  16 +-
 23 files changed, 819 insertions(+), 370 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-aoctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-mediactrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-pmctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sramctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-bootwrapper.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip04-fabric.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
 create mode 100644 arch/arm/boot/dts/sd5203.dts

-- 
1.8.3


