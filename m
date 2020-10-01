Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD62804D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgJARMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:12:45 -0400
Received: from foss.arm.com ([217.140.110.172]:40466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732787AbgJARMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:12:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0962B1042;
        Thu,  1 Oct 2020 10:12:38 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 248A63F6CF;
        Thu,  1 Oct 2020 10:12:36 -0700 (PDT)
Date:   Thu, 1 Oct 2020 18:12:30 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: [PATCH 5/9] sched/hotplug: Consolidate task migration on CPU
 unplug
Message-ID: <20201001171138.GA299736@e120877-lin.cambridge.arm.com>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.644634229@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921163845.644634229@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 06:36:02PM +0200, Peter Zijlstra wrote:

[...]

> +
> +     [CPUHP_AP_SCHED_WAIT_EMPTY] = {
> +             .name                   = "sched:waitempty",
> +             .startup.single         = NULL,
> +             .teardown.single        = sched_cpu_wait_empty,
> +     },
> +
>       /* Handle smpboot threads park/unpark */

Unless I missed something, now that the wait has its own HP step, this
patch can probably also get rid of the balance_hotplug_wait() in
sched_cpu_deactivate() introduced by: 

  [PATCH 4/9] sched/core: Wait for tasks being pushed away on hotplug

-- 
Vincent
