Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9929DFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgJ1WIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:08:47 -0400
Received: from foss.arm.com ([217.140.110.172]:38890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbgJ1WHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 204E21AC1;
        Wed, 28 Oct 2020 11:29:50 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5434A3F719;
        Wed, 28 Oct 2020 11:29:49 -0700 (PDT)
Date:   Wed, 28 Oct 2020 18:29:46 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Yun Hsiang <hsiang023167@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201028182946.6qfmt7q35ewrjjua@e107158-lin>
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
 <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
 <20201027155813.GA818508@ubuntu>
 <87v9eumzic.derkling@matbug.net>
 <20201028113943.7jzxbytizrv7wsm3@e107158-lin>
 <87sg9ymdmw.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sg9ymdmw.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 19:03, Patrick Bellasi wrote:
> 
> On Wed, Oct 28, 2020 at 12:39:43 +0100, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> > On 10/28/20 11:11, Patrick Bellasi wrote:
> >> >>  
> >> >>  		/*
> >> >>  		 * RT by default have a 100% boost value that could be modified
> >> >>  		 * at runtime.
> >> >>  		 */
> >> >>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> >> >> -			__uclamp_update_util_min_rt_default(p);
> >> >> +			value = sysctl_sched_uclamp_util_min_rt_default;
> >> 
> >> By removing this usage of __uclamp_updadate_util_min_rt_default(p),
> >> the only other usage remaining is the call from:
> >>    uclamp_udpate_util_min_rt_default().
> >> 
> >> What about an additional cleanup by in-lining the only surviving usage?
> >
> > This is not a cleanup IMO. There is special rule about updating that are
> > encoded and documented in this helper function. Namely:
> >
> > 	* p->pi_lock must be held.
> > 	* p->uclamp_req[].user_defined must be false.
> 
> Both these conditions are satisfied in the above call site:
>  - user_defined is tested just 4 lines above
>  - pi_lock is taken by the caller, i.e. __sched_setscheduler()
> Thus, there is no need to test them two times.
> Moreover, the same granted pi_lock you check in
> __ucalmp_update_util_min_rt_default() is not checked at all in the rest
> of __setscheduler_uclamp().

Updating the default rt value is done from different contexts. Hence it is
important to document the rules under which this update must happen and ensure
the update happens through a common path.

__setscheduler_uclamp() is not called from 2 different contexts.

> Thus, perhaps we should have just avoided to add
> __uclamp_update_util_min_rt_default() since the beginning and:
>  - have all its logic in the _only_ place where it's required
>  - added the lockdep_assert_held() in __setscheduler_uclamp()
> 
> That's why I consider this a very good cleanup opportunity.

I disagree. This is unnecessary churn.

Thanks

--
Qais Yousef

> > I don't see open coding helps but rather makes the code harder to read and
> > prone to introduce bugs if anything gets reshuffled in the future.
> 
> It's not open coding IMHO, it's just adding the code that's required.
