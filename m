Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907DF2F10BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbhAKLCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbhAKLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:02:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F0C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sjTOx309UH9UDea/ED/bGaya+96NK69HIN+kQy3fME8=; b=eoa2vyzpVfl2RPp1L93PIPkt6C
        UP06p38X1n2E+p/mOzbUShPo/OGdmCGT8//o2zW1utYbEyHzic3q+paKnGbUO/xPli3k2+isn0LV9
        H7+MftkuJenmDuo7IrpfQlHQkx0XjbIy5fOLG59euCN/VOHAfPzwmGOILBeq9pu7p/to09aG5GiiO
        mfM0MdOjFCJF2hWt3Rts2vG6cFJbF55F+tmYI4AHlxVCvJX7t5tMKP1VgUzJmgVzMolV7Qu17ea3F
        8QyMk9if+/CdsPjcXucMQsQEB0rFJtyecHX6APH0Y3f4JOZLfGApb67WwJgigOjBSLfad5s4SWTcC
        zIzJLelg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kyuwc-0036rc-KG; Mon, 11 Jan 2021 11:01:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72E61304E03;
        Mon, 11 Jan 2021 12:01:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 198A02016280A; Mon, 11 Jan 2021 12:01:03 +0100 (CET)
Date:   Mon, 11 Jan 2021 12:01:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:07:34AM +0100, Thomas Gleixner wrote:
> On Fri, Jan 08 2021 at 12:46, Peter Zijlstra wrote:
> > On Sat, Dec 26, 2020 at 10:51:08AM +0800, Lai Jiangshan wrote:
> >> From: Lai Jiangshan <laijs@linux.alibaba.com>
> >> 
> >> 06249738a41a ("workqueue: Manually break affinity on hotplug")
> >> said that scheduler will not force break affinity for us.
> >
> > So I've been looking at this the past day or so, and the more I look,
> > the more I think commit:
> >
> >   1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
> >
> > is a real problem and we need to revert it (at least for now).
> >
> > Let me attempt a brain dump:
> >
> >  - the assumption that per-cpu kernel threads are 'well behaved' on
> >    hot-plug has, I think, been proven incorrect, it's far worse than
> >    just bounded workqueue. Therefore, it makes sense to provide the old
> >    semantics.
> 
> I disagree. Per-cpu kernel threads which are magically stopped during
> hotplug and then migrated to a random other CPU are just wrong.
> 
> We really need to fix that and not proliferate the sloppy and ill
> defined behaviour.

Well yes, but afaict the workqueue stuff hasn't been settled yet, and
the rcutorture patch Paul did was just plain racy and who knows what
other daft kthread users are out there. That and we're at -rc3.

So I'm really tempted to revert for now and try again later.
