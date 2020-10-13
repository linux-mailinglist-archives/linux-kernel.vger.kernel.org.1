Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1C28CF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgJMNcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:32:51 -0400
Received: from foss.arm.com ([217.140.110.172]:59998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbgJMNcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:32:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 203771FB;
        Tue, 13 Oct 2020 06:32:50 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55BB03F719;
        Tue, 13 Oct 2020 06:32:49 -0700 (PDT)
Date:   Tue, 13 Oct 2020 14:32:46 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, dietmar.eggemann@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201013133246.cjomufo5q7qsocrn@e107158-lin>
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <87blh6iljc.derkling@matbug.net>
 <20201013102951.orcr6m4q2cb7y6zx@e107158-lin>
 <875z7eic14.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875z7eic14.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 13:46, Patrick Bellasi wrote:
> > So IMO you just need a single SCHED_FLAG_UTIL_CLAMP_RESET that if set in the
> > attr, you just execute that loop in __setscheduler_uclamp() + reset
> > uc_se->user_defined.
> >
> > It should be invalid to pass the SCHED_FLAG_UTIL_CLAMP_RESET with
> > SCHED_FLAG_UTIL_CLAMP_MIN/MAX. Both have contradictory meaning IMO.
> > If user passes both we should return an EINVAL error.
> 
> Passing in  _CLAMP_RESET|_CLAMP_MIN will mean reset the min value while
> keeping the max at whatever it is. I think there could be cases where
> this support could be on hand.

I am not convinced personally. I'm anxious about what this fine grained control
means and how it should be used. I think less is more in this case and we can
always relax the restriction (appropriately) later if it's *really* required.

Particularly the fact that this user_defined is per uclamp_se and that it
affects the cgroup behavior is implementation details this API shouldn't rely
on. A generic RESET my uclamp settings makes more sense for me as a long term
API to maintain.

Actually maybe we should even go for a more explicit
SCHED_FLAG_UTIL_CLAMP_INHERIT_CGROUP flag instead. If we decide to abandon the
support for this feature in the future, at least we can make it return an error
without affecting other functionality because of the implicit nature of
SCHED_FLAG_UTIL_CLAMP_RESET means inherit cgroup value too.

That being said, I am not strongly against the fine grained approach if that's
what Yun wants now or what you both prefer. I just think the name of the flag
needs to change to be more explicit too then.

It'd be good to hear what others think.

Cheers

--
Qais Yousef
