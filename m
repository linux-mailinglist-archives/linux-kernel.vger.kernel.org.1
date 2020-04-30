Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44781BEDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD3Bgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 21:36:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726309AbgD3Bgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588210605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1gZzSto7hNc0Fves2SwneJoXyyNd5NhhVuof1lvKH8=;
        b=YuuRNMlCJq8oFjQ0oPs6lBJBbbQGgFkXNwKF37Rx80C/AZO+tvPwlR4jTwk7wzuHCSpKQm
        zlsfQVhYWhgAsNJUyzm06J0IDxHECcZvZPta4lfn2TMigqKBkTXb5nBQZ5cGz9w/8lVFNI
        ovtEPD8ZPZ+GVlZFgdja3K3MVQb52dE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-f8b3uKY-OWu0GYdxOfHhfw-1; Wed, 29 Apr 2020 21:36:41 -0400
X-MC-Unique: f8b3uKY-OWu0GYdxOfHhfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 501471005510;
        Thu, 30 Apr 2020 01:36:40 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC481002388;
        Thu, 30 Apr 2020 01:36:39 +0000 (UTC)
Message-ID: <76ad9ab3684bacb2c8458678ef07b6a574384445.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
From:   Scott Wood <swood@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Wed, 29 Apr 2020 20:36:38 -0500
In-Reply-To: <CAKfTPtBsfneVVdT5UhtysUGACqPp7YUGKzSTKu4D8UYKwDbykg@mail.gmail.com>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-2-swood@redhat.com>
         <CAKfTPtBsfneVVdT5UhtysUGACqPp7YUGKzSTKu4D8UYKwDbykg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 10:27 +0200, Vincent Guittot wrote:
> On Tue, 28 Apr 2020 at 07:02, Scott Wood <swood@redhat.com> wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 02f323b85b6d..74c3c5280d6b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6758,8 +6758,6 @@ balance_fair(struct rq *rq, struct task_struct
> > *prev, struct rq_flags *rf)
> >  {
> >         if (rq->nr_running)
> >                 return 1;
> > -
> > -       return newidle_balance(rq, rf) != 0;
> 
> Missing return ?

Yes, editing error during last minute cleanup. :-P

-Scott


