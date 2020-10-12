Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB228B26B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgJLKkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:40:21 -0400
Received: from foss.arm.com ([217.140.110.172]:36532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387522AbgJLKkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:40:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19BB531B;
        Mon, 12 Oct 2020 03:40:20 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 758493F719;
        Mon, 12 Oct 2020 03:40:18 -0700 (PDT)
References: <20201012053910.97010-1-juri.lelli@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        patrick.bellasi@matbug.net, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, chris.redpath@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH] sched/features: Fix !CONFIG_JUMP_LABEL case
In-reply-to: <20201012053910.97010-1-juri.lelli@redhat.com>
Date:   Mon, 12 Oct 2020 11:40:10 +0100
Message-ID: <jhj8scbenhx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 12/10/20 06:39, Juri Lelli wrote:
> Commit 765cc3a4b224e ("sched/core: Optimize sched_feat() for
> !CONFIG_SCHED_DEBUG builds") made sched features static for
> !CONFIG_SCHED_DEBUG configurations, but overlooked the CONFIG_
> SCHED_DEBUG enabled and !HAVE_JUMP_LABEL cases. For the latter, echoing
> changes to /sys/kernel/debug/sched_features has the nasty effect of
> effectively changing what sched_features reports, but without actually
> changing the scheduler behaviour (since different translation units get
> different sysctl_sched_features).
>
> Fix CONFIG_SCHED_DEBUG and !HAVE_JUMP_LABEL configurations by properly
> restructuring ifdefs.
>

That should be CONFIG_JUMP_LABEL, no? The HAVE stuff should've died with

  e9666d10a567 ("jump_label: move 'asm goto' support test to Kconfig")

> Fixes: 765cc3a4b224e ("sched/core: Optimize sched_feat() for !CONFIG_SCHED_DEBUG builds")
> Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

With the aforementioned replacement (changelog AND diff):

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
