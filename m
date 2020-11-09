Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2D2ABCF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgKINlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:41:45 -0500
Received: from foss.arm.com ([217.140.110.172]:40634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730421AbgKINlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:41:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1200331B;
        Mon,  9 Nov 2020 05:41:43 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CEA83F719;
        Mon,  9 Nov 2020 05:41:42 -0800 (PST)
Date:   Mon, 9 Nov 2020 13:41:39 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201109134139.igx2slqwdhli2jdy@e107158-lin.cambridge.arm.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <87blgag4an.derkling@matbug.net>
 <20201107191501.GB1056076@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107191501.GB1056076@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/20 03:15, Yun Hsiang wrote:
> I think SCHED_FLAG_ALL is for internal kernel use. So I agree with not
> exporting it to user.

+1 for the #ifdef __kernel__

> > > +	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
> > > +		return false;
> > > +
> > > +	/* Only _UCLAMP_RESET flag set: reset both clamps */
> > > +	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
> > > +		return true;
> > > +
> > > +	/* Both _UCLAMP_RESET and _UCLAMP_MIN flags are set: reset only min */
> > > +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
> > > +		return true;
> > > +
> > > +	/* Both _UCLAMP_RESET and _UCLAMP_MAX flags are set: reset only max */
> > > +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
> > > +		return true;
> > > +
> > > +	return false;
> > 
> > I was suggesting maybe we need READ_ONCE() in the if above but did not
> > addressed previous Dietmar's question [2] on why.
> > 
> > The function above has a correct semantics only when the ordering of the
> > if statement is strictly observed.
> > 
> > Now, since we don't have any data dependency on the multiple if cases,
> > are we sure an overzealous compiler will never come up with some
> > "optimized reordering" of the checks required?
> > 
> > IOW, if the compiler could scramble the checks on an optimization, we
> > would get a wrong semantics which is also very difficult do debug.
> > Hence the idea to use READ_ONCE, to both tell the compiler to not
> > even attempt reordering those checks and also to better document the
> > code about the importance of the ordering on those checks.
> > 
> > Is now more clear? Does that makes sense?
> 
> I can undertand what your worries. But I'm not sure is it really needed.
> If there is no other concern I can add it.

I too don't think the compiler has a power to do such an optimization. It must
preserve the order of the checks even if it found a more efficient way to
perform them.

Thanks

--
Qais Yousef
