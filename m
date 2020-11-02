Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C62A301C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgKBQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:42:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726865AbgKBQmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604335343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5EySfE5/KX52CRxGXz90zdeGjq93k6VPREHvKcPrTq0=;
        b=UbSIKheDJLC/Z8gWhbnIeA7EAuK3vFtxjVNMrpjF5kL9FY/AZQ2Z03ZFk8C+y82f7usY3V
        VySuGvmt3Wu+Rrk1dbQg3BRrZ6HEXjUH4DhCKjEHUIQK3xGrtbN9FMTT52G/fXdKZqzJ5N
        0oJelQKHHZOOCycWNxD/wGrisPM7ADI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-yT3E2-5-MgWLRrydahSFWg-1; Mon, 02 Nov 2020 11:42:19 -0500
X-MC-Unique: yT3E2-5-MgWLRrydahSFWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90ABD1084C8B;
        Mon,  2 Nov 2020 16:42:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id DB95019C78;
        Mon,  2 Nov 2020 16:42:14 +0000 (UTC)
Date:   Mon, 2 Nov 2020 17:42:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf lock: Correct field name "flags"
Message-ID: <20201102164213.GC3405508@krava>
References: <20201021003948.28817-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021003948.28817-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 08:39:47AM +0800, Leo Yan wrote:
> The tracepoint "lock:lock_acquire" contains field "flags" but not
> "flag".  Current code wrongly retrieves value from field "flag" and it
> always gets zero for the value, thus "perf lock" doesn't report the
> correct result.
> 
> This patch replaces the field name "flag" with "flags", so can read out
> the correct flags for locking.
> 
> Fixes: 746f16ec6ae3 ("perf lock: Use perf_evsel__intval and perf_session__set_tracepoints_handlers")

Acked-by: Jiri Olsa <jolsa@redhat.com>

btw it seems the issue was there event before that commit:
  acquire_event.flag = (int)raw_field_value(event, "flag", data);

thanks,
jirka

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index f0a1dbacb46c..5cecc1ad78e1 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -406,7 +406,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
>  	struct lock_seq_stat *seq;
>  	const char *name = evsel__strval(evsel, sample, "name");
>  	u64 tmp	 = evsel__intval(evsel, sample, "lockdep_addr");
> -	int flag = evsel__intval(evsel, sample, "flag");
> +	int flag = evsel__intval(evsel, sample, "flags");
>  
>  	memcpy(&addr, &tmp, sizeof(void *));
>  
> -- 
> 2.17.1
> 

