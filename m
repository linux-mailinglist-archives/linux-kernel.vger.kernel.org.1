Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D92F653F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbhANPxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:53:54 -0500
Received: from foss.arm.com ([217.140.110.172]:52032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbhANPxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:53:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8F6ED1;
        Thu, 14 Jan 2021 07:53:08 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BA903F70D;
        Thu, 14 Jan 2021 07:53:06 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH] sched/core: Print out straggler tasks in sched_cpu_dying()
In-Reply-To: <20210114152207.GI2743@paulmck-ThinkPad-P72>
References: <20210113183141.11974-1-valentin.schneider@arm.com> <20210113220244.GC2743@paulmck-ThinkPad-P72> <jhjft34z84j.mognet@arm.com> <20210114003613.GD2743@paulmck-ThinkPad-P72> <jhjczy7ztw0.mognet@arm.com> <20210114152207.GI2743@paulmck-ThinkPad-P72>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Jan 2021 15:52:56 +0000
Message-ID: <jhj35z3o6qv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/21 07:22, Paul E. McKenney wrote:
> If someone can identify Lai's series to me, I would be happy to give it
> a try as well.  All I see are workqueue-specific patches and patches
> contributing to the discussion of possible fixes to the splats from
> Peter's series.  (I figured that I would wait for the discussion to
> converge a bit.)
>

I was referring to

http://lore.kernel.org/r/20210111152638.2417-1-jiangshanlai@gmail.com

which I believe you already tested earlier version of.
