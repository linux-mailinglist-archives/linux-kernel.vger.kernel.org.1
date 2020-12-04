Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F22CF77F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgLDX3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgLDX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607124468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohTS7EreoYXvKStB5ImYk5vobWiE5nT6sWzMWLbKmyI=;
        b=Y6FOHQoQdQR1QClVjCFKKPhZVpHMfkD0d8XAn2HI1Js4U4QKqsFIEbgaHLDPdyDIhNNWtc
        uhBA9OC+cfUWthu1VDBx+CvwQ9rot4biEm/2TzM843VZsbRENlVJ3pzOqThijid6e+j78d
        cNcSaXJ8UKbSc90eAeNcJupFQ+XSAHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-4DKl_I2TO0O1QU5wR9MXhw-1; Fri, 04 Dec 2020 18:27:44 -0500
X-MC-Unique: 4DKl_I2TO0O1QU5wR9MXhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37E0A180A086;
        Fri,  4 Dec 2020 23:27:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id EECE26087C;
        Fri,  4 Dec 2020 23:27:40 +0000 (UTC)
Date:   Sat, 5 Dec 2020 00:27:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 03/12] perf script: Support data page size
Message-ID: <20201204232739.GI3613628@krava>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130172803.2676-4-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:27:54AM -0800, kan.liang@linux.intel.com wrote:

SNIP

>  #endif /* __PERF_RECORD_H */
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5cc722b6fe7c..e73f579f31d3 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1260,10 +1260,30 @@ static void dump_event(struct evlist *evlist, union perf_event *event,
>  	       event->header.size, perf_event__name(event->header.type));
>  }
>  
> +char *get_page_size_name(u64 size, char *str)
> +{
> +	const char suffixes[5] = { 'B', 'K', 'M', 'G', 'T' };
> +	int i;
> +
> +	if (size == 0) {
> +		snprintf(str, PAGE_SIZE_NAME_LEN, "%s", "N/A");
> +		return str;
> +	}
> +	for (i = 0; i < 5; i++) {
> +		if (size < 1024)
> +			break;
> +		size /= 1024;
> +	}
> +
> +	snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
> +	return str;
> +}

we have the same code in unit_number__scnprintf,
you just need to add support for 'T' and 'N/A'

jirka

