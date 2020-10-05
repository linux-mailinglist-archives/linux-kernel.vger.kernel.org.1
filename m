Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34228316F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJEIFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEIFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:05:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:05:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dt13so1174580ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yzyDdyQdfmfcye8jOjz2zOKzbZtAhYoUBBiOMnzMJnI=;
        b=QpmDh47ZptXqOyxcRB6BNAqIbj4BVSK0Y0RQxnzKYZu+apEMXpEc2bXAgmPZhsg+OE
         Esnifd2MF89xHGo7SemEDbMaDaejPNBeXcg5Z71FEdsLi36tkCsTCbvHCDKw6ftkeG0P
         +dNlaF0UVpmOJCvGnNGrXmJULkg86EsdK/g46t9QgFj1M6IBQ3+h6/+mi4llS2mG/f1z
         ctKVI61TKoYctsdvd4iUxZF6HIqcO8Hw0MFime9hOicWL2/QKb2wCASKw7nZEIGGnHm5
         ZzFP2yp+xC92GsMNXKLpVVyDR/JFM8OE99hIQGLp83/IuOd5qcIGH3bhFVmjcYZzOGxy
         EvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yzyDdyQdfmfcye8jOjz2zOKzbZtAhYoUBBiOMnzMJnI=;
        b=MMhn3bNgo3cuzYYImo8w3znSyyFs4hasDOBRDLn8ck2lnzYuh/eLqilQI3QpAc9zrv
         nOJ3iYKFofxjDJF9tZO0GHWLURsqf6XCZqid+t+ExJ6oRaY9wtrf+XRa0f1nMIE0VTYv
         fwkWM2OKNwmZTuLIP8FxcENO3wKKyEdcVgP7GWjVX8J/gimJdZ66XtbZPV3PHNufbuRr
         r8/pPQK8V52G2Xo0YZlUlfdNXiCD7PhpJQ+nXy9IMa1jZ4C5jRwvcbd4JB23PUb0itSa
         M3Ch3so33E51lW0IBjuA7EoRBIEgtjP6QA9kjLCVcXcy/obIojUThg94BGFJ+Z7IbBvx
         dkRg==
X-Gm-Message-State: AOAM532lAT90/cf9DkEHIHIjPZkcfyd2dzv93X6WEYGMIoCfCk39WqkD
        cSx4zotgWYLyTLaYkKAMX6A=
X-Google-Smtp-Source: ABdhPJzcuBEaPS8c7LdvWvuxsE/k2aAozTjGmanmxaw3IbLNcn6v1mRRTSLlByU9OO/o2AqTb3zKgQ==
X-Received: by 2002:a17:906:118f:: with SMTP id n15mr8653433eja.394.1601885099874;
        Mon, 05 Oct 2020 01:04:59 -0700 (PDT)
Received: from gmail.com (563B83F3.dsl.pool.telekom.hu. [86.59.131.243])
        by smtp.gmail.com with ESMTPSA id t16sm7467954eje.39.2020.10.05.01.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:04:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Oct 2020 10:04:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20201005080456.GA3521702@gmail.com>
References: <20201004132716.GS393@shao2-debian>
 <20201004162108.GC3165@suse.de>
 <20201005065101.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005065101.GE2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Oct 04, 2020 at 05:21:08PM +0100, Mel Gorman wrote:
> > On Sun, Oct 04, 2020 at 09:27:16PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -30.8% regression of netperf.Throughput_Mbps due to commit:
> > > 
> > > 
> > > commit: fcf0553db6f4c79387864f6e4ab4a891601f395e ("sched/fair: Remove meaningless imbalance calculation")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > 
> > This commit was the start of a series that made large changes to load
> > balancing.  The series was not bisect-safe and has since been reconciled
> > with the NUMA balancing. Any workload with a potential load balancing
> > problem has to be checked against the latest kernel to see if the problem
> > persists there. If it does, then tip/sched/core should be checked or
> > 5.10-rc1 when it comes out as tip has a few more LB changes pending.
> 
> What Mel said ;-)

Basically it would be nice to test either the following commit directly 
(which is the latest relevant sched/core commit):

   233e7aca4c8a: ("sched/fair: Use dst group while checking imbalance for NUMA balancer")

Or a -next version that includes these commits.

Thanks,

	Ingo
