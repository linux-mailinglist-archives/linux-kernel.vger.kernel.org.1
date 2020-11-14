Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348F2B2AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 03:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKNCuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 21:50:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35942 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgKNCuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 21:50:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id f11so17041792lfs.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 18:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKIZDENAZH5jg01SbaZDXnOTH1Mu5Q2TuRdOVL8Q/bk=;
        b=FDq+2jOb8wUz9T9O+F29q7WJkv+1kC/BXZLGbt++jycM/F+q9qipeU87op/UQyR1lP
         5bcxcAX3zQ5CmRgNwCdlD0iHsj1kUgbV1nRWUEK6UaGazDBHU2qwFVVYLzTib/We03Yo
         6C6gpXdDTrA2JTRRWcbmhpB48Z4tNKcL/QcUX8A73hL5E/WaLTVFFouwoMfzhrPyBVkH
         qCR1zCAvmjO0BPTBItll2vG7wvJwEc0Pi2l9ZAXkcaHLLIVMdMQMEycE3XZwzm9HJq2h
         nY61rqATNFvtRfa3jbUqJmrlyyk+tiKtRhBiNlbxk+Pcxk/EQk4tKNoxSBgT4jC8xCkW
         F1DQ==
X-Gm-Message-State: AOAM531831gZh0+TB14fN9wlUKYPDNH582+5fxU5P2BZBb5BF6ZnWCnz
        PAbAJHirkBeeas/PymHaGWQZRlJArlwlhPgkDI4=
X-Google-Smtp-Source: ABdhPJx+5HBICw+z7N81xJ7kA5kBMw2tADxpoIU2XvSB1LSNt+o1aHz9MPZJolm+IEX9028ZYSpNl4iAncrHO/OML/8=
X-Received: by 2002:a19:838c:: with SMTP id f134mr1894114lfd.540.1605322249475;
 Fri, 13 Nov 2020 18:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20201030054742.87740-1-namhyung@kernel.org>
In-Reply-To: <20201030054742.87740-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 14 Nov 2020 11:50:38 +0900
Message-ID: <CAM9d7ci2LY7TjukVJEme8BT_WqsoRCtXD3JSKTYjBskfZmzv3w@mail.gmail.com>
Subject: Re: [PATCH v2] perf data: Allow to use stdio functions for pipe mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping! :)


