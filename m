Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392002AC8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgKIWjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:39:31 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:51629 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgKIWja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:39:30 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 06F6422F00;
        Mon,  9 Nov 2020 23:39:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604961568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ro/+OvHVqgcq7Jo+DY0/nC8c3FbHtMpGGgAuCTulVw=;
        b=tIjpYMORMU457dseye+jrlU3UzOaNCTZXYdLH7pSt3l0TYJcdeNpLAu9oL4N2pqxeqz9d2
        n0G5IHC5MfEWKy6QGnNU02w/PbDjwhYMwuB3DNLDhJsL763ccH91EuVtamFLyO0AO2S/CY
        JGBQGE5kY8Wc4J4sN5/7B3CZOynZm4U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Nov 2020 23:39:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 3/9] clk: qoriq: provide constants for the type
In-Reply-To: <20201109220543.GA1835644@bogus>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-4-michael@walle.cc> <20201109220543.GA1835644@bogus>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <78aa06920a318cfb68e962afe13e8432@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-09 23:05, schrieb Rob Herring:
> On Sun, Nov 08, 2020 at 07:51:07PM +0100, Michael Walle wrote:
>> To avoid future mistakes in the device tree for the clockgen module, 
>> add
>> constants for the clockgen subtype as well as a macro for the PLL
>> divider.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Changes since v2:
>>  - new patch
>> 
>>  drivers/clk/clk-qoriq.c                        | 13 +++++++------
>>  include/dt-bindings/clock/fsl,qoriq-clockgen.h | 15 +++++++++++++++
>>  2 files changed, 22 insertions(+), 6 deletions(-)
>>  create mode 100644 include/dt-bindings/clock/fsl,qoriq-clockgen.h
>> 
>> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
>> index 46101c6a20f2..70aa521e7e7f 100644
>> --- a/drivers/clk/clk-qoriq.c
>> +++ b/drivers/clk/clk-qoriq.c
>> @@ -7,6 +7,7 @@
>> 
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> 
>> +#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
>>  #include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/clkdev.h>
>> @@ -1368,33 +1369,33 @@ static struct clk *clockgen_clk_get(struct 
>> of_phandle_args *clkspec, void *data)
>>  	idx = clkspec->args[1];
>> 
>>  	switch (type) {
>> -	case 0:
>> +	case QORIQ_CLK_SYSCLK:
>>  		if (idx != 0)
>>  			goto bad_args;
>>  		clk = cg->sysclk;
>>  		break;
>> -	case 1:
>> +	case QORIQ_CLK_CMUX:
>>  		if (idx >= ARRAY_SIZE(cg->cmux))
>>  			goto bad_args;
>>  		clk = cg->cmux[idx];
>>  		break;
>> -	case 2:
>> +	case QORIQ_CLK_HWACCEL:
>>  		if (idx >= ARRAY_SIZE(cg->hwaccel))
>>  			goto bad_args;
>>  		clk = cg->hwaccel[idx];
>>  		break;
>> -	case 3:
>> +	case QORIQ_CLK_FMAN:
>>  		if (idx >= ARRAY_SIZE(cg->fman))
>>  			goto bad_args;
>>  		clk = cg->fman[idx];
>>  		break;
>> -	case 4:
>> +	case QORIQ_CLK_PLATFORM_PLL:
>>  		pll = &cg->pll[PLATFORM_PLL];
>>  		if (idx >= ARRAY_SIZE(pll->div))
>>  			goto bad_args;
>>  		clk = pll->div[idx].clk;
>>  		break;
>> -	case 5:
>> +	case QORIQ_CLK_CORECLK:
>>  		if (idx != 0)
>>  			goto bad_args;
>>  		clk = cg->coreclk;
>> diff --git a/include/dt-bindings/clock/fsl,qoriq-clockgen.h 
>> b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
>> new file mode 100644
>> index 000000000000..ddec7d0bdc7f
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
>> +#define DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
>> +
>> +#define QORIQ_CLK_SYSCLK	0
>> +#define QORIQ_CLK_CMUX		1
>> +#define QORIQ_CLK_HWACCEL	2
>> +#define QORIQ_CLK_FMAN		3
>> +#define QORIQ_CLK_PLATFORM_PLL	4
>> +#define QORIQ_CLK_CORECLK	5
>> +
>> +#define QORIQ_CLK_PLL_DIV(x)	((x) - 1)
> 
> This is not used and doesn't seem like part of the ABI (shared with dts
> files).

TBH I haven't found a nice way to integrate this macro into the clock 
driver. It is used in the device tree for the type PLATFORM_PLL.
Previously, you had "<&clockgen 4 1>", where 4 is the PLATFORM_PLL and 1 
is actually "div-by-2". Thus I replaced it by <&clockgen 
QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>. (I just realized that 
QORIQ_CLK_PLL_DIV_BY(2) might be a better name.)

I already figured, that this might be a problem, if that macro isn't 
used in the driver.

-michael
