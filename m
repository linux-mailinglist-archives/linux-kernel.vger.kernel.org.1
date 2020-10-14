Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5513B28E024
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbgJNL7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbgJNL7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:59:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56BEE20848;
        Wed, 14 Oct 2020 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602676750;
        bh=i/RjhwcClAbrOb3UfGZRHExzd394qZjz3qR/uBO9XAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUDysWA2CtcQ9ORfpqI9PCOl/3oXz9y0AJh5q5EG8JFw4eOKDxa8nq5uukDrJIYQ5
         63X6cpei7blc0r2XOInIVLuplSfyOmcKabbDOa7m5WN0dYiB8RdIGDT8oVkoCHpy6H
         YKioWdS/18kAfoSFJSjPiCUaw2hQMmbfmY0O8ttM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 218984047F; Wed, 14 Oct 2020 08:59:08 -0300 (-03)
Date:   Wed, 14 Oct 2020 08:59:08 -0300
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
Message-ID: <20201014115908.GE3100363@kernel.org>
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

Hey, shouldn't we just append the extra info at the end, i.e. keep it
like:

 struct perf_record_header_build_id {
 	struct perf_event_header header;
 	pid_t			 pid;
	__u8			 build_id[24];
 	char			 filename[];
	__u8			 size;
 };


No need for PERF_RECORD_MISC_BUILD_ID_SIZE, older tools will continue
working with new perf data files.

OTOH BUILD_ID_SIZE is 20 and the space on this header is 24, so the last
4 bytes were not being used, so older tools don't look into it, they
should continue working, have you tested this case? I.e. getting the
perf binary in, say, fedora and check that it works with this new
perf_record_header_build_id layout?

- Arnaldo
  
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
>  		dso__put(dso);
>  	}
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
