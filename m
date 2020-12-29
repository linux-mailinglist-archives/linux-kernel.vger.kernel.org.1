Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124E72E6EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgL2HZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:25:47 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:39343 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2HZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:25:46 -0500
Received: by mail-lf1-f47.google.com with SMTP id a12so28935189lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsW0me4CZYfrJ7jvw6bqdKKDNHfc1qIFtkLhW9vDiEQ=;
        b=rrkVFy7ehpiavBCm7br15Y8kWXn+xqZ+oyyDt6OXMJj35qQDsdDc9Cks5uwc5gjCM9
         Z+N3Eg8V0q5p4yudqCupmO7rZb8S2t0fooP3lnDUUFp/LZ4PV+6sQgZIDMVzDK4clE53
         W/SVW7d60Zu8i8d44uDJgsdW8tN9BwDMeosQ/GH+4/QKlRnDrUEPAjzKkDV9sOjZliQ1
         wERrNAWcMCp5uMvbUgOoihMtc3CLZPTDGrbVJ8F/8DR+h1CQBnLaDugmLToi4muijvsd
         3X7v8J1jomq6lrv/nbt2alaQpL3jxSG57fvS9RV9kIe4q28n+tOKoA75d2oHpjkK/JLm
         vizQ==
X-Gm-Message-State: AOAM530aI8/l7/nFgo3dAec4sF/MVvHBXcrw7tfXtXiWeycEZYNayQZD
        sGFsipLAPkkcMqESAaUORMnb5VjsOfh7di4yXu0=
X-Google-Smtp-Source: ABdhPJwHcZWYy8LweXgd3hauDAJK1SgCvychc8/QnmON4Qcwe7FQdam4DPczew9kw0S1/3CRKgB93qeMhmkIGdeomwE=
X-Received: by 2002:a2e:bc16:: with SMTP id b22mr25325006ljf.166.1609226703987;
 Mon, 28 Dec 2020 23:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20201228174054.907740-1-songliubraving@fb.com> <20201228174054.907740-5-songliubraving@fb.com>
In-Reply-To: <20201228174054.907740-5-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Dec 2020 16:24:53 +0900
Message-ID: <CAM9d7chxLKqjhB3CoxPV8Oz9y6fzZBTZ-YhtEWc1dzf9s-iB3A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] perf-stat: add documentation for -b option
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
>
> Add documentation to perf-stat -b option, which stats event for BPF
> programs.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 5d4a673d7621a..15b9a646e853d 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -75,6 +75,20 @@ report::
>  --tid=<tid>::
>          stat events on existing thread id (comma separated list)
>
> +-b::
> +--bpf-prog::
> +        stat events on existing bpf program id (comma separated list),
> +        requiring root righs. For example:

Typo: rights

It'd be nice if it can show how we can get the id.

Thanks,
Namhyung


> +
> +  # perf stat -e cycles,instructions --bpf-prog 17247 --timeout 1000
> +
> +   Performance counter stats for 'BPF program(s) 17247':
> +
> +             85,967      cycles
> +             28,982      instructions              #    0.34  insn per cycle
> +
> +        1.102235068 seconds time elapsed
> +
>  ifdef::HAVE_LIBPFM[]
>  --pfm-events events::
>  Select a PMU event using libpfm4 syntax (see http://perfmon2.sf.net)
> --
> 2.24.1
>
