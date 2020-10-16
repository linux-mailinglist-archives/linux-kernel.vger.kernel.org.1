Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8376B290B71
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392382AbgJPSit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391980AbgJPSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:38:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3DC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:38:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p15so4573142ejm.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=2zZ9Bi5ipiBfOedVgWs+s17XKliwMJJo2kx5NuQsO90=;
        b=NkgS21FMAKTdY8KfT1dAj5/BSF3aJXAiiidrcKTHLpR+HeCQgP1u8BC6v1a7WCRcDq
         l9xumpHbA3K1/ubMrowrA2PHr8aCyOQhwbhLDO8WcR1U5td02UK2KWdjaldMkfFwq4on
         2T8LxW2E+LgAqt+l2+dIfTZDQcvMFhFjYUZR/AQjAEFjQxoDkgIBcOclq6WINpwDlrc4
         otw8k5BzWxOi7Z4wQmcehzqik+2bpzbLkxVKqnDSZX3T0ezM6Oq+xTuoYVSaOsCcj6EC
         yUU8fl2fYqJzS5Q2QT6JevqBRXef1CXibpcwiAwQnB6o7CvP3qlGxjifIhFFzoPT5PTu
         FtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=2zZ9Bi5ipiBfOedVgWs+s17XKliwMJJo2kx5NuQsO90=;
        b=QruZnbne3olJjlqG0KqU9D5rSbCO+j6WspS2Z5hhzBDqkZqEyTDX90pyHvYoD5DXSo
         8oEUaIU0W/C6G59LXfgOa1jwMwUUWKOzXzZYUKiX0382eY2DUpyqO2IvwUtHuHNaC1FK
         00nM0ipYqHqF3Ar4iVJb408sPhl5NztjOcPnjfxT2SCvAc6bSbt/+D1/LOCg6/ojy1ZI
         wWyeRKF46NAaBL1jbBTs7U2aAm88LyZg1VB3gwhcX3yKwfU8lBEvpP6vCuy5vNfUGOcY
         vdmggMDsEApft4Ak96elKO1ZKu2aruv8VDw62ViF4bi0LmvExSzDBzon5BSAxtpvn9NF
         AL0g==
X-Gm-Message-State: AOAM533MclCAbLVE6SyKG89xGARSSgudWWdl8hfThviuWs57Ll+fB2gA
        RrcQP4T2bjz7+i5IJ4l0hIaYIQ==
X-Google-Smtp-Source: ABdhPJwvdBTERxVJGMwUofl3mCYol43bxTqtNRVxrOu8OGKxuymL0NyNUXYNtTPyp+cmdarLmQUpzQ==
X-Received: by 2002:a17:906:72cb:: with SMTP id m11mr4941541ejl.348.1602873527174;
        Fri, 16 Oct 2020 11:38:47 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id o13sm2397555ejr.120.2020.10.16.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:38:46 -0700 (PDT)
References: <20201016173020.12686-1-jassisinghbrar@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     ionela.voinescu@arm.com, khilman@baylibre.com, da@libre.computer,
        sudeep.holla@arm.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] mailbox: avoid timer start from callback
In-reply-to: <20201016173020.12686-1-jassisinghbrar@gmail.com>
Date:   Fri, 16 Oct 2020 20:38:45 +0200
Message-ID: <1jh7quj9sa.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 16 Oct 2020 at 19:30, jassisinghbrar@gmail.com wrote:

> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> If the txdone is done by polling, it is possible for msg_submit() to start
> the timer while txdone_hrtimer() callback is running. If the timer needs
> recheduling, it could already be enqueued by the time hrtimer_forward_now()
> is called, leading hrtimer to loudly complain.
>
> WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
> CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
> Hardware name: Libre Computer AML-S805X-AC (DT)
> Workqueue: events_freezable_power_ thermal_zone_device_check
> pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> pc : hrtimer_forward+0xc4/0x110
> lr : txdone_hrtimer+0xf8/0x118
> [...]
>
> This can be fixed by not starting the timer from the callback path. Which
> requires the timer reloading as long as any message is queued on the
> channel, and not just when current tx is not done yet.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/mailbox/mailbox.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 0b821a5b2db8..a093a6ecaa66 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -82,9 +82,12 @@ static void msg_submit(struct mbox_chan *chan)
>  exit:
>  	spin_unlock_irqrestore(&chan->lock, flags);
>  
> -	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> -		/* kick start the timer immediately to avoid delays */
> -		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> +	/* kick start the timer immediately to avoid delays */
> +	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> +		/* but only if not already active */

It would solve the problem I reported as well but instead of running the
check immediately (timer with value 0), we will have to wait for the
next of the timer, it is already started. IOW, there might be a delay
now. I don't know if this important for the mailbox - the existing
comments in the code suggested it was.

> +		if (!hrtimer_active(&chan->mbox->poll_hrt))
> +			hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> +	}
>  }
>  
>  static void tx_tick(struct mbox_chan *chan, int r)
> @@ -122,11 +125,10 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
>  		struct mbox_chan *chan = &mbox->chans[i];
>  
>  		if (chan->active_req && chan->cl) {
> +			resched = true;
>  			txdone = chan->mbox->ops->last_tx_done(chan);
>  			if (txdone)
>  				tx_tick(chan, 0);
> -			else
> -				resched = true;
>  		}
>  	}

