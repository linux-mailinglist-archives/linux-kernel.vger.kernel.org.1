Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE832B9586
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKSOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSOwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:52:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9430422253;
        Thu, 19 Nov 2020 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605797569;
        bh=arKwAImRZkpK7S8DScmkA7Yccm27HivzpID+RFG5ywU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwLPUwG6x/A15BIeyV0mYxquOXeJa+azepCbOoU6bGA50ISgGx2EuREj+Cnfgz4f3
         tUl+gEGSA/Bvt3c6pkJLgIG+93cf3VPnyZRXVaccDTmNy6WlpVk4jhvQppUP+EAgwA
         BrMbmM03aAD1O7hyF25b2cYGrGaKtXjHt62bAeoU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1B5E40E29; Thu, 19 Nov 2020 11:52:46 -0300 (-03)
Date:   Thu, 19 Nov 2020 11:52:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [RFC 0/2] Introduce perf-stat -b for BPF programs
Message-ID: <20201119145246.GJ692998@kernel.org>
References: <20201119045046.1491106-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119045046.1491106-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 18, 2020 at 08:50:44PM -0800, Song Liu escreveu:
> This set introduces perf-stat -b option to count events for BPF programs.
> This is similar to bpftool-prog-profile. But perf-stat makes it much more
> flexible.
> 
> Sending as RFC because I would like comments on some key design choices:
>   1. We are using BPF skeletons here, which is by far the easiest way to
>      write and ship BPF programs. However, this requires bpftool, which
>      makes building perf slower.
>   2. A Makefile is added to tools/perf/util/bpf_skel/ to build bpftool,
>      and BPF skeletons. This keeps main perf Makefiles simple. But we may
>      not like it for some reason?

I'll review it in detail, but before that: thanks a lot for working on
this! Looks super cool from a first quick look. :-)

- Arnaldo
 
> Some known limitations (or work to be done):
>   1. Only counting events for one BPF program at a time.
>   2. Need extra logic in target__validate().

 
> Song Liu (2):
>   perf: support build BPF skeletons with perf
>   perf-stat: enable counting events for BPF programs
> 
>  tools/build/Makefile.feature                  |   3 +-
>  tools/perf/Makefile.config                    |   8 +
>  tools/perf/Makefile.perf                      |  15 +-
>  tools/perf/builtin-stat.c                     |  59 ++++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf_counter.c                 | 215 ++++++++++++++++++
>  tools/perf/util/bpf_counter.h                 |  71 ++++++
>  tools/perf/util/bpf_skel/.gitignore           |   3 +
>  tools/perf/util/bpf_skel/Makefile             |  71 ++++++
>  .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  96 ++++++++
>  tools/perf/util/bpf_skel/dummy.bpf.c          |  19 ++
>  tools/perf/util/evsel.c                       |  10 +
>  tools/perf/util/evsel.h                       |   5 +
>  tools/perf/util/target.h                      |   6 +
>  14 files changed, 571 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/util/bpf_counter.c
>  create mode 100644 tools/perf/util/bpf_counter.h
>  create mode 100644 tools/perf/util/bpf_skel/.gitignore
>  create mode 100644 tools/perf/util/bpf_skel/Makefile
>  create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c
> 
> --
> 2.24.1

-- 

- Arnaldo
