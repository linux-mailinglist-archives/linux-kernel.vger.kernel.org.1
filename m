Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7062A2FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgKBQgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:36:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbgKBQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604334972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IEIX5FvfSSNZ7zMv2iBsljeEmNk8AhaSYR3sfQ7m8o=;
        b=ZraIJE00H+UTI990P0lEfJD0Pwi5s2qINUs3je//OkhEiAg6G0ZoNJ0DlIQ5QSzwdniFnb
        a4pvxFAQ5jl9BR7EumU6QGpf1D+bIFH4PRZ67oxZ/17lopPdG7dMK0Dig2XTFAZCojZVXx
        aUnZB7JQ4+WyisEKlNjP0oqlH8KKJxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-0-mixDYdOuiPnshFjAzeFw-1; Mon, 02 Nov 2020 11:36:07 -0500
X-MC-Unique: 0-mixDYdOuiPnshFjAzeFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CF3B18A62A5;
        Mon,  2 Nov 2020 16:36:04 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 686D55D9D2;
        Mon,  2 Nov 2020 16:36:00 +0000 (UTC)
Date:   Mon, 2 Nov 2020 17:35:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/9] perf c2c: Support AUX trace
Message-ID: <20201102163559.GB3405508@krava>
References: <20201028063813.8562-1-leo.yan@linaro.org>
 <20201028063813.8562-7-leo.yan@linaro.org>
 <20201031202103.GA3380099@krava>
 <20201102100823.GB6633@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102100823.GB6633@leoy-ThinkPad-X240s>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:08:23PM +0800, Leo Yan wrote:
> Hi Jiri,
> 
> On Sat, Oct 31, 2020 at 09:21:03PM +0100, Jiri Olsa wrote:
> > On Wed, Oct 28, 2020 at 02:38:10PM +0800, Leo Yan wrote:
> > > This patches adds the AUX callbacks in session structure, so support
> > > AUX trace for "perf c2c" tool.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/builtin-c2c.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > > index 4d1a08e38233..24f4af997aab 100644
> > > --- a/tools/perf/builtin-c2c.c
> > > +++ b/tools/perf/builtin-c2c.c
> > > @@ -369,6 +369,10 @@ static struct perf_c2c c2c = {
> > >  		.exit		= perf_event__process_exit,
> > >  		.fork		= perf_event__process_fork,
> > >  		.lost		= perf_event__process_lost,
> > > +		.attr		= perf_event__process_attr,
> > > +		.auxtrace_info  = perf_event__process_auxtrace_info,
> > > +		.auxtrace       = perf_event__process_auxtrace,
> > > +		.auxtrace_error = perf_event__process_auxtrace_error,
> > 
> > so this will process aux data, but don't you have to
> > say which events you want to synthesize?
> > 
> > like in script/report via --itrace option?
> 
> Indeed, we need to assign "session->itrace_synth_opts", otherwise, the
> tool cannot output synthesized samples.
> 
> I tried to keep this patch set as small as possible, for easier
> reviewing.
> 
> Comparing to the previous patch set, I moved out the patch "perf
> auxtrace: Add option '-M' for memory events" [1] from this patch set,
> at the end my purpose is to introduce the itrace option '-M' to
> synthesize memory event; and "perf c2c" tool can use memory event
> for output result.  Thus "perf c2c" needs to add itrace_synth_opts:
> 
>   struct itrace_synth_opts itrace_synth_opts = {
>           .set = true,
>           .mem = true,            /* Memory samples */
>           .default_no_sample = true,
>   };
> 
> > aybe arm differs from x86 in this, and it's happening
> > in the background.. I have no idea ;-)
> 
> There should have no any difference between archs for 'itrace'
> behaviour.
> 
> Since I moved the patch "perf auxtrace: Add option '-M' for memory
> events" out from this patch set, thus I also left out the code for
> adding itrace_synth_opts.  This introduced confusion for reviewing the
> change (sorry!), I will add back the patch "perf auxtrace: Add option
> '-M' for memory events" and add itrace_synth_opts for perf mem/c2c in
> next patch set.

ok either way works for me, I just wanted to understand ;-)

thanks,
jirka

