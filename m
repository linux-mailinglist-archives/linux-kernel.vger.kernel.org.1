Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0109B297D2B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761978AbgJXPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761950AbgJXPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJLNUpS6ea+ny+4LUiVCKeZjlZnueWST9pU3roA+Uu4=;
        b=PqDBUzg06TRClPn7oODv6oCQAPcNR/JYJFlmfec8arLwqm0G+XCRg9y8XSh4A0+QxAk6q2
        8SdoxaVYQ6S2xX9Qph35vSUqeDq60m896WWpG1hfZ3tnZGxMVf5HNrktZQqXV2eHuVjXMD
        +hirRYGUVliMV8LOOQUN5TeJl3t9E08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-fHG3iwD_Ndqu_Wvf04eVvw-1; Sat, 24 Oct 2020 11:43:54 -0400
X-MC-Unique: fHG3iwD_Ndqu_Wvf04eVvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 737F2804B6A;
        Sat, 24 Oct 2020 15:43:52 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 863A810013D0;
        Sat, 24 Oct 2020 15:43:50 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:43:49 +0200
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
Subject: Re: [PATCH v2 06/15] perf session: load data directory into tool
 process memory
Message-ID: <20201024154349.GC2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <d28243e3-3178-d7cd-7b96-7ed63fd83493@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28243e3-3178-d7cd-7b96-7ed63fd83493@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:01:19PM +0300, Alexey Budankov wrote:
> 
> Read trace files located in data directory into tool process memory.
> Basic analysis support of data directories is provided for report
> mode. Raw dump (-D) and aggregated reports are available for data
> directories, still with no memory consumption optimizations. However
> data directories collected with --compression-level option enabled
> can be analyzed with little less memory because trace files are
> unmaped from tool process memory after loading collected data.
> The implementation is based on the prototype [1], [2].
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>

very loosely ;-) so there was a reason for all that reader refactoring,
so we could have __perf_session__process_dir_events function:

  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=308aa7cff1fed335401cfc02c7bac1a4644af68e

when reporting the threaded record data on really big servers,
you will run out of memory, so you need to read and flush all
the files together by smaller pieces

IMO we need to have this change before we allow threaded record

jirka


> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/session.c | 48 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/session.h |  1 +
>  2 files changed, 49 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 6afc670fdf0c..0752eec19813 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		goto more;
>  
>  out:
> +	if (rd->unmap_file) {
> +		int i;
> +
> +		for (i = 0; i < NUM_MMAPS; i++) {
> +			if (mmaps[i]) {
> +				munmap(mmaps[i], mmap_size);
> +				mmaps[i] = NULL;
> +			}
> +		}
> +	}
> +
>  	return err;
>  }
>  
> @@ -2231,6 +2242,7 @@ static int __perf_session__process_events(struct perf_session *session)
>  		.data_offset	= session->header.data_offset,
>  		.process	= process_simple,
>  		.path		= session->data->file.path,
> +		.unmap_file	= false,
>  	};
>  	struct ordered_events *oe = &session->ordered_events;
>  	struct perf_tool *tool = session->tool;
> @@ -2247,6 +2259,42 @@ static int __perf_session__process_events(struct perf_session *session)
>  	err = reader__process_events(&rd, session, &prog);
>  	if (err)
>  		goto out_err;
> +
> +	if (perf_data__is_dir(session->data)) {
> +		int i, nr = session->data->dir.nr;
> +		struct reader file_rd[nr];
> +		u64 total_size = perf_data__size(session->data);
> +
> +		total_size -= session->data->file.size;
> +		ui_progress__init_size(&prog, total_size, "Sorting events...");
> +
> +		memset(&file_rd, 0, nr * sizeof(file_rd[0]));
> +
> +		for (i = 0; i < nr ; i++) {
> +			struct perf_data_file *file;
> +
> +			file = &session->data->dir.files[i];
> +			file_rd[i] = (struct reader) {
> +				.fd             = file->fd,
> +				.path           = file->path,
> +				.data_size      = file->size,
> +				.data_offset    = 0,
> +				.process	= process_simple,
> +			};
> +			file_rd[i].unmap_file = perf_header__has_feat(&session->header,
> +								      HEADER_COMPRESSED);
> +			session->reader = &file_rd[i];
> +
> +			if (zstd_init(&(file_rd[i].zstd_data), 0))
> +				goto out_err;
> +			err = reader__process_events(&file_rd[i], session, &prog);
> +			zstd_fini(&(file_rd[i].zstd_data));
> +			session->reader = NULL;
> +			if (err)
> +				goto out_err;
> +		}
> +	}
> +
>  	/* do the final flush for ordered samples */
>  	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
>  	if (err)
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 4fc9ccdf7970..d428f3eaf7fd 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -43,6 +43,7 @@ struct reader {
>  	u64		 data_offset;
>  	reader_cb_t	 process;
>  	struct zstd_data zstd_data;
> +	bool		 unmap_file;
>  };
>  
>  struct perf_session {
> -- 
> 2.24.1
> 

