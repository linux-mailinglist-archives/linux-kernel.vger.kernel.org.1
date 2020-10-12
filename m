Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1367E28B5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbgJLNTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:19:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388013AbgJLNTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87AC94D63537C318D420;
        Mon, 12 Oct 2020 21:19:30 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:19:23 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 00/11] clean up some Hisilicon-related errors detected by DT schema on arm64
Date:   Mon, 12 Oct 2020 21:17:28 +0800
Message-ID: <20201012131739.1655-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are based on the latest linux-next. Because some txt files have
not converted to DT schema, so a lot of errors can not be fixed now. This time,
only some obvious errors are cleared.

Zhen Lei (11):
  arm64: dts: hisilicon: normalize the node name of the ITS devices
  arm64: dts: hisilicon: separate each group of data in the property
    "reg"
  arm64: dts: hisilicon: write the values of property-units into a
    uint32 array
  arm64: dts: hisilicon: remove unused property pinctrl-names
  arm64: dts: hisilicon: place clock-names "biu" before "ciu"
  arm64: dts: hisilicon: normalize the node name of the SMMU devices
  arm64: dts: hisilicon: normalize the node name of the usb devices
  arm64: dts: hisilicon: normalize the node name of the UART devices
  arm64: dts: hisilicon: list all clocks required by spi-pl022.yaml
  arm64: dts: hisilicon: list all clocks required by pl011.yaml
  arm64: dts: hisilicon: list all clocks required by
    snps-dw-apb-uart.yaml

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi      |  11 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi      |   5 +-
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi |  27 ++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |   4 +-
 arch/arm64/boot/dts/hisilicon/hip05.dtsi       |  20 +--
 arch/arm64/boot/dts/hisilicon/hip06.dtsi       |  14 +-
 arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 178 ++++++++++++-------------
 7 files changed, 129 insertions(+), 130 deletions(-)

-- 
1.8.3


