Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3327D292CED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgJSRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:36:21 -0400
Received: from foss.arm.com ([217.140.110.172]:34538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbgJSRgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:36:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A032C30E;
        Mon, 19 Oct 2020 10:36:20 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862593F66B;
        Mon, 19 Oct 2020 10:36:18 -0700 (PDT)
References: <20201015110532.738127234@infradead.org> <20201015110923.910090294@infradead.org> <jhjlfg6qqum.mognet@arm.com> <BN8PR12MB29784D239007D0D6CA3F4F2A9A010@BN8PR12MB2978.namprd12.prod.outlook.com> <jhjimb7r0r5.mognet@arm.com> <BN8PR12MB2978F76887133CCA2102B7589A1E0@BN8PR12MB2978.namprd12.prod.outlook.com>
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
Subject: Re: [PATCH v3 10/19] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <BN8PR12MB2978F76887133CCA2102B7589A1E0@BN8PR12MB2978.namprd12.prod.outlook.com>
Date:   Mon, 19 Oct 2020 18:36:16 +0100
Message-ID: <jhjblgyqfsf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/10/20 17:32, Tao Zhou wrote:
> Hi Valentin,
>>
>> Side thought: don't we need to NULL p->migration_pending in __sched_fork()?
>>
>
> No need, if fork happen, the forked task will inherit that pending.

Which is what I'm worrying about. I think we can ignore migrate_disable()
for now and just consider a task fork()'ing while another tries to
sched_setaffinity() it; say the fork() happens just after the pending has
been installed.

Unless I'm overthinking it, we could end up with a dangling pending
reference, which will wreck havock to any later affine_move_task() (see the
if (p->migration_pending) paths).

> If pending is NULL, when call SCA, it will install pending. If pending
> is not NULL, it means it is in migrate region and wait for complete.
> If NULL pending in __sched_fork() it will install a new pending in this
> case which is not right to me. Add a flag(ENABLE_MIGRATE) to arg will
> differ the path where in.
>
> Always likely miss something.
>
> Tao
>
