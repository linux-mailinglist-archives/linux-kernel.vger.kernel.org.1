Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F7275C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIWPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:47:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:46002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:47:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F393FABC1;
        Wed, 23 Sep 2020 15:48:25 +0000 (UTC)
Date:   Wed, 23 Sep 2020 16:47:44 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        pauld@redhat.com, hdanton@sina.com
Subject: Re: [PATCH 0/4 v2] sched/fair: Improve fairness between cfs tasks
Message-ID: <20200923154744.GL3117@suse.de>
References: <20200921072424.14813-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200921072424.14813-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:24:20AM +0200, Vincent Guittot wrote:
> When the system doesn't have enough cycles for all tasks, the scheduler
> must ensure a fair split of those CPUs cycles between CFS tasks. The
> fairness of some use cases can't be solved with a static distribution of
> the tasks on the system and requires a periodic rebalancing of the system
> but this dynamic behavior is not always optimal and the fair distribution
> of the CPU's time is not always ensured.
> 

FWIW, nothing bad fell out of the series from a battery of scheduler
tests across various machines. Headline-wise, EPYC 1 looked very bad for
hackbench but a detailed look showed that it was great until the very
highest group count when it looked bad. Otherwise EPYC 1 looked good
as-did EPYC 2. Various generation of Intel boxes showed marginal gains
or losses, nothing dramatic.  will-it-scale for various test loads looks
looked fractionally worse across some machines which may how up in the
0-day bot but it probably will be marginal.

As the patches are partially magic numbers which you could reason about
either way, I'm not going to say that it's universally better. However
it's slightly better in normal cases, your tests indicate its good for
a specific corner case and it does not look like anything obvious falls
apart.

-- 
Mel Gorman
SUSE Labs
