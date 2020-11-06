Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634022A9765
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgKFOEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:04:14 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22DC0613CF;
        Fri,  6 Nov 2020 06:04:11 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0F42522FAD;
        Fri,  6 Nov 2020 15:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604671449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dno5sBvYxAuw3MDGvBMCHVYmJvxMS+kWsqU80FUOXA=;
        b=l4TapnhA4st1PTrh4jy7UoaFIncBkag6/FkvvKrRWxEXQzTTDpR+ElYUCpDrBqNw1YV4uI
        qgLzk7ljoSLv3kdZ03gC1FZI6Q2kw/oxduYscwI66XSe/LSQTZr1ssWr3wXO64q+5I3KO6
        tXQvEBfDIPaFJwuvFysWojOV+p84SqU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Nov 2020 15:04:08 +0100
From:   Michael Walle <michael@walle.cc>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: lx2160a: fix FlexSPI clock
In-Reply-To: <639fa8e62e0b98bedf4077f76fd75e83@walle.cc>
References: <20201105193512.22388-1-michael@walle.cc>
 <20201105193512.22388-6-michael@walle.cc>
 <VE1PR04MB6687EC27F8C230A8F334119E8FED0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <639fa8e62e0b98bedf4077f76fd75e83@walle.cc>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <8c96e34b3139c99f0946b62767b8cfdd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-06 09:11, schrieb Michael Walle:
> Am 2020-11-06 03:00, schrieb Leo Li:
>>> -----Original Message-----
>>> From: Michael Walle <michael@walle.cc>
>>> Sent: Thursday, November 5, 2020 1:35 PM
>>> To: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
>>> <sboyd@kernel.org>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
>>> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Michael Walle
>>> <michael@walle.cc>
>>> Subject: [PATCH v2 5/5] arm64: dts: lx2160a: fix FlexSPI clock
>>> 
>>> Now that we have a proper driver for the FlexSPI interface use it. 
>>> This will fix
>>> SCK frequency switching on Layerscape SoCs.
>>> 
>>> This was only compile time tested.
>>> 
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>> Changes since v1:
>>>  - none
>>> 
>>>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 15 +++++++++++++--
>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>>> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>>> index 83072da6f6c6..6e375e80bd35 100644
>>> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>>> @@ -659,9 +659,20 @@
>>>  		};
>>> 
>>>  		dcfg: syscon@1e00000 {
>>> -			compatible = "fsl,lx2160a-dcfg", "syscon";
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			compatible = "fsl,lx2160a-dcfg", "syscon", "simple-
>>> mfd";
>>>  			reg = <0x0 0x1e00000 0x0 0x10000>;
>>> +			ranges = <0x0 0x0 0x1e00000 0x10000>;
>>>  			little-endian;
>>> +
>>> +			fspi_clk: clock-controller@900 {
>>> +				compatible = "fsl,lx2160a-flexspi-clk";
>>> +				reg = <0x900 0x4>;
>>> +				#clock-cells = <0>;
>>> +				clocks = <&clockgen 4 0>;
>> 
>> This is different from the current <&clockgen 4 3>, is it an intended 
>> change?
> 
> Yes, this change was intended. At least on the LS1028A this clock 
> divider is
> connected to the platform base clock. I don't know why there was
> "<&clockgen 4 3>" in the first place. But because the clkgen clock 
> cannot
> be changed it didn't matter before this commit. The flexspi driver only
> calls clk_set_rate(), never clk_get_rate(). On the LS1028A I actually
> meassured the resulting SCK frequency.
> Looking at Figure 7. (Clock subsystem block diagram) in the LX2160A RM, 
> this
> seems to be the case here, too.

Btw on the LS1028A this should be "<&clockgen 2 0>;" Will be fixed in 
the
new version.
And because there so much difference between LS1028A and LX2160A, I'll 
mark
the last patch (this one, for the LX2160A) as RFC until someone will 
test it.

-michael
