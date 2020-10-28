Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63DA29D682
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgJ1WPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbgJ1WPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:15:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195F8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:15:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k21so6498wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWU1/XSxFhXiLqRvqrs/YoEaZri0rD3iuPB1YtRZ+X8=;
        b=h1skedaF18ojhV+Le1rhp6mCSmmK5EYRAgLnTP2tcTXFhxyAcBjBjbZWYGzck+F9B3
         sM6aEZZ4fBdSsdE3foshqRj56FWvq9MAiaNa0fmLzsOSyGC0CZr8TlvSpaKEuFr7/XEl
         MqPZZ52nTkBaSgjJSMxx94410pbEUO6PNPFYI4ASig6/ESLIPI9vMepxp+mg0bei6+dr
         koWFKRCVWAxXCLzmZ06yFrxoWdT1Moo4mc/558zWtWC1tEp+6Z0FD6qfz6oYLLrhTWl7
         jM32/qGuHGG4iFWRW1ExVsX6x1m8VdVDqTyQQZ1//Yd6YHpLB46mQx1ljgB4B9cnUjey
         JOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWU1/XSxFhXiLqRvqrs/YoEaZri0rD3iuPB1YtRZ+X8=;
        b=cEMTAieRcfVdGwwKZ1ywFhLpsIFiROEffY6WFgHxonfsd/WkksnGpwKwf/k341vOb8
         p088QBoDDuEUzu1ctc0k+IYATVg5CX10JZijUxwtxtRoYeuuGbLLvGHM3Het47is/30B
         JWgcZr/QCBzuOFwd6/WvDqRjbrq0plFvqpT51bEvzkMgGLuzqvOE1cKiJ0ckxzw8Ftku
         sB15Mwg4AbXVKORb/eYI3QYEVorp2PyCE2wRV0u7LyIP1zIC3whEooNlPaDhQjJifJzN
         X4tR3HBirAXXlX4E+I6/eQWucZS2x5ondi8PW6L4xzIt8j39wEK7g677akkeyGGwM2sG
         n12A==
X-Gm-Message-State: AOAM533mqQAZlL52V4DwR56seOqQNSEaV8/kCfqj0j/uQwCohA3+/EMB
        S2klw9Fst6le5oV9iZU89PDlksfYA9W3cHjdh2Z8/jRI0tc=
X-Google-Smtp-Source: ABdhPJxqZu7iRwXpQKGFhXCX8IConzfxYE2Rl0Z7MXo07eaLVmfZ27D/Wu12UTPwpNuwjO4xLC4DCzJWH/BNe7gtMAg=
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr284928wmg.124.1603903072281;
 Wed, 28 Oct 2020 09:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201028085632.825804-1-namhyung@kernel.org>
In-Reply-To: <20201028085632.825804-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Oct 2020 09:37:39 -0700
Message-ID: <CAP-5=fWxPdE_UVRewNUGDrTi9A8j+OYsjsHQLJsVDkMV2tRMBA@mail.gmail.com>
Subject: Re: [PATCH] perf data: Allow to use stdio functions for pipe mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 1:56 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When perf data is in a pipe, it reads each event separately using
> read(2) syscall.  This is a huge performance bottleneck when
> processing large data like in perf inject.  Also perf inject needs to
> use write(2) syscall for the output.
>
> So convert it to use buffer I/O functions in stdio library for pipe
> data.  This makes inject-build-id bench time drops from 20ms to 8ms.

This is great! Reading the numbers below the times are reduced to
67.9% of their previous, this is a little less than 20ms to 8ms so
perhaps check that number.

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

For perf record there is also the async IO used for writing. I like
that this patch is adding the reading to perf_data. Should the async
IO code live in perf_data rather than record? Should async IO be used
for reading in that case? What would be the policy of using stdio,
not-stdio and async IO?

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-inject.c |  2 ++
>  tools/perf/util/data.c      | 36 +++++++++++++++++++++++++++++++++---
>  tools/perf/util/data.h      | 11 ++++++++++-
>  tools/perf/util/header.c    |  8 ++++----
>  tools/perf/util/session.c   |  7 ++++---
>  5 files changed, 53 insertions(+), 11 deletions(-)
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
> index c47aa34fdc0a..47b5a4b50ca5 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -174,8 +174,16 @@ static bool check_pipe(struct perf_data *data)
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
> +               } else {
> +                       data->file.fd = fd;
> +               }
> +       }
>
>         return data->is_pipe = is_pipe;
>  }
> @@ -334,6 +342,9 @@ int perf_data__open(struct perf_data *data)
>         if (check_pipe(data))
>                 return 0;
>
> +       /* currently it allows stdio for pipe only */
> +       data->use_stdio = false;
> +
>         if (!data->path)
>                 data->path = "perf.data";
>
> @@ -353,7 +364,21 @@ void perf_data__close(struct perf_data *data)
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
> @@ -365,6 +390,11 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
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
> 2.29.0.rc2.309.g374f81d7ae-goog
>
