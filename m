Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55A297D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761991AbgJXPoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761980AbgJXPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8xLHDe8rVD+OjMq0aaRegU8pV9lJncI+VX4k02mtvQY=;
        b=DGNgTSP3duGVtn0jYfSM0hx0CVwwNHEooFynwuCJJPRzbTlvB7pQGBqy/VBpkNr+a2ioIj
        UXdffso6ez3xcdZ/gBAcigik0gtfEwvJoHoyrl6qyEzWVG6YiqWdbzENyGl9B5hZiBJlJG
        YxZ+3aUsLFYpG/KDGwwjDs1BppqMIuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-xU-ie3EkN3OmGZ7mrA7RuQ-1; Sat, 24 Oct 2020 11:44:02 -0400
X-MC-Unique: xU-ie3EkN3OmGZ7mrA7RuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A72D11006CB0;
        Sat, 24 Oct 2020 15:44:00 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id A436610013D0;
        Sat, 24 Oct 2020 15:43:58 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:43:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 12/15] perf record: introduce thread local variable
 for trace streaming
Message-ID: <20201024154357.GD2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:07:00PM +0300, Alexey Budankov wrote:
> 
> Introduce thread local variable and use it for threaded trace streaming.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 71 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 89cb8e913fb3..3b7e9026f25b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -101,6 +101,8 @@ struct thread_data {
>  	u64		   bytes_written;
>  };
>  
> +static __thread struct thread_data *thread;
> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
> @@ -587,7 +589,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  		}
>  	}
>  
> -	rec->samples++;
> +	if (thread)
> +		thread->samples++;
> +	else
> +		rec->samples++;

this is really wrong, let's keep just single samples counter
ditto for all the other places in this patch

SNIP

> -		if (hits == rec->samples) {
> +		if (thread)
> +			hits1 = thread->samples;
> +		else
> +			hits1 = rec->samples;
> +
> +		if (hits0 == hits1) {
>  			if (done || draining)
>  				break;
> -			err = evlist__poll(rec->evlist, -1);
> +
> +			if (thread)
> +				err = fdarray__poll(&thread->pollfd, -1);
> +			else
> +				err = evlist__poll(rec->evlist, -1);

same here, why do we have the __thread struct then?

jirka