On Fri, Oct 30, 2020 at 2:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
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
>                 .output = {
>                         .path = "-",
>                         .mode = PERF_DATA_MODE_WRITE,
> +                       .use_stdio = true,
>                 },
>         };
>         struct perf_data data = {
>                 .mode = PERF_DATA_MODE_READ,
> +               .use_stdio = true,
>         };
>         int ret;
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index c47aa34fdc0a..05bbcb663c41 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -174,8 +174,21 @@ static bool check_pipe(struct perf_data *data)
>                         is_pipe = true;
>         }
>
> -       if (is_pipe)
> -               data->file.fd = fd;
> +       if (is_pipe) {
> +               if (data->use_stdio) {
> +                       const char *mode;
> +
> +                       mode = perf_data__is_read(data) ? "r" : "w";
> +                       data->file.fptr = fdopen(fd, mode);
> +
> +                       if (data->file.fptr == NULL) {
> +                               data->file.fd = fd;
> +                               data->use_stdio = false;
> +                       }
> +               } else {
> +                       data->file.fd = fd;
> +               }
> +       }
>
>         return data->is_pipe = is_pipe;
>  }
> @@ -334,6 +347,9 @@ int perf_data__open(struct perf_data *data)
>         if (check_pipe(data))
>                 return 0;
>
> +       /* currently it allows stdio for pipe only */
> +       data->use_stdio = false;
> +
>         if (!data->path)
>                 data->path = "perf.data";
>
> @@ -353,7 +369,21 @@ void perf_data__close(struct perf_data *data)
>                 perf_data__close_dir(data);
>
>         zfree(&data->file.path);
> -       close(data->file.fd);
> +
> +       if (data->use_stdio)
> +               fclose(data->file.fptr);
> +       else
> +               close(data->file.fd);
> +}
> +
> +ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size)
> +{
> +       if (data->use_stdio) {
> +               if (fread(buf, size, 1, data->file.fptr) == 1)
> +                       return size;
> +               return feof(data->file.fptr) ? 0 : -1;
> +       }
> +       return readn(data->file.fd, buf, size);
>  }
>
>  ssize_t perf_data_file__write(struct perf_data_file *file,
> @@ -365,6 +395,11 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
>  ssize_t perf_data__write(struct perf_data *data,
>                               void *buf, size_t size)
>  {
> +       if (data->use_stdio) {
> +               if (fwrite(buf, size, 1, data->file.fptr) == 1)
> +                       return size;
> +               return -1;
> +       }
>         return perf_data_file__write(&data->file, buf, size);
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
>         char            *path;
> -       int              fd;
> +       union {
> +               int      fd;
> +               FILE    *fptr;
> +       };
>         unsigned long    size;
>  };
>
> @@ -26,6 +30,7 @@ struct perf_data {
>         bool                     is_pipe;
>         bool                     is_dir;
>         bool                     force;
> +       bool                     use_stdio;
>         enum perf_data_mode      mode;
>
>         struct {
> @@ -62,11 +67,15 @@ static inline bool perf_data__is_single_file(struct perf_data *data)
>
>  static inline int perf_data__fd(struct perf_data *data)
>  {
> +       if (data->use_stdio)
> +               return fileno(data->file.fptr);
> +
>         return data->file.fd;
>  }
>
>  int perf_data__open(struct perf_data *data);
>  void perf_data__close(struct perf_data *data);
> +ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size);
>  ssize_t perf_data__write(struct perf_data *data,
>                               void *buf, size_t size);
>  ssize_t perf_data_file__write(struct perf_data_file *file,
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index be850e9f8852..d9a70154426b 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3652,7 +3652,8 @@ static int perf_file_section__process(struct perf_file_section *section,
>  }
>
>  static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
> -                                      struct perf_header *ph, int fd,
> +                                      struct perf_header *ph,
> +                                      struct perf_data* data,
>                                        bool repipe)
>  {
>         struct feat_fd ff = {
> @@ -3661,7 +3662,7 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
>         };
>         ssize_t ret;
>
> -       ret = readn(fd, header, sizeof(*header));
> +       ret = perf_data__read(data, header, sizeof(*header));
>         if (ret <= 0)
>                 return -1;
>
> @@ -3684,8 +3685,7 @@ static int perf_header__read_pipe(struct perf_session *session)
>         struct perf_header *header = &session->header;
>         struct perf_pipe_file_header f_header;
>
> -       if (perf_file_header__read_pipe(&f_header, header,
> -                                       perf_data__fd(session->data),
> +       if (perf_file_header__read_pipe(&f_header, header, session->data,
>                                         session->repipe) < 0) {
>                 pr_debug("incompatible file format\n");
>                 return -EINVAL;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7a5f03764702..f901a09a58e4 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1923,7 +1923,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  {
>         struct ordered_events *oe = &session->ordered_events;
>         struct perf_tool *tool = session->tool;
> -       int fd = perf_data__fd(session->data);
>         union perf_event *event;
>         uint32_t size, cur_size = 0;
>         void *buf = NULL;
> @@ -1943,7 +1942,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>         ordered_events__set_copy_on_queue(oe, true);
>  more:
>         event = buf;
> -       err = readn(fd, event, sizeof(struct perf_event_header));
> +       err = perf_data__read(session->data, event,
> +                             sizeof(struct perf_event_header));
>         if (err <= 0) {
>                 if (err == 0)
>                         goto done;
> @@ -1975,7 +1975,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>         p += sizeof(struct perf_event_header);
>
>         if (size - sizeof(struct perf_event_header)) {
> -               err = readn(fd, p, size - sizeof(struct perf_event_header));
> +               err = perf_data__read(session->data, p,
> +                                     size - sizeof(struct perf_event_header));
>                 if (err <= 0) {
>                         if (err == 0) {
>                                 pr_err("unexpected end of event stream\n");
> --
> 2.29.1.341.ge80a0c044ae-goog
>
