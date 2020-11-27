Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830302C68E4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgK0Pny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730366AbgK0Pny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606491833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8J05ulLOsiD7VK6s+teJvW++u29lCCcdGf+VvJyAJE=;
        b=Zm1FWcyWl+WI0ouohToc0f1VDyn1fLxbDcJadi9lE76RdteI6pJMtTB6EY52PhlH9SuJkv
        ep4zxM/a01DfXzkNey9UXFLHLqlFipEl2ljwEIB2UhX3MaluLr4Bu9hct7a5xM9cb8FznQ
        7Ll4ZCpH5A+uoerS+Mnd0MmiBMGdXJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-FamK5uCJPH2xfJO0gAbA4Q-1; Fri, 27 Nov 2020 10:43:49 -0500
X-MC-Unique: FamK5uCJPH2xfJO0gAbA4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB6D73FD1;
        Fri, 27 Nov 2020 15:43:47 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id CAE7F60BF1;
        Fri, 27 Nov 2020 15:43:45 +0000 (UTC)
Date:   Fri, 27 Nov 2020 16:43:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf diff: fix error return value in __cmd_diff()
Message-ID: <20201127154344.GA2729821@krava>
References: <20201124103652.438-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124103652.438-1-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 06:36:52PM +0800, Zhen Lei wrote:
> An appropriate return value should be set on the failed path.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-diff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 584e2e1a3793..cefc71506409 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1222,8 +1222,10 @@ static int __cmd_diff(void)
>  		if (compute == COMPUTE_STREAM) {
>  			d->evlist_streams = evlist__create_streams(
>  						d->session->evlist, 5);
> -			if (!d->evlist_streams)
> +			if (!d->evlist_streams) {
> +				ret = -ENOMEM;
>  				goto out_delete;
> +			}
>  		}
>  	}
>  
> -- 
> 2.26.0.106.g9fadedd
> 
> 

