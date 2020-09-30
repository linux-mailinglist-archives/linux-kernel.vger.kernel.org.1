Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AE27DD91
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgI3BA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:00:27 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36543 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728943AbgI3BA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:00:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C4E2C5C01B0;
        Tue, 29 Sep 2020 21:00:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 29 Sep 2020 21:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=u
        XZBl2SuPm2uEbCG/CnRR8c/y/1bFaqSLMqAnU5sW3o=; b=gnqmQET76LNyu8TCZ
        HhoTlpwM6XR7NcIAQ9nKxXhZV+keDQ+w9pIxDlfLiBoJy++86lITvmVWpYyds1RI
        O+71C2r7vK5uoSPzrsHuoVHR3G35VcoXoJE3vlC5DA9ZRQPQCrUWrKeH/mSctdeD
        muoxDbzz62sNk5Y6rlKCdt8irfKhnH9h34aRtTIFVdqtt9qhA8SlNhnSYn+jYSqm
        /VcOTuLItwQRCwpOmj2FxGGwAP0MY4tYiN0fBDlQY1FxzLgC4OTDZKX2gc03IJvg
        +rkPheJa7CYqBepY7vYpEVGUcwF9181hHcgWu8G21Xe8Mtx0hnMmtnt8rXeES9qn
        WWoIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=uXZBl2SuPm2uEbCG/CnRR8c/y/1bFaqSLMqAnU5sW
        3o=; b=duoLuofudl5wvpgnosV4kIxHtTIVN3HqeAHAWPIbF1Sv1ZXLdrT2a+KkI
        g0MAikaF7kkB9lH1fgLz7x5fhW4Y/8D8+vt/lJbRpS5wxnxKz2D11BZamKpfo5p2
        tT4Yx3pPuwZMa3aBh3yRvj5F+dQDi2woDKob2VtdYKikGA/nD/xMb7d5p18CIXkN
        d+hKdafC/711m54Jj2+91l0qFvxk5PyYVM4rUAQLwpZ57Ir85oRcFgFs8BlUFhD8
        vEaWiXjkpGi0hwHGw7NJpQwOa8jNeUDJ34TA2972WBYkN/iDdmexWWLkB05LjJVz
        2aT9mcCucPyUF1AJiqmjp+3sNehmw==
X-ME-Sender: <xms:qNhzXzkjBnX4wrXYhrvY1P3EqFw3PLcFzL0xv0ut0n6nlHUyrtX-7g>
    <xme:qNhzX21RxIXc6dLcwzNk59bICN0CXK4wnyBmly00uYJ-kd81rRnkSmfu5cWDKNGWJ
    bKNIJ7dwn4g7GqxuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefflefhtdeukedvffeigfeludeltdfhjeehkeekhfeuvdehfeehheeh
    keehhfdtvdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhinhhfrhgruggvrggurd
    horhhgnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurd
    horhhg
X-ME-Proxy: <xmx:qNhzX5rxmuPGpxD5LOaZWwrcza9aw11H32HFaRNqX1ec4ZSJaVcpLg>
    <xmx:qNhzX7mm5KiNWEzArDOTvSJ_iVY1si0F_sWxvbr4tRvtdTRPskrFgA>
    <xmx:qNhzXx339LP5MxYsLEOUCfBW7wxztznVD6XotrpZ8S4pXtXKK3ohbQ>
    <xmx:qdhzX8TNp9YyDCKpWfc31WJlmuftssQOsQam4j2dWW4xG8DTz7pgYw>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 102F7328005D;
        Tue, 29 Sep 2020 21:00:24 -0400 (EDT)
Subject: Re: [PATCH] RFC: arm64: arch_timer: Fix timer inconsistency test for
 A64
To:     Mark Rutland <mark.rutland@arm.com>,
        Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     linux-sunxi@googlegroups.com, megous@megous.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org
References: <20200929111347.1967438-1-r.stratiienko@gmail.com>
 <20200929154012.GF53442@C02TD0UTHF1T.local>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <90f2e396-b679-fa25-c227-37489bc167e6@sholland.org>
