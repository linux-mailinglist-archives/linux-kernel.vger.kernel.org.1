Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127252CB759
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgLBIhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:37:41 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:49734 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgLBIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:37:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id ABFF72015B9C;
        Wed,  2 Dec 2020 16:36:54 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fnejSr34lf9O; Wed,  2 Dec 2020 16:36:54 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 881B42015B84;
        Wed,  2 Dec 2020 16:36:54 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.227])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 6EC46C019F3;
        Wed,  2 Dec 2020 16:36:53 +0800 (HKT)
Subject: Re: [PATCH] phy: rockchip-emmc: emmc_phy_init() always return 0
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20201201031015.23314-1-chris.ruehl@gtsys.com.hk>
 <CAD=FV=Wyk9BYR3cnfm=9tBh=XBxEP=udMTeaEYPzAqa5m8x=yg@mail.gmail.com>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <f8a21465-91d0-9967-e559-d8f91f795028@gtsys.com.hk>
Date:   Wed, 2 Dec 2020 16:36:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Wyk9BYR3cnfm=9tBh=XBxEP=udMTeaEYPzAqa5m8x=yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/12/2020 12:05 am, Doug Anderson wrote:
> Hi,
> 
> On Mon, Nov 30, 2020 at 7:10 PM Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>>
>> rockchip_emmc_phy_init() return variable is not set with the error value
>> if clk_get() failed. The debug message print 0 on error and the function
>> always return 0.
>> Fix it using PTR_ERR().
>>
>> Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   drivers/phy/rockchip/phy-rockchip-emmc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> index 48e2d75b1004..75faee5c0d27 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> @@ -253,6 +253,7 @@ static int rockchip_emmc_phy_init(struct phy *phy)
>>           */
>>          rk_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
>>          if (IS_ERR(rk_phy->emmcclk)) {
>> +               ret = PTR_ERR(rk_phy->emmcclk);
> 
> I'm pretty sure your patch isn't correct and it would break use cases.
> Is it fixing some bug that you're aware of, or you found it via code
> inspection?
> 
> Specifically:
> 
> * The big comment block in this function says that the clock is
> optional and that we're ignoring errors.
> 
> * The printout in this function is "dbg" level, which is an extra
> indication that we aren't concerned with these errors.
> 
> Arguably the code could be made better.  If you want to improve it,
> you could check for just the error we expect if the clock isn't
> specified (probably -ENODEV, but you should check) and treat all other
> failures as real errors.
> 
> 
> -Doug
>

Hi Doug,
  I reviewed the code while hunting behind an other bug, with hs400
and yes I saw the comment that they don't care about the problem
if the clk_get() return an error, and set the rk_phy->emmcclk = NULL
regardless, not using the ret variable but define it isn't useful.

If return a error code break something on the other hand, better it
hit it rather then suppress it in IMHO.

Let me follow the caller of the function and see how they treat the
err != 0.

If something is in danger, I will be effected with my rk3399 rollout :)

Chris

