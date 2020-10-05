Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F200283075
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJEGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgJEGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:51:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CEC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 23:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cYk7Obp2ahObSK3QU4wsH0HwLm9yxaSVt/cZVZIJRRg=; b=Egux96ObWB5/g7c2+G+4yqlRkL
        V05Rlh4LYcf8wi0KbCTnyvpS/wxR3IyM1OREFZHPAK/HbTCLZv6BpnHNM66UUd3KAQPIsagDjcGss
        dr0G5c+DFHV+N6suh4eiB8uafFPbaX8uhzXweHsZMvxpMfzV5YbyZRJfN8DiAdl2VMVGwznQERQs+
        hDN+kNXr/CQLR4G+hvffXjuwnCA5UV4DAkIIR75IUiXhM/O4JtAJ3zDYsoVcJDQG2pQjgIrtjFcNJ
        1MUfCZXco40kE6LajhYaEBmxnnxsGrGjpPPGkeNaiLAhD1azd3bt/szW3su3ds0usHJlkdJEAnEfl
        AS+ajliQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPKKt-0002Te-FW; Mon, 05 Oct 2020 06:51:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0AB130377D;
        Mon,  5 Oct 2020 08:51:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEFCC29E463CA; Mon,  5 Oct 2020 08:51:01 +0200 (CEST)
Date:   Mon, 5 Oct 2020 08:51:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair] fcf0553db6: netperf.Throughput_Mbps -30.8%
 regression
Message-ID: <20201005065101.GE2628@hirez.programming.kicks-ass.net>
References: <20201004132716.GS393@shao2-debian>
 <20201004162108.GC3165@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004162108.GC3165@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 05:21:08PM +0100, Mel Gorman wrote:
> On Sun, Oct 04, 2020 at 09:27:16PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -30.8% regression of netperf.Throughput_Mbps due to commit:
> > 
> > 
> > commit: fcf0553db6f4c79387864f6e4ab4a891601f395e ("sched/fair: Remove meaningless imbalance calculation")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> 
> This commit was the start of a series that made large changes to load
> balancing.  The series was not bisect-safe and has since been reconciled
> with the NUMA balancing. Any workload with a potential load balancing
> problem has to be checked against the latest kernel to see if the problem
> persists there. If it does, then tip/sched/core should be checked or
> 5.10-rc1 when it comes out as tip has a few more LB changes pending.

What Mel said ;-)