Date:   Tue, 29 Sep 2020 20:00:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200929154012.GF53442@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 10:40 AM, Mark Rutland wrote:
> Hi,
> 
> Please Cc maintainers for drivers -- Marc and I maintain the arch timer
> driver.
> 
> On Tue, Sep 29, 2020 at 02:13:47PM +0300, Roman Stratiienko wrote:
>> Fixes linux_kselftest:timers_inconsistency-check_arm_64
>>
>> Test logs without the fix:
>> '''
>> binary returned non-zero. Exit code: 1, stderr: , stdout:
>> Consistent CLOCK_REALTIME
>> 1601335525:467086804
>> 1601335525:467087554
>> 1601335525:467088345
>> 1601335525:467089095
>> 1601335525:467089887
>> 1601335525:467090637
>> 1601335525:467091429
>> 1601335525:467092179
>> 1601335525:467092929
>> 1601335525:467093720
>> 1601335525:467094470
>> 1601335525:467095262
>> 1601335525:467096012
>> 1601335525:467096804
>> --------------------
>> 1601335525:467097554
>> 1601335525:467077012
> 
> That's 0x1BD757D2 followed by 0x1BD70794. The rollback is somewhere in
> bits 15:12 to go from 0x1BD75xxx to 0x1BD70xxx, which suggests the
> analysis in the existing comment is incomplete.

My analysis only looked at consecutive timer reads on a single core. Apparently,
from the vendor comment that they needed CLOCKSOURCE_VALIDATE_LAST_CYCLE (linked
below), there is another inconsistency with reads across cores.

>> --------------------
>> 1601335525:467099095
>> 1601335525:467099845
>> 1601335525:467100637
>> 1601335525:467101387
>> 1601335525:467102179
>> 1601335525:467102929
>> '''
> 
> It would be very helpful if the commit message could explain the rough
> idea behind the change, because the rationale is not clear to me.
> 
>> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> CC: linux-sunxi@googlegroups.com
>> CC: megous@megous.com
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 6c3e841801461..d50aa43cb654b 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -346,16 +346,17 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
>>   * number of CPU cycles in 3 consecutive 24 MHz counter periods.
>>   */
>>  #define __sun50i_a64_read_reg(reg) ({					\
>> -	u64 _val;							\
>> +	u64 _val1, _val2;						\
>>  	int _retries = 150;						\
>>  									\
>>  	do {								\
>> -		_val = read_sysreg(reg);				\
>> +		_val1 = read_sysreg(reg);				\
>> +		_val2 = read_sysreg(reg);				\
>>  		_retries--;						\
>> -	} while (((_val + 1) & GENMASK(9, 0)) <= 1 && _retries);	\
>> +	} while (((_val2 - _val1) > 0x10) && _retries);			\
> 
> This is going to fail quite often at low CPU frequencies, and it's not
> clear to me that this solves the problem any more generally. DO we know
> what the underlying erratum is here?

This is what we have from the vendor:

https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/include/asm/arch_timer.h#L155
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/clocksource/arm_arch_timer.c#L272

and they select CLOCKSOURCE_VALIDATE_LAST_CYCLE.

Everything else we know (e.g. the tables and explanation in my original commit
log) is from testing by users.

I had not seen the vendor changes to arch_timer.h when I wrote the existing
workaround. Their retry loop is similar to this patch, but as you mention, it
won't work if the CPU frequency is too low. That may not be a problem for the
vendor kernel, but it breaks badly on mainline.

As Ondrej referenced, the mainline DVFS implementation bypasses the PLL during
frequency changes. At that point, both the CPU and the timer are running at 24
MHz, so the chance of hitting the retry limit is high... and there's a udelay()
call in the PLL bypass code (ccu_mux_notifier_cb()) that will need to read the
timer.

> Thanks,
> Mark.

Cheers,
Samuel

>>  									\
>>  	WARN_ON_ONCE(!_retries);					\
>> -	_val;								\
>> +	_val2;								\
>>  })
>>  
>>  static u64 notrace sun50i_a64_read_cntpct_el0(void)
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

