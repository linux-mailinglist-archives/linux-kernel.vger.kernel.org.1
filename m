Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E63244A35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHNNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 09:15:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:15:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC73FAE16;
        Fri, 14 Aug 2020 13:16:19 +0000 (UTC)
Date:   Fri, 14 Aug 2020 14:15:54 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     ????????? <tianchen.dingtianc@alibaba-inc.com>
Cc:     'Ingo Molnar' <mingo@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Juri Lelli' <juri.lelli@redhat.com>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        'Ben Segall' <bsegall@google.com>,
        'linux-kernel' <linux-kernel@vger.kernel.org>,
        '??????' <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched/numa: fix bug in update_task_scan_period
Message-ID: <20200814131554.GH3510@suse.de>
References: <44875b14-00ea-4e61-aba7-4809808c4b2a.tianchen.dingtianc@alibaba-inc.com>
 <20200811110154.GY3510@suse.de>
 <000401d6705b$eba56bf0$c2f043d0$@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <000401d6705b$eba56bf0$c2f043d0$@alibaba-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 11:51:54AM +0800, ????????? wrote:
> OK. Thanks for your advice and I'll use label instead.
> In the case of migration failures, if there are still new failures after
> clearing (meaning the node is still overloaded), the scanning period would
> be doubled, just like not using this patch. However, if the failures do not
> increase again, then the scanning period should be adjusted according to the
> following rules (i.e., ps and lr ratio). I believe this is the original
> design idea, right?
> 

The original idea was to simply throttle scanning if the faults were
useless. Your patch is probably correct but I would still like to see
some evidence of the user-visible impact. What tests have you conducted
to make sure it behaves better (or is at least neutral in most cases)?

-- 
Mel Gorman
SUSE Labs
