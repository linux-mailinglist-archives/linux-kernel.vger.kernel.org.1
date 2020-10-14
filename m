Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA428E359
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgJNPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbgJNPcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:32:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F272222A;
        Wed, 14 Oct 2020 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602689573;
        bh=WM1Hvr8bDTrmnCVWxoy9L5zQxwvffkXzzjQoeQZmZrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSncnFiuHPhHXthkNcNiNIEg+GUfiy8tlVrNkUWH5ooxa2gDIJkIKRz0+ET2nBCKB
         6Hze9M0Y3pZN28INCDpiyC6QLgr//mp+h5i/0zMdQZCfnv4MIUXeJBmjE6Wt6iU8da
         VrTDc59uJyBSx5uCLXuFQhSnQl2nPWyRu58sGZ4k=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BAAE24047F; Wed, 14 Oct 2020 12:32:50 -0300 (-03)
Date:   Wed, 14 Oct 2020 12:32:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 7/9] perf tools: Add size to struct
 perf_record_header_build_id
Message-ID: <20201014153250.GK3100363@kernel.org>
References: <20201013192441.1299447-1-jolsa@kernel.org>
 <20201013192441.1299447-8-jolsa@kernel.org>
 <20201014115908.GE3100363@kernel.org>
 <20201014132146.GB1382146@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014132146.GB1382146@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 14, 2020 at 03:21:46PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 14, 2020 at 08:59:08AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 13, 2020 at 09:24:39PM +0200, Jiri Olsa escreveu:
> > > We do not store size with build ids in perf data,
> > > but there's enough space to do it. Adding misc bit
> > > PERF_RECORD_MISC_BUILD_ID_SIZE to mark build id event
> > > with size.
> > > 
> > > With this fix the dso with md5 build id will have correct
> > > build id data and will be usable for debuginfod processing
> > > if needed (coming in following patches).
> > > 
> > > Acked-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/perf/include/perf/event.h | 12 +++++++++++-
> > >  tools/perf/util/build-id.c          |  8 +++++---
> > >  tools/perf/util/header.c            | 10 +++++++---
> > >  3 files changed, 23 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > > index a6dbba6b9073..988c539bedb6 100644
> > > --- a/tools/lib/perf/include/perf/event.h
> > > +++ b/tools/lib/perf/include/perf/event.h
> > > @@ -201,10 +201,20 @@ struct perf_record_header_tracing_data {
> > >  	__u32			 size;
> > >  };
> > >  
> > > +#define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
> > > +
> > >  struct perf_record_header_build_id {
> > >  	struct perf_event_header header;
> > >  	pid_t			 pid;
> > > -	__u8			 build_id[24];
> > > +	union {
> > > +		__u8		 build_id[24];
> > > +		struct {
> > > +			__u8	 data[20];
> > > +			__u8	 size;
> > > +			__u8	 reserved1__;
> > > +			__u16	 reserved2__;
> > > +		};
> > > +	};
> > >  	char			 filename[];
> > >  };

> > Hey, shouldn't we just append the extra info at the end, i.e. keep it
> > like:

> >  struct perf_record_header_build_id {
> >  	struct perf_event_header header;
> >  	pid_t			 pid;
> > 	__u8			 build_id[24];
> >  	char			 filename[];
> > 	__u8			 size;
> >  };

> > No need for PERF_RECORD_MISC_BUILD_ID_SIZE, older tools will continue
> > working with new perf data files.
 
> hum, then how would we tell if the last byte (size) is present or not?

IT would be different than '\0' ;-)

- Arnaldo
 
> > 
> > OTOH BUILD_ID_SIZE is 20 and the space on this header is 24, so the last
> > 4 bytes were not being used, so older tools don't look into it, they
> > should continue working, have you tested this case? I.e. getting the
> > perf binary in, say, fedora and check that it works with this new
> > perf_record_header_build_id layout?
> 
> yes, that still works (tested), because we copied only 20 bytes
> of the build_id[24] and did not care about the rest

Great that you actually tested it.

- Arnaldo
