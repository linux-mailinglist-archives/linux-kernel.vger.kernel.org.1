Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9418D290C51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411037AbgJPTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408131AbgJPTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:32:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE383C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:32:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so4802955ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=BqW8JiuIYvnXw5H3Z5hu1Iu1nuYkaGW3P8AQ8gC+FKM=;
        b=XGMTdoX+Gb7Re8mBkXzcfp7ph0rlqxum1dHeqeBiWns3aO0thPHJl4+fEhp+vawpfg
         JcE+EqdgCdYRH0t6sksouq6UihIaRxTB027K/2ksywUfcowTjJdzwVsSiXWItetd4bXV
         +8kiT8DyBDC01TToRWIVjPZgTjF6YBV0FZP3KOGw4d4KTruU8mPe5FZS8KTCC0WJxWws
         6aTHw7codOkvRnaMIH4gVnB4cdCOmhJJJJFDSQXK+2cbXizW2ElLWAjtzk1rNP2Cbd4m
         nSD77rNpq6UgWTVjRZgVZRC9fi27j6aO+PSIOr+XVWPBPoieKHv5sL1+ada96FYz7tLX
         BbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=BqW8JiuIYvnXw5H3Z5hu1Iu1nuYkaGW3P8AQ8gC+FKM=;
        b=DWSQZpC7QMgrJ1JnM5nvCd8G/yG/LPnIRS6oanO+86VwvW70TsedluPekIIEpfjQhp
         kHDde9QaMmntDmwYUHM3H5AjRD1UNnQgiHP2/lBea1cSiEpGmaycV2rYahjPs5TrdeYu
         CCMQa5I8KhNzpWm0UVToFYtE/1d9t7ZHFPvIKpCZW0jDO8N0MypxSw5yyRO2PhiaGB+k
         eXOlIs6ACOPMwP1n8dvdUJNg2IZxMdftdqFk62wMsh6U1hKd0FBfrB97eq6XIVBUUkmn
         ynOigH94R1BNN3pbBOYeMXhAo+/60KBfrQN6CIBKbXAYzj1hZwtaQBN7ELd6WsGWlOnl
         UYqQ==
X-Gm-Message-State: AOAM530uyRMhxCc4yRrQ03zLIEaFUYPJKRjYORG+DzzxIKh++27d709u
        odGBXYL1M4XUVVVk2fPwTMcNfw==
X-Google-Smtp-Source: ABdhPJyBwMqo/66INsZbW1Y/UGKInEg+kHUaO9pvAn8S4dAFGvICAYgMBWhZBx84giYv3KIZEuMzJQ==
X-Received: by 2002:a17:906:c094:: with SMTP id f20mr5604777ejz.550.1602876773475;
        Fri, 16 Oct 2020 12:32:53 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id u18sm2533174ejn.122.2020.10.16.12.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 12:32:52 -0700 (PDT)
References: <20201016173020.12686-1-jassisinghbrar@gmail.com> <1jh7quj9sa.fsf@starbuckisacylon.baylibre.com> <CABb+yY3oghojLDAz2n8fio47X=we=mF=u8iA2zc7ApvcH7ySKA@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da@libre.computer>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] mailbox: avoid timer start from callback
In-reply-to: <CABb+yY3oghojLDAz2n8fio47X=we=mF=u8iA2zc7ApvcH7ySKA@mail.gmail.com>
Date:   Fri, 16 Oct 2020 21:32:52 +0200
Message-ID: <1jeelyj7a3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 16 Oct 2020 at 20:45, Jassi Brar <jassisinghbrar@gmail.com> wrote:

> On Fri, Oct 16, 2020 at 1:38 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Fri 16 Oct 2020 at 19:30, jassisinghbrar@gmail.com wrote:
>>
>> > From: Jassi Brar <jaswinder.singh@linaro.org>
>> >
>> > If the txdone is done by polling, it is possible for msg_submit() to start
>> > the timer while txdone_hrtimer() callback is running. If the timer needs
>> > recheduling, it could already be enqueued by the time hrtimer_forward_now()
>> > is called, leading hrtimer to loudly complain.
>> >
>> > WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
>> > CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
>> > Hardware name: Libre Computer AML-S805X-AC (DT)
>> > Workqueue: events_freezable_power_ thermal_zone_device_check
>> > pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
>> > pc : hrtimer_forward+0xc4/0x110
>> > lr : txdone_hrtimer+0xf8/0x118
>> > [...]
>> >
>> > This can be fixed by not starting the timer from the callback path. Which
>> > requires the timer reloading as long as any message is queued on the
>> > channel, and not just when current tx is not done yet.
>> >
>> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> > ---
>> >  drivers/mailbox/mailbox.c | 12 +++++++-----
>> >  1 file changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> > index 0b821a5b2db8..a093a6ecaa66 100644
>> > --- a/drivers/mailbox/mailbox.c
>> > +++ b/drivers/mailbox/mailbox.c
>> > @@ -82,9 +82,12 @@ static void msg_submit(struct mbox_chan *chan)
>> >  exit:
>> >       spin_unlock_irqrestore(&chan->lock, flags);
>> >
>> > -     if (!err && (chan->txdone_method & TXDONE_BY_POLL))
>> > -             /* kick start the timer immediately to avoid delays */
>> > -             hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
>> > +     /* kick start the timer immediately to avoid delays */
>> > +     if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
>> > +             /* but only if not already active */
>>
>> It would solve the problem I reported as well but instead of running the
>> check immediately (timer with value 0), we will have to wait for the
>> next of the timer, it is already started. IOW, there might be a delay
>> now. I don't know if this important for the mailbox - the existing
>> comments in the code suggested it was.
>>
> That comment is for when the first message is queued on the channel,
> which remains unimpacted.
> So, do I have your tested/acked by ?

Sure go ahead

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>

>
> thnx,

