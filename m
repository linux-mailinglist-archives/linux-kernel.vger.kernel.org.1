Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295D127D2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgI2PkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:40:18 -0400
Received: from foss.arm.com ([217.140.110.172]:47394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgI2PkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:40:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A941063;
        Tue, 29 Sep 2020 08:40:17 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A44C43F70D;
        Tue, 29 Sep 2020 08:40:15 -0700 (PDT)
Date:   Tue, 29 Sep 2020 16:40:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     linux-sunxi@googlegroups.com, megous@megous.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org
Subject: Re: [PATCH] RFC: arm64: arch_timer: Fix timer inconsistency test for
 A64
Message-ID: <20200929154012.GF53442@C02TD0UTHF1T.local>
References: <20200929111347.1967438-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929111347.1967438-1-r.stratiienko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please Cc maintainers for drivers -- Marc and I maintain the arch timer
driver.

On Tue, Sep 29, 2020 at 02:13:47PM +0300, Roman Stratiienko wrote:
> Fixes linux_kselftest:timers_inconsistency-check_arm_64
> 
> Test logs without the fix:
> '''
> binary returned non-zero. Exit code: 1, stderr: , stdout:
> Consistent CLOCK_REALTIME
> 1601335525:467086804
> 1601335525:467087554
> 1601335525:467088345
> 1601335525:467089095
> 1601335525:467089887
> 1601335525:467090637
> 1601335525:467091429
> 1601335525:467092179
> 1601335525:467092929
> 1601335525:467093720
> 1601335525:467094470
> 1601335525:467095262
> 1601335525:467096012
> 1601335525:467096804
> --------------------
> 1601335525:467097554
> 1601335525:467077012

That's 0x1BD757D2 followed by 0x1BD70794. The rollback is somewhere in
bits 15:12 to go from 0x1BD75xxx to 0x1BD70xxx, which suggests the
analysis in the existing comment is incomplete.

> --------------------
> 1601335525:467099095
> 1601335525:467099845
> 1601335525:467100637
> 1601335525:467101387
> 1601335525:467102179
> 1601335525:467102929
> '''

It would be very helpful if the commit message could explain the rough
idea behind the change, because the rationale is not clear to me.

> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-sunxi@googlegroups.com
> CC: megous@megous.com
> ---
>  drivers/clocksource/arm_arch_timer.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 6c3e841801461..d50aa43cb654b 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -346,16 +346,17 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
>   * number of CPU cycles in 3 consecutive 24 MHz counter periods.
>   */
>  #define __sun50i_a64_read_reg(reg) ({					\
> -	u64 _val;							\
> +	u64 _val1, _val2;						\
>  	int _retries = 150;						\
>  									\
>  	do {								\
> -		_val = read_sysreg(reg);				\
> +		_val1 = read_sysreg(reg);				\
> +		_val2 = read_sysreg(reg);				\
>  		_retries--;						\
> -	} while (((_val + 1) & GENMASK(9, 0)) <= 1 && _retries);	\
> +	} while (((_val2 - _val1) > 0x10) && _retries);			\

This is going to fail quite often at low CPU frequencies, and it's not
clear to me that this solves the problem any more generally. DO we know
what the underlying erratum is here?

Thanks,
Mark.

>  									\
>  	WARN_ON_ONCE(!_retries);					\
> -	_val;								\
> +	_val2;								\
>  })
>  
>  static u64 notrace sun50i_a64_read_cntpct_el0(void)
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
