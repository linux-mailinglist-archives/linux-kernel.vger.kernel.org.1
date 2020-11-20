Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A22BB5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgKTTfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728282AbgKTTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605900913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGRdA1sp4aWVP0lf2aD801Gns5XZWzMzikpu+pfp5Qc=;
        b=EF6HUnl7j5W2mGZsevmPx2PrhPNyriq1uT9OTsTRHuVEHc5T8VeF5Eztn58TxFCLKlFrf1
        X58Qvr4s4KLk6FKyYENmw/W7IofcQUCXssxdKCbD9+YzBF8h7+COHMVWBw5psBkZi8UdHz
        kqwXEQGflCPiQxCxlzVbYQ/Po7Njxwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95--7AyUIfzOem0R47IS3syZg-1; Fri, 20 Nov 2020 14:35:09 -0500
X-MC-Unique: -7AyUIfzOem0R47IS3syZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B64C3100A652;
        Fri, 20 Nov 2020 19:35:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.134])
        by smtp.corp.redhat.com (Postfix) with SMTP id 58A775C224;
        Fri, 20 Nov 2020 19:35:02 +0000 (UTC)
Date:   Fri, 20 Nov 2020 20:35:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] perf metric: Don't compute unused events.
Message-ID: <20201120193501.GO1475102@krava>
References: <20201118050335.2347358-1-irogers@google.com>
 <20201118050335.2347358-6-irogers@google.com>
 <20201119205920.GM1475102@krava>
 <CAP-5=fWjzwDg7SbfBq+mHqT+zDEEpei8M5AF8+Bk8sU19Ta_hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWjzwDg7SbfBq+mHqT+zDEEpei8M5AF8+Bk8sU19Ta_hg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:37:15PM -0800, Ian Rogers wrote:
> On Thu, Nov 19, 2020 at 12:59 PM Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > On Tue, Nov 17, 2020 at 09:03:35PM -0800, Ian Rogers wrote:
> >
> > SNIP
> >
> > > +                     ids__free($1.ids);
> > > +                     ids__free($3.ids);
> > > +             }
> > > +     } else {
> > > +             $$.val = NAN;
> > > +             $$.ids = ids__union($1.ids, $3.ids);
> > > +     }
> > > +}
> > > +| expr '*' expr
> > > +{
> > > +     if (!compute_ids || (isfinite($1.val) && isfinite($3.val))) {
> > > +             $$.val = $1.val * $3.val;
> > > +             $$.ids = NULL;
> > > +             if (compute_ids) {
> > > +                     ids__free($1.ids);
> > > +                     ids__free($3.ids);

thanks for the explanation below, really nice, one more question ;-)

why do we need to call ids__free in here, for compute_ids and constants
case in here it should be always NULL, no?

> > > +             }
> > > +     } else {
> > > +             $$.val = NAN;
> > > +             $$.ids = ids__union($1.ids, $3.ids);
> > > +     }
> > > +}
> > > +| expr '/' expr
> > > +{
> > > +     if (fpclassify($3.val) == FP_ZERO) {
> > > +             pr_debug("division by zero\n");
> > > +             YYABORT;
> > > +     } else if (!compute_ids || (isfinite($1.val) && isfinite($3.val)))
> > {
> > > +             $$.val = $1.val / $3.val;
> > > +             $$.ids = NULL;
> >
> > hum, I'm confused with this.. compute_ids with finite values?
> > why do we erase ids then? also val should be NAN then, no?
> > could you please put in some comment with reasoning?
> >
> 
> Each expr parsing step needs to create a val and an ids. If we're not
> computing ids then we know we don't need ids. If the values are both
> constants (aka finite), again we don't need ids as  we can just divide. It
> is invariant that if you have ids then the value is NAN which isn't finite.
> So when computing ids we may want to constant evaluate:
> 
> event1 if 0.5 > 1.0/3.0 else event2
> 
> which is quite hypothetical but the idea is to have a general approach for
> all the operators. The simple lattice is something like:
> 
> Constants: 0.0, 1.0, ....
>                     \.    |.     /
> Bottom:         NAN
> 
> Bottom means we really have a set of values and we don't know which it
> could be. So:
> 
> 3.0 if event1 > 10.0 else 4.0
> 
> has possible values of 3.0 or 4.0 which we could represent with the set
> {3.0, 4.0}, but because the lattice is simple we just say bottom, meaning
> the set of all values - which is conservatively correct as 3.0 and 4.0 are
> in the set of all values. It would be incorrect to say the value was 3.0.
> Even with a simple lattice we could represent that:
> 
> 3.0 if event1 > 10.0 else 3.0
> 
> evaluates to 3.0 and so there is no need to measure event1. Note, this
> peephole optimization isn't performed here, just the peephole optimization
> that if the condition is true or false we can remove events.
> 
> The code in general needs to handle the compute_ids case and the evaluation
> case. So what the code is trying to do is propagate constants with sets of
> ids in the compute_ids case, or just evaluate in the other case. NAN is
> used as a bottom just for simplicity and to avoid inventing a type lattice
> abstraction.

could you please put it in comment, will be helpful for future ;-)

thanks,
jirka

