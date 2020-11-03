Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C22A4500
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgKCMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgKCMYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:24:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1E122226;
        Tue,  3 Nov 2020 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604406290;
        bh=uzSsHKYI3AVS8O5Hh4QZhR5AO/zJNYM2a2bpKbAz1u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xhxoBa4efutXu+ggGvefkqdSlZqAT9ERj5Tm1iKr1FOGZbUFpMjgIiJj1WO9yARCw
         ahxKfMtRlAcTATkVm3uWU/VFu/4w462uxrC4fe45LdyeN2nsB9w1g1MqgM+DMV1iLW
         eYyuHUdR/1oEe7QAUhWPXUxqBZgc4Sw/MdGBpifw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2DC5540452; Tue,  3 Nov 2020 09:24:48 -0300 (-03)
Date:   Tue, 3 Nov 2020 09:24:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Add missing swap for cgroup events
Message-ID: <20201103122448.GF151027@kernel.org>
References: <20201102140228.303657-1-namhyung@kernel.org>
 <20201102174956.GA3597846@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102174956.GA3597846@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 02, 2020 at 06:49:56PM +0100, Jiri Olsa escreveu:
> On Mon, Nov 02, 2020 at 11:02:28PM +0900, Namhyung Kim wrote:
> > It was missed to add a swap function for PERF_RECORD_CGROUP.
> > 
> > Fixes: ba78c1c5461c ("perf tools: Basic support for CGROUP event")
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>


Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/session.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 7a5f03764702..c44c8e8c09c6 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -710,6 +710,18 @@ static void perf_event__namespaces_swap(union perf_event *event,
> >  		swap_sample_id_all(event, &event->namespaces.link_info[i]);
> >  }
> >  
> > +static void perf_event__cgroup_swap(union perf_event *event, bool sample_id_all)
> > +{
> > +	event->cgroup.id = bswap_64(event->cgroup.id);
> > +
> > +	if (sample_id_all) {
> > +		void *data = &event->cgroup.path;
> > +
> > +		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
> > +		swap_sample_id_all(event, data);
> > +	}
> > +}
> > +
> >  static u8 revbyte(u8 b)
> >  {
> >  	int rev = (b >> 4) | ((b & 0xf) << 4);
> > @@ -952,6 +964,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
> >  	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
> >  	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
> >  	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
> > +	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
> >  	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
> >  	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
> >  	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
> > -- 
> > 2.29.1.341.ge80a0c044ae-goog
> > 
> 

-- 

- Arnaldo
