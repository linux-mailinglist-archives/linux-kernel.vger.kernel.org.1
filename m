Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C159F2FBE90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbhASSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:06:54 -0500
Received: from foss.arm.com ([217.140.110.172]:42292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbhASRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:43:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 134BE139F;
        Tue, 19 Jan 2021 09:42:48 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106403F66E;
        Tue, 19 Jan 2021 09:42:46 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:42:44 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is
 pinned
Message-ID: <20210119174244.3p2graxd5gonv4di@e107158-lin>
References: <20210119120755.2425264-1-qais.yousef@arm.com>
 <YAb8XGyp3NtrHl+U@google.com>
 <20210119164027.drfpmrol3xhf4ckc@e107158-lin>
 <YAcO9HHHVBx7oBG/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAcO9HHHVBx7oBG/@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/21 16:55, Quentin Perret wrote:
> On Tuesday 19 Jan 2021 at 16:40:27 (+0000), Qais Yousef wrote:
> > On 01/19/21 15:35, Quentin Perret wrote:
> > > Do you mean failing the sched_setaffinity syscall if e.g. the task
> > > has a min clamp that is higher than the capacity of the CPUs to which it
> > > will be pinned? If so, I'm not sure if we really want that.
> > 
> > No. In Android for instance, I'm worried a background task affined to little
> > cores that has a utilization > capacity_of(little) will trigger the same
> > problem. It'll be affined to more than just 1 cpu, but none of the little cpus
> > will actually fit.
> > 
> > Makes sense?
> 
> Now yes.
> 
> I agree this may be a real problem, but capacity_of() very much is a
> per-CPU thing, because of RT pressure and such, and that is not a static
> thing by any mean. So, even if the task doesn't fit on any CPU _now_ we
> might still want to mark it misfit, just so it can be picked up by a
> potential idle balance on another CPU later on. Maybe capacity_orig_of
> would be preferable?

Hmm IIUC you want to still tag it as misfit so it'll be balanced within the
little cores in case there's another core with more spare capacity, right?

This needs more thinking. Misfit doesn't seem the right mechanism to handle
this. If there are multiple tasks crammed on the same CPU, then we should try
to distribute yes. If it is the only task I can't see this being useful unless
the pressure is very high. Which could be an indication of another problem in
the system..

Thanks

--
Qais Yousef
