Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ABD28D78D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgJNAfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:35:55 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:60620 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgJNAfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:35:55 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id E513A1819;
        Wed, 14 Oct 2020 08:35:52 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18907T140200013461248S1602635751373857_;
        Wed, 14 Oct 2020 08:35:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <54d03ae8eef3293f97bdf5fd605b3e77>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v10 0/8] Add Rockchip NFC drivers for RK3308 and others
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <5288a031-5dbe-e32d-f706-a70a8109110d@rock-chips.com>
Date:   Wed, 14 Oct 2020 08:35:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel and maintainers,

     This patch set seems ready for upstream, could you pick and merge 
to linux-mtd?


Thanks,

- Kever

On 2020/9/30 上午10:07, Yifeng Zhao wrote:
> Rockchp's NFC(Nand Flash Controller) has four versions: V600, V622, V800 and
> V900.This series patch can support all four versions.
>
>
> Changes in v10:
> - Fix compile error on master v5.9-rc7
>
> Changes in v9:
> - The nfc->buffer will realloc while the page size of the second mtd
>    is large than the first one
> - Fix coding style.
> - Remove struct rk_nfc_clk.
> - Prepend some function with rk_nfc_.
> - Replace function readl_poll_timeout_atomic with readl_relaxed_poll_timeout.
> - Remove function rk_nfc_read_byte and rk_nfc_write_byte.
> - Don't select the die if 'check_only == true' in function rk_nfc_exec_op.
> - Modify function rk_nfc_write_page and rk_nfc_write_page_raw.
>
> Changes in v8:
> - Fix make dt_binding_check error
>
> Changes in v7:
> - Fix some wrong define
> - Rebase to linux-next.
> - Fix coding style.
> - Reserved 4 bytes at the beginning of the oob area.
> - Page raw read and write included ecc data.
>
> Changes in v6:
> - Fix some wrong define
> - Modified the definition of compatible
> - The mtd->name set by NAND label property.
> - Add some comments.
> - Fix compile error.
>
> Changes in v5:
> - Fix some wrong define.
> - Add boot-medium define.
> - Remove some compatible define.
> - Add boot blocks support  with different ECC for bootROM.
> - Rename rockchip-nand.c to rockchip-nand-controller.c.
> - Unification of other variable names.
> - Remove some compatible define.
>
> Changes in v4:
> - The compatible define with rkxx_nfc.
> - Add assigned-clocks.
> - Fix some wrong defineChanges in.
> - Define platform data structure for the register offsets.
> - The compatible define with rkxx_nfc.
> - Use SET_SYSTEM_SLEEP_PM_OPS to define PM_OPS.
> - Use exec_op instead of legacy hooks.
>
> Changes in v3:
> - Change the title for the dt-bindings.
>
> Changes in v2:
> - Fix compile error.
> - Include header files sorted by file name.
>
> Yifeng Zhao (8):
>    dt-bindings: mtd: Describe Rockchip RK3xxx NAND flash controller
>    mtd: rawnand: rockchip: NFC drivers for RK3308, RK2928 and others
>    MAINTAINERS: add maintainers to ROCKCHIP NFC
>    arm64: dts: rockchip: Add NFC node for RK3308 SoC
>    arm64: dts: rockchip: Add NFC node for PX30 SoC
>    arm: dts: rockchip: Add NFC node for RV1108 SoC
>    arm: dts: rockchip: Add NFC node for RK2928 and other SoCs
>    arm: dts: rockchip: Add NFC node for RK3036 SoC
>
>   .../mtd/rockchip,nand-controller.yaml         |  162 ++
>   MAINTAINERS                                   |    4 +-
>   arch/arm/boot/dts/rk3036.dtsi                 |   52 +
>   arch/arm/boot/dts/rk3xxx.dtsi                 |    9 +
>   arch/arm/boot/dts/rv1108.dtsi                 |   11 +
>   arch/arm64/boot/dts/rockchip/px30.dtsi        |   15 +
>   arch/arm64/boot/dts/rockchip/rk3308.dtsi      |   15 +
>   drivers/mtd/nand/raw/Kconfig                  |   12 +
>   drivers/mtd/nand/raw/Makefile                 |    1 +
>   .../mtd/nand/raw/rockchip-nand-controller.c   | 1455 +++++++++++++++++
>   10 files changed, 1734 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
>   create mode 100644 drivers/mtd/nand/raw/rockchip-nand-controller.c
>


