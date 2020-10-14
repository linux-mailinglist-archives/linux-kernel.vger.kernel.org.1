Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD1528E027
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgJNL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388567AbgJNL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602676780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OUXfs8ZFnSKO8DTZ95o///qFwP8Bn+Shck7dmpALbqc=;
        b=JAd+nUlQ3BeysdfxsYshxpk4ZTpxAnLbhhSu16MsgAHf5XLu/jVcGcfRxJukhrk9DnfEFY
        wr6vdGVU/+e3iYSzdgUuGo/M2ulduoPUIjG4UFmx9Mo5rK2DcSw4fggRRTvnHETYWEPwSu
        ovYzHJR+pOb04q46LwPoibX5bJ3zat8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-S_FlfM07Pn-9zz36HQXGKA-1; Wed, 14 Oct 2020 07:59:37 -0400
X-MC-Unique: S_FlfM07Pn-9zz36HQXGKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 712051084C82;
        Wed, 14 Oct 2020 11:59:35 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9100D6EF5A;
        Wed, 14 Oct 2020 11:59:32 +0000 (UTC)
Date:   Wed, 14 Oct 2020 13:59:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 5/9] perf tools: Pass build_id object to dso__set_build_id
Message-ID: <20201014115931.GA1382146@krava>
References: <20201013192441.1299447-1-jolsa@kernel.org>
 <20201013192441.1299447-6-jolsa@kernel.org>
 <20201014115144.GD3100363@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014115144.GD3100363@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:51:44AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 13, 2020 at 09:24:37PM +0200, Jiri Olsa escreveu:
> > Passing build_id object to dso__set_build_id, so it's easier
> > to initialize dos's build id object.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/dso.c            | 4 ++--
> >  tools/perf/util/dso.h            | 2 +-
> >  tools/perf/util/header.c         | 4 +++-
> >  tools/perf/util/symbol-minimal.c | 2 +-
> >  tools/perf/util/symbol.c         | 2 +-
> >  5 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 2f7f01ead9a1..4415ce83150b 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -1326,9 +1326,9 @@ void dso__put(struct dso *dso)
> >  		dso__delete(dso);
> >  }
> >  
> > -void dso__set_build_id(struct dso *dso, void *build_id)
> > +void dso__set_build_id(struct dso *dso, struct build_id *bid)
> >  {
> > -	memcpy(dso->bid.data, build_id, sizeof(dso->bid.data));
> > +	dso->bid = *bid;
> 
> Can't we use bid->size here?
> 
> 	dso->bid.size = bid->size;
> 	memcpy(dso->bid.data, bid->data, bid->size));
> 
> ?
> 
> Not worth it? Probably :-)

yea, I wonder compiler will do the same thing in both cases,
but I don't know ;-)

I wanted to demonstrate that it's the same object

jirka

