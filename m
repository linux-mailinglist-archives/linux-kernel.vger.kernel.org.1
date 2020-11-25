Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F282C40A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgKYMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:55:07 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:45204 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKYMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:55:06 -0500
Received: by mail-lj1-f178.google.com with SMTP id b17so2139274ljf.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLnRwfdcdOxY2dP+spMnSnPeaQC/00TlBcBbUyOD4Zg=;
        b=cLckE2Zr1SJ03smryq8Nmav4gVTGgdfxGuv46CmvZjqd4ITSLVwLIDYNjju9nRvdvn
         9OVipwCgGvuGgaT26b47agfvCSqh+a/kQYnE0QUJmKwL3cbE7aYqzDCIedthrEvWWWzi
         aMR7QI/6DKIFh8jfsKsoqnSjrRCG68OqwZFjWDXMYAqUEldaYyukRUfVbyIm+fWn/1Vb
         ++9xnrCbk3aHFmA7ghGjSxWs8KkmjRrFng2sHeUHuW1XJtx9JdVqkUDGgRaox0X2HXd6
         217CVq/mlReZ2RU0JVYXl7umYx4kY6hlxs1MGt1qCnTLTnKjMc1xRC+vCjIWwzwVYvKC
         JUnw==
X-Gm-Message-State: AOAM531PKG3DlkhdkyzNbdmBnmo1SP6UgILOEDGRuqLVSu+3+I7Lw2WF
        s5NuD2+BlQ9BTCCxG8U5/bapweuXwNuM1cyQkxI=
X-Google-Smtp-Source: ABdhPJyRgNOs6G8/U8oIf2zSK2ZO5ncwh0MbnA51D7XUpFAVmE1PxAW8Caa0R4RA813U7vfE8mQFNYtGxb2co+DCeNE=
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr1387879ljj.48.1606308903831;
 Wed, 25 Nov 2020 04:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20201123230512.2097312-1-jolsa@kernel.org>
In-Reply-To: <20201123230512.2097312-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Nov 2020 21:54:52 +0900
Message-ID: <CAM9d7cgz=gMKe9YfmpBCQR7qCz56t4CwwC_p76Ouwre11Ax5mg@mail.gmail.com>
Subject: Re: [PATCHv3 00/25] perf: Add mmap2 build id support
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Frank Ch . Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Nov 24, 2020 at 8:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> adding the support to have buildid stored in mmap2 event,
> so we can bypass the final perf record hunt on build ids.
>
> This patchset allows perf to record build ID in mmap2 event,
> and adds perf tooling to store/download binaries to .debug
> cache based on these build IDs.
>
> Note that the build id retrieval code is stolen from bpf
> code, where it's been used (together with file offsets)
> to replace IPs in user space stack traces. It's now added
> under lib directory.
>
> v3 changes:
>   - added acks
>   - removed forgotten debug code [Arnaldo]
>   - fixed readlink termination [Ian]
>   - fixed doc for --debuginfod=URLs [Ian]
>   - adopted kernel's memchr_inv function and used
>     it in build_id__is_defined function [Arnaldo]

[SNIP]
> ---
> Jiri Olsa (25):
>       bpf: Move stack_map_get_build_id into lib
>       bpf: Add size arg to build_id_parse function
>       perf: Add build id data in mmap2 event
>       tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
>       tools lib: Adopt memchr_inv() from kernel
>       perf tools: Do not swap mmap2 fields in case it contains build id
>       perf tools: Add build_id__is_defined function
>       perf tools: Add filename__decompress function
>       perf tools: Add support to read build id from compressed elf
>       perf tools: Add check for existing link in buildid dir
>       perf tools: Use struct extra_kernel_map in machine__process_kernel_mmap_event
>       perf tools: Try to load vmlinux from buildid database
>       perf tools: Store build id from mmap2 events
>       perf tools: Allow mmap2 event to synthesize kernel image
>       perf tools: Allow mmap2 event to synthesize modules
>       perf tools: Synthesize build id for kernel/modules/tasks
>       perf tools: Add support to display build id for mmap2 events
>       perf tools: Use machine__for_each_dso in perf_session__cache_build_ids
>       perf tools: Add __perf_session__cache_build_ids function
>       perf tools: Add is_perf_data function
>       perf tools: Add build_id_cache__add function
>       perf buildid-cache: Add support to add build ids from perf data
>       perf buildid-cache: Add --debuginfod option
>       perf buildid-list: Add support for mmap2's buildid events
>       perf record: Add --buildid-mmap option to enable mmap's build id

Mostly looks good!

I only have some comments on the buildid-cache part.

Thanks,
Namhyung

>
>  include/linux/buildid.h                           |  12 +++++
>  include/uapi/linux/perf_event.h                   |  42 +++++++++++++++---
>  kernel/bpf/stackmap.c                             | 143 ++---------------------------------------------------------
>  kernel/events/core.c                              |  32 ++++++++++++--
>  lib/Makefile                                      |   3 +-
>  lib/buildid.c                                     | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/include/linux/string.h                      |   1 +
>  tools/include/uapi/linux/perf_event.h             |  42 +++++++++++++++---
>  tools/lib/perf/include/perf/event.h               |  18 ++++++--
>  tools/lib/string.c                                |  58 ++++++++++++++++++++++++
>  tools/perf/Documentation/perf-buildid-cache.txt   |  18 +++++++-
>  tools/perf/Documentation/perf-config.txt          |  10 ++++-
>  tools/perf/Documentation/perf-record.txt          |   3 ++
>  tools/perf/builtin-buildid-cache.c                | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  tools/perf/builtin-buildid-list.c                 |   3 ++
>  tools/perf/builtin-record.c                       |  20 +++++++++
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh |   2 +-
>  tools/perf/util/build-id.c                        | 127 ++++++++++++++++++++++++++++++++++-------------------
>  tools/perf/util/build-id.h                        |   8 ++++
>  tools/perf/util/data.c                            |  19 ++++++++
>  tools/perf/util/data.h                            |   1 +
>  tools/perf/util/dso.c                             |  31 ++++++++-----
>  tools/perf/util/dso.h                             |   2 +
>  tools/perf/util/event.c                           |  41 ++++++++++++-----
>  tools/perf/util/evsel.c                           |  10 +++--
>  tools/perf/util/machine.c                         |  80 ++++++++++++++++++++-------------
>  tools/perf/util/map.c                             |   8 +++-
>  tools/perf/util/map.h                             |   3 +-
>  tools/perf/util/perf_api_probe.c                  |  10 +++++
>  tools/perf/util/perf_api_probe.h                  |   1 +
>  tools/perf/util/perf_event_attr_fprintf.c         |   2 +
>  tools/perf/util/probe-event.c                     |   6 +--
>  tools/perf/util/record.h                          |   1 +
>  tools/perf/util/session.c                         |  11 +++--
>  tools/perf/util/symbol-elf.c                      |  37 +++++++++++++++-
>  tools/perf/util/symbol.c                          |  16 +++++++
>  tools/perf/util/symbol_conf.h                     |   3 +-
>  tools/perf/util/synthetic-events.c                | 121 +++++++++++++++++++++++++++++++++++++-------------
>  38 files changed, 1026 insertions(+), 311 deletions(-)
>  create mode 100644 include/linux/buildid.h
>  create mode 100644 lib/buildid.c
>
