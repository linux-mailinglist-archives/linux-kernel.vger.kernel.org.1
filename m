Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7652009E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbgFSNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 09:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732503AbgFSNXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:23:11 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D80D21527;
        Fri, 19 Jun 2020 13:23:09 +0000 (UTC)
Date:   Fri, 19 Jun 2020 09:23:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619092307.3fc89312@oasis.local.home>
In-Reply-To: <20200619125148.y4cq3hwllgozbutq@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
        <20200618195525.7889-3-qais.yousef@arm.com>
        <jhjwo43cpfl.mognet@arm.com>
        <20200619125148.y4cq3hwllgozbutq@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 13:51:48 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> > On 18/06/20 20:55, Qais Yousef wrote:  
> > > There is a report that when uclamp is enabled, a netperf UDP test
> > > regresses compared to a kernel compiled without uclamp.
> > >
> > > https://lore.kernel.org/lkml/20200529100806.GA3070@suse.de/
> > >  
> > 
> > ISTR the perennial form for those is: https://lkml.kernel.org/r/<message-id>  
> 
> The link is correct permalinnk from lore and contains the message-id as Peter
> likes and he has accepted this form before.
> 
> If you look closely you'll see that what you suggest is just moving 'lkml' to
> replace lore in the dns name and put an /r/. I don't see a need to enforce one
> form over the other as the one I used is much easier to get.

The two produce the same result, and I personally have used both. I'm
starting to move over to lore over lkml, as that seems to be becoming
the more popular form.

> 
> If Peter really insists I'll be happy to change.

But I agree, if Peter is insistent on lkml over lore, then it really
doesn't make a difference to switch it. As I said, they are identical
in what they produce.

-- Steve
