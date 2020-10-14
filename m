Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A260F28E12E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgJNNV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgJNNV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602681715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9NVdj+kPwJdRormeMamG7afab/t3Y2i3JPFl6pfr44=;
        b=ULlB56fU32TB+1ADWKDTWw/rkCYBnh+HP0EH/zmoOZiXev8Sks9u/vvzBP+ikmrw3Qu8P+
        z6F6JgclJW8fFT3F/BfMiL6qmoMxkwLGnlpg0KNCNoI/hGd2IKfXdFRgthYbW1RAXkXQNe
        vsVotUdxMrxwYEUwPdXCh7KLLBXsCYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-Jw2jOGwcOAidoAbZhkdD6Q-1; Wed, 14 Oct 2020 09:21:51 -0400
X-MC-Unique: Jw2jOGwcOAidoAbZhkdD6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8C8914703;
        Wed, 14 Oct 2020 13:21:49 +0000 (UTC)
Received: from krava (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3E3C5D98D;
        Wed, 14 Oct 2020 13:21:46 +0000 (UTC)
Date:   Wed, 14 Oct 2020 15:21:46 +0200
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
Subject: Re: [PATCH 7/9] perf tools: Add size to struct
 perf_record_header_build_id
Message-ID: <20201014132146.GB1382146@krava>
References: <20201013192441.1299447-1-jolsa@kernel.org>
 <20201013192441.1299447-8-jolsa@kernel.org>
 <20201014115908.GE3100363@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014115908.GE3100363@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:59:08AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 13, 2020 at 09:24:39PM +0200, Jiri Olsa escreveu:
> > We do not store size with build ids in perf data,
> > but there's enough space to do it. Adding misc bit
> > PERF_RECORD_MISC_BUILD_ID_SIZE to mark build id event
> > with size.
> > 
> > With this fix the dso with md5 build id will have correct
> > build id data and will be usable for debuginfod processing
> > if needed (coming in following patches).
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/perf/include/perf/event.h | 12 +++++++++++-
> >  tools/perf/util/build-id.c          |  8 +++++---
> >  tools/perf/util/header.c            | 10 +++++++---
> >  3 files changed, 23 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > index a6dbba6b9073..988c539bedb6 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -201,10 +201,20 @@ struct perf_record_header_tracing_data {
> >  	__u32			 size;
> >  };
> >  
> > +#define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
> > +
> >  struct perf_record_header_build_id {
> >  	struct perf_event_header header;
> >  	pid_t			 pid;
> > -	__u8			 build_id[24];
> > +	union {
> > +		__u8		 build_id[24];
> > +		struct {
> > +			__u8	 data[20];
> > +			__u8	 size;
> > +			__u8	 reserved1__;
> > +			__u16	 reserved2__;
> > +		};
> > +	};
> >  	char			 filename[];
> >  };
> 
> Hey, shouldn't we just append the extra info at the end, i.e. keep it
> like:
> 
>  struct perf_record_header_build_id {
>  	struct perf_event_header header;
>  	pid_t			 pid;
> 	__u8			 build_id[24];
>  	char			 filename[];
> 	__u8			 size;
>  };
> 
> 
> No need for PERF_RECORD_MISC_BUILD_ID_SIZE, older tools will continue
> working with new perf data files.

hum, then how would we tell if the last byte (size) is present or not?

> 
> OTOH BUILD_ID_SIZE is 20 and the space on this header is 24, so the last
> 4 bytes were not being used, so older tools don't look into it, they
> should continue working, have you tested this case? I.e. getting the
> perf binary in, say, fedora and check that it works with this new
> perf_record_header_build_id layout?

yes, that still works (tested), because we copied only 20 bytes
of the build_id[24] and did not care about the rest

jirka

