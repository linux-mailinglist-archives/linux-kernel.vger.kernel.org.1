Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FCF28E21E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgJNOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJNOYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:24:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB57E22201;
        Wed, 14 Oct 2020 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602685456;
        bh=1bA06vEUgJZMo9UUAoAA3o3DxjYhRbauj9sN1CE3nww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvvpP95bdRLTK6ZSyw0e8JuvTVeWPKMiBwtGfUnA95mJI8b1N7CEi7XKEGglgyMtj
         c6vXujiKrLlKiQAtzsNTNy/PQlZFKFAvYdT+YnA89krSL2LeZlIFrHUjMz1pL+zsL1
         LLBjX7z9g6oI99weqfbCiJq0BSBVMZddDIzbDoQc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 554744047F; Wed, 14 Oct 2020 11:24:13 -0300 (-03)
Date:   Wed, 14 Oct 2020 11:24:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 7/9] perf tools: Add size to struct
 perf_record_header_build_id
Message-ID: <20201014142413.GF3100363@kernel.org>
References: <20201013192441.1299447-1-jolsa@kernel.org>
 <20201013192441.1299447-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013192441.1299447-8-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 13, 2020 at 09:24:39PM +0200, Jiri Olsa escreveu:
> We do not store size with build ids in perf data,
> but there's enough space to do it. Adding misc bit
> PERF_RECORD_MISC_BUILD_ID_SIZE to mark build id event
> with size.
> 
> With this fix the dso with md5 build id will have correct
> build id data and will be usable for debuginfod processing
> if needed (coming in following patches).
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/include/perf/event.h | 12 +++++++++++-
>  tools/perf/util/build-id.c          |  8 +++++---
>  tools/perf/util/header.c            | 10 +++++++---
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index a6dbba6b9073..988c539bedb6 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -201,10 +201,20 @@ struct perf_record_header_tracing_data {
>  	__u32			 size;
>  };
>  
> +#define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
> +
>  struct perf_record_header_build_id {
>  	struct perf_event_header header;
>  	pid_t			 pid;
> -	__u8			 build_id[24];
> +	union {
> +		__u8		 build_id[24];
> +		struct {
> +			__u8	 data[20];
> +			__u8	 size;
> +			__u8	 reserved1__;
> +			__u16	 reserved2__;
> +		};
> +	};
>  	char			 filename[];
>  };
>  
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index b5648735f01f..8763772f1095 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -296,7 +296,7 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>  			continue;		\
>  		else
>  
> -static int write_buildid(const char *name, size_t name_len, u8 *build_id,
> +static int write_buildid(const char *name, size_t name_len, struct build_id *bid,
>  			 pid_t pid, u16 misc, struct feat_fd *fd)
>  {
>  	int err;
> @@ -307,7 +307,9 @@ static int write_buildid(const char *name, size_t name_len, u8 *build_id,
>  	len = PERF_ALIGN(len, NAME_ALIGN);
>  
>  	memset(&b, 0, sizeof(b));
> -	memcpy(&b.build_id, build_id, BUILD_ID_SIZE);
> +	memcpy(&b.data, bid->data, bid->size);
> +	b.size = (u8) bid->size;
> +	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
>  	b.pid = pid;
>  	b.header.misc = misc;
>  	b.header.size = sizeof(b) + len;
> @@ -354,7 +356,7 @@ static int machine__write_buildid_table(struct machine *machine,
>  		in_kernel = pos->kernel ||
>  				is_kernel_module(name,
>  					PERF_RECORD_MISC_CPUMODE_UNKNOWN);
> -		err = write_buildid(name, name_len, pos->bid.data, machine->pid,
> +		err = write_buildid(name, name_len, &pos->bid, machine->pid,
>  				    in_kernel ? kmisc : umisc, fd);
>  		if (err)
>  			break;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 21243adbb9fd..8da3886f10a8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2083,8 +2083,12 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>  	if (dso != NULL) {
>  		char sbuild_id[SBUILD_ID_SIZE];
>  		struct build_id bid;
> +		size_t size = BUILD_ID_SIZE;
>  
> -		build_id__init(&bid, bev->build_id, BUILD_ID_SIZE);
> +		if (bev->header.misc & PERF_RECORD_MISC_BUILD_ID_SIZE)
> +			size = bev->size;
> +
> +		build_id__init(&bid, bev->data, size);
>  		dso__set_build_id(dso, &bid);
>  
>  		if (dso_space != DSO_SPACE__USER) {
> @@ -2098,8 +2102,8 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>  		}
>  
>  		build_id__sprintf(&dso->bid, sbuild_id);
> -		pr_debug("build id event received for %s: %s\n",
> -			 dso->long_name, sbuild_id);
> +		pr_debug("build id event received for %s: %s [%lu]\n",
> +			 dso->long_name, sbuild_id, size);


util/header.c: In function '__event_process_build_id':
util/header.c:2105:3: error: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' [-Werror=format=]
   pr_debug("build id event received for %s: %s [%lu]\n",
   ^

Fixing this to '%zd'

- Arnaldo

>  		dso__put(dso);
>  	}
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
