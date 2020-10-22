Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203C0295746
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgJVE3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:29:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33386 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgJVE3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:29:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id f19so156600wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XePNdqdGUvR7uMsQ2+sIdYWLsR1M38GxB2KA6zWHEQk=;
        b=k/izKDGFFdvLAZSJMJI3puywqKug05HZJxNB6T0Gbd9g1+PyKRc+k9sjO/Wv5C2/dA
         5TkozrNMN/niiXb29lNbNzW5qa03TGAc1S4yw2GAUC1Qd5GyI+S5+u+CHtzXvzE/nREk
         iAsQMFsFiuBJnK6VBfZHORmO+caQHq2TGL4gBlvqpJmBZZ8LAVnX183hAQJwP6gjSDNZ
         gGHkr8QHg4P6zXubhMmF9Q/kr7+VUj5xdOdhQ6Ccmx1LrUHuL34jS5BdcRIioDQourll
         E464hCJRJInAzoZyfPvyxBltlpeOBMYsfuaoXUeRLVLUwVXG6fH1bm0kYXHiSTTwAt95
         iucA==
X-Gm-Message-State: AOAM530apc6WHN+gpaAHUwuoIx+NpRlosE4bu2YlnKze6SdnTC7A4nYv
        LmUtu0C4bs0AkCVSqXGM0uCTYBUduNmWqq6hJlE=
X-Google-Smtp-Source: ABdhPJxQLkhMnZGZhqElOyRop0JpS0sIFNtGwJVZFYU2djgyaq2itwuJ4pWLHFnYM5UB7WXmh+J3+wjQP2pfymfswtc=
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr609880wma.189.1603340945993;
 Wed, 21 Oct 2020 21:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com> <e73eba79-9c3d-8894-7540-7329bd3c09da@linux.intel.com>
In-Reply-To: <e73eba79-9c3d-8894-7540-7329bd3c09da@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Oct 2020 13:28:54 +0900
Message-ID: <CAM9d7chbBfdEOpem8-8G3uN6cYVL=hVKVnhXnoe51-R02S_Qzw@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] perf session: introduce trace file path to be
 shown in raw trace dump
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 22, 2020 at 12:56 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Extend reader, ordered_event and decomp objects to contain path
> of a trace file being displayed.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

> ---
>  tools/perf/util/ordered-events.h | 1 +
>  tools/perf/util/session.c        | 2 ++
>  tools/perf/util/session.h        | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> index 75345946c4b9..42c9764c6b5b 100644
> --- a/tools/perf/util/ordered-events.h
> +++ b/tools/perf/util/ordered-events.h
> @@ -9,6 +9,7 @@ struct perf_sample;
>  struct ordered_event {
>         u64                     timestamp;
>         u64                     file_offset;
> +       const char              *file_path;
>         union perf_event        *event;
>         struct list_head        list;
>  };
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7a5f03764702..4478ddae485b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2119,6 +2119,7 @@ typedef s64 (*reader_cb_t)(struct perf_session *session,
>
>  struct reader {
>         int              fd;
> +       const char       *path;
>         u64              data_size;
>         u64              data_offset;
>         reader_cb_t      process;
> @@ -2241,6 +2242,7 @@ static int __perf_session__process_events(struct perf_session *session)
>                 .data_size      = session->header.data_size,
>                 .data_offset    = session->header.data_offset,
>                 .process        = process_simple,
> +               .path           = session->data->file.path,
>         };
>         struct ordered_events *oe = &session->ordered_events;
>         struct perf_tool *tool = session->tool;
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index f76480166d38..378ffc3e2809 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -46,6 +46,7 @@ struct perf_session {
>  struct decomp {
>         struct decomp *next;
>         u64 file_pos;
> +       const char *file_path;
>         size_t mmap_len;
>         u64 head;
>         size_t size;
> --
> 2.24.1
>
>
