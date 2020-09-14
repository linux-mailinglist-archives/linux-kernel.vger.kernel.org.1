Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5616E268423
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgINFjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:39:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39773 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINFj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:39:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id a17so17215511wrn.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 22:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAkzaOWL4Nu8JZqwZ6SJPpCKL9x+DfRKOfCjWFPwixM=;
        b=LNEy7nSL1csqmQkKo4xbs+uepo9przZZTzvkaTNFvlhOXkOzKGZpddByD0feaz+QsA
         jx8Z1S34nsDP9eSBjY3meAQ86Twdfd4tyZAT2Pp1KfE7jUuOrw5bN7/L4PsdEjMlOflE
         GonWbjwYLye+z9jFgdPXPLAayHb5UYtLMUYUf9LyfbEsxMuEYEUtSUoNqp4fxO/Naqij
         Moe8cRfJLpVq63BekmSiCorbiUz+7Zk6DIYv+coA6p5Dwi1ozct5U5xWvoLarKl4MXkb
         chFDxM7HnBj+olLxZI05e+PZgRP+Vcn8l4i8kgHVVWgPplDnZOjaf1DXHc0ZqdghOq9c
         KcoQ==
X-Gm-Message-State: AOAM532HSjVZgey84pGv55F5efmfcY8wdgVa1Jjx4sCqTdKqNROFnVL1
        aeNx8ZdfKdWeQl0zs5iUq/4z7edIDvFvq6w1V+g=
X-Google-Smtp-Source: ABdhPJx6kMLQl16pDPk60EVPC6sFWUbDYV331GMTw8XJLeNBDUj37LS7L07V7TtrRbJjTpeL4Py0YAvBLQerGSDCmb4=
X-Received: by 2002:adf:e481:: with SMTP id i1mr13900480wrm.391.1600061985048;
 Sun, 13 Sep 2020 22:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-4-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-4-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 14:39:34 +0900
Message-ID: <CAM9d7cizs+vbxD9QG8N5YQZDHRyh_NPGzPEKeGMj+63MuXmSGQ@mail.gmail.com>
Subject: Re: [PATCH 03/26] tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Sync uapi header with kernel version for mmap3 support.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 3e5dcdd48a49..84a0cbdab1ef 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -384,7 +384,8 @@ struct perf_event_attr {
>                                 aux_output     :  1, /* generate AUX records instead of events */
>                                 cgroup         :  1, /* include cgroup events */
>                                 text_poke      :  1, /* include text poke events */
> -                               __reserved_1   : 30;
> +                               mmap3          :  1, /* include bpf events */

Same here..

Thanks
Namhyung


> +                               __reserved_1   : 29;
>
>         union {
>                 __u32           wakeup_events;    /* wakeup every n events */
> @@ -1060,6 +1061,30 @@ enum perf_event_type {
>          */
>         PERF_RECORD_TEXT_POKE                   = 20,
>
> +       /*
> +        * The MMAP3 records are an augmented version of MMAP2, they add
> +        * build id value to identify the exact binary behind map
> +        *
> +        * struct {
> +        *      struct perf_event_header        header;
> +        *
> +        *      u32                             pid, tid;
> +        *      u64                             addr;
> +        *      u64                             len;
> +        *      u64                             pgoff;
> +        *      u32                             maj;
> +        *      u32                             min;
> +        *      u64                             ino;
> +        *      u64                             ino_generation;
> +        *      u32                             prot, flags;
> +        *      u32                             reserved;
> +        *      u8                              buildid[20];
> +        *      char                            filename[];
> +        *      struct sample_id                sample_id;
> +        * };
> +        */
> +       PERF_RECORD_MMAP3                       = 21,
> +
>         PERF_RECORD_MAX,                        /* non-ABI */
>  };
>
> --
> 2.26.2
>
