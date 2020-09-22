Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443D8274A42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIVUmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgIVUmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600807369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TL9ZpdvJq+3pcigOCf3AY8p/+h7Z/wEUR3BPPFIoghQ=;
        b=KDTcWyP+ChhW9tDbZmdvHF/+rMtv5FTKzB1YQv6QpYU1FzkisnIZ6vVDqPf5YhheuOu5wR
        01mxrPFa1Ac75djBRN+vQKyXeCjGigNR9DyQKN+ly+qh7NiX0cpWv4yevK0psYnAB9MFRn
        pwlUPg5fHrAjfiuDHp1zMfegIXnGtZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-dc9UP2NENY24bQSdwG8jZA-1; Tue, 22 Sep 2020 16:42:44 -0400
X-MC-Unique: dc9UP2NENY24bQSdwG8jZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 466C31074643;
        Tue, 22 Sep 2020 20:42:43 +0000 (UTC)
Received: from krava (ovpn-112-28.ams2.redhat.com [10.36.112.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id 404021002C00;
        Tue, 22 Sep 2020 20:42:41 +0000 (UTC)
Date:   Tue, 22 Sep 2020 22:42:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/3] perf list: Add 'pfm' to list libpfm4 events
Message-ID: <20200922204240.GB2893484@krava>
References: <20200909055849.469612-1-namhyung@kernel.org>
 <20200909055849.469612-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909055849.469612-3-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 02:58:49PM +0900, Namhyung Kim wrote:

SNIP

>  int parse_events__is_hardcoded_term(struct parse_events_term *term)
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index d735acb6c29c..26ae2c8c0932 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -12,6 +12,7 @@
>  #include "util/parse-events.h"
>  #include "util/pmu.h"
>  #include "util/pfm.h"
> +#include "util/string2.h"
>  
>  #include <string.h>
>  #include <linux/kernel.h>
> @@ -227,7 +228,7 @@ print_libpfm_events_raw(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
>  		printf("%s::%s\n", pinfo->name, info->name);
>  }
>  
> -void print_libpfm_events(bool name_only, bool long_desc)
> +void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc)
>  {
>  	pfm_event_info_t info;
>  	pfm_pmu_info_t pinfo;
> @@ -265,6 +266,9 @@ void print_libpfm_events(bool name_only, bool long_desc)
>  			if (ret != PFM_SUCCESS)
>  				continue;
>  
> +			if (event_glob && !strglobmatch_nocase(info.name, event_glob))
> +				continue;

you could mentioned in changelog that it also enables glob
matching for pfm events.. but other than then looks ok

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> +
>  			if (!name_only && !printed_pmu) {
>  				printf("%s:\n", pinfo.name);
>  				printed_pmu = true;
> diff --git a/tools/perf/util/pfm.h b/tools/perf/util/pfm.h
> index 7d70dda87012..036e2d97b260 100644
> --- a/tools/perf/util/pfm.h
> +++ b/tools/perf/util/pfm.h
> @@ -13,7 +13,7 @@
>  int parse_libpfm_events_option(const struct option *opt, const char *str,
>  			int unset);
>  
> -void print_libpfm_events(bool name_only, bool long_desc);
> +void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc);
>  
>  #else
>  #include <linux/compiler.h>
> @@ -26,7 +26,8 @@ static inline int parse_libpfm_events_option(
>  	return 0;
>  }
>  
> -static inline void print_libpfm_events(bool name_only __maybe_unused,
> +static inline void print_libpfm_events(const char *event_glob __maybe_unused,
> +				       bool name_only __maybe_unused,
>  				       bool long_desc __maybe_unused)
>  {
>  }
> -- 
> 2.28.0.526.ge36021eeef-goog
> 

