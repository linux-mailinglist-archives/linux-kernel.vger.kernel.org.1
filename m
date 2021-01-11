Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50682F0DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbhAKIZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:25:31 -0500
Received: from comms.puri.sm ([159.203.221.185]:60716 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbhAKIZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:25:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C7126DF90D;
        Mon, 11 Jan 2021 00:24:50 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UJ3WHmDS4bbL; Mon, 11 Jan 2021 00:24:49 -0800 (PST)
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mq-librem5: add pinctrl for the
 touchscreen description
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201222151347.7886-1-martin.kepplinger@puri.sm>
 <20201222151347.7886-3-martin.kepplinger@puri.sm>
 <20210111002942.GR28365@dragon>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Message-ID: <f699bf19-c5df-c2da-af23-ef144cec4750@puri.sm>
Date:   Mon, 11 Jan 2021 09:24:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210111002942.GR28365@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.21 01:29, Shawn Guo wrote:
> On Tue, Dec 22, 2020 at 04:13:45PM +0100, Martin Kepplinger wrote:
>> In order for the touchscreen interrupt line to work, describe it properly.
>> Otherwise it can work if defaults are ok, but we cannot be sure.
>>
>> Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
>> index 55268fc0622e..a60df09d90f7 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
>> @@ -459,6 +459,13 @@
>>   		>;
>>   	};
>>   
>> +	pinctrl_touch: touchgrp {
>> +		fsl,pins = <
>> +		/* TP_INT */
>> +		MX8MQ_IOMUXC_ENET_RD1_GPIO1_IO27	0x80
> 
> Miss indentation for these two lines.
> 
> I fixed it up and applied the series.
> 
> Shawn
> 

thanks for this!

                             martin
