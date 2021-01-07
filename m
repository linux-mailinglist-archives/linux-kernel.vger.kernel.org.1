Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625162ECEB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbhAGL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:27:31 -0500
Received: from foss.arm.com ([217.140.110.172]:58342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbhAGL1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:27:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A75D831B;
        Thu,  7 Jan 2021 03:26:44 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C93F3F719;
        Thu,  7 Jan 2021 03:26:43 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/3 v2] sched/fair: don't set LBF_ALL_PINNED unnecessarily
In-Reply-To: <20210107103325.30851-3-vincent.guittot@linaro.org>
References: <20210107103325.30851-1-vincent.guittot@linaro.org> <20210107103325.30851-3-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 07 Jan 2021 11:26:34 +0000
Message-ID: <jhjeeixasyd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/21 11:33, Vincent Guittot wrote:
> Setting LBF_ALL_PINNED during active load balance is only valid when there
> is only 1 running task on the rq otherwise this ends up increasing the
> balance interval whereas other tasks could migrate after the next interval
> once they become cache-cold as an example.
>
> LBF_ALL_PINNED flag is now always set it by default. It is then cleared
> when we find one task that can be pulled when calling detach_tasks() or
> during active migration.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
