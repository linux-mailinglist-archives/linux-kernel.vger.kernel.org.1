Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72CB275A82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIWOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:43:43 -0400
Received: from foss.arm.com ([217.140.110.172]:47924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:43:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08860113E;
        Wed, 23 Sep 2020 07:43:43 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90BA93F73B;
        Wed, 23 Sep 2020 07:43:41 -0700 (PDT)
References: <20200921072424.14813-1-vincent.guittot@linaro.org> <20200921072424.14813-2-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH 1/4 v2] sched/fair: relax constraint on task's load during load balance
In-reply-to: <20200921072424.14813-2-vincent.guittot@linaro.org>
Date:   Wed, 23 Sep 2020 15:43:19 +0100
Message-ID: <jhjeemsmu48.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/09/20 08:24, Vincent Guittot wrote:
> Some UCs like 9 always running tasks on 8 CPUs can't be balanced and the
> load balancer currently migrates the waiting task between the CPUs in an
> almost random manner. The success of a rq pulling a task depends of the
> value of nr_balance_failed of its domains and its ability to be faster
> than others to detach it. This behavior results in an unfair distribution
> of the running time between tasks because some CPUs will run most of the
> time, if not always, the same task whereas others will share their time
> between several tasks.
>
> Instead of using nr_balance_failed as a boolean to relax the condition
> for detaching task, the LB will use nr_balanced_failed to relax the
> threshold between the tasks'load and the imbalance. This mecanism
> prevents the same rq or domain to always win the load balance fight.
>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
