Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F612275A85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIWOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:44:00 -0400
Received: from foss.arm.com ([217.140.110.172]:47988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:44:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C508A1396;
        Wed, 23 Sep 2020 07:43:59 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E483F73B;
        Wed, 23 Sep 2020 07:43:58 -0700 (PDT)
References: <20200921072424.14813-1-vincent.guittot@linaro.org> <20200921072424.14813-5-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH 4/4 v2] sched/fair: reduce busy load balance interval
In-reply-to: <20200921072424.14813-5-vincent.guittot@linaro.org>
Date:   Wed, 23 Sep 2020 15:43:56 +0100
Message-ID: <jhja6xgmu37.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/09/20 08:24, Vincent Guittot wrote:
> The busy_factor, which increases load balance interval when a cpu is busy,
> is set to 32 by default. This value generates some huge LB interval on
> large system like the THX2 made of 2 node x 28 cores x 4 threads.
> For such system, the interval increases from 112ms to 3584ms at MC level.
> And from 228ms to 7168ms at NUMA level.
>
> Even on smaller system, a lower busy factor has shown improvement on the
> fair distribution of the running time so let reduce it for all.
>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
