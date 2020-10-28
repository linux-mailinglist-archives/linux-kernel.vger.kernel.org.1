Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D634429D6AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgJ1WRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:17 -0400
Received: from foss.arm.com ([217.140.110.172]:39542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbgJ1WRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2207C175D;
        Wed, 28 Oct 2020 04:39:47 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558AE3F719;
        Wed, 28 Oct 2020 04:39:46 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:39:43 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Yun Hsiang <hsiang023167@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201028113943.7jzxbytizrv7wsm3@e107158-lin>
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
 <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
 <20201027155813.GA818508@ubuntu>
 <87v9eumzic.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9eumzic.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 11:11, Patrick Bellasi wrote:
> >>  
> >>  		/*
> >>  		 * RT by default have a 100% boost value that could be modified
> >>  		 * at runtime.
> >>  		 */
> >>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> >> -			__uclamp_update_util_min_rt_default(p);
> >> +			value = sysctl_sched_uclamp_util_min_rt_default;
> 
> By removing this usage of __uclamp_updadate_util_min_rt_default(p),
> the only other usage remaining is the call from:
>    uclamp_udpate_util_min_rt_default().
> 
> What about an additional cleanup by in-lining the only surviving usage?

This is not a cleanup IMO. There is special rule about updating that are
encoded and documented in this helper function. Namely:

	* p->pi_lock must be held.
	* p->uclamp_req[].user_defined must be false.

I don't see open coding helps but rather makes the code harder to read and
prone to introduce bugs if anything gets reshuffled in the future.

Thanks

--
Qais Yousef
