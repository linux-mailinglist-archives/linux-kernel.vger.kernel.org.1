Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE6A27D0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgI2OPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:15:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14781 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730001AbgI2OPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:15:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7D915BBDD0B9E71D19F4;
        Tue, 29 Sep 2020 22:15:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 22:15:10 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 00/17] add support for Hisilicon SD5203 SoC
Date:   Tue, 29 Sep 2020 22:14:37 +0800
Message-ID: <20200929141454.2312-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 --> v5:
1. Drop the descriptions of the common properties, such as "reg".
2. Add "additionalProperties: false" or "additionalProperties: type: object"
   for each new yaml file.
3. Group three Hi6220 domain controller into one yaml file, see Patch 15
4. Remove the prefix "hisilicon," of each yaml file, all of them are under
   hisilicon directory, no need to duplicated it.
5. move four controllers into syscon.yaml, because they have no specific
   properties, see Patch 1-2.
6. Add the name of the board which based on sd5203, see Patch 5 and 8.
7. Add Patch 9, all controller should contain "syscon" compatible string.
8. Add property "ranges" and update the example, see Patch 16.
9. Romove the labels in all examples.
10. other trival fixes are not mentioned.

Please review Patch 1-9 first, other patches are not urgent and each of them
is independent.


v3 --> v4:
1. remove unexpected "\ No newline at end of file" of each new file.
2. discard the subdirectory "hi3620" and "hipxx", all files in the two
   directories are moved to the parent directory.
3. add two spaces for the below cases:
   - items:
     - const: hisilicon,sysctrl.	//add two spaces
4. only list the compatible of boards in hisilicon.yaml, that is:
   1) a compatible of one board
   2) a compatible of one board + a compatible of one SoC
5. other trival fixes are not mentioned.


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

Zhen Lei (14):
  dt-bindings: mfd: syscon: add some compatible strings for Hisilicon
  dt-bindings: arm: hisilicon: delete the descriptions of HiP05/HiP06
    controllers
  dt-bindings: arm: hisilicon: split the dt-bindings of each controller
    into a separate file
  dt-bindings: arm: hisilicon: convert Hisilicon board/soc bindings to
    json-schema
  dt-bindings: arm: hisilicon: add binding for SD5203 SoC
  ARM: dts: hisilicon: fix ststem controller compatible node
  dt-bindings: arm: hisilicon: convert system controller bindings to
    json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,cpuctrl bindings to
    json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,pctrl bindings to
    json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hip04-fabric bindings
    to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hip04-bootwrapper
    bindings to json-schema
  dt-bindings: arm: hisilicon: convert Hi6220 domain controller bindings
    to json-schema
  dt-bindings: arm: hisilicon: convert hisilicon,hi3798cv200-perictrl
    bindings to json-schema
  dt-bindings: arm: hisilicon: convert LPC controller bindings to
    json-schema

 .../bindings/arm/hisilicon/controller/cpuctrl.yaml |  29 ++
 .../hisilicon/controller/hi3798cv200-perictrl.yaml |  64 +++++
 .../hisilicon/controller/hi6220-domain-ctrl.yaml   |  64 +++++
 .../hisilicon/controller/hip04-bootwrapper.yaml    |  34 +++
 .../arm/hisilicon/controller/hip04-fabric.yaml     |  27 ++
 .../bindings/arm/hisilicon/controller/pctrl.yaml   |  34 +++
 .../bindings/arm/hisilicon/controller/sysctrl.yaml | 110 +++++++
 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 -
 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ---
 .../bindings/arm/hisilicon/hisilicon.txt           | 319 ---------------------
 .../bindings/arm/hisilicon/hisilicon.yaml          |  67 +++++
 .../bindings/arm/hisilicon/low-pin-count.yaml      |  61 ++++
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   5 +-
 arch/arm/Kconfig.debug                             |  11 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/hi3620.dtsi                      |   2 +-
 arch/arm/boot/dts/hip04.dtsi                       |   2 +-
 arch/arm/boot/dts/sd5203.dts                       |  96 +++++++
 arch/arm/mach-hisi/Kconfig                         |  16 +-
 19 files changed, 618 insertions(+), 372 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-fabric.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/pctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
 create mode 100644 arch/arm/boot/dts/sd5203.dts

-- 
1.8.3


