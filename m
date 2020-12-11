Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1C2D7667
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406089AbgLKNSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:18:21 -0500
Received: from foss.arm.com ([217.140.110.172]:56648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404965AbgLKNRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:17:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E341FB;
        Fri, 11 Dec 2020 05:16:45 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9277F3F68F;
        Fri, 11 Dec 2020 05:16:43 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:16:38 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, qais.yousef@arm.com,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH 2/2] workqueue: Fix affinity of kworkers attached during
 late hotplug
Message-ID: <20201211131638.GA142813@e120877-lin.cambridge.arm.com>
References: <20201210163830.21514-1-valentin.schneider@arm.com>
 <20201210163830.21514-3-valentin.schneider@arm.com>
 <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
 <jhjo8j0tsia.mognet@arm.com>
 <jhjmtyktri8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjmtyktri8.mognet@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 01:13:35PM +0000, Valentin Schneider wrote:
> On 11/12/20 12:51, Valentin Schneider wrote:
> >> In that case maybe we should check for the cpu_active_mask here too ?
> >
> > Looking at it again, I think we might need to.
> >
> > IIUC you can end up with pools bound to a single NUMA node (?). In that
> > case, say the last CPU of a node is going down, then:
> >
> >   workqueue_offline_cpu()
> >     wq_update_unbound_numa()
> >       alloc_unbound_pwq()
> >         get_unbound_pool()
> >
> > would still pick that node, because it doesn't look at the online / active
> > mask. And at this point, we would affine the
> > kworkers to that node, and we're back to having kworkers enqueued on a
> > (!active, online) CPU that is going down...
> 
> Assuming a node covers at least 2 CPUs, that can't actually happen per
> is_cpu_allowed().

Yes indeed, my bad, no problem here.
