Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485E72CD2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgLCJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:43:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:48030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgLCJnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:43:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5ABD1AC2E;
        Thu,  3 Dec 2020 09:42:39 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:42:37 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH 2/2] sched: Split the function show_schedstat()
Message-ID: <20201203094237.GD3306@suse.de>
References: <66f73a23-a273-7dff-4202-adc61c3152c8@huawei.com>
 <a0245eb6-d7ff-cae5-3608-d46424fa437d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a0245eb6-d7ff-cae5-3608-d46424fa437d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:47:14PM +0800, Yunfeng Ye wrote:
> The schedstat include runqueue-specific stats and domain-specific stats,
> so split it into two functions, show_rqstat() and show_domainstat().
> 
> No functional changes.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Why?

I could understand if there was a follow-up patch that adjusted some
subset or there was a difference in checking for schedstat_enabled,
locking or inserting new schedstat information. This can happen in the
general case when the end result is easier to review here it seems to be
just moving code around.

-- 
Mel Gorman
SUSE Labs
