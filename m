Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561221D1449
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbgEMNNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:13:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45434 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbgEMNNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589375627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzpdvS0eGDAs3u+faEs6xFQKInmRrpLKrVl06DGsJYg=;
        b=ArPOVCe+2EEN/TqysjHImMfUMr6aWkE3tnUaCFuE9L0u8wShrLtDoGpA4IDuJbXzlwsGUw
        C8AZTiEjqI6+sn/kmsqm5o9YZf6KBdSAjzI1a0Bzpa6StsI8UVSQO7ipizRUr8W5xMxxov
        9jrRHxU1J9Lee24MhS9Wr8v40UvkrJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-93XHqRorOcWhMnpsoeuJUQ-1; Wed, 13 May 2020 09:13:45 -0400
X-MC-Unique: 93XHqRorOcWhMnpsoeuJUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050AC461;
        Wed, 13 May 2020 13:13:44 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-165.phx2.redhat.com [10.3.113.165])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B28367D908;
        Wed, 13 May 2020 13:13:39 +0000 (UTC)
Date:   Wed, 13 May 2020 09:13:37 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tao Zhou <ouwen210@hotmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH v2] sched/fair: enqueue_task_fair optimization
Message-ID: <20200513131337.GF12425@lorien.usersys.redhat.com>
References: <20200513123335.28122-1-vincent.guittot@linaro.org>
 <20200513124540.GB12425@lorien.usersys.redhat.com>
 <CAKfTPtBFP5eAV-u02x42U2cQnWA56RP+wbj78rWpzj560OS+-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBFP5eAV-u02x42U2cQnWA56RP+wbj78rWpzj560OS+-g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:10:28PM +0200 Vincent Guittot wrote:
> On Wed, 13 May 2020 at 14:45, Phil Auld <pauld@redhat.com> wrote:
> >
> > Hi Vincent,
> >
> > On Wed, May 13, 2020 at 02:33:35PM +0200 Vincent Guittot wrote:
> > > enqueue_task_fair jumps to enqueue_throttle label when cfs_rq_of(se) is
> > > throttled which means that se can't be NULL and we can skip the test.
> > >
> >
> > s/be NULL/be non-NULL/
> >
> > I think.
> 
> This sentence refers to the move of enqueue_throttle and the fact that
> se can't be null when goto enqueue_throttle and we can jump directly
> after the if statement, which is now removed in v2 because se is
> always NULL if we don't use goto enqueue_throttle.
> 
> I haven't change the commit message for the remove of if statement
>

Fair enough, it just seems backwards from the intent of the patch now.

There is also an extra }  after the update_overutilized_status.


Cheers,
Phil



> >
> > It's more like if it doesn't jump to the label then se must be NULL for
> > the loop to terminate.  The final loop is a NOP if se is NULL. The check
> > wasn't protecting that.
> >
> > Otherwise still
> >
> > > Reviewed-by: Phil Auld <pauld@redhat.com>
> >
> > Cheers,
> > Phil
> >
> >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >
> > > v2 changes:
> > > - Remove useless if statement
> > >
> > >  kernel/sched/fair.c | 39 ++++++++++++++++++++-------------------
> > >  1 file changed, 20 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index a0c690d57430..b51b12d63c39 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5513,28 +5513,29 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >                         list_add_leaf_cfs_rq(cfs_rq);
> > >       }
> > >
> > > -enqueue_throttle:
> > > -     if (!se) {
> > > -             add_nr_running(rq, 1);
> > > -             /*
> > > -              * Since new tasks are assigned an initial util_avg equal to
> > > -              * half of the spare capacity of their CPU, tiny tasks have the
> > > -              * ability to cross the overutilized threshold, which will
> > > -              * result in the load balancer ruining all the task placement
> > > -              * done by EAS. As a way to mitigate that effect, do not account
> > > -              * for the first enqueue operation of new tasks during the
> > > -              * overutilized flag detection.
> > > -              *
> > > -              * A better way of solving this problem would be to wait for
> > > -              * the PELT signals of tasks to converge before taking them
> > > -              * into account, but that is not straightforward to implement,
> > > -              * and the following generally works well enough in practice.
> > > -              */
> > > -             if (flags & ENQUEUE_WAKEUP)
> > > -                     update_overutilized_status(rq);
> > > +     /* At this point se is NULL and we are at root level*/
> > > +     add_nr_running(rq, 1);
> > > +
> > > +     /*
> > > +      * Since new tasks are assigned an initial util_avg equal to
> > > +      * half of the spare capacity of their CPU, tiny tasks have the
> > > +      * ability to cross the overutilized threshold, which will
> > > +      * result in the load balancer ruining all the task placement
> > > +      * done by EAS. As a way to mitigate that effect, do not account
> > > +      * for the first enqueue operation of new tasks during the
> > > +      * overutilized flag detection.
> > > +      *
> > > +      * A better way of solving this problem would be to wait for
> > > +      * the PELT signals of tasks to converge before taking them
> > > +      * into account, but that is not straightforward to implement,
> > > +      * and the following generally works well enough in practice.
> > > +      */
> > > +     if (flags & ENQUEUE_WAKEUP)
> > > +             update_overutilized_status(rq);
> > >
> > >       }
> > >
> > > +enqueue_throttle:
> > >       if (cfs_bandwidth_used()) {
> > >               /*
> > >                * When bandwidth control is enabled; the cfs_rq_throttled()
> > > --
> > > 2.17.1
> > >
> >
> > --
> >
> 

-- 

