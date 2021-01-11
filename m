Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60B2F19E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbhAKPnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:43:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbhAKPnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:43:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64426AD8C;
        Mon, 11 Jan 2021 15:42:28 +0000 (UTC)
Date:   Mon, 11 Jan 2021 15:42:26 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3 v2] sched/fair: don't set LBF_ALL_PINNED unnecessarily
Message-ID: <20210111154226.GG3524@suse.de>
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
 <20210107103325.30851-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210107103325.30851-3-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:33:24AM +0100, Vincent Guittot wrote:
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

When reviewing this, I found it curious that sched_nr_migrate_break is
a const instead of a #define. It's not clear why as it only appears to
exist in case sysctl_sched_nr_migrate is set higher than 32 to prevent
rq lock starvation.

With your patch, s/atleast/at least/ in the comments if there is another
version.

Otherwise, I didn't spot a real problem so

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
