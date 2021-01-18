Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E459E2F9D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbhARK7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:59:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:55342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389410AbhARK6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:58:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3588B1C1;
        Mon, 18 Jan 2021 10:57:59 +0000 (UTC)
Date:   Mon, 18 Jan 2021 10:57:57 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Remove redundant sched_numa_balancing check.
Message-ID: <20210118105757.GA20777@suse.de>
References: <20210118103218.204373-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210118103218.204373-1-imran.f.khan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:32:18PM +1100, Imran Khan wrote:
> task_numa_fault is invoked from do_numa_page/do_huge_pmd_numa_page,
> for task_numa_work induced memory faults. task_numa_work is scheduled
> from task_tick_numa which is invoked only if sched_numa_balancing
> is true.
> 
> So task_numa_fault will not get invoked if sched_numa_balancing is
> false and hence we can avoid checking it again in task_numa_fault.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

If NUMA balancing is disabled at runtime, there may still be PTEs that
are marked for NUMA balancing. While these still get handled at fault,
there is no point tracking the fault information in task_numa_fault and
this function can still get called after sched_numa_balancing is
disabled.

-- 
Mel Gorman
SUSE Labs
