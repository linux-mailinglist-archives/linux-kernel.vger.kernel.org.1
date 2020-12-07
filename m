Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127922D11DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLGNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:25:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38099 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLGNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:25:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id w13so5349830lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 05:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6R+mKdobZPxGFSXVZkvJEJYXaB6cPXOghB4Jwb/lc8=;
        b=A/zaLmujjnI8c2KVS7qZnNtEdZwbgf9AB5+P/uk873eiB2Tx2ggvn24khWWIi1oukG
         Pud0u8EiXDwnLrItHu7BOVB0+8uTV8TE3IY3z3KMEX+A3eIZlePrS52+WT8NaJ8YYAe9
         olYiobtufMzCsVsPhUIufGEDdiURqrQPDr1gmJCFUgUZj1IgdEsBs1mOKdSbCymiWeph
         Z1wiiR+Z1SVMYNnw7cB4DoP4VoIJvsvHnXmtPV8rJLq7rp9/0BPfgJ60XdBeKbtpiqk6
         NouZDPTY0qhm39z/9YvBHQQZDfLuOdaQx0y55fPqDfTZ6uhX816SPv+E3tgAklbwD/Wz
         OveQ==
X-Gm-Message-State: AOAM5302EaJBUAronHyBhU4iP+a5iRshilbSw/Ir+cNlZIwsNSmrHwP8
        D7MNe4K/US2yEYvw5LvI4bdfL6yxCNOdFiNL6hQ=
X-Google-Smtp-Source: ABdhPJwWOux+N2uN5G23QnVYTcVgm9bvKxVaj2jgJhFMwDoo/h31Cyna9kj21h7dtGX1uW4BQqz09zN8Z9BmfqFh9L4=
X-Received: by 2002:a05:6512:33a8:: with SMTP id i8mr417468lfg.5.1607347515185;
 Mon, 07 Dec 2020 05:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20201206170519.4010606-1-jolsa@kernel.org>
In-Reply-To: <20201206170519.4010606-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Dec 2020 22:25:04 +0900
Message-ID: <CAM9d7ci5EBmmypb4_x4nveZWL26NbCbAtJBXd5ELG-=mDNDgWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Allow to enable/disable events via
 control pipe
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Dec 7, 2020 at 2:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> adding support to enable/disable specific events via control
> file via following commands:
>
>     # echo enable-sched:sched_process_fork > control
>     # echo disabled-sched:sched_process_fork > control
>
> The code is available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/control
>
> thanks,
> jirka

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> Jiri Olsa (3):
>       perf tools: Add evlist__disable_evsel/evlist__enable_evsel
>       perf tools: Allow to enable/disable events via control file
>       perf tools: Allow to list events via control file
>
>  tools/perf/builtin-record.c |   3 +++
>  tools/perf/builtin-stat.c   |   3 +++
>  tools/perf/util/evlist.c    | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  tools/perf/util/evlist.h    |   8 ++++++++
>  4 files changed, 115 insertions(+), 4 deletions(-)
>
