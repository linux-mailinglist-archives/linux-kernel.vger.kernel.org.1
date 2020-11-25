Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918EF2C36BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgKYCWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:22:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7732 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKYCWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:22:06 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cgl4y1rL0zkfYX;
        Wed, 25 Nov 2020 10:21:38 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 10:21:56 +0800
Subject: Re: [PATCH 00/11] clean up some Hisilicon-related errors detected by
 DT schema on arm64
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201012131739.1655-1-thunder.leizhen@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5FBDBFC3.60205@hisilicon.com>
Date:   Wed, 25 Nov 2020 10:21:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20201012131739.1655-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On 2020/10/12 21:17, Zhen Lei wrote:
> These patches are based on the latest linux-next. Because some txt files have
> not converted to DT schema, so a lot of errors can not be fixed now. This time,
> only some obvious errors are cleared.
> 
> Zhen Lei (11):
>   arm64: dts: hisilicon: normalize the node name of the ITS devices
>   arm64: dts: hisilicon: separate each group of data in the property
>     "reg"
>   arm64: dts: hisilicon: write the values of property-units into a
>     uint32 array
>   arm64: dts: hisilicon: remove unused property pinctrl-names
>   arm64: dts: hisilicon: place clock-names "biu" before "ciu"
>   arm64: dts: hisilicon: normalize the node name of the SMMU devices
>   arm64: dts: hisilicon: normalize the node name of the usb devices
>   arm64: dts: hisilicon: normalize the node name of the UART devices
>   arm64: dts: hisilicon: list all clocks required by spi-pl022.yaml
>   arm64: dts: hisilicon: list all clocks required by pl011.yaml
>   arm64: dts: hisilicon: list all clocks required by
>     snps-dw-apb-uart.yaml
> 
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi      |  11 +-
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi      |   5 +-
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi |  27 ++--
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |   4 +-
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi       |  20 +--
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi       |  14 +-
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 178 ++++++++++++-------------
>  7 files changed, 129 insertions(+), 130 deletions(-)
> 

Thanks!
Series applied to the hisilicon arm64 dt tree.

Best Regards,
Wei
