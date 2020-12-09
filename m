Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59982D480A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgLIRhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:37:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732511AbgLIRgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:36:55 -0500
Date:   Wed, 9 Dec 2020 14:36:23 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607535374;
        bh=mKqfw4LlvC4BHb2SUf1RPWCFLYHqYWBkz7CS9om+lb4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVCy33vSNw3lnA7uU9vL3kD/HFlMfxb0lqTaz/dXjnhbVTf0RXvkXLbXT8MY4KSu5
         6rZYGTlZe+dNCCtwEYpIC8JOtybal+yup5Y3jvGT47CNJ4d+akZ4sLNIZyeKVWUzWT
         X6M3sQRh6ge9O5vDuaqG4rYsJT0Y0NIF5f6dTIsT9KdG731qafMFNvNNTboF/wFU5r
         ki1EwBKjYFfQrZrwIsi5Zekvs38wnYjmjAJDOyTrgtvSrukQY+SbbROPCz4af4zgNj
         Bzh4fXmF9HF6MWOAWstuIbJb8+ZODxAnBcjianxToKmAqzXzgN+JDtZ+EtSzaxSx1M
         yrJzoSBAnUM7Q==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 0/2] Introduce perf-stat -b for BPF programs
Message-ID: <20201209173623.GA185686@kernel.org>
References: <20201208181646.3044417-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208181646.3044417-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 08, 2020 at 10:16:44AM -0800, Song Liu escreveu:
> This set introduces perf-stat -b option to count events for BPF programs.
> This is similar to bpftool-prog-profile. But perf-stat makes it much more
> flexible.
> 
> Changes v2 => v3:
>   1. Small fixes in Makefile.perf and bpf_counter.c (Jiri)
>   2. Rebased on top of bpf-next. This is because 1/2 conflicts with some
>      patches in bpftool/Makefile.

Can't you split that up so that I can process the perf part and the
bpftool goes via the bpf-next tree?

- Arnaldo
 
> Changes PATCH v1 => PATCH v2:
>   1. Various fixes in Makefiles. (Jiri)
>   2. Fix an build warning/error with gcc-10. (Jiri)
> 
> Changes RFC v2 => PATCH v1:
>   1. Support counting on multiple BPF programs.
>   2. Add BPF handling to target__validate().
>   3. Improve Makefile. (Jiri)
> 
> Changes RFC v1 => RFC v2:
>   1. Use bootstrap version of bpftool. (Jiri)
>   2. Set default to not building bpf skeletons. (Jiri)
>   3. Remove util/bpf_skel/Makefile, keep all the logic in Makefile.perf.
>      (Jiri)
>   4. Remove dependency to vmlinux.h in the two skeletons. The goal here is
>      to enable building perf without building kernel (vmlinux) first.
>      Note: I also removed the logic that build vmlinux.h. We can add that
>      back when we have to use it (to access big kernel structures).
> 
> Song Liu (2):
>   perf: support build BPF skeletons with perf
>   perf-stat: enable counting events for BPF programs
> 
>  tools/bpf/bpftool/Makefile                    |   3 +
>  tools/build/Makefile.feature                  |   4 +-
>  tools/perf/Makefile.config                    |   9 +
>  tools/perf/Makefile.perf                      |  48 ++-
>  tools/perf/builtin-stat.c                     |  77 ++++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf_counter.c                 | 297 ++++++++++++++++++
>  tools/perf/util/bpf_counter.h                 |  73 +++++
>  tools/perf/util/bpf_skel/.gitignore           |   3 +
>  .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
>  tools/perf/util/evsel.c                       |  11 +
>  tools/perf/util/evsel.h                       |   6 +
>  tools/perf/util/stat-display.c                |   4 +-
>  tools/perf/util/target.c                      |  34 +-
>  tools/perf/util/target.h                      |  10 +
>  tools/scripts/Makefile.include                |   1 +
>  16 files changed, 655 insertions(+), 19 deletions(-)
>  create mode 100644 tools/perf/util/bpf_counter.c
>  create mode 100644 tools/perf/util/bpf_counter.h
>  create mode 100644 tools/perf/util/bpf_skel/.gitignore
>  create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> 
> --
> 2.24.1

-- 

- Arnaldo
