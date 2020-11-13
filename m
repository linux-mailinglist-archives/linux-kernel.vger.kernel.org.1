Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5562B1B18
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgKMM0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:26:37 -0500
Received: from foss.arm.com ([217.140.110.172]:37258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgKMM0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:26:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F29142F;
        Fri, 13 Nov 2020 04:26:35 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D763F6CF;
        Fri, 13 Nov 2020 04:26:34 -0800 (PST)
Date:   Fri, 13 Nov 2020 12:26:32 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201113122632.jydnt2o7ipp4ntli@e107158-lin.cambridge.arm.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201110122108.GG2594@hirez.programming.kicks-ass.net>
 <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
 <20201112144131.7gqglj435bs6otwm@e107158-lin.cambridge.arm.com>
 <dd1e4632-5f1f-e493-8dcf-2de7468fb53f@arm.com>
 <131cb7b5-e400-11e1-8fc1-b6e8183f1a8d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <131cb7b5-e400-11e1-8fc1-b6e8183f1a8d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 12:45, Dietmar Eggemann wrote:
> On 12/11/2020 17:01, Dietmar Eggemann wrote:
> > On 12/11/2020 15:41, Qais Yousef wrote:
> >> On 11/11/20 18:41, Dietmar Eggemann wrote:
> >>> On 10/11/2020 13:21, Peter Zijlstra wrote:
> >>>> On Tue, Nov 03, 2020 at 10:37:56AM +0800, Yun Hsiang wrote:
> 
> [...]
> 
> >> If you or Yun would still like to send the patch to protect
> >> SCHED_FLAG_UTIL_CLAMP and SCHED_FLAG_ALL with __kernel__ that'd be great.
> > 
> > Ah yes! Can add an extra patch for this when sending out the next version.
> 
> On second thought, why should we risk a change in UAPI? Since we're now
> not introducing a new flag the meaning of SCHED_FLAG_ALL or
> SCHED_FLAG_UTIL_CLAMP won't change.

It's a judgement call. Hide them now where it's likely there are no users and
hope we won't have to revert it. Or just ignore it and treat it as an ABI and
make sure no one change them later.

My judgement call it's better to introduce the __kernel__ while we can. But
I can't say for sure nothing will break. All I know it'd be easy to revert if
it does cause breakage.

You get to choose :-)

Thanks

--
Qais Yousef
