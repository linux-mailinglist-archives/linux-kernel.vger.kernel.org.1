Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC026F4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIRDh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgIRDh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:37:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8394721D24;
        Fri, 18 Sep 2020 03:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600400275;
        bh=RzOwyfu72IHm0AgVL34AlxS885cvVoyeaPAXXAeXSXY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pjt+aRBc6ipVrHhQ5zRRsJ+FIG36cVrAvWaMS4Qjg7Q6QNmbEyU16AdhnrZrL0OjB
         ek6zdN1lWEV3IMIwbgg6pgxvRyi/uYIAXihC9qtcaIA6AAeeIiN30lQHVHIPgCxUEd
         V/iUbrLcNIOwQoRSnH7JArP3imlf9XBrWGvnO/9U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 507D93522B5A; Thu, 17 Sep 2020 20:37:55 -0700 (PDT)
Date:   Thu, 17 Sep 2020 20:37:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] locktorture: doesn't check nreaders_stress when no
 readlock support
Message-ID: <20200918033755.GS29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200917135910.137389-1-houtao1@huawei.com>
 <20200917135910.137389-2-houtao1@huawei.com>
 <20200917165817.GK29330@paulmck-ThinkPad-P72>
 <86bc5a54-5dfa-4320-9e10-9660a25724d0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bc5a54-5dfa-4320-9e10-9660a25724d0@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 09:13:14AM +0800, Hou Tao wrote:
> Hi Paul,
> 
> On 2020/9/18 0:58, Paul E. McKenney wrote:
> > On Thu, Sep 17, 2020 at 09:59:09PM +0800, Hou Tao wrote:
> >> To ensure there is always at least one locking thread.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/locking/locktorture.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >> index 9cfa5e89cff7f..bebdf98e6cd78 100644
> >> --- a/kernel/locking/locktorture.c
> >> +++ b/kernel/locking/locktorture.c
> >> @@ -868,7 +868,8 @@ static int __init lock_torture_init(void)
> >>  		goto unwind;
> >>  	}
> >>  
> >> -	if (nwriters_stress == 0 && nreaders_stress == 0) {
> >> +	if (nwriters_stress == 0 &&
> >> +	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
> > 
> > You lost me on this one.  How does it help to allow tests with zero
> > writers on exclusive locks?  Or am I missing something subtle here?
> > 
> The purpose is to prohibit test with only readers on exclusive locks, not allow it.
> 
> So if the module parameters are "torture_type=mutex_lock nwriters_stress=0 nreaders_stress=3",
> locktorture can fail early instead of continuing but doing nothing useful.

Very good!

Now please make that clear in the commit log.  (Your English looks to
me to be more than equal to that challenge.)

In this commit log, please first state what is wrong.  Then what the
change is and how it improves things.

							Thanx, Paul

> Regards,
> Tao
> 
> > 							Thanx, Paul
> > 
> >>  		pr_alert("lock-torture: must run at least one locking thread\n");
> >>  		firsterr = -EINVAL;
> >>  		goto unwind;
> >> -- 
> >> 2.25.0.4.g0ad7144999
> >>
> > .
> > 
