Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094FB28A060
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgJJMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 08:24:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbgJJKQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:16:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C053B28522AC5525DB75;
        Sat, 10 Oct 2020 17:57:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 17:57:34 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 00/10] clean up all Hisilicon-related errors detected by DT schema on arm32
Date:   Sat, 10 Oct 2020 17:56:59 +0800
Message-ID: <20201010095709.1340-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 .../bindings/arm/hisilicon/controller/sysctrl.yaml | 25 +++++++++++--
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
 12 files changed, 133 insertions(+), 89 deletions(-)

-- 
1.8.3


