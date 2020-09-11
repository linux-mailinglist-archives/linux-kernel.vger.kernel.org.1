Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9991D2667A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgIKRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgIKM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:29:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD31CC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qTJ9qYDYwWWCnoAj1TvImcLaoBAdOnFO4RHFFxDwY7k=; b=NZxja/Dwp664juq26ZQ9uWU+Bj
        dSc34IAEX6X3SgrUbye1RyHf/vS/UszYISwWWIt8ERcV8M+LQfnqsZYolZzO+/03C5leX3CHcrM2e
        YMgoK3Cec0ya+QBd47IpjoYJhSTv+zKc3sPOFdHPBPNtECy1Ouvp5Hr2JRwoMeK4/jsVGkRfHnU41
        kq94W3f0it9URmgy7abmzxo8Sp5Lnu59dpKjMs57xp0byozaJTP7fjZJAaqe8dTF24czYisGmJQ6l
        Wcg3Pd4LNdDNk0ZXPUNn/40GoTXoVwin8GKmOCN+34H5KAP58DLmdjfCaWVhI8ovl2V3CgIbblCzc
        shwdTiqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGiB9-0001yr-V1; Fri, 11 Sep 2020 12:29:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B88DA3003D8;
        Fri, 11 Sep 2020 14:29:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EBBB2B082748; Fri, 11 Sep 2020 14:29:22 +0200 (CEST)
Date:   Fri, 11 Sep 2020 14:29:22 +0200
From:   peterz@infradead.org
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        Vincent Donnefort <Vincent.Donnefort@arm.com>
Subject: Re: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
Message-ID: <20200911122922.GJ1362448@hirez.programming.kicks-ass.net>
References: <20200911081745.214686199@infradead.org>
 <20200911082536.528661716@infradead.org>
 <jhjr1r85wye.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjr1r85wye.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 01:17:45PM +0100, Valentin Schneider wrote:

> > @@ -6968,6 +7064,8 @@ int sched_cpu_deactivate(unsigned int cp
> >        */
> >       synchronize_rcu();
> >
> > +	balance_push_set(cpu, true);
> > +
> 
> IIUC this is going to make every subsequent finish_lock_switch()
> migrate the switched-to task if it isn't a pcpu kthread. So this is going
> to lead to a dance of
> 
> switch_to(<task0>) -> switch_to(<stopper>) -> switch_to(<task1>) -> switch_to(<stopper>) ...
> 
> Wouldn't it be better to batch all those in a migrate_tasks() sibling that
> skips pcpu kthreads?

That's 'difficult', this is hotplug, performance is not a consideration.

Basically we don't have an iterator for the runqueues, so finding these
tasks is hard.
