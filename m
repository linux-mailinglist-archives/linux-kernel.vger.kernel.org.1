Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9FF29819A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415656AbgJYMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 08:19:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54072 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415647AbgJYMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 08:19:21 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CJxpt32Pjz1qs1B;
        Sun, 25 Oct 2020 13:19:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CJxpt1TVbz1r0m3;
        Sun, 25 Oct 2020 13:19:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id A2gxUHxS7zm1; Sun, 25 Oct 2020 13:19:15 +0100 (CET)
X-Auth-Info: Oy5A8u/kFGTBqcA/O1cCc3OeJHETH+IazF66OtuW++w=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 25 Oct 2020 13:19:15 +0100 (CET)
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
To:     Abel Vesa <abel.vesa@nxp.com>, Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20201024162016.1003041-1-aford173@gmail.com>
 <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
 <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
 <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
From:   Marek Vasut <marex@denx.de>
Message-ID: <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
Date:   Sun, 25 Oct 2020 13:18:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/20 1:05 PM, Abel Vesa wrote:

[...]

>> Together, both the GPC and the clk-blk driver should be able to pull
>> the multimedia block out of reset.  Currently, the GPC can handle the
>> USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated by
>> the clock block
>>
>> My original patch RFC didn't include the imx8mn node, because it
>> hangs, but the node I added looks like:
>>
>> media_blk_ctl: clock-controller@32e28000 {
>>      compatible = "fsl,imx8mn-media-blk-ctl", "syscon";
>>      reg = <0x32e28000 0x1000>;
>>      #clock-cells = <1>;
>>      #reset-cells = <1>;
>> };
>>
>> I was hoping you might have some feedback on the 8mn clk-blk driver
>> since you did the 8mp clk-blk drive and they appear to be very
>> similar.
>>
> 
> I'll do you one better still. I'll apply the patch in my tree and give it
> a test tomorrow morning.

You can also apply the one for 8MM:
https://lore.kernel.org/linux-arm-kernel/20201003224555.163780-5-marex@denx.de/
