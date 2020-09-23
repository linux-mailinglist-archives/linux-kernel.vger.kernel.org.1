Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7364275A84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIWOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:43:55 -0400
Received: from foss.arm.com ([217.140.110.172]:47964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:43:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FAA412FC;
        Wed, 23 Sep 2020 07:43:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99A33F73B;
        Wed, 23 Sep 2020 07:43:52 -0700 (PDT)
References: <20200921072424.14813-1-vincent.guittot@linaro.org> <20200921072424.14813-4-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH 3/4 v2] sched/fair: minimize concurrent LBs between domain level
In-reply-to: <20200921072424.14813-4-vincent.guittot@linaro.org>
Date:   Wed, 23 Sep 2020 15:43:50 +0100
Message-ID: <jhjblhwmu3d.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/09/20 08:24, Vincent Guittot wrote:
> sched domains tend to trigger simultaneously the load balance loop but
> the larger domains often need more time to collect statistics. This
> slowness makes the larger domain trying to detach tasks from a rq whereas
> tasks already migrated somewhere else at a sub-domain level. This is not
> a real problem for idle LB because the period of smaller domains will
> increase with its CPUs being busy and this will let time for higher ones
> to pulled tasks. But this becomes a problem when all CPUs are already busy
> because all domains stay synced when they trigger their LB.
>
> A simple way to minimize simultaneous LB of all domains is to decrement the
> the busy interval by 1 jiffies. Because of the busy_factor, the interval of
> larger domain will not be a multiple of smaller ones anymore.
>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
