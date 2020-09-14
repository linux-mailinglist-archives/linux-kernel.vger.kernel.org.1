Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D32690B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgINPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:54:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgINPvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:51:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 867E7ADC2;
        Mon, 14 Sep 2020 15:51:17 +0000 (UTC)
Date:   Mon, 14 Sep 2020 16:50:59 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     peterz@infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        pauld@redhat.com
Subject: Re: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
Message-ID: <20200914155059.GF3117@suse.de>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914114202.GQ1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200914114202.GQ1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 01:42:02PM +0200, peterz@infradead.org wrote:
> On Mon, Sep 14, 2020 at 12:03:36PM +0200, Vincent Guittot wrote:
> > Vincent Guittot (4):
> >   sched/fair: relax constraint on task's load during load balance
> >   sched/fair: reduce minimal imbalance threshold
> >   sched/fair: minimize concurrent LBs between domain level
> >   sched/fair: reduce busy load balance interval
> 
> I see nothing objectionable there, a little more testing can't hurt, but
> I'm tempted to apply them.
> 
> Phil, Mel, any chance you can run them through your respective setups?

They're queued but the test grid is backlogged at the moment. It'll be
a few days before the tests complete.

-- 
Mel Gorman
SUSE Labs
