Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3A3018D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 00:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAWXNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 18:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbhAWXM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 18:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611443490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tb/FcJ9LN21iyf86898QHOEQVGGymrdYI09iiM6rLos=;
        b=X3qk0mei4XTcSu1cnrcIi4YQ0um4o6BvQtfLSdjOVVujpKgLZHn+OT7hMM/tI2eJXXAVVz
        UHOVxlP5ZTJbFIz0/YVEsSKWDBiTAfSSz1iUW42/n7tuDha4LOvCgvsAANBLkovG1NE/FP
        Ln18YUsH8vkIPFD9js1kAsUDsAsqW94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-AMULYCf2N1i2STvk5BS6zQ-1; Sat, 23 Jan 2021 18:11:28 -0500
X-MC-Unique: AMULYCf2N1i2STvk5BS6zQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D145010054FF;
        Sat, 23 Jan 2021 23:11:26 +0000 (UTC)
Received: from krava (unknown [10.40.192.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id F232E60BFA;
        Sat, 23 Jan 2021 23:11:25 +0000 (UTC)
Date:   Sun, 24 Jan 2021 00:11:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Automatically group aux-output events
Message-ID: <20210123231125.GC138414@krava>
References: <20210121140418.14705-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121140418.14705-1-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:04:18PM +0200, Adrian Hunter wrote:
> aux-output events need to have an AUX area event as the group leader.
> However, grouping events does not allow the AUX area event to be given
> an address filter because the --filter option must come after the event,
> which conflicts with the grouping syntax.
> 
> To allow filtering in that case, automatically create a group since that
> is the requirement anyway.
> 
> Example: (requires Intel Tremont)
> 
>   perf record -c 500 -e 'intel_pt//u' --filter 'filter main @ /bin/ls' -e 'cycles/aux-output/pp' ls

great, nice to see this working

jirka

> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-record.c |  2 ++
>  tools/perf/util/auxtrace.c  | 15 +++++++++++++++
>  tools/perf/util/auxtrace.h  |  6 ++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8a0127d4fb52..687f1449a845 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -731,6 +731,8 @@ static int record__auxtrace_init(struct record *rec)
>  	if (err)
>  		return err;
>  
> +	auxtrace_regroup_aux_output(rec->evlist);
> +
>  	return auxtrace_parse_filters(rec->evlist);
>  }
>  
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a60878498139..953f4afacd3b 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -788,6 +788,21 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
>  	return auxtrace_validate_aux_sample_size(evlist, opts);
>  }
>  
> +void auxtrace_regroup_aux_output(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *aux_evsel = NULL;
> +	struct evsel_config_term *term;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel__is_aux_event(evsel))
> +			aux_evsel = evsel;
> +		term = evsel__get_config_term(evsel, AUX_OUTPUT);
> +		/* If possible, group with the AUX event */
> +		if (term && aux_evsel)
> +			evlist__regroup(evlist, aux_evsel, evsel);
> +	}
> +}
> +
>  struct auxtrace_record *__weak
>  auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
>  {
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 7e5c9e1552bd..a4fbb33b7245 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -559,6 +559,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  int auxtrace_parse_sample_options(struct auxtrace_record *itr,
>  				  struct evlist *evlist,
>  				  struct record_opts *opts, const char *str);
> +void auxtrace_regroup_aux_output(struct evlist *evlist);
>  int auxtrace_record__options(struct auxtrace_record *itr,
>  			     struct evlist *evlist,
>  			     struct record_opts *opts);
> @@ -740,6 +741,11 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr __maybe_unused,
>  	return -EINVAL;
>  }
>  
> +static inline
> +void auxtrace_regroup_aux_output(struct evlist *evlist __maybe_unused)
> +{
> +}
> +
>  static inline
>  int auxtrace__process_event(struct perf_session *session __maybe_unused,
>  			    union perf_event *event __maybe_unused,
> -- 
> 2.17.1
> 

