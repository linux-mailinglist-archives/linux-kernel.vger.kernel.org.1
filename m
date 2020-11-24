Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763A32C29CB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbgKXOg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389142AbgKXOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606228613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kymzfJ2oxkSUJR89/SsMrJNlPC5DR18c0lpdXSeyrFg=;
        b=Kmaw05WWBBAxWG2SgApsrmzr8QcSyCj0W7UezvAJuI0Ig/l4Hdq6pEpSDe/Fv+stmMoPD0
        rlRwFpgWMLfe+WLgd/RNPK0ux7hA/SVUdhYSFl1A9K9DcmQFgPV2zRxY+Rcd7Z7sfe9CKV
        JbYuGNf41aGOo1Yan/mAyoXMyN1wAc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-w6QARhs9OMa5dJfhMJ7fsQ-1; Tue, 24 Nov 2020 09:36:51 -0500
X-MC-Unique: w6QARhs9OMa5dJfhMJ7fsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2A7A18B6140;
        Tue, 24 Nov 2020 14:36:48 +0000 (UTC)
Received: from krava (unknown [10.40.193.173])
        by smtp.corp.redhat.com (Postfix) with SMTP id A307619C44;
        Tue, 24 Nov 2020 14:36:46 +0000 (UTC)
Date:   Tue, 24 Nov 2020 15:36:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/3] Revert "perf session: Fix decompression of
 PERF_RECORD_COMPRESSED records"
Message-ID: <20201124143645.GD2088148@krava>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124102919.15312-1-oss@malat.biz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:29:15AM +0100, Petr Malat wrote:
> Both mmapped and compressed events can be split by the buffer boundary,
> it doesn't make sense to handle them differently.

hi,
I'm going to need more than this, if there's a problem
with current code please share more details, what's
broken and how it shows

thanks,
jirka

> 
> Fixes: bb1835a3b86c ("perf session: Fix decompression of PERF_RECORD_COMPRESSED records")
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  tools/perf/util/session.c | 44 +++++++++++++++------------------------
>  1 file changed, 17 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 098080287c68..0d7a59c1aeb6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2038,8 +2038,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  }
>  
>  static union perf_event *
> -prefetch_event(char *buf, u64 head, size_t mmap_size,
> -	       bool needs_swap, union perf_event *error)
> +fetch_mmaped_event(struct perf_session *session,
> +		   u64 head, size_t mmap_size, char *buf)
>  {
>  	union perf_event *event;
>  
> @@ -2051,32 +2051,20 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
>  		return NULL;
>  
>  	event = (union perf_event *)(buf + head);
> -	if (needs_swap)
> -		perf_event_header__bswap(&event->header);
> -
> -	if (head + event->header.size <= mmap_size)
> -		return event;
>  
> -	/* We're not fetching the event so swap back again */
> -	if (needs_swap)
> +	if (session->header.needs_swap)
>  		perf_event_header__bswap(&event->header);
>  
> -	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
> -		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
> -
> -	return error;
> -}
> -
> -static union perf_event *
> -fetch_mmaped_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
> -{
> -	return prefetch_event(buf, head, mmap_size, needs_swap, ERR_PTR(-EINVAL));
> -}
> +	if (head + event->header.size > mmap_size) {
> +		/* We're not fetching the event so swap back again */
> +		if (session->header.needs_swap)
> +			perf_event_header__bswap(&event->header);
> +		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
> +			 __func__, head, event->header.size, mmap_size);
> +		return ERR_PTR(-EINVAL);
> +	}
>  
> -static union perf_event *
> -fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
> -{
> -	return prefetch_event(buf, head, mmap_size, needs_swap, NULL);
> +	return event;
>  }
>  
>  static int __perf_session__process_decomp_events(struct perf_session *session)
> @@ -2089,8 +2077,10 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  		return 0;
>  
>  	while (decomp->head < decomp->size && !session_done()) {
> -		union perf_event *event = fetch_decomp_event(decomp->head, decomp->size, decomp->data,
> -							     session->header.needs_swap);
> +		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
> +
> +		if (IS_ERR(event))
> +			return PTR_ERR(event);
>  
>  		if (!event)
>  			break;
> @@ -2190,7 +2180,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	}
>  
>  more:
> -	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
> +	event = fetch_mmaped_event(session, head, mmap_size, buf);
>  	if (IS_ERR(event))
>  		return PTR_ERR(event);
>  
> -- 
> 2.20.1
> 

