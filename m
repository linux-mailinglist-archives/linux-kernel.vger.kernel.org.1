Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C331B27CAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgI2MVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:21:37 -0400
Received: from vps.xff.cz ([195.181.215.36]:51274 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbgI2LfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1601379320; bh=NYesYDM0ZLiT5Nd37jm/2orVxg1+VI1tpstJHtB2iwc=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=BXPssIoLK58jxGGdh3oWBFqmOG0oAUyMMFee7FzK7Pu/QztXqe05NKQJrYh/WoLjn
         vDN8Kjnhi6zYRRuGUcAkdQN4y9t9/oCzXXv/nXdLUxYK6DAZA7YdPfRf+MEe1WRxZe
         omGBFLhJSsKQfeSvkqfTFanXdGik98nq9QVznuIk=
Date:   Tue, 29 Sep 2020 13:35:19 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: arm64: arch_timer: Fix timer inconsistency test for
 A64
Message-ID: <20200929113519.b2vydqmhcivvbwom@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Roman Stratiienko <r.stratiienko@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200929111347.1967438-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929111347.1967438-1-r.stratiienko@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roman,

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
> --------------------
> 1601335525:467099095
> 1601335525:467099845
> 1601335525:467100637
> 1601335525:467101387
> 1601335525:467102179
> 1601335525:467102929
> '''

Can you reproduce the issue with a fixed CPU frequency. I suspect the root
cause is around CPU frequency scaling code on A64, and timer jumps happen when
the kernel is changing CPU frequency.

I fixed a similar issue on H3 SoC just by changing the CPU frequency scaling
code, without having to touch the timer readout code.

https://megous.com/git/linux/commit/?h=ths-5.9&id=51ff1a6d80126f678efca42555f93efa611f50c4

regards,
	o.

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
