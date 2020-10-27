Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5729A89A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896655AbgJ0KAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:00:35 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:11849
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896664AbgJ0KA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:00:27 -0400
X-IronPort-AV: E=Sophos;i="5.77,423,1596492000"; 
   d="scan'208";a="362862092"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 11:00:24 +0100
Date:   Tue, 27 Oct 2020 11:00:23 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mel Gorman <mgorman@suse.de>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: check for idle core
In-Reply-To: <20201027091936.GS32041@suse.de>
Message-ID: <alpine.DEB.2.22.394.2010271100110.2847@hadrien>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr> <20201027091936.GS32041@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Oct 2020, Mel Gorman wrote:

> On Thu, Oct 22, 2020 at 03:15:50PM +0200, Julia Lawall wrote:
> > Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
> >
>
> While not a universal win, it was mostly a win or neutral. In few cases
> where there was a problem, one benchmark I'm a bit suspicious of generally
> as occasionally it generates bad results for unknown and unpredictable
> reasons. In another, it was very machine specific and the differences
> were small in absolte time rather than relative time. Other tests on the
> same machine were fine so overall;

Thanks for testing!

julia

>
> Acked-by: Mel Gorman <mgorman@suse.de>
>
> Thanks.
>
> --
> Mel Gorman
> SUSE Labs
>
