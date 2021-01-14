Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D122F61E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbhANNYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbhANNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610630555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RLfx2LEZjsSITiGQmMI4unqomIKtXYwKtgG0whp/WI=;
        b=hcIhhwjw45EUhz+fAcqdszKg52yIZK8lZcHhkc8BkmsA6PAZiTb0Z/s60aGaQit/CPSwF/
        DMGmS9qgR1AY4qiEk/e5GqKeO8TVkgcC4C0ymLlD3oSe7OnfRjy7VvsEfwl2lR8RyB1kP/
        aNdOQKnMAeUexDe6t7heLnvZncoITZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-iMeSBMkrMUqK0e30NGCIAw-1; Thu, 14 Jan 2021 08:22:31 -0500
X-MC-Unique: iMeSBMkrMUqK0e30NGCIAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4749A9CDA0;
        Thu, 14 Jan 2021 13:22:29 +0000 (UTC)
Received: from krava (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id ECC7F19727;
        Thu, 14 Jan 2021 13:22:26 +0000 (UTC)
Date:   Thu, 14 Jan 2021 14:22:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf stat: Introduce struct runtime_stat_data
Message-ID: <20210114132226.GA1409793@krava>
References: <20210112061431.1122838-1-namhyung@kernel.org>
 <20210113111902.GD1331835@krava>
 <CAM9d7cig3+P3Q+gAQNRQJJqB+wcNT+KVjo+9AU92AZ+QvP6ZAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cig3+P3Q+gAQNRQJJqB+wcNT+KVjo+9AU92AZ+QvP6ZAg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:25:39PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Wed, Jan 13, 2021 at 8:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jan 12, 2021 at 03:14:30PM +0900, Namhyung Kim wrote:
> > > To pass more info to the saved_value in the runtime_stat, add a new
> > > struct runtime_stat_data.  Currently it only has 'ctx' field but later
> > > patch will add more.
> > >
> > > Suggested-by: Andi Kleen <ak@linux.intel.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/stat-shadow.c | 346 +++++++++++++++++-----------------
> > >  1 file changed, 173 insertions(+), 173 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > > index 901265127e36..a1565b6e38f2 100644
> > > --- a/tools/perf/util/stat-shadow.c
> > > +++ b/tools/perf/util/stat-shadow.c
> > > @@ -114,6 +114,10 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
> > >
> > >       rblist = &st->value_list;
> > >
> > > +     /* don't use context info for clock events */
> > > +     if (type == STAT_NSECS)
> > > +             dm.ctx = 0;
> > > +
> >
> > I think this should go to separate patch and be explained,
> > the change is advertised as adding struct for arguments
> 
> Actually it was already there and I found it during this work.
> Basically it passes ctx for lookup but it uses 0 for time.
> Please see below..

ah nice, did not see that.. could be mentioned in the changelog ;-)

thanks,
jirka

