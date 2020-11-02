Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF42A320E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKBRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgKBRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604339404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDJ/RiCI+DkL83hKz9HhYrdiFyHAl2S8mdkiC/aSEWw=;
        b=bTMqqgK7U9POP77ZQUmn+39YDFtFy15vUyV1pS+5xYiljClNMxKAqPrYaVTAwD6sOy87Qf
        6AFmaa5PO40hF8vLI87bS1CkPTMYSqLer6tQYp3NHws8XgWrYW2CDkvOj5tCODlT28R0ax
        5ke8eA6XCsAhh+JguOs/doRW+U/p0es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Fl7CTRwjNMC-cprDtkPD8w-1; Mon, 02 Nov 2020 12:50:01 -0500
X-MC-Unique: Fl7CTRwjNMC-cprDtkPD8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 831F980B70A;
        Mon,  2 Nov 2020 17:49:59 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 489EA75126;
        Mon,  2 Nov 2020 17:49:57 +0000 (UTC)
Date:   Mon, 2 Nov 2020 18:49:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Add missing swap for cgroup events
Message-ID: <20201102174956.GA3597846@krava>
References: <20201102140228.303657-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102140228.303657-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:02:28PM +0900, Namhyung Kim wrote:
> It was missed to add a swap function for PERF_RECORD_CGROUP.
> 
> Fixes: ba78c1c5461c ("perf tools: Basic support for CGROUP event")

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7a5f03764702..c44c8e8c09c6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -710,6 +710,18 @@ static void perf_event__namespaces_swap(union perf_event *event,
>  		swap_sample_id_all(event, &event->namespaces.link_info[i]);
>  }
>  
> +static void perf_event__cgroup_swap(union perf_event *event, bool sample_id_all)
> +{
> +	event->cgroup.id = bswap_64(event->cgroup.id);
> +
> +	if (sample_id_all) {
> +		void *data = &event->cgroup.path;
> +
> +		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
> +		swap_sample_id_all(event, data);
> +	}
> +}
> +
>  static u8 revbyte(u8 b)
>  {
>  	int rev = (b >> 4) | ((b & 0xf) << 4);
> @@ -952,6 +964,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
>  	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
>  	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
>  	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
> +	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
>  	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
>  	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
>  	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 

