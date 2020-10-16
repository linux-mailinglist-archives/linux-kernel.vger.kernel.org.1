Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15D1290AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbgJPRu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:50:57 -0400
Received: from foss.arm.com ([217.140.110.172]:41838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732453AbgJPRu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:50:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C66ED13D5;
        Fri, 16 Oct 2020 10:50:55 -0700 (PDT)
Received: from bogus (unknown [10.57.17.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501203F71F;
        Fri, 16 Oct 2020 10:50:54 -0700 (PDT)
Date:   Fri, 16 Oct 2020 18:50:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        jbrunet@baylibre.com, ionela.voinescu@arm.com,
        khilman@baylibre.com, da@libre.computer,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] mailbox: avoid timer start from callback
Message-ID: <20201016175039.7xs4cafoe2uq7zus@bogus>
References: <20201016173020.12686-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016173020.12686-1-jassisinghbrar@gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:30:20PM -0500, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> If the txdone is done by polling, it is possible for msg_submit() to start
> the timer while txdone_hrtimer() callback is running. If the timer needs
> recheduling, it could already be enqueued by the time hrtimer_forward_now()
> is called, leading hrtimer to loudly complain.
> 
> WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
> CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
> Hardware name: Libre Computer AML-S805X-AC (DT)
> Workqueue: events_freezable_power_ thermal_zone_device_check
> pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> pc : hrtimer_forward+0xc4/0x110
> lr : txdone_hrtimer+0xf8/0x118
> [...]
> 
> This can be fixed by not starting the timer from the callback path. Which
> requires the timer reloading as long as any message is queued on the
> channel, and not just when current tx is not done yet.
>

I came to similar conclusion and was testing something similar. You bet
me. Since we have single timer and multiple channels, each time a message
is enqueued on any channel, timer gets added which is wrong.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

I tested this patch too by reverting offending commit in -next, so

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

You seem to have dropped the Fixes tags. Is that intentional ? If so,
any particular reasons. I think it is stable material and better to have
fixes tag so that it gets added to stable trees.

--
Regards,
Sudeep
