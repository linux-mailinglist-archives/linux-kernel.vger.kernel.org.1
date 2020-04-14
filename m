Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2011A84DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391599AbgDNQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391585AbgDNQ2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:28:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F182075E;
        Tue, 14 Apr 2020 16:28:12 +0000 (UTC)
Date:   Tue, 14 Apr 2020 12:28:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] cpumask: Convert cpumask_any_but() to the new
 random function
Message-ID: <20200414122810.4b83ddd2@gandalf.local.home>
In-Reply-To: <20200414150556.10920-4-qais.yousef@arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
        <20200414150556.10920-4-qais.yousef@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 16:05:55 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> +int cpumask_any_but(const struct cpumask *srcp, unsigned int cpu)
> +{
> +	unsigned int i;
> +
> +	cpumask_check(cpu);
> +
> +	for_each_cpu(i, srcp) {
> +		i = cpumask_any(srcp);

Hmm, if the current CPU is the last CPU in the mask, and cpumask_any()
happens to return it, what happens?

> +		if (i != cpu)
> +			return i;

We loop again, and wouldn't i being the last CPU in the mask cause this
loop to exit, and return nr_cpu_ids?

-- Steve

> +	}
> +
> +	return nr_cpu_ids;
> +}
