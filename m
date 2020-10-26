Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20EF29915E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784381AbgJZPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:45:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40778 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784373AbgJZPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:45:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id x13so6285670pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FpczMM0BIbW8zGDZ4BqUDJjRDDytSOvjwX4hH97+YEs=;
        b=DfzBgh6YARRrqyocwtFVZHwvBTnXBOZj7lzcXyB+zAOMhLLv5IedJFW/Igi9SydoV6
         H2PB8DK45l5a8y2wXwSPx76+BCLu5w93pQ5CUc764ws6Fr70IUUD/JCOElBnvGPpg2EV
         HbdW77W/WFPXsfjwfLLOPitwYubz++wDeEb0aqYS0UhO60BWxm84iMyygk/SkAJojX9J
         VIxUBaVu6h015ovm2XzTYPR6FRtK51ihn6yKtgJOWpEY3qOTuDZY80KljI4NE4WaUnfu
         IsIDnT+/zATG5bT/pzPRl1jpSBkJ4z+QlXveDhgrujZcyoMDxFQ9rTuLctQGtBECKK1Q
         c6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FpczMM0BIbW8zGDZ4BqUDJjRDDytSOvjwX4hH97+YEs=;
        b=ZykvMwGrUUw9uZ6HiwHzVtoIoGNt4avrYsHiiVOhnntj36bSWZ5Al+0b8yMIR6E55W
         eAwKzdF50tZ77lFYo7NPQwEhjbBO9v3ujjaKXEunOq5+fbQ4/v3eunvp/fTRNcWXb3yq
         yEEHG6aE6x8729RioBkQcFEg7TYDr70BgrqopTuJgRlurJy6rkBQDD6Rx6GwRJ97+905
         cfiDOnsc/RfU7KntlfKKtc3inUEC/Jr8O6fSsTeRK4yOQrYGmSJz9bWhsG7f0cpFV2D8
         xMZL26l+AbfQ+GMtYQB0IKNgyVaRiqQTo/83zX2j2uALR1DkdYf8hQcdtAfKP3urcfuH
         jfzQ==
X-Gm-Message-State: AOAM533WZTg1jjn9cRev6jJ0T5QX56QURH1q9o4VzLo+GKyNPZPO37JX
        jJyvsKgwaHrFh9E5m9dWydA=
X-Google-Smtp-Source: ABdhPJzHzynb2cxPdhkP+f8nib3QuSwFqwMbErf6j3L307i7tdAp6ncAdTLfvQ3rv1hyuDbijIz/4w==
X-Received: by 2002:a63:7a1b:: with SMTP id v27mr14632577pgc.176.1603727147301;
        Mon, 26 Oct 2020 08:45:47 -0700 (PDT)
Received: from ubuntu (1-171-242-24.dynamic-ip.hinet.net. [1.171.242.24])
        by smtp.gmail.com with ESMTPSA id z66sm11484665pfb.109.2020.10.26.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:45:45 -0700 (PDT)
Date:   Mon, 26 Oct 2020 23:45:38 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201026154538.GA807103@ubuntu>
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Mon, Oct 26, 2020 at 10:47:11AM +0100, Dietmar Eggemann wrote:
> On 25/10/2020 08:36, Yun Hsiang wrote:
> > If the user wants to stop controlling uclamp and let the task inherit
> > the value from the group, we need a method to reset.
> > 
> > Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> > sched_setattr syscall.
> > 
> > The policy is
> > _CLAMP_RESET                           => reset both min and max
> > _CLAMP_RESET | _CLAMP_MIN              => reset min value
> > _CLAMP_RESET | _CLAMP_MAX              => reset max value
> > _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> > 
> > Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
> 
> [...]
> 
> > @@ -1451,7 +1464,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
> >  
> >  		/* Keep using defined clamps across class changes */
> > -		if (uc_se->user_defined)
> > +		if (flags != SCHED_FLAG_UTIL_CLAMP_RESET &&
> > +				uc_se->user_defined)
> >  			continue;
> 
> With:
> 
> (1) _CLAMP_RESET                           => reset both min and max
> (2) _CLAMP_RESET | _CLAMP_MIN              => reset min value
> (3) _CLAMP_RESET | _CLAMP_MAX              => reset max value
> (4) _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> 
> If you reset an RT task with (1) you don't reset its uclamp.min value.
> 
> __uclamp_update_util_min_rt_default(p) doesn't know about
> SCHED_FLAG_UTIL_CLAMP_RESET. It only knows user_defined and will bail early.
>

Sorry I didn't notice __uclamp_update_util_min_rt_default will return
directly if user_defined is set, I'll fix it.

> [...]
> 
> > -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> > +	if (likely(!flags || flags == SCHED_FLAG_UTIL_CLAMP_RESET))
> >  		return;
> >  
> > -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +	if (flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +		if (reset) {
> > +			clamp_value = __default_uclamp_value(p, UCLAMP_MIN);
> > +			user_defined = false;
> > +		} else {
> > +			clamp_value = attr->sched_util_min;
> > +			user_defined = true;
> > +		}
> 
> Why do you reset for (1) in the for_each_clamp_id(clamp_id) loop and for
> (2)-(4) in the if (flags & SCHED_FLAG_UTIL_CLAMP_MXX) condition?
> 
> You could reset (1)-(4) in the for_each_clamp_id(clamp_id) loop? In this
> case you wouldn't need __default_uclamp_value().

Do you mean adding these code in for_each_clamp_id(clamp_id) loop?

if (clamp_id == UCLAMP_MIN) {
	if (flags == SCHED_FLAG_UTIL_CLAMP_RESET || 
		(reset && (flags || SCHED_FLAG_UTIL_CLAMP_MIN)) ||
		!se->user_defined) {
		if (task_rt(p)) {
			clamp_value = sysctl_sched_uclamp_util_min_rt_default
		} else {
			clamp_value = uclamp_none(clamp_id);
		}
	} else 
		continue;
}
/* similar code for UCLAMP_MAX */
...
uclamp_se_set(uc_se, clamp_value, false);

It seems more clear.
If you think this one is better, I'll use this method and send patch V4.

> [...]
