Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BF1F552A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgFJMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgFJMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:49:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACD8C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Mul5KAxOGk2b7Zi1O+VKvrqvTFd8MfuytPDM5+l5Oo=; b=KZMBJMy8/LwjgJfHVC6VnZJTq8
        p8teu0zgxg/11Y7iPUXgzmZq/OZqPpALucwErxz3jGL0HsBqPmVopvkQoD5g+FPnD15XcEH9cgEnJ
        fxqk4E3xYDUuYPIN+ikM7g3i+ph634/udVFyTPpCyrE9YjR7KxHB6fg2VUCsDwswVF+T2WeJAmQv8
        lLKJRJu5Z9B1S/aRz9sDNxUeLqMDYO+LePB4ocC+Jjc0jWM0T+wSokLy7t8aJUhZbtFrjVxTcDJ6E
        4FLYrsVeEa/BBNZHpnetJ+tUNScQuVI+TMTq2B/e0t4UKpy/uu23lfFAwfDxwizg7fRgc2LQ/FRYB
        ZT2r2Wdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj0AV-0005yL-Ae; Wed, 10 Jun 2020 12:49:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2DD7301A7A;
        Wed, 10 Jun 2020 14:49:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 645B8203EE214; Wed, 10 Jun 2020 14:49:21 +0200 (CEST)
Date:   Wed, 10 Jun 2020 14:49:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, iwtbavbm@gmail.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: fix nohz next idle balance
Message-ID: <20200610124921.GD2497@hirez.programming.kicks-ass.net>
References: <20200609123748.18636-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609123748.18636-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:37:48PM +0200, Vincent Guittot wrote:
> With commit:
>   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
> rebalance_domains of the local cfs_rq happens before others idle cpus have
> updated nohz.next_balance and its value is overwritten.
> 
> Move the update of nohz.next_balance for other idles cpus before balancing
> and updating the next_balance of local cfs_rq.
> 
> Also, the nohz.next_balance is now updated only if all idle cpus got a
> chance to rebalance their domains and the idle balance has not been aborted
> because of new activities on the CPU. In case of need_resched, the idle
> load balance will be kick the next jiffie in order to address remaining
> ilb.
> 
> Reported-by: Peng Liu <iwtbavbm@gmail.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks
