Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C244C2F9E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbhARLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389864AbhARLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:31:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21350C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:30:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l1SkK-0001G2-ID; Mon, 18 Jan 2021 12:30:56 +0100
Subject: Re: [PATCH] clk: imx6q: demote warning about pre-boot ldb_di_clk
 reparenting
To:     Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201113145310.8274-1-a.fatoum@pengutronix.de>
 <160627062508.2717324.2756565276373452151@swboyd.mtv.corp.google.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <cb519f7c-772f-0da3-da72-6af9a0f2ddfb@pengutronix.de>
Date:   Mon, 18 Jan 2021 12:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <160627062508.2717324.2756565276373452151@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 25.11.20 03:17, Stephen Boyd wrote:
> Quoting Ahmad Fatoum (2020-11-13 06:53:09)
>> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
>> index ba33c79158de..b2e4b6234ac0 100644
>> --- a/drivers/clk/imx/clk-imx6q.c
>> +++ b/drivers/clk/imx/clk-imx6q.c
>> @@ -337,10 +337,10 @@ static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
>>         of_assigned_ldb_sels(np, &sel[0][3], &sel[1][3]);
>>  
>>         for (i = 0; i < 2; i++) {
>> -               /* Warn if a glitch might have been introduced already */
>> +               /* Print a notice if a glitch might have been introduced already */
>>                 if (sel[i][0] != 3) {
>> -                       pr_warn("ccm: ldb_di%d_sel already changed from reset value: %d\n",
>> -                               i, sel[i][0]);
>> +                       pr_notice("ccm: ldb_di%d_sel already changed from reset value: %d\n",
> 
> Maybe the print should also say "Possible glitch"?

Somehow missed this reply completely.
Yes, adding "possible glitch" improves the usefulness of the message,
I just sent out a v2.

Thanks,
Ahmad
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
