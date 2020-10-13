Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9928CF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgJMNUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:20:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgJMNUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:20:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E41491FB;
        Tue, 13 Oct 2020 06:20:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C38F83F719;
        Tue, 13 Oct 2020 06:20:35 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201005150921.960169379@infradead.org> <CH2PR14MB41833F828B4D3BA5A7B6CE7B9A0B0@CH2PR14MB4183.namprd14.prod.outlook.com> <20201012113657.GV2628@hirez.programming.kicks-ass.net> <CH2PR14MB4183BF26F02A4AD4F45CADA59A070@CH2PR14MB4183.namprd14.prod.outlook.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 10/17] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <CH2PR14MB4183BF26F02A4AD4F45CADA59A070@CH2PR14MB4183.namprd14.prod.outlook.com>
Date:   Tue, 13 Oct 2020 14:20:29 +0100
Message-ID: <jhjy2kacleq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/20 19:25, Tao Zhou wrote:
> Hi Peter,
> @@ -1989,7 +1994,24 @@ static int affine_move_task(struct rq *rq, struct rq_flags *rf,
>         };
>         bool complete = false;
>
> -       /* Can the task run on the task's current CPU? If so, we're done */
> +       /*
> +        * Can the task run on the task's current CPU ? If so,  we're done.
> +        * One scenario can happen here. Consider task T running on CPU P0:
> +        *
> +        *   P0                     P1                    p2

That naming convention weirds me out, and I'm the one who wrote that...

How about:

  https://gitlab.arm.com/linux-arm/linux-vs/-/commit/b30f50c7b2dd1ef70598bbe1a2a90934d894b861

I also have an extra goodie:

  https://gitlab.arm.com/linux-arm/linux-vs/-/commits/mainline/review/migrate_disable_peterz_v2_extras/

The whole thing can be cloned via
git@git.gitlab.arm.com:linux-arm/linux-vs.git -b mainline/review/migrate_disable_peterz_v2_extras

(I can send those as replies to patch 0 if that helps)
