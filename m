Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796422FEE15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbhAUPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:08:43 -0500
Received: from foss.arm.com ([217.140.110.172]:38878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732285AbhAUPG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:06:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BCCC11D4;
        Thu, 21 Jan 2021 07:05:41 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A45B3F68F;
        Thu, 21 Jan 2021 07:05:40 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: 5.11-rc4+git: Shortest NUMA path spans too many nodes
In-Reply-To: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee>
References: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 15:05:32 +0000
Message-ID: <jhjmtx22uv7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(+Cc relevant folks)

Hi,

On 21/01/21 15:41, Meelis Roos wrote:
> This happens on Sun Fire X4600 M2 - 32 cores in 8 CPU slots. 5.10 was silent. Current git and
> 5.10.0-13256-g5814bc2d4cc2 exhibit this message in dmesg but otherwise seem to work fine
> (kernel compilation succeeds).
>

b5b217346de8 ("sched/topology: Warn when NUMA diameter > 2") was added in
5.11-rc1, and I believe was marked for stable.

It doesn't come with a scheduler behaviour change, it only catches
topologies that end up being silently (unless run with SCHED_DEBUG=y)
misrepresented / misinterpreted by the scheduler.

Up until now I had only seen it fire on a single, somewhat unusual
topology. As fixing it is far from trivial, I figured adding this warning
would let us build a case for actually fixing it if we get some more
reports.

Could you paste the output of the below?

  $ cat /sys/devices/system/node/node*/distance

Additionally, booting your system with CONFIG_SCHED_DEBUG=y and
appending 'sched_debug' to your cmdline should yield some extra data.
