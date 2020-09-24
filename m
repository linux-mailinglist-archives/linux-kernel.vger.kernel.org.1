Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9462771D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgIXNJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbgIXNJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600952956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4CWp1yGIIVeZJPCvlPfgxNZqZUsgXhnQY5EnhMHT5M=;
        b=Gj0nLWGsoMUIhYx8G27cY1c6DazKCxShoZLQxZaFi+Te64OihepUIQVnuuwZyXOiVicw4L
        Q2Hx9JUXVzktA5nMKJuURnCOye0orQ7b9fmZFFGT+k8gXU7jtOKLZbfY5ghUdMC7hzFlF1
        yepSO6iEaG1q59+Zemhg2QuvVUofhwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-MPR0eO2QM1-Pb2ArlzKIkw-1; Thu, 24 Sep 2020 09:09:14 -0400
X-MC-Unique: MPR0eO2QM1-Pb2ArlzKIkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8421610A7AE3;
        Thu, 24 Sep 2020 13:09:12 +0000 (UTC)
Received: from krava (ovpn-115-138.ams2.redhat.com [10.36.115.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5CA8F5D9D2;
        Thu, 24 Sep 2020 13:09:10 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:09:09 +0200
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
Subject: Re: [PATCH 4/7] perf inject: Do not load map/dso when injecting
 build-id
Message-ID: <20200924130909.GB3150401@krava>
References: <20200923080537.155264-1-namhyung@kernel.org>
 <20200923080537.155264-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923080537.155264-5-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:05:34PM +0900, Namhyung Kim wrote:

SNIP

> -static inline int is_no_dso_memory(const char *filename)
> -{
> -	return !strncmp(filename, "[stack", 6) ||
> -	       !strncmp(filename, "/SYSV",5)   ||
> -	       !strcmp(filename, "[heap]");
> -}
> -
>  static inline int is_android_lib(const char *filename)
>  {
>  	return strstarts(filename, "/data/app-lib/") ||
> @@ -158,7 +143,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  		int anon, no_dso, vdso, android;
>  
>  		android = is_android_lib(filename);
> -		anon = is_anon_memory(filename, flags);
> +		anon = is_anon_memory(filename) || flags & MAP_HUGETLB;

what's the reason to take 'flags & MAP_HUGETLB' out of is_anon_memory?

jirka

>  		vdso = is_vdso_map(filename);
>  		no_dso = is_no_dso_memory(filename);
>  		map->prot = prot;
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index c2f5d28fe73a..b1c0686db1b7 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -171,4 +171,18 @@ static inline bool is_bpf_image(const char *name)
>  	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
>  	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
>  }
> +
> +static inline int is_anon_memory(const char *filename)
> +{
> +	return !strcmp(filename, "//anon") ||
> +	       !strncmp(filename, "/dev/zero", sizeof("/dev/zero") - 1) ||
> +	       !strncmp(filename, "/anon_hugepage", sizeof("/anon_hugepage") - 1);
> +}
> +
> +static inline int is_no_dso_memory(const char *filename)
> +{
> +	return !strncmp(filename, "[stack", 6) ||
> +	       !strncmp(filename, "/SYSV", 5)  ||
> +	       !strcmp(filename, "[heap]");
> +}
>  #endif /* __PERF_MAP_H */
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

