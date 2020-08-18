Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9F248DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHRSLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 14:11:33 -0400
Received: from foss.arm.com ([217.140.110.172]:46846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHRSL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:11:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E336631B;
        Tue, 18 Aug 2020 11:11:28 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2F913F6CF;
        Tue, 18 Aug 2020 11:11:27 -0700 (PDT)
Date:   Tue, 18 Aug 2020 19:11:20 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200818181120.GA297937@e120877-lin.cambridge.arm.com>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
 <20200727123801.GJ119549@hirez.programming.kicks-ass.net>
 <20200727152303.GA301827@e120877-lin.cambridge.arm.com>
 <20200728111302.GV119549@hirez.programming.kicks-ass.net>
 <20200728120027.GN43129@hirez.programming.kicks-ass.net>
 <20200728195320.GA426859@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728195320.GA426859@e120877-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

[...]

> > > 
> > > How about something like:
> > > 
> > > #ifdef CONFIG_64BIT
> > > 
> > > #define DEFINE_U64_U32(name)	u64 name
> > > #define u64_u32_load(name)	name
> > > #define u64_u32_store(name, val)name = val
> > > 
> > > #else
> > > 
> > > #define DEFINE_U64_U32(name)			\
> > > 	struct {				\
> > > 		u64 name;			\
> > > 		u64 name##_copy;		\
> > > 	}
> > > 
> > > #define u64_u32_load(name)			\
> > > 	({					\
> > > 		u64 val, copy;			\
> > > 		do {				\
> > > 			val = name;		\
> > > 			smb_rmb();		\
> > > 			copy = name##_copy;	\
> > > 		} while (val != copy);		\
> > 
> > wrong order there; we should first read _copy and then the regular one
> > of course.
> > 
> > > 		val;
> > > 	})
> > > 
> > > #define u64_u32_store(name, val)		\
> > > 	do {					\
> > > 		typeof(val) __val = (val);	\
> > > 		name = __val;			\
> > > 		smp_wmb();			\
> > > 		name##_copy = __val;		\
> > > 	} while (0)
> > > 
> > > #endif
> > 
> > The other approach is making it a full type and inline functions I
> > suppose.
> 
> I didn't pick this approach originally, as I thought it would be way too
> invasive. If the API looks way cleaner, it nonetheless doesn't match
> last_update_time usage. The variable is declared in sched_avg while its copy
> is in struct cfs_rq.
> 
> Moving the copy in sched_avg would mean:
> 
>  * Setting the copy for all struct sched_avg in ___update_load_sum(), instead
>    of just the cfs_rq.avg in update_cfs_rq_load_avg().
> 
>  * Having the DEFINE_U64_U32 declaration in include/linux/sched.h to cover
>    struct sched_avg.

Gentle ping

