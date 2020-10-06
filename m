Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12885284C96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgJFNdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:33:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CCAC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4EuFqx5BLHnEuSbZbHwwDASDoQ4qTKYnpBwSKictmrY=; b=AGTkU6WVtH4G/hfGMJ++W8Kjl/
        CVScfS1tqrv226bmMp7gKBb/dMEFSL3XrPXJR5TSonuWQwK7bjCDyRRAzHdhesvXfcFA7PAFiTI4j
        jfPxX9QJxVPp1AY8jNjY6Am6ptCY//sL3B1VxIcUlxZAoH4GX0ZQYyWfW+6+voD8UCEZujk3MOavw
        2z5VXanODbGfohkpgpGqtBCvYPIOAqfdyUYx4BUSXUplekV11Gy8HLshVpZlvlJcG2i9bIdIXV6HA
        0iSUAZKQ+ZAxHX8d3MU3BruREDcDEMP4M9AWHEelzDgEwO+U0y2AcmlYuY4Rs3/J4t4Tz4rGe5FJO
        IXRs+AUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPn5c-0000sL-AQ; Tue, 06 Oct 2020 13:33:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91CF73019CE;
        Tue,  6 Oct 2020 15:33:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7543B20244ED7; Tue,  6 Oct 2020 15:33:09 +0200 (CEST)
Date:   Tue, 6 Oct 2020 15:33:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -v2 07/17] sched: Fix hotplug vs CPU bandwidth control
Message-ID: <20201006133309.GU2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150921.661842442@infradead.org>
 <CAKfTPtDr+pOxEninW5m_R6bKPWqwpFYsrHVLcQ-LimLvk3hDAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDr+pOxEninW5m_R6bKPWqwpFYsrHVLcQ-LimLvk3hDAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:46:28PM +0200, Vincent Guittot wrote:

> > @@ -6993,6 +6995,14 @@ int sched_cpu_deactivate(unsigned int cp
> >
> >         balance_push_set(cpu, true);
> >
> > +       rq_lock_irqsave(rq, &rf);
> > +       if (rq->rd) {
> > +               update_rq_clock();
> 
> Tried to compile but rq parameter is missing

Damn :/, I'm sure I fixed that. must've lost a refresh before sending.
