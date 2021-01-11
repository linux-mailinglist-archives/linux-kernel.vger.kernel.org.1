Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BECD2F18A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbhAKOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:46:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:58990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbhAKOqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:46:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD875AD6A;
        Mon, 11 Jan 2021 14:46:10 +0000 (UTC)
Date:   Mon, 11 Jan 2021 14:46:08 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 v2] sched/fair: skip idle cfs_rq
Message-ID: <20210111144608.GF3524@suse.de>
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
 <20210107103325.30851-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210107103325.30851-2-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:33:23AM +0100, Vincent Guittot wrote:
> Don't waste time checking whether an idle cfs_rq could be the busiest
> queue. Furthermore, this can end up selecting a cfs_rq with a high load
> but being idle in case of migrate_load.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
