Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19652B19AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKMLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgKMLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605265776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rimX36Qvv5sOLJryfQ7O8d6YF2GdBPtAORACH4c6Ctw=;
        b=PcYB/Ct+VqTNec0AYxNTPnuMJ5DalkwDloUgcMhtoVKMAoG6QM5gAu16xCSZ5SIf+g+MXa
        8FWQVJAIkpz3CfydIaYdyAX8EzUs3gcKtSgOXnbTHk0i+J9zy/6k9etmhsZfyw/Wqa+rVB
        VK5kIKNP3Zy5bCYbGJXJZFMPJT+ysFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-EpMIlOTaO7SD0LMhxXM2nA-1; Fri, 13 Nov 2020 06:09:32 -0500
X-MC-Unique: EpMIlOTaO7SD0LMhxXM2nA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91FC5100E32C;
        Fri, 13 Nov 2020 11:09:30 +0000 (UTC)
Received: from krava (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 994D05F9DF;
        Fri, 13 Nov 2020 11:09:27 +0000 (UTC)
Date:   Fri, 13 Nov 2020 12:09:26 +0100
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/24] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201113110926.GE753418@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-25-jolsa@kernel.org>
 <20201113044000.GC167797@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113044000.GC167797@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 01:40:00PM +0900, Namhyung Kim wrote:
> On Mon, Nov 09, 2020 at 10:54:15PM +0100, Jiri Olsa wrote:
> > Adding --buildid-mmap option to enable build id in mmap2 events.
> > It will only work if there's kernel support for that and it disables
> > build id cache (implies --no-buildid).
> > 
> > It's also possible to enable it permanently via config option
> > in ~.perfconfig file:
> > 
> >   [record]
> >   build-id=mmap
> 
> You also need to update the documentation.

right, forgot doc for the config option

SNIP

> >  		    "append timestamp to output filename"),
> >  	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> > @@ -2657,6 +2662,21 @@ int cmd_record(int argc, const char **argv)
> >  
> >  	}
> >  
> > +	if (rec->buildid_mmap) {
> > +		if (!perf_can_record_build_id()) {
> > +			pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> > +			err = -EINVAL;
> > +			goto out_opts;
> > +		}
> > +		pr_debug("Enabling build id in mmap2 events.\n");
> > +		/* Enable mmap build id synthesizing. */
> > +		symbol_conf.buildid_mmap2 = true;
> > +		/* Enable perf_event_attr::build_id bit. */
> > +		rec->opts.build_id = true;
> > +		/* Disable build id cache. */
> > +		rec->no_buildid = true;
> 
> I'm afraid this can make it miss some build-id in the end because of
> the possibility of the failure.

with following fix (already merged):
  b33164f2bd1c bpf: Iterate through all PT_NOTE sections when looking for build id

I could see high rate of build id being retrieved

I'll make new numbers for next version, but I think we can neglect
the failure, considering that we pick only 'hit' objects out of all
of them

also enabling the build id cache for this would go against the
purpose why I'd like to have this.. so hopefuly the numbers
will be convincing ;-)

jirka

