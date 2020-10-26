Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0F298A73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770035AbgJZKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1769886AbgJZKef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603708474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Xq4J7iLfWQtlFBeFy3nAXQsXnwL69jJ6Leu45C2zMs=;
        b=E38bOImiIBafvj6k8wjodsBAQRBfdbjzzdXT3ulJ3CfEPbpDWsX7PbcmA2U87tckcFE80v
        KZdGAejVDh5Q9wUtsdvJ/g4MzWTBfPa63K3lIzniZo/o2v8nkQijkrJQoWE66NrGcXeFJO
        Unm7G6x9K8YmLdfuFYnqa2AQ+g1y/qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-svnbSZQQOiuOL3np9H1ofQ-1; Mon, 26 Oct 2020 06:34:31 -0400
X-MC-Unique: svnbSZQQOiuOL3np9H1ofQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5907EC1A0;
        Mon, 26 Oct 2020 10:34:29 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F53955762;
        Mon, 26 Oct 2020 10:34:26 +0000 (UTC)
Date:   Mon, 26 Oct 2020 11:34:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Budankov <budankov.lore@gmail.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 12/15] perf record: introduce thread local variable
 for trace streaming
Message-ID: <20201026103426.GC2726983@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
 <20201024154357.GD2589351@krava>
 <6eb97205-4d13-6487-8e15-a85f63d3f0cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb97205-4d13-6487-8e15-a85f63d3f0cc@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:21:28AM +0300, Alexei Budankov wrote:
> 
> On 24.10.2020 18:43, Jiri Olsa wrote:
> > On Wed, Oct 21, 2020 at 07:07:00PM +0300, Alexey Budankov wrote:
> >>
> >> Introduce thread local variable and use it for threaded trace streaming.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-record.c | 71 ++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 62 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >> index 89cb8e913fb3..3b7e9026f25b 100644
> >> --- a/tools/perf/builtin-record.c
> >> +++ b/tools/perf/builtin-record.c
> >> @@ -101,6 +101,8 @@ struct thread_data {
> >>  	u64		   bytes_written;
> >>  };
> >>  
> >> +static __thread struct thread_data *thread;
> >> +
> >>  struct record {
> >>  	struct perf_tool	tool;
> >>  	struct record_opts	opts;
> >> @@ -587,7 +589,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
> >>  		}
> >>  	}
> >>  
> >> -	rec->samples++;
> >> +	if (thread)
> >> +		thread->samples++;
> >> +	else
> >> +		rec->samples++;
> > 
> > this is really wrong, let's keep just single samples counter
> > ditto for all the other places in this patch
> 
> This does look like data parallelism [1] which is very true for
> threaded trace streaming so your prototype design looks optimal.
> 
> For this specific place incrementing global counter in memory is
> less performant and faces scalability limitations as a number of
> cores grow.
> 
> Not sure why you have changed your mind.

I'm not sure I follow.. what I'm complaining about is to have
'samples' stat variable in separate locations for --threads
and --no-threads mode

jirka

> 
> Alexei
> 
> [1] https://en.wikipedia.org/wiki/Data_parallelism#:~:text=Data%20parallelism%20is%20parallelization%20across,on%20each%20element%20in%20parallel.
> 

