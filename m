Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3314268B94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgINM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:58:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgINMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600088008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HD6K7iEyfKt9ztXCnGE6bNakZvZxN19cANl0JTN4EYg=;
        b=VJM7lh4QeY2XLvMwKgASpWcWig4C3jRwbKWa4J3U2g+AHmEq4vB/SbBK4504zh+cUUTm9q
        Jnmfss2RUZ+rwKXTVAnVfmVOb9TYE7yU6pa/3W37yhZRS1bTL26X5/geIFjqzn/y9gMGL2
        BqTC4M9bYlFrGWL9h261JBAEZIb5s/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-4e4NH806MriLDuKVKrttrA-1; Mon, 14 Sep 2020 08:53:26 -0400
X-MC-Unique: 4e4NH806MriLDuKVKrttrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E84E107B113;
        Mon, 14 Sep 2020 12:53:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-89.phx2.redhat.com [10.3.113.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03E6F7E8D8;
        Mon, 14 Sep 2020 12:53:10 +0000 (UTC)
Date:   Mon, 14 Sep 2020 08:53:09 -0400
From:   Phil Auld <pauld@redhat.com>
To:     peterz@infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
Message-ID: <20200914125309.GA4008@lorien.usersys.redhat.com>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914114202.GQ1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914114202.GQ1362448@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 01:42:02PM +0200 peterz@infradead.org wrote:
> On Mon, Sep 14, 2020 at 12:03:36PM +0200, Vincent Guittot wrote:
> > Vincent Guittot (4):
> >   sched/fair: relax constraint on task's load during load balance
> >   sched/fair: reduce minimal imbalance threshold
> >   sched/fair: minimize concurrent LBs between domain level
> >   sched/fair: reduce busy load balance interval
> 
> I see nothing objectionable there, a little more testing can't hurt, but
> I'm tempted to apply them.
> 
> Phil, Mel, any chance you can run them through your respective setups?
> 

Yep. I'll try to get something started today, results in a few days.

These look pretty inocuous. It'll be interesting to see the effect is.


Cheers,
Phil
-- 

