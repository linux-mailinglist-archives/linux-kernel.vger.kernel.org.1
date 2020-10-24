Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94807297D35
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762144AbgJXPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762137AbgJXPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9eOnKKqHmFUyxd7iJ0hoPPiKGXBs69jmdgmsFo2Hf8=;
        b=VowuBzI2Snuz4Q26HZIkkJVG0h0svrZJvBAm4Me4I+vsXvOQVmf/tVdUQNFj7mPg0XKx59
        QENVuKYL9dBOZhQWfbJLmj4/0iEpHOYmV9ani+6ZFU73QbDivYKY6fHa+RJGNfe4tvetlF
        iiX3z6uW3CsssThSX7z5mkvsNRtDmZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-cwAmbtHMNwOxR8I0aegNaw-1; Sat, 24 Oct 2020 11:44:52 -0400
X-MC-Unique: cwAmbtHMNwOxR8I0aegNaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FCB9805F0A;
        Sat, 24 Oct 2020 15:44:50 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8B245D9D5;
        Sat, 24 Oct 2020 15:44:48 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:44:47 +0200
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
Subject: Re: [PATCH v2 04/15] perf session: move reader object definition to
 header file
Message-ID: <20201024154447.GJ2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <635d39aa-5ce8-2c0b-9b12-952b95ed22da@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635d39aa-5ce8-2c0b-9b12-952b95ed22da@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 06:59:48PM +0300, Alexey Budankov wrote:
> 
> Move definition of reader to session header file to be shared
> among different source files. Introduce reference to active
> reader object from session object.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/session.c | 27 ---------------------------
>  tools/perf/util/session.h | 25 +++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 6f09d506b2f6..911b2dbcd0ac 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2110,33 +2110,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  	return 0;
>  }
>  
> -/*
> - * On 64bit we can mmap the data file in one go. No need for tiny mmap
> - * slices. On 32bit we use 32MB.
> - */
> -#if BITS_PER_LONG == 64
> -#define MMAP_SIZE ULLONG_MAX
> -#define NUM_MMAPS 1
> -#else
> -#define MMAP_SIZE (32 * 1024 * 1024ULL)
> -#define NUM_MMAPS 128
> -#endif
> -
> -struct reader;
> -
> -typedef s64 (*reader_cb_t)(struct perf_session *session,
> -			   union perf_event *event,
> -			   u64 file_offset,
> -			   const char *file_path);
> -
> -struct reader {
> -	int		 fd;
> -	const char	 *path;
> -	u64		 data_size;
> -	u64		 data_offset;
> -	reader_cb_t	 process;
> -};
> -
>  static int
>  reader__process_events(struct reader *rd, struct perf_session *session,
>  		       struct ui_progress *prog)
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 378ffc3e2809..abdb8518a81f 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -20,6 +20,30 @@ struct thread;
>  struct auxtrace;
>  struct itrace_synth_opts;
>  
> +/*
> + * On 64bit we can mmap the data file in one go. No need for tiny mmap
> + * slices. On 32bit we use 32MB.
> + */
> +#if BITS_PER_LONG == 64
> +#define MMAP_SIZE ULLONG_MAX
> +#define NUM_MMAPS 1
> +#else
> +#define MMAP_SIZE (32 * 1024 * 1024ULL)
> +#define NUM_MMAPS 128
> +#endif
> +
> +typedef s64 (*reader_cb_t)(struct perf_session *session,
> +			   union perf_event *event,
> +			   u64 file_offset, const char *file_path);
> +
> +struct reader {
> +	int		 fd;
> +	const char	 *path;
> +	u64		 data_size;
> +	u64		 data_offset;
> +	reader_cb_t	 process;
> +};

I wasn't able to find where is this used ouf of session.c ?


> +
>  struct perf_session {
>  	struct perf_header	header;
>  	struct machines		machines;
> @@ -41,6 +65,7 @@ struct perf_session {
>  	struct zstd_data	zstd_data;
>  	struct decomp		*decomp;
>  	struct decomp		*decomp_last;
> +	struct reader		*reader;

please define it in the patch where it's actualy used

thanks,
jirka

