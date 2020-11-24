Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2B2C2519
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbgKXL7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:59:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8025 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXL7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:59:30 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CgMxX105Czhfxt;
        Tue, 24 Nov 2020 19:58:56 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 19:59:05 +0800
Subject: Re: [PATCH v2 00/10] clean up all Hisilicon-related errors detected
 by DT schema on arm32
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5FBCF58A.5060608@hisilicon.com>
Date:   Tue, 24 Nov 2020 19:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20201012061225.1597-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On 2020/10/12 14:12, Zhen Lei wrote:
> v1 --> v2:
> Too deep in arm32. I forgot arm64. Add property "#reset-cells" into sysctrl.yaml (Patch 9).
> 
> 
> v1:
> These patches are based on the latest linux-next.
> 
> Zhen Lei (10):
>   ARM: dts: hisilicon: fix errors detected by snps-dw-apb-uart.yaml
>   ARM: dts: hisilicon: fix errors detected by pl011.yaml
>   ARM: dts: hisilicon: fix errors detected by usb yaml
>   ARM: dts: hisilicon: fix errors detected by simple-bus.yaml
>   ARM: dts: hisilicon: fix errors detected by root-node.yaml
>   ARM: dts: hisilicon: fix errors detected by synopsys-dw-mshc.yaml
>   ARM: dts: hisilicon: fix errors detected by spi-pl022.yaml
>   ARM: dts: hisilicon: fix errors detected by syscon.yaml

Thanks!
Fixed some typos in the commit and applied all the dts changes
to the hisilicon arm32 dt tree.

Best Regards,
Wei

>   dt-bindings: arm: hisilicon: add missing properties into sysctrl.yaml
>   dt-bindings: arm: hisilicon: add missing properties into cpuctrl.yaml
> 
>  .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 27 +++++++++++++-
>  .../bindings/arm/hisilicon/controller/sysctrl.yaml | 28 +++++++++++++--
>  arch/arm/boot/dts/hi3519-demb.dts                  |  2 +-
>  arch/arm/boot/dts/hi3519.dtsi                      | 32 ++++++++---------
>  arch/arm/boot/dts/hi3620-hi4511.dts                | 24 ++++++-------
>  arch/arm/boot/dts/hi3620.dtsi                      | 32 ++++++++---------
>  arch/arm/boot/dts/hip01-ca9x2.dts                  |  2 +-
>  arch/arm/boot/dts/hip01.dtsi                       | 26 +++++++-------
>  arch/arm/boot/dts/hip04-d01.dts                    |  2 +-
>  arch/arm/boot/dts/hip04.dtsi                       |  6 ++--
>  arch/arm/boot/dts/hisi-x5hd2-dkb.dts               |  2 +-
>  arch/arm/boot/dts/hisi-x5hd2.dtsi                  | 42 +++++++++++-----------
>  12 files changed, 136 insertions(+), 89 deletions(-)
> 
