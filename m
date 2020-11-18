Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423FD2B7D69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgKRMK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:10:57 -0500
Received: from foss.arm.com ([217.140.110.172]:53228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgKRMK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:10:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB1111D4;
        Wed, 18 Nov 2020 04:10:56 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2809A3F70D;
        Wed, 18 Nov 2020 04:10:54 -0800 (PST)
References: <20201113112414.2569-1-valentin.schneider@arm.com> <20201115115849.GA6943@geo.homenetwork>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Tao Zhou <t1zhou@163.com>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        bigeasy@linutronix.de, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        mingo@kernel.org, ouwen210@hotmail.com, peterz@infradead.org,
        qais.yousef@arm.com, rostedt@goodmis.org, swood@redhat.com,
        tglx@linutronix.de, tj@kernel.org, vincent.donnefort@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/core: Add missing completion for affine_move_task() waiters
In-reply-to: <20201115115849.GA6943@geo.homenetwork>
Date:   Wed, 18 Nov 2020 12:10:51 +0000
Message-ID: <jhjk0uix3uc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/11/20 11:59, Tao Zhou wrote:
> Oh, I did not receive this patch from 'ouwen210@hotmail.com'
> account. Checked that you sent the patch to that mail address
> from web. If 'ouwen210' is not a good mail account name(I have
> used this name since 2002), I will change to use this one(Now
> is smooth enough and can go to lkml).
>

Nah, any address is fine. I grabbed whatever emails were cc'd to the patch
this is fixing - just make sure you're using the right address (i.e. the
one you want LKML stuff to go to) when interacting on the list and you
should be good.

> Thanks,
> Tao

