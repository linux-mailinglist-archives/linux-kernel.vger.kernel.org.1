Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB2270B35
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgISGqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 02:46:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbgISGqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:46:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 91941BA70DD06B526FF5;
        Sat, 19 Sep 2020 14:46:29 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 14:46:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/4] add support for Hisilicon SD5203 SoC
Date:   Sat, 19 Sep 2020 14:45:51 +0800
Message-ID: <20200919064555.3616-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Zhen Lei (1):
  dt-bindings: arm: hisilicon: add binding for SD5203 SoC

 .../bindings/arm/hisilicon/hisilicon.txt           |  5 ++
 arch/arm/Kconfig.debug                             | 11 ++-
 arch/arm/boot/dts/Makefile                         |  2 +
 arch/arm/boot/dts/sd5203.dts                       | 96 ++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig                         | 16 +++-
 5 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/sd5203.dts

-- 
1.8.3


