Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796792B30CE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKNUzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:55:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgKNUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605387341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGgX8SRMa98UKLZhWHnvoe9ffHec5XLgRYkPADNwuUs=;
        b=iLxkAws2kZZwNQUBa0mkSz3VlshBQU4y0MKxomfLJTayHvPJ7m4CQTEUnY52viCHyp+IqN
        VarDOv/GcM6mORb4w6Pg2RlYSzA6zG0xcdUAyaolrBja4UAQNOVsHIT5sVsq/cUNmkMsu9
        3lgZCrObjTx6E3paUFYMihnMkE8n444=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-OvrBRg5JOvmHS2Pk73GZkg-1; Sat, 14 Nov 2020 15:55:39 -0500
X-MC-Unique: OvrBRg5JOvmHS2Pk73GZkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 504AA107464C;
        Sat, 14 Nov 2020 20:55:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3F5B91992D;
        Sat, 14 Nov 2020 20:55:35 +0000 (UTC)
Date:   Sat, 14 Nov 2020 21:55:34 +0100
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
Subject: Re: [PATCH v2] perf data: Allow to use stdio functions for pipe mode
Message-ID: <20201114205534.GB903902@krava>
References: <20201030054742.87740-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030054742.87740-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 02:47:42PM +0900, Namhyung Kim wrote:
> When perf data is in a pipe, it reads each event separately using
> read(2) syscall.  This is a huge performance bottleneck when
> processing large data like in perf inject.  Also perf inject needs to
> use write(2) syscall for the output.
> 
> So convert it to use buffer I/O functions in stdio library for pipe
> data.  This makes inject-build-id bench time drops from 20ms to 8ms.
> 
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 8.074 msec (+- 0.013 msec)
>     Average time per event: 0.792 usec (+- 0.001 usec)
>     Average memory usage: 8328 KB (+- 0 KB)
>     Average build-id-all injection took: 5.490 msec (+- 0.008 msec)
>     Average time per event: 0.538 usec (+- 0.001 usec)
>     Average memory usage: 7563 KB (+- 0 KB)
> 
> This patch enables it just for perf inject when used with pipe (it's a
> default behavior).  Maybe we could do it for perf record and/or report
> later..
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> v2: check result of fdopen()
> 
>  tools/perf/builtin-inject.c |  2 ++
>  tools/perf/util/data.c      | 41 ++++++++++++++++++++++++++++++++++---
>  tools/perf/util/data.h      | 11 +++++++++-
>  tools/perf/util/header.c    |  8 ++++----
>  tools/perf/util/session.c   |  7 ++++---
>  5 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 452a75fe68e5..14d6c88fed76 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -853,10 +853,12 @@ int cmd_inject(int argc, const char **argv)
>  		.output = {
>  			.path = "-",
>  			.mode = PERF_DATA_MODE_WRITE,
> +			.use_stdio = true,
>  		},
>  	};
>  	struct perf_data data = {
>  		.mode = PERF_DATA_MODE_READ,
> +		.use_stdio = true,
>  	};
>  	int ret;
>  
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index c47aa34fdc0a..05bbcb663c41 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -174,8 +174,21 @@ static bool check_pipe(struct perf_data *data)
>  			is_pipe = true;
>  	}
>  
> -	if (is_pipe)
> -		data->file.fd = fd;
> +	if (is_pipe) {
> +		if (data->use_stdio) {
> +			const char *mode;
> +
> +			mode = perf_data__is_read(data) ? "r" : "w";
> +			data->file.fptr = fdopen(fd, mode);
> +
> +			if (data->file.fptr == NULL) {
> +				data->file.fd = fd;
> +				data->use_stdio = false;
> +			}
> +		} else {
> +			data->file.fd = fd;
> +		}
> +	}
>  
>  	return data->is_pipe = is_pipe;
>  }
> @@ -334,6 +347,9 @@ int perf_data__open(struct perf_data *data)
>  	if (check_pipe(data))
>  		return 0;
>  
> +	/* currently it allows stdio for pipe only */
> +	data->use_stdio = false;
> +
>  	if (!data->path)
>  		data->path = "perf.data";
>  
> @@ -353,7 +369,21 @@ void perf_data__close(struct perf_data *data)
>  		perf_data__close_dir(data);
>  
>  	zfree(&data->file.path);
> -	close(data->file.fd);
> +
> +	if (data->use_stdio)
> +		fclose(data->file.fptr);
> +	else
> +		close(data->file.fd);
> +}
> +
> +ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size)
> +{
> +	if (data->use_stdio) {
> +		if (fread(buf, size, 1, data->file.fptr) == 1)
> +			return size;
> +		return feof(data->file.fptr) ? 0 : -1;
> +	}
> +	return readn(data->file.fd, buf, size);
>  }
>  
>  ssize_t perf_data_file__write(struct perf_data_file *file,
> @@ -365,6 +395,11 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
>  ssize_t perf_data__write(struct perf_data *data,
>  			      void *buf, size_t size)
>  {
> +	if (data->use_stdio) {
> +		if (fwrite(buf, size, 1, data->file.fptr) == 1)
> +			return size;
> +		return -1;
> +	}
>  	return perf_data_file__write(&data->file, buf, size);
>  }
>  
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 75947ef6bc17..c563fcbb0288 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -2,6 +2,7 @@
>  #ifndef __PERF_DATA_H
>  #define __PERF_DATA_H
>  
> +#include <stdio.h>
>  #include <stdbool.h>
>  
>  enum perf_data_mode {
> @@ -16,7 +17,10 @@ enum perf_dir_version {
>  
>  struct perf_data_file {
>  	char		*path;
> -	int		 fd;
> +	union {
> +		int	 fd;
> +		FILE	*fptr;
> +	};
>  	unsigned long	 size;
>  };
>  
> @@ -26,6 +30,7 @@ struct perf_data {
>  	bool			 is_pipe;
>  	bool			 is_dir;
>  	bool			 force;
> +	bool			 use_stdio;
>  	enum perf_data_mode	 mode;
>  
>  	struct {
> @@ -62,11 +67,15 @@ static inline bool perf_data__is_single_file(struct perf_data *data)
>  
>  static inline int perf_data__fd(struct perf_data *data)
>  {
> +	if (data->use_stdio)
> +		return fileno(data->file.fptr);
> +
>  	return data->file.fd;
>  }
>  
>  int perf_data__open(struct perf_data *data);
>  void perf_data__close(struct perf_data *data);
> +ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size);
>  ssize_t perf_data__write(struct perf_data *data,
>  			      void *buf, size_t size);
>  ssize_t perf_data_file__write(struct perf_data_file *file,
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index be850e9f8852..d9a70154426b 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3652,7 +3652,8 @@ static int perf_file_section__process(struct perf_file_section *section,
>  }
>  
>  static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
> -				       struct perf_header *ph, int fd,
> +				       struct perf_header *ph,
> +				       struct perf_data* data,
>  				       bool repipe)
>  {
>  	struct feat_fd ff = {
> @@ -3661,7 +3662,7 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
>  	};
>  	ssize_t ret;
>  
> -	ret = readn(fd, header, sizeof(*header));
> +	ret = perf_data__read(data, header, sizeof(*header));
>  	if (ret <= 0)
>  		return -1;
>  
> @@ -3684,8 +3685,7 @@ static int perf_header__read_pipe(struct perf_session *session)
>  	struct perf_header *header = &session->header;
>  	struct perf_pipe_file_header f_header;
>  
> -	if (perf_file_header__read_pipe(&f_header, header,
> -					perf_data__fd(session->data),
> +	if (perf_file_header__read_pipe(&f_header, header, session->data,
>  					session->repipe) < 0) {
>  		pr_debug("incompatible file format\n");
>  		return -EINVAL;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7a5f03764702..f901a09a58e4 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1923,7 +1923,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  {
>  	struct ordered_events *oe = &session->ordered_events;
>  	struct perf_tool *tool = session->tool;
> -	int fd = perf_data__fd(session->data);
>  	union perf_event *event;
>  	uint32_t size, cur_size = 0;
>  	void *buf = NULL;
> @@ -1943,7 +1942,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  	ordered_events__set_copy_on_queue(oe, true);
>  more:
>  	event = buf;
> -	err = readn(fd, event, sizeof(struct perf_event_header));
> +	err = perf_data__read(session->data, event,
> +			      sizeof(struct perf_event_header));
>  	if (err <= 0) {
>  		if (err == 0)
>  			goto done;
> @@ -1975,7 +1975,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  	p += sizeof(struct perf_event_header);
>  
>  	if (size - sizeof(struct perf_event_header)) {
> -		err = readn(fd, p, size - sizeof(struct perf_event_header));
> +		err = perf_data__read(session->data, p,
> +				      size - sizeof(struct perf_event_header));
>  		if (err <= 0) {
>  			if (err == 0) {
>  				pr_err("unexpected end of event stream\n");
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 

