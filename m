Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912E61BEC75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 01:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgD2XNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 19:13:23 -0400
Received: from foss.arm.com ([217.140.110.172]:46848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgD2XNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93E01045;
        Wed, 29 Apr 2020 16:13:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 757B03F73D;
        Wed, 29 Apr 2020 16:13:21 -0700 (PDT)
References: <20200428050242.17717-1-swood@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] newidle_balance() latency mitigation
In-reply-to: <20200428050242.17717-1-swood@redhat.com>
Date:   Thu, 30 Apr 2020 00:13:14 +0100
Message-ID: <jhjzhatdgxh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/04/20 06:02, Scott Wood wrote:
> These patches mitigate latency caused by newidle_balance() on large
> systems, by enabling interrupts when the lock is dropped, and exiting
> early at various points if an RT task is runnable on the current CPU.
>
> When applied to an RT kernel on a 72-core machine (2 threads per core), I
> saw significant reductions in latency as reported by rteval -- from
> over 500us to around 160us with hyperthreading disabled, and from
> over 1400us to around 380us with hyperthreading enabled.
>
> This isn't the first time something like this has been tried:
> https://lore.kernel.org/lkml/20121222003019.433916240@goodmis.org/
> That attempt ended up being reverted:
> https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/
>
> The problem in that case was the failure to keep BH disabled, and the
> difficulty of fixing that when called from the post_schedule() hook.
> This patchset uses finish_task_switch() to call newidle_balance(), which
> enters in non-atomic context so we have full control over what we disable
> and when.
>
> There was a note at the end about wanting further discussion on the matter --
> does anyone remember if that ever happened and what the conclusion was?
> Are there any other issues with enabling interrupts here and/or moving
> the newidle_balance() call?
>

Random thought that just occurred to me; in the grand scheme of things,
with something in the same spirit as task-stealing (i.e. don't bother with
a full fledged balance at newidle, just pick one spare task somewhere),
none of this would be required.

Sadly I don't think anyone has been looking at it any recently.
