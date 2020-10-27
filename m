Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD3429A7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506155AbgJ0JTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:19:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:32796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505970AbgJ0JTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:19:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C6B4B02D;
        Tue, 27 Oct 2020 09:19:39 +0000 (UTC)
Date:   Tue, 27 Oct 2020 09:19:36 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: check for idle core
Message-ID: <20201027091936.GS32041@suse.de>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 03:15:50PM +0200, Julia Lawall wrote:
> Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
> 

While not a universal win, it was mostly a win or neutral. In few cases
where there was a problem, one benchmark I'm a bit suspicious of generally
as occasionally it generates bad results for unknown and unpredictable
reasons. In another, it was very machine specific and the differences
were small in absolte time rather than relative time. Other tests on the
same machine were fine so overall;

Acked-by: Mel Gorman <mgorman@suse.de>

Thanks.

-- 
Mel Gorman
SUSE Labs
