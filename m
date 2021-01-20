Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFA2FCFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbhATMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:18:41 -0500
Received: from foss.arm.com ([217.140.110.172]:58402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732790AbhATL63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:58:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B153D6E;
        Wed, 20 Jan 2021 03:57:42 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B0213F66E;
        Wed, 20 Jan 2021 03:57:41 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:57:39 +0000
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
Message-ID: <20210120115739.ohe4l2c3ed72suk3@e107158-lin>
References: <20210119120755.2425264-1-qais.yousef@arm.com>
 <YAb8XGyp3NtrHl+U@google.com>
 <20210119164027.drfpmrol3xhf4ckc@e107158-lin>
 <YAcO9HHHVBx7oBG/@google.com>
 <20210119174244.3p2graxd5gonv4di@e107158-lin>
 <YAcb3vUFovqz1gCL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAcb3vUFovqz1gCL@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/21 17:50, Quentin Perret wrote:
> On Tuesday 19 Jan 2021 at 17:42:44 (+0000), Qais Yousef wrote:
> > Hmm IIUC you want to still tag it as misfit so it'll be balanced within the
> > little cores in case there's another core with more spare capacity, right?
> 
> Well yes but that's just a special case. But even you have big CPUs in
> the affinity mask, you may find that the task fits on none of the CPUs
> because they're currently under pressure. But in this case, you may
> still want to mark the task as misfit because being under pressure may
> be a relatively transient state.

Okay. So your thoughts are that if the utilization is above capacity_orig_of()
then marking it as misfit is meaningless (taking into account the cpus it is
affined to). Which I agree with. But if it is less than capacity_orig_of() but
doesn't fit because of pressure ie:

	util <= capacity_orig_of(cpu) && util > capacity_of(cpu)

then we should mark it as misfit as it currently does. I think this makes sense
too. There's the margin to consider in the mix here too. And util clamp
effects. And the fact this gets called from pick_next_task_fair() which is
a hot path :-)

Unless someone else beats me to it, I'll send a patch eventually :-)

Thanks

--
Qais Yousef
