Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB225F989
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgIGLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 07:33:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32018 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729042AbgIGL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599478175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdatg3+EIvbmCx4rquRr8nF8KzhV+GhB+U/I/9Y53Ew=;
        b=b/VlkQ7ngJ4c5ZYzgKhDuz5zElfmxJMm21XyoRRVhdVnFyKwPd3ckGdMGAaOTO0c3wFpwI
        ZLioNQr86+uoEXlTm9y4LhPa8U2bwkenJ8V4dAHiYp5N3wtUw+TOLLnO8GqGsM+D0htBBq
        qQ9a8Usf4N/jhJRZK2yEkQ6L36721NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42--mIHqnlHMzq9MMno81SbDw-1; Mon, 07 Sep 2020 07:29:32 -0400
X-MC-Unique: -mIHqnlHMzq9MMno81SbDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 307FA8015FD;
        Mon,  7 Sep 2020 11:29:29 +0000 (UTC)
Received: from krava (ovpn-112-180.ams2.redhat.com [10.36.112.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B72E5D9D2;
        Mon,  7 Sep 2020 11:29:26 +0000 (UTC)
Date:   Mon, 7 Sep 2020 13:29:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/9] perf evlist: Fix cpu/thread map leak
Message-ID: <20200907112925.GJ1199773@krava>
References: <20200907034502.753230-1-namhyung@kernel.org>
 <20200907034502.753230-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907034502.753230-2-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:44:54PM +0900, Namhyung Kim wrote:
> Asan reported leak of cpu and thread maps as they have one more
> refcount than released.  I found that after setting evlist maps it
> should release it's refcount.
> 
> It seems to be broken from the beginning so I chose the original
> commit as the culprit.  But not sure how it's applied to stable trees
> since there are many changes in the code after that.
> 
> Fixes: 7e2ed097538c5 ("perf evlist: Store pointer to the cpu and thread maps")
> Fixes: 4112eb1899c0e ("perf evlist: Default to syswide target when no thread/cpu maps set")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evlist.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index e3fa3bf7498a..c0768c61eb43 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -946,6 +946,10 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
>  
>  	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
> +	/* as evlist now has references, put count here */
> +	perf_cpu_map__put(cpus);
> +	perf_thread_map__put(threads);

nice catch, I checked perf_evlist__create_syswide_maps is doing this
correctly, but I think we might have the same issue in script's
set_maps function

thanks,
jirka

> +
>  	return 0;
>  
>  out_delete_threads:
> @@ -1273,11 +1277,12 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
>  		goto out_put;
>  
>  	perf_evlist__set_maps(&evlist->core, cpus, threads);
> -out:
> -	return err;
> +
> +	perf_thread_map__put(threads);
>  out_put:
>  	perf_cpu_map__put(cpus);
> -	goto out;
> +out:
> +	return err;
>  }
>  
>  int evlist__open(struct evlist *evlist)
> -- 
> 2.28.0.526.ge36021eeef-goog
> 

