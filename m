Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7FA290075
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394884AbgJPJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394536AbgJPJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:02:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899ECC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:02:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg9so1472977edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=YRalqKr57maWSBCFfKOl28ih/XZdpqUZ21LloKcUJks=;
        b=RJw96zwU0FQkNGmsV2GHZr0VT571lwKekreZUXepXoEHLq+c8nEGV/Yh2xnNwkWh35
         x/EJLppvbeovU3HGvSOjN9+WFqQY81UrIStIrqEVatheU4A9omKh02Y9l1R5OdbPzuqt
         cyl/Ur77cYpOTUBDgvQf8OHzH+y/5gAs1/72XiCRpGhbDCCU/lPb5vtq46oUqYyyqCzI
         M0b7P1GJ+TGIyNrSG6M9dtbZ2HJW/HHhbN4MrKS0L2UJ3SKc689zxNT+ZpicuqzpwAz1
         nKtT3aDn/mQeHAuzQetX6R7puzox7w4j034Oo30H6nCxs+3vbAa+DHjp0Qs4FNY/M+ut
         M8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=YRalqKr57maWSBCFfKOl28ih/XZdpqUZ21LloKcUJks=;
        b=d4rKSbyg2Hgd5qbfEp6Ti6YelIekPkjVPbOdpIt8V3Yg9dxNyuKg/uAQC2t+qqSD3L
         1DmuuYoYVdEeWOl33hp7+ohSHgMFFVLWvVOSODQXD3jJPi7sUDNZY7RqFts1/Roc2FGK
         1Q/SuMIZ1pIZLuJyh7vzeXJ6Xg1BhOfU1uhGYVthbcQkZo1+iRPL6iecO7GvVdLp0IcA
         IoFDaNXFWVgfv7UWGn29XZ3lzZP1NAuGcXyScH/v8WE6mZEomymT1qBmFjBOBkbqN0GA
         pWgpOxtWanyPS+oK9tJhtxJIfwYdFCMuUshzoRnJ8UxNfCXnYSZWpZZkMPrV7fVWG4Ia
         pclw==
X-Gm-Message-State: AOAM533cwRXVeSy3hrhMNmy554Xpr7XmWTH7dhnGnOws4FXXt0Edrc/a
        xTTidLiD0PM11QgIfDNmDPMfVA==
X-Google-Smtp-Source: ABdhPJxJfdyU0OC1yvdvGDEZ8q85HrAiLG1l1xKb7I8SIW4X4SGJNje80ty/juGeB0gzJ6huReSteg==
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr2702751edr.247.1602838924236;
        Fri, 16 Oct 2020 02:02:04 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id a13sm915107edx.53.2020.10.16.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 02:02:03 -0700 (PDT)
References: <20200923123916.1115962-1-jbrunet@baylibre.com> <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com> <20201015142935.GA12516@arm.com> <20201016084428.gthqj25wrvnqjsvz@bogus>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: cancel timer before starting it
In-reply-to: <20201016084428.gthqj25wrvnqjsvz@bogus>
Date:   Fri, 16 Oct 2020 11:02:02 +0200
Message-ID: <1jimbak0hh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 16 Oct 2020 at 10:44, Sudeep Holla <sudeep.holla@arm.com> wrote:

> On Thu, Oct 15, 2020 at 03:29:35PM +0100, Ionela Voinescu wrote:
>> Hi Jerome,
>> 
>> On Thursday 15 Oct 2020 at 15:58:30 (+0200), Jerome Brunet wrote:
>> > 
>> > On Thu 15 Oct 2020 at 15:46, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>> > 
>> > > Hi guys,
>> > >
>> > > On Wednesday 23 Sep 2020 at 14:39:16 (+0200), Jerome Brunet wrote:
>> > >> If the txdone is done by polling, it is possible for msg_submit() to start
>> > >> the timer while txdone_hrtimer() callback is running. If the timer needs
>> > >> recheduling, it could already be enqueued by the time hrtimer_forward_now()
>> > >> is called, leading hrtimer to loudly complain.
>> > >> 
>> > >> WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
>> > >> CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
>> > >> Hardware name: Libre Computer AML-S805X-AC (DT)
>> > >> Workqueue: events_freezable_power_ thermal_zone_device_check
>> > >> pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
>> > >> pc : hrtimer_forward+0xc4/0x110
>> > >> lr : txdone_hrtimer+0xf8/0x118
>> > >> [...]
>> > >> 
>> > >> Canceling the timer before starting it ensure that the timer callback is
>> > >> not running when the timer is started, solving this race condition.
>> > >> 
>> > >> Fixes: 0cc67945ea59 ("mailbox: switch to hrtimer for tx_complete polling")
>> > >> Reported-by: Da Xue <da@libre.computer>
>> > >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > >> ---
>> > >>  drivers/mailbox/mailbox.c | 8 ++++++--
>> > >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> > >> 
>> > >> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> > >> index 0b821a5b2db8..34f9ab01caef 100644
>> > >> --- a/drivers/mailbox/mailbox.c
>> > >> +++ b/drivers/mailbox/mailbox.c
>> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
>> > >>  exit:
>> > >>  	spin_unlock_irqrestore(&chan->lock, flags);
>> > >>  
>> > >> -	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
>> > >> -		/* kick start the timer immediately to avoid delays */
>> > >> +	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
>> > >> +		/* Disable the timer if already active ... */
>> > >> +		hrtimer_cancel(&chan->mbox->poll_hrt);
>> > >> +
>> > >> +		/* ... and kick start it immediately to avoid delays */
>> > >>  		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
>> > >> +	}
>> > >>  }
>> > >>  
>> > >>  static void tx_tick(struct mbox_chan *chan, int r)
>> > >
>> > > I've tracked a regression back to this commit. Details to reproduce:
>> > 
>> > Hi Ionela,
>> > 
>> > I don't have access to your platform and I don't get what is going on
>> > from the log below.
>> > 
>> > Could you please give us a bit more details about what is going on ?
>> > 
>> 
>> I'm not familiar with the mailbox subsystem, so the best I can do right
>> now is to add Sudeep to Cc, in case this conflicts in some way with the
>> ARM MHU patches [1].
>>
>
> Not it can't be doorbell driver as we use SCPI(old firmware) with upstream
> MHU driver as is limiting the number of channels to be used.
>
>> In the meantime I'll get some traces and get more familiar with the
>> code.
>>
>
> I will try that too.

BTW, this issue was originally reported on amlogic platforms which also
use arm,mhu mailbox driver.

