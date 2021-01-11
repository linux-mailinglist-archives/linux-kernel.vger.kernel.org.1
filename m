Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF77B2F0D90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbhAKIB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:01:26 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:58257 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbhAKIB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:01:26 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 26C4F22ED8;
        Mon, 11 Jan 2021 09:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610352041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KShO+OFfKKxbrDChHYBQdJKbcsRMQPuSF+8nsNYYzeQ=;
        b=CjekFt5AWYyoS6JfaFe3H9DIb00mR42DgedR4rNSwnJ4QtiUGOQ4TKA/Rqe5UljApaGq4K
        vm8aYjV5u2cof8HBK0WZDD6qDaKC6lQ9sK9y5lGM8bw55681FiRtB39IM4uE17zoc/Wtd2
        2FeDzjEnyaJuXUmlCGvymugbXMjAWZQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 09:00:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: sl28: add variant 1
In-Reply-To: <20210111013442.GU28365@dragon>
References: <20201229120321.17103-1-michael@walle.cc>
 <20201229120321.17103-2-michael@walle.cc> <20210111013442.GU28365@dragon>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <838c9860e19dcfb18d35cffde773ad93@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-11 02:34, schrieb Shawn Guo:
> On Tue, Dec 29, 2020 at 01:03:21PM +0100, Michael Walle wrote:
>> There is a new variant 1 of this board available. It features up to 
>> four
>> SerDes lanes for customer use. Add a new device tree which features 
>> just
>> the basic peripherals. A customer will then have to modify or append 
>> to
>> this device tree.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>>  .../fsl-ls1028a-kontron-sl28-var1.dts         | 61 
>> +++++++++++++++++++
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile 
>> b/arch/arm64/boot/dts/freescale/Makefile
>> index 6f0777ee6cd6..79cb0025fcc6 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
>>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
>>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += 
>> fsl-ls1028a-kontron-kbox-a-230-ls.dtb
>>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28.dtb
>> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var1.dtb
>>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var2.dtb
>>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += 
>> fsl-ls1028a-kontron-sl28-var3-ads2.dtb
>>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
>> diff --git 
>> a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts 
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
>> new file mode 100644
>> index 000000000000..52f2f3ffdce1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Device Tree file for the Kontron SMARC-sAL28 board.
>> + *
>> + * This is for the network variant 1 which has one ethernet port. It 
>> is
>> + * different than the base variant, which also has one port, but here 
>> the
>> + * port is connected via RGMII. This port is not TSN aware.
>> + * None of the  four SerDes lanes are used by the module, instead 
>> they are
>> + * all led out to the carrier for customer use.
>> + *
>> + * Copyright (C) 2020 Michael Walle <michael@walle.cc>
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +#include "fsl-ls1028a-kontron-sl28.dts"
>> +#include <dt-bindings/net/qca-ar803x.h>
>> +
>> +/ {
>> +	model = "Kontron SMARC-sAL28 (4 Lanes)";
>> +	compatible = "kontron,sl28-var1", "kontron,sl28", "fsl,ls1028a";
>> +};
>> +
>> +&enetc_port0 {
>> +	status = "disabled";
>> +	/delete-property/ phy-handle;
>> +	/delete-node/ mdio;
> 
> As it's disabled anyway, why do we bother to delete the property and
> child node?

Because beneath that node is also the old phy0 label. So you'd be 
getting
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts:38.24-55.5: 
ERROR (duplicate_label): 
/soc/pcie@1f0000000/ethernet@0,1/mdio/ethernet-phy@4: Duplicate label 
'phy0' on /soc/pcie@1f0000000/ethernet@0,1/mdio/ethernet-phy@4 and 
/soc/pcie@1f0000000/ethernet@0,0/mdio/ethernet-phy@5

>> +};
>> +
>> +
> 
> One newline is enough.
> 
>> +&enetc_port1 {
>> +	phy-handle = <&phy0>;
>> +	phy-connection-type = "rgmii-id";
>> +	status = "okay";
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		phy0: ethernet-phy@4 {
>> +			reg = <0x4>;
>> +			eee-broken-1000t;
>> +			eee-broken-100tx;
>> +
> 
> Unnecessary newline.
> 
>> +			qca,clk-out-frequency = <125000000>;
>> +			qca,clk-out-strength = <AR803X_STRENGTH_FULL>;
>> +
> 
> Ditto
> 
> Shawn
> 
>> +			vddio-supply = <&vddh>;
>> +
>> +			vddio: vddio-regulator {
>> +				regulator-name = "VDDIO";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +			};
>> +
>> +			vddh: vddh-regulator {
>> +				regulator-name = "VDDH";
>> +			};
>> +		};
>> +	};
>> +};
>> --
>> 2.20.1
>> 

-- 
-michael
