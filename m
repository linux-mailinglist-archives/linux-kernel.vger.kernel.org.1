Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3428E295751
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443990AbgJVEgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:36:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36475 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443812AbgJVEgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:36:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id x7so402191wrl.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hc/tVgY/tw8iRj/ePwmccLYyEyi2uJxxtFlcvBAdZdM=;
        b=gZxHqyek3qmjjYDY6oedNftdNwfURAy+08ck8gvdXbdbZUTAU0TY2t1i4zgnQqNdfy
         on4invOMnjoc69lr5qfoMKkTPeEJHHQstiMwU7AzhrmhFbhA/bqyWmrT0JhE/3CiQMNI
         C/0aMd7DoZRgCnoD7r3hihchdpLctaszAz981383hbKY84MAraiL7d8rat5kySx5q3GO
         PKjxsTfipBz6j/jOuHzKG85ws+mHa4qQQAWWQBuTeYBpGAnCCfYSEugWpyTex+UXO8pQ
         Cbh+P3YzCQj7hL9hPY4jOU29lrItQXtGGs68veISHGYtEmlX99Mt/mm9ZsdDG2PZDW/X
         HV8g==
X-Gm-Message-State: AOAM531OKjObmFNeU0aVg3Vvd5UTfeCOYjpdF3G5Y7D01254JY73kEZQ
        FL3izenmYxKREMn06mMtPL1XFVa48JCMRAWqdoI=
X-Google-Smtp-Source: ABdhPJziEekR2fPhRBerNtqricUmPS/et+OY8uzsvpXbmmsSesXPpQsZ9CIewWzE7WhbAjIkCzirFDmVoPeN7OAxBQ4=
X-Received: by 2002:adf:a553:: with SMTP id j19mr505099wrb.349.1603341372011;
 Wed, 21 Oct 2020 21:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com> <b3c73389-7b4c-89cd-423c-68b00fcc61c9@linux.intel.com>
In-Reply-To: <b3c73389-7b4c-89cd-423c-68b00fcc61c9@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Oct 2020 13:36:01 +0900
Message-ID: <CAM9d7cgr11TD-cACYbsxa=sUyStH_TGUDbdw9dsBuKAH43uQow@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] perf session: introduce decompressor into trace
 reader object
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

On Thu, Oct 22, 2020 at 1:00 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Introduce decompressor to trace reader object so that decompression
> could be executed on per trace file basis separately for every
> trace file located in trace directory.

I'm slightly uncomfortable with the word 'trace' here as it's
used for other cases like perf trace and ftrace.  Maybe we can
change it to 'profile' and/or 'data file'?

Thanks
Namhyung

>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/session.c | 4 +++-
>  tools/perf/util/session.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 911b2dbcd0ac..6afc670fdf0c 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -44,6 +44,8 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>         u64 decomp_last_rem = 0;
>         size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
>         struct decomp *decomp, *decomp_last = session->decomp_last;
> +       struct zstd_data *zstd_data = session->reader ?
> +               &(session->reader->zstd_data) : &(session->zstd_data);
>
>         if (decomp_last) {
>                 decomp_last_rem = decomp_last->size - decomp_last->head;
> @@ -71,7 +73,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>         src = (void *)event + sizeof(struct perf_record_compressed);
>         src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
>
> -       decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
> +       decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
>                                 &(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>         if (!decomp_size) {
>                 munmap(decomp, mmap_len);
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index abdb8518a81f..4fc9ccdf7970 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -42,6 +42,7 @@ struct reader {
>         u64              data_size;
>         u64              data_offset;
>         reader_cb_t      process;
> +       struct zstd_data zstd_data;
>  };
>
>  struct perf_session {
> --
> 2.24.1
>
>
