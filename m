Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C582E98CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbhADPbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:31:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2286 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbhADPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:31:39 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D8fbq5Sp2z67XBn;
        Mon,  4 Jan 2021 23:26:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 4 Jan 2021 16:30:55 +0100
Received: from localhost (10.47.65.160) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 4 Jan 2021
 15:30:55 +0000
Date:   Mon, 4 Jan 2021 15:30:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linus.walleij@linaro.org>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <BMC-SW@aspeedtech.com>,
        <cyrilbur@gmail.com>, <haiyue.wang@linux.intel.com>,
        <rlippert@google.com>
Subject: Re: [PATCH v3 0/5] Remove LPC register partitioning
Message-ID: <20210104153020.000015d1@Huawei.com>
In-Reply-To: <20201221055623.31463-1-chiawei_wang@aspeedtech.com>
References: <20201221055623.31463-1-chiawei_wang@aspeedtech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.160]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 13:56:18 +0800
"Chia-Wei, Wang" <chiawei_wang@aspeedtech.com> wrote:

> The LPC controller has no concept of the BMC and the Host partitions.
> The incorrect partitioning can impose unnecessary range restrictions
> on register access through the syscon regmap interface.
> 
> For instance, HICRB contains the I/O port address configuration
> of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
> HICRB as it is located at the other LPC partition.
> 
> In addition, to be backward compatible, the newly added HW control
> bits could be located at any reserved bits over the LPC addressing
> space.
> 
> Thereby, this patch series aims to remove the LPC partitioning for
> better driver development and maintenance. This requires the change
> to both the device tree and the driver implementation. To ensure
> both sides are synchronously updated, a v2 binding check is added.
> 
> Changes since v2:
> 	- Add v2 binding check to ensure the synchronization between the
> 	  device tree change and the driver register offset fix.
> 
> Changes since v1:
> 	- Add the fix to the aspeed-lpc binding documentation.
> 
> Chia-Wei, Wang (5):
>   dt-bindings: aspeed-lpc: Remove LPC partitioning
>   ARM: dts: Remove LPC BMC and Host partitions
>   ipmi: kcs: aspeed: Adapt to new LPC DTS layout
>   pinctrl: aspeed-g5: Adapt to new LPC device tree layout
>   soc: aspeed: Adapt to new LPC device tree layout
> 
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    |  99 +++----------
>  arch/arm/boot/dts/aspeed-g4.dtsi              |  74 ++++------
>  arch/arm/boot/dts/aspeed-g5.dtsi              | 135 ++++++++----------
>  arch/arm/boot/dts/aspeed-g6.dtsi              | 135 ++++++++----------
>  drivers/char/ipmi/kcs_bmc_aspeed.c            |  35 +++--
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    |  19 ++-
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c          |  20 ++-
>  drivers/soc/aspeed/aspeed-lpc-snoop.c         |  23 +--
>  8 files changed, 232 insertions(+), 308 deletions(-)
> 
Hi,

New year, new campaign to make people's lives slightly easier :)

I would appreciate it if everyone made sure their cover letters have an
appropriate "scope" defined.   This is going to broad mailing
lists so it would be good to give it a title of something like
"aspeed: Remove LPC register partitioning"
possibly even
"arm: aspeed: Remove LPC register partitioning"

both to make it stand out to people who do want to read it and to
allow others to rapidly conclude they can skip the thread.

Thanks,

Jonathan
