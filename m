Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F92303062
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbhAYXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:44:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732933AbhAYXmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611618049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzIK0dNGmCcK/1nr62R/wDDSGrVY+nqc18uNMtz2XpI=;
        b=L5ue6JSh+jjhqmHAdHdLTwjJh9Z8Ip6FqtRDlOuyuEaPRNG/0DR1EGhcmGfcPX173Ite3O
        lAMz0V+SRsl0o8Z5/W3wnthjolM7pkQOqGbLyYqd7Ey1KA+1s3f94Nfmekg1DHCHIXTfjp
        2z/Q2lmWQMKpVlDmr6mFOnWU82rAERk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-4oFIAcJwOPamaxj-0gPjkg-1; Mon, 25 Jan 2021 18:40:45 -0500
X-MC-Unique: 4oFIAcJwOPamaxj-0gPjkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463A080A5C0;
        Mon, 25 Jan 2021 23:40:43 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D5DB10023AD;
        Mon, 25 Jan 2021 23:40:41 +0000 (UTC)
Date:   Mon, 25 Jan 2021 17:40:39 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210125234039.mb5fvhyzzoujajhm@treble>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122165226.GD16371@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:52:26PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 18, 2021 at 03:12:21PM +0100, Frederic Weisbecker wrote:
> > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > +DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> > +EXPORT_STATIC_CALL(preempt_schedule);
> > +#endif
> 
> > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > +DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> > +EXPORT_STATIC_CALL(preempt_schedule_notrace);
> > +#endif
> 
> So one of the things I hates most of this is that is allows 'random'
> modules to hijack the preemption by rewriting these callsites. Once you
> export the key, we've lost.
> 
> I've tried a number of things, but this is the only one I could come up
> with that actually stands a chance against malicious modules (vbox and
> the like).
> 
> It's somewhat elaborate, but afaict it actually works.

What about this hopefully abuse-proof idea which has less code, less
complexity, no registration, no new data structures, no COC defiance.

Add a writable-by-modules bit to the key struct, which can be set when
you define the key.  Enforce it in __static_call_update() with a call to
__builtin_return_address(0).  WARN when the caller's text isn't in the
kernel proper and the flag isn't set.

Hm?

-- 
Josh

