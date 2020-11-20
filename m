Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571FC2BA772
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKTK3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKTK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:28:59 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9473CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:28:59 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g7so7454762pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n2WTjnYPpYOXbZLxJ0YPMA+QYsuybDSPafsUWHTWsQ0=;
        b=diopmtRuKZS2TN0vv0e79W2L2Ld7+jl4d83nw4z1m84NL+7dsNpH8NoFjbO0h4pHnL
         4/EbUD1hhJyMoV1qozYbtTzymPRAra+S7PYWQwu2Oup9WRo2mw2PxPnsZO1i8Z+NCBqW
         YippoZ/JQj0ks+8JXwlUlTyEexLRh05Ke34Vc2lnQ5RC/iY2durjsdkzpIqBCwOp7pD6
         Vkyhic5uzjFW7VPS2Q5RT2CuYf3BwNiMzL/eZ+12D8OrZNkZ1vKI9vIkdeedt7Dsp1Ha
         +CX2Mniv/Gu6Db/f7cdFisamBLxJltgyiToN6GiNMPCyvDimWFlTutFSWtj66sNiqHhe
         G+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=n2WTjnYPpYOXbZLxJ0YPMA+QYsuybDSPafsUWHTWsQ0=;
        b=fWWX5dOUcSUvQnyThGWwIGIMhYCxFAaS9kXlbFxo0A1tFgnzmZvEUzltEzRPFUf5GR
         zEUpupeNUqs2Whf8FxgZtJ9c15d+abnQlBMTnDvsNENOXK5SMq0SVJZ22lwC+yvxvQc+
         MBl4p18jX1UwfAkp/Sw7LA5fh8n4V6K92gTVP9CHBR8hvHpPOE2oRmDi1t2All2MsoiU
         dSN82UyJvtRL82MAf4Yk6hUGPLT+8MMmGcdSmJnque2xIfDxaV2zaA63RfB9WRgfTJsR
         FjazLVjHRezJ9r8AAswZ2SJg2vvNAZ9DS3uXGQMCWRrfd+Ts8Bjm+c+UfKAaoyLKNPYq
         Mq3g==
X-Gm-Message-State: AOAM531EeOOc+tGG/vaD5W7/sEP22ScwcQPJpcISngRIg6HJp/y1rXOZ
        neDFvhq87u/S2uNxjN4+g+0JfRFJTBU=
X-Google-Smtp-Source: ABdhPJwCRSGLzArk2okYHa0atVUGq5VCiYt7bS/5A9HAJjsKabHYQfSaFIO9rPymIRMH+U+aR/eE5A==
X-Received: by 2002:a62:cec6:0:b029:18a:d620:6b86 with SMTP id y189-20020a62cec60000b029018ad6206b86mr12861484pfg.2.1605868139021;
        Fri, 20 Nov 2020 02:28:59 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id m18sm2816169pfk.10.2020.11.20.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:28:58 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 20 Nov 2020 19:28:50 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v3 06/12] perf record: introduce data file at mmap buffer
 object
Message-ID: <20201120102850.GE94830@google.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <c439c1f5-de40-8f6b-d494-39082092f3b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c439c1f5-de40-8f6b-d494-39082092f3b4@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:18:50PM +0300, Alexey Budankov wrote:
> 
> Introduce data file and compressor objects into mmap object so
> they could be used to process and store data stream from the
> corresponding kernel data buffer. Introduce bytes_transferred
> and bytes_compressed stats so they would capture statistics for
> the related data buffer transfers. Make use of the introduced
> per mmap file, compressor and stats when they are initialized
> and available.

So the bytes_transferred == bytes read from the mmap buffer, right?

Thanks,
Namhyung

> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 64 +++++++++++++++++++++++++++++--------
>  tools/perf/util/mmap.c      |  6 ++++
>  tools/perf/util/mmap.h      |  6 ++++
>  3 files changed, 63 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 13773739bedc..779676531edf 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -188,11 +188,19 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  {
>  	struct perf_data_file *file = &rec->session->data->file;
>  
> +	if (map && map->file)
> +		file = map->file;
> +
>  	if (perf_data_file__write(file, bf, size) < 0) {
>  		pr_err("failed to write perf data, error: %m\n");
>  		return -1;
>  	}
>  
> +	if (map && map->file) {
> +		map->bytes_written += size;
> +		return 0;
> +	}
> +
>  	rec->bytes_written += size;
>  
>  	if (record__output_max_size_exceeded(rec) && !done) {
> @@ -210,8 +218,8 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  
>  static int record__aio_enabled(struct record *rec);
>  static int record__comp_enabled(struct record *rec);
> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
> -			    void *src, size_t src_size);
> +static size_t zstd_compress(struct zstd_data *data,
> +			    void *dst, size_t dst_size, void *src, size_t src_size);
>  
>  #ifdef HAVE_AIO_SUPPORT
>  static int record__aio_write(struct aiocb *cblock, int trace_fd,
> @@ -345,9 +353,13 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
>  	 */
>  
>  	if (record__comp_enabled(aio->rec)) {
> -		size = zstd_compress(aio->rec->session, aio->data + aio->size,
> -				     mmap__mmap_len(map) - aio->size,
> +		struct zstd_data *zstd_data = &aio->rec->session->zstd_data;
> +
> +		aio->rec->session->bytes_transferred += size;
> +		size = zstd_compress(zstd_data,
> +				     aio->data + aio->size, mmap__mmap_len(map) - aio->size,
>  				     buf, size);
> +		aio->rec->session->bytes_compressed += size;
>  	} else {
>  		memcpy(aio->data + aio->size, buf, size);
>  	}
> @@ -572,8 +584,22 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  	struct record *rec = to;
>  
>  	if (record__comp_enabled(rec)) {
> -		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
> +		struct zstd_data *zstd_data = &rec->session->zstd_data;
> +
> +		if (map->file) {
> +			zstd_data = &map->zstd_data;
> +			map->bytes_transferred += size;
> +		} else {
> +			rec->session->bytes_transferred += size;
> +		}
> +
> +		size = zstd_compress(zstd_data, map->data, mmap__mmap_len(map), bf, size);
>  		bf   = map->data;
> +
> +		if (map->file)
> +			map->bytes_compressed += size;
> +		else
> +			rec->session->bytes_compressed += size;
>  	}
>  
>  	thread->samples++;
> @@ -1291,18 +1317,15 @@ static size_t process_comp_header(void *record, size_t increment)
>  	return size;
>  }
>  
> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
> +static size_t zstd_compress(struct zstd_data *zstd_data, void *dst, size_t dst_size,
>  			    void *src, size_t src_size)
>  {
>  	size_t compressed;
>  	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
>  
> -	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
> +	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
>  						     max_record_size, process_comp_header);
>  
> -	session->bytes_transferred += src_size;
> -	session->bytes_compressed  += compressed;
> -
>  	return compressed;
>  }
>  
> @@ -1959,8 +1982,9 @@ static int record__start_threads(struct record *rec)
>  
>  static int record__stop_threads(struct record *rec, unsigned long *waking)
>  {
> -	int t;
> +	int t, tm;
>  	struct thread_data *thread_data = rec->thread_data;
> +	u64 bytes_written = 0, bytes_transferred = 0, bytes_compressed = 0;
>  
>  	for (t = 1; t < rec->nr_threads; t++)
>  		record__terminate_thread(&thread_data[t]);
> @@ -1968,9 +1992,23 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
>  	for (t = 0; t < rec->nr_threads; t++) {
>  		rec->samples += thread_data[t].samples;
>  		*waking += thread_data[t].waking;
> -		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld\n",
> +		for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
> +			if (thread_data[t].maps) {
> +				bytes_transferred += thread_data[t].maps[tm]->bytes_transferred;
> +				bytes_compressed += thread_data[t].maps[tm]->bytes_compressed;
> +				bytes_written += thread_data[t].maps[tm]->bytes_written;
> +			}
> +			if (thread_data[t].overwrite_maps) {
> +				bytes_transferred += thread_data[t].overwrite_maps[tm]->bytes_transferred;
> +				bytes_compressed += thread_data[t].overwrite_maps[tm]->bytes_compressed;
> +				bytes_written += thread_data[t].overwrite_maps[tm]->bytes_written;
> +			}
> +		}
> +		rec->session->bytes_transferred += bytes_transferred;
> +		rec->session->bytes_compressed += bytes_compressed;
> +		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld, written=%ld\n",
>  			 thread_data[t].tid, thread_data[t].samples, thread_data[t].waking,
> -			 rec->session->bytes_transferred, rec->session->bytes_compressed);
> +			 bytes_transferred, bytes_compressed, bytes_written);
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..a2c5e4237592 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -230,6 +230,8 @@ void mmap__munmap(struct mmap *map)
>  {
>  	bitmap_free(map->affinity_mask.bits);
>  
> +	zstd_fini(&map->zstd_data);
> +
>  	perf_mmap__aio_munmap(map);
>  	if (map->data != NULL) {
>  		munmap(map->data, mmap__mmap_len(map));
> @@ -291,6 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>  	map->core.flush = mp->flush;
>  
>  	map->comp_level = mp->comp_level;
> +	if (zstd_init(&map->zstd_data, map->comp_level)) {
> +		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
> +		return -1;
> +	}
>  
>  	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 9d5f589f02ae..c04ca4b5adf5 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -13,6 +13,7 @@
>  #endif
>  #include "auxtrace.h"
>  #include "event.h"
> +#include "util/compress.h"
>  
>  struct aiocb;
>  
> @@ -43,6 +44,11 @@ struct mmap {
>  	struct mmap_cpu_mask	affinity_mask;
>  	void		*data;
>  	int		comp_level;
> +	struct perf_data_file *file;
> +	struct zstd_data      zstd_data;
> +	u64		      bytes_transferred;
> +	u64		      bytes_compressed;
> +	u64		      bytes_written;
>  };
>  
>  struct mmap_params {
> -- 
> 2.24.1
> 
> 
