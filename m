Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97CC2DD288
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgLQOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgLQOAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:00:43 -0500
Date:   Thu, 17 Dec 2020 14:59:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608213602;
        bh=svPMXpH6bDkIdejaUcdO9VkfvHen07wvadh8PJV0fLU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=gerW71+PdJ1eyajH7qobdOXQoi6N5swnm8mDW5oLR0j6UgEIQxj/W9nYT+QA8XKMB
         sOozaDaRYYdmSyRoZ3Hdz1kj1w+YUeWoV6hc8p0t5+jJsmaU2O/PLcFrk2ILyZ2ssR
         uye8S3kDU23g7jO/MTqcjP2KvlZYEZjN3X8UEnXHBMuK40AqUtL9n5kQ25s9HNf/jD
         QasEVpv0Jg0Mpnrh5fsZFQjL2LDRTzM41cyZh/rPFHDACNMaICOVgMJ431/oTL2ea+
         lPAAWWzxSgYYUxF+85f/bvZJ6OAR3cXvDgYS4L0PT9SCdLz1m/LXO/Jj/22chXUybX
         tAwsEoc4u6CHg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tick/nohz: Make the idle_exittime update correctly
Message-ID: <20201217135959.GA3736@lothringen>
References: <2e194669-c074-069c-4fda-ad5bc313a611@huawei.com>
 <bc6f830d-21da-b334-9dfd-54dcf2d4f7a0@huawei.com>
 <20201215144757.GA9391@lothringen>
 <e1a3b328-6684-77d8-8d28-9baa36980403@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a3b328-6684-77d8-8d28-9baa36980403@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 02:51:58PM +0800, Yunfeng Ye wrote:
> 
> 
> On 2020/12/15 22:47, Frederic Weisbecker wrote:
> > On Tue, Dec 15, 2020 at 08:06:34PM +0800, Yunfeng Ye wrote:
> >> The idle_exittime field of tick_sched is used to record the time when
> >> the idle state was left. but currently the idle_exittime is updated in
> >> the function tick_nohz_restart_sched_tick(), which is not always in idle
> >> state when nohz_full is configured.
> >>
> >>   tick_irq_exit
> >>     tick_nohz_irq_exit
> >>       tick_nohz_full_update_tick
> >>         tick_nohz_restart_sched_tick
> >>           ts->idle_exittime = now;
> >>
> >> So move to tick_nohz_stop_idle() to make the idle_exittime update
> >> correctly.
> >>
> >> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >> ---
> >>  kernel/time/tick-sched.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> >> index 749ec2a583de..be2e5d772d50 100644
> >> --- a/kernel/time/tick-sched.c
> >> +++ b/kernel/time/tick-sched.c
> >> @@ -591,6 +591,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
> >>  {
> >>  	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
> >>  	ts->idle_active = 0;
> >> +	ts->idle_exittime = now;
> > 
> > This changes a bit the meaning of idle_exittime then since this is also called
> > from idle interrupt entry.
> > 
> > __tick_nohz_idle_restart_tick() would be a better place.
> > 
> So is it necessary to modify the comment "@idle_exittime:      Time when the idle state was left" ?
> 
> On the other hand, if the patch "nohz: Update tick instead of restarting tick in tick_nohz_idle_exit()"
> (https://www.spinics.net/lists/kernel/msg3747039.html ) applied, __tick_nohz_idle_restart_tick will not
> be called always, So is it put here also a better place?

Right but I need to re-order some code before. That's ok, I'll integrate this
patch inside the changes.

Thanks.
