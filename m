Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017F32696F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgINUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgINUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600116435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRkU5TfQydlr6TP0dcPc8PgGpwKQaIXfxGuE5ILWkDU=;
        b=a6mU/dLBx1UiEjqIBbLL5qR+TnmfRjFxZBniSBQidG3vWqO0NGigPfiAVyJA7g+rOqp2MX
        Qy6wFZ5VSSbDkqVxy7hFz/WDM5NxKIUU4HsiJMyILkBZHWFRzWxMF9ZWfgqcQ8KQFjUbKU
        1Pze03G74XxLwNbWF1JD1HR3NbZYpYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-VeUKd1agP5qWaJq0qil6oQ-1; Mon, 14 Sep 2020 16:47:11 -0400
X-MC-Unique: VeUKd1agP5qWaJq0qil6oQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ACF510066FA;
        Mon, 14 Sep 2020 20:47:09 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FEB75DA6B;
        Mon, 14 Sep 2020 20:47:02 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:47:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 05/26] perf tools: Add build_id__is_defined function
Message-ID: <20200914204701.GZ1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-6-jolsa@kernel.org>
 <CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 02:44:35PM +0900, Namhyung Kim wrote:
> On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding build_id__is_defined helper to check build id
> > is defined and is != zero build id.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/build-id.c | 11 +++++++++++
> >  tools/perf/util/build-id.h |  1 +
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 31207b6e2066..bdee4e08e60d 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -902,3 +902,14 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
> >
> >         return ret;
> >  }
> > +
> > +bool build_id__is_defined(const u8 *build_id)
> > +{
> > +       static u8 zero[BUILD_ID_SIZE];
> > +       int err = 0;
> > +
> > +       if (build_id)
> > +               err = memcmp(build_id, &zero, BUILD_ID_SIZE);
> > +
> > +       return err ? true : false;
> > +}
> 
> I think this is a bit confusing.. How about this?
> 
>   bool ret = false;
>   if (build_id)
>       ret = memcmp(...);
>   return ret;

ok

> 
> Or, it can be a oneliner..

everything can be oneliner ;-)

thanks,
jirka

