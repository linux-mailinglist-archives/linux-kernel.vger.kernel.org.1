Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83122D765A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436729AbgLKNOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:14:52 -0500
Received: from foss.arm.com ([217.140.110.172]:56456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436713AbgLKNOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:14:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E5F1FB;
        Fri, 11 Dec 2020 05:13:39 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8864D3F68F;
        Fri, 11 Dec 2020 05:13:37 -0800 (PST)
References: <20201210163830.21514-1-valentin.schneider@arm.com> <20201210163830.21514-3-valentin.schneider@arm.com> <20201211113920.GA75974@e120877-lin.cambridge.arm.com> <jhjo8j0tsia.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, qais.yousef@arm.com,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH 2/2] workqueue: Fix affinity of kworkers attached during late hotplug
In-reply-to: <jhjo8j0tsia.mognet@arm.com>
Date:   Fri, 11 Dec 2020 13:13:35 +0000
Message-ID: <jhjmtyktri8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 12:51, Valentin Schneider wrote:
>> In that case maybe we should check for the cpu_active_mask here too ?
>
> Looking at it again, I think we might need to.
>
> IIUC you can end up with pools bound to a single NUMA node (?). In that
> case, say the last CPU of a node is going down, then:
>
>   workqueue_offline_cpu()
>     wq_update_unbound_numa()
>       alloc_unbound_pwq()
>         get_unbound_pool()
>
> would still pick that node, because it doesn't look at the online / active
> mask. And at this point, we would affine the
> kworkers to that node, and we're back to having kworkers enqueued on a
> (!active, online) CPU that is going down...

Assuming a node covers at least 2 CPUs, that can't actually happen per
is_cpu_allowed().
