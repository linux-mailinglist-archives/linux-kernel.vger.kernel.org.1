Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A028297D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761916AbgJXPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761905AbgJXPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/SAObKvoFYpmQ+QYKJsoy0EO6zCZgavM+XPxIgmLRg8=;
        b=BUhYkVhsZNbwoQyfauDtlN9m9mrLHex17UYSgqPhxZgVrEIryTwLbzQ58UjUtSHT83Jk+i
        f2Luv0Us16tqrAGLqtmwE+657q8UpNf/Vz5Km8OqHqZJNk6r5C6yDYsobgeQfo95c0fp47
        EXoGL7epETvxVrUW4dgSb4hts8LcUx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Jzgn3x0GNTirFAfIBk2YOQ-1; Sat, 24 Oct 2020 11:43:22 -0400
X-MC-Unique: Jzgn3x0GNTirFAfIBk2YOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D26803F78;
        Sat, 24 Oct 2020 15:43:20 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id D0F2955793;
        Sat, 24 Oct 2020 15:43:18 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:43:17 +0200
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
Subject: Re: [PATCH v2 03/15] perf data: open data directory in read access
 mode
Message-ID: <20201024154317.GB2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 06:57:53PM +0300, Alexey Budankov wrote:
> 
> Open files located at trace data directory in case read access
> mode is requested. File are opened and its fds assigned to
> perf_data dir files especially for loading data directories
> content in perf report mode.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/data.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index c47aa34fdc0a..6ad61ac6ba67 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
>  		return -1;
>  
>  	ret = open_file(data);
> +	if (!ret && perf_data__is_dir(data)) {
> +		if (perf_data__is_read(data))
> +			ret = perf_data__open_dir(data);
> +	}

perf_data__open_dir is also called from perf_session__new
is it called twice?

jirka

>  
>  	/* Cleanup whatever we managed to create so far. */
>  	if (ret && perf_data__is_write(data))
> -- 
> 2.24.1
> 

