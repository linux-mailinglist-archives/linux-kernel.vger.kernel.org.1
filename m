Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD782F8DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbhAPRMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbhAPRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC825C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W+j2/cC9bO7SVefvsAQf2Xue8XA7j4g2ZxW25x/Tkm8=; b=C8YsHjSo1Cgwr5G0ikVnOuumCd
        EX9SFualxezBIeCMruNTzdiaMw1vYpgM6YhNHjwmkpRLKoF1vyu+l7K0KizUCmolkNzeUl3bEvOss
        JgroXrBjQjPlJ7ES3TJZ2M84Ebyj34TKV2XRgj1tmYbVNSzMZ/d92gdgBHpW+gypGvTohp56E2GpM
        Kf5xllvUc0f8PWiCOKLRyNe7Xkx1hUcJATavysxSXZbQ30XTQ46KSjDw/0cIqaikedcH7RB3I/Met
        sd3L44x4wGA0oRFS0cSO4CHJOIEGAv9ivGMjKMAHS2fRto9qZLvrejqoOuYDShIWYCrQFCcUzmes1
        6kfSOc5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0nGW-00AOLR-00; Sat, 16 Jan 2021 15:13:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04CE33010CF;
        Sat, 16 Jan 2021 16:13:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E633D20299B4E; Sat, 16 Jan 2021 16:13:20 +0100 (CET)
Date:   Sat, 16 Jan 2021 16:13:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <YAMCkDx9BjA9w+mg@hirez.programming.kicks-ass.net>
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
 <jhjlfcvhcx5.mognet@arm.com>
 <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net>
 <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
 <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 01:45:23PM +0100, Peter Zijlstra wrote:
> On Sat, Jan 16, 2021 at 02:27:09PM +0800, Lai Jiangshan wrote:

> > I feel nervous to use kthread_park() here and kthread_parkme() in
> > worker thread.  And adding kthread_should_park() to the fast path
> > also daunt me.
> 
> Is that really such a hot path that an additional load is problematic?

I think we can remove it. It would mean the kthread_park() from the
online callback will take a bit longer, as it will have to wait for all
the works to complete, but that should not be a fundamental problem.
