Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1E290200
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405856AbgJPJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:34:25 -0400
Received: from foss.arm.com ([217.140.110.172]:60794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404835AbgJPJeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:34:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8869A30E;
        Fri, 16 Oct 2020 02:34:24 -0700 (PDT)
Received: from bogus (unknown [10.57.17.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43AB33F719;
        Fri, 16 Oct 2020 02:34:23 -0700 (PDT)
Date:   Fri, 16 Oct 2020 10:34:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: cancel timer before starting it
Message-ID: <20201016093421.7hyiqrekiy6mtyso@bogus>
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com>
 <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
 <20201015142935.GA12516@arm.com>
 <20201016084428.gthqj25wrvnqjsvz@bogus>
 <1jimbak0hh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jimbak0hh.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:02:02AM +0200, Jerome Brunet wrote:
> 
> On Fri 16 Oct 2020 at 10:44, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> > On Thu, Oct 15, 2020 at 03:29:35PM +0100, Ionela Voinescu wrote:
> >> Hi Jerome,
> >> 
> >> On Thursday 15 Oct 2020 at 15:58:30 (+0200), Jerome Brunet wrote:
> >> > 
> >> > On Thu 15 Oct 2020 at 15:46, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >> > 
> >> > > Hi guys,
> >> > >
> >> > > On Wednesday 23 Sep 2020 at 14:39:16 (+0200), Jerome Brunet wrote:
> >> > >> If the txdone is done by polling, it is possible for msg_submit() to start
> >> > >> the timer while txdone_hrtimer() callback is running. If the timer needs
> >> > >> recheduling, it could already be enqueued by the time hrtimer_forward_now()
> >> > >> is called, leading hrtimer to loudly complain.
> >> > >> 
> >> > >> WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
> >> > >> CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
> >> > >> Hardware name: Libre Computer AML-S805X-AC (DT)
> >> > >> Workqueue: events_freezable_power_ thermal_zone_device_check
> >> > >> pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> >> > >> pc : hrtimer_forward+0xc4/0x110
> >> > >> lr : txdone_hrtimer+0xf8/0x118
> >> > >> [...]
> >> > >> 
> >> > >> Canceling the timer before starting it ensure that the timer callback is
> >> > >> not running when the timer is started, solving this race condition.
> >> > >> 
> >> > >> Fixes: 0cc67945ea59 ("mailbox: switch to hrtimer for tx_complete polling")
> >> > >> Reported-by: Da Xue <da@libre.computer>
> >> > >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> > >> ---
> >> > >>  drivers/mailbox/mailbox.c | 8 ++++++--
> >> > >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> > >> 
> >> > >> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> >> > >> index 0b821a5b2db8..34f9ab01caef 100644
> >> > >> --- a/drivers/mailbox/mailbox.c
> >> > >> +++ b/drivers/mailbox/mailbox.c
> >> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
> >> > >>  exit:
> >> > >>  	spin_unlock_irqrestore(&chan->lock, flags);
> >> > >>  
> >> > >> -	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> >> > >> -		/* kick start the timer immediately to avoid delays */
> >> > >> +	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> >> > >> +		/* Disable the timer if already active ... */
> >> > >> +		hrtimer_cancel(&chan->mbox->poll_hrt);
> >> > >> +
> >> > >> +		/* ... and kick start it immediately to avoid delays */
> >> > >>  		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> >> > >> +	}
> >> > >>  }
> >> > >>  
> >> > >>  static void tx_tick(struct mbox_chan *chan, int r)
> >> > >
> >> > > I've tracked a regression back to this commit. Details to reproduce:
> >> > 
> >> > Hi Ionela,
> >> > 
> >> > I don't have access to your platform and I don't get what is going on
> >> > from the log below.
> >> > 
> >> > Could you please give us a bit more details about what is going on ?
> >> > 
> >> 
> >> I'm not familiar with the mailbox subsystem, so the best I can do right
> >> now is to add Sudeep to Cc, in case this conflicts in some way with the
> >> ARM MHU patches [1].
> >>
> >
> > Not it can't be doorbell driver as we use SCPI(old firmware) with upstream
> > MHU driver as is limiting the number of channels to be used.
> >
> >> In the meantime I'll get some traces and get more familiar with the
> >> code.
> >>
> >
> > I will try that too.
> 
> BTW, this issue was originally reported on amlogic platforms which also
> use arm,mhu mailbox driver.
> 

OK. Anyway just noticed that hrtimer_cancel uses  hrtimer_try_to_cancel
and hrtimer_cancel_wait_running. The latter is just cpu_relax() if
PREEMPT_RT=n, so you may still have issue if the hrtimer is still active
or restarts in the meantime.

-- 
Regards,
Sudeep
