Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36012DD245
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgLQNif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:38:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E89C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2j5SyKzfkhG4+GIahrgxga1F7ov7IQkTMlGIU7JUGvY=; b=vkTdn2bb30CJwK/BdkiV6Uy2AR
        RCKfmt6VVw14hlI3aSS75HbTuHigTWD9OEJCfpFJx186/bPmddtVGN5Bt0Wpmnj1UTLSTmhv0HCQL
        8OQHH0eM2pYtPVvTLYYo8CkayLhFUHbAjAIjq42XGcPDcNqWFKvtcvzxW6WF7sZ0iYsPGkVwf2Iav
        DAfkktx4G5Zc7lvR5S4hyoe5kuklqFajQzdU9vY7PsrZUI9tWMP9O/U/7w43HJrEig1Stqg540+4E
        eJb5JBH/74ea8m8pEXIj0bWtmDoK1AyX5TQ7a4oSaFtp9d3R5qSitFPIZnd7okQDmUd/D24eyYrjQ
        9ber0chw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kptT1-0006T8-FQ; Thu, 17 Dec 2020 13:37:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01CBB300DAE;
        Thu, 17 Dec 2020 14:36:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6C072020D9ED; Thu, 17 Dec 2020 14:36:56 +0100 (CET)
Date:   Thu, 17 Dec 2020 14:36:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        khlebnikov@yandex-team.ru, xiyou.wangcong@gmail.com,
        shanpeic@linux.alibaba.com
Subject: Re: [PATCH 1/4] sched/fair: Introduce primitives for CFS bandwidth
 burst
Message-ID: <20201217133656.GX3040@hirez.programming.kicks-ass.net>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
 <20201217074620.58338-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217074620.58338-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 03:46:17PM +0800, Huaixin Chang wrote:
> In this patch, we introduce the notion of CFS bandwidth burst. Unused
> "quota" from pervious "periods" might be accumulated and used in the
> following "periods". The maximum amount of accumulated bandwidth is
> bounded by "burst". And the maximun amount of CPU a group can consume in
> a given period is "buffer" which is equivalent to "quota" + "burst in
> case that this group has done enough accumulation.

Oh man, Juri, wasn't there a paper about statistical bandwidth
accounting somewhere? Where, if you replace every utilization by a
statistical variable, the end result is still useful?

That is, instead of something like; \Sum u_i <= 1, you get something
like: \Sum {avg(u),var(u)}_i <= {1, sqrt(\Sum var_i^2)} and you can
still proof bounded tardiness etc.. (assuming a gaussian distribution).

The proposed seems close to that, but not quite, and I'm afraid it's not
quite strong enough to still provide any guarantees.
