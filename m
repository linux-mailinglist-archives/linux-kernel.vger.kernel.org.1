Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8D32F2902
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbhALHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:36:08 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46788 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhALHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:36:08 -0500
Received: by mail-lj1-f174.google.com with SMTP id u11so1704222ljo.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVjaHrWianPPRGb7QXh34XCCnFMGhB7Fieldkue6gGY=;
        b=ZfQwSXoJnGYnoym2k3UlmgVRBrBjCouUh9W4ATvk+2Au+mHfPUC/sjMfL/oJ7BFchK
         2/kITFJ2jCl4GMrfg0miK5O8Sdhwg3i7FMjqHQQ6zn4sHdFmTt31BKDvDtia7gMY3m9+
         p9tdqyMBZcTRyWvsSWvI6El722x1bhtTNid04zTSWAvFN36574Z7DmAIrB/Icm53XeJH
         BAotx+Dr+gulJw5XHLLSdjKz9/VW2BSzABCK4L5cY/fFJDr3J6WDZT6aj1quk/0T777H
         9ooo/tfUrydGCV/bFrggvE9ZzWaxW1VZlWGNFZh8OeiG10YufH+sO3I+3gIlOv8dXs86
         orEA==
X-Gm-Message-State: AOAM532R7yvKjkgP4wMEpSfVmG652vMTaCkKhNealkuwvx1VPCymUjyT
        2ZwJGj5Pha5kf8esyorYS8OswKeZC8diG3FJoaM=
X-Google-Smtp-Source: ABdhPJxovU9B9UrN61/zmwID+9XaWsxG9rycY9+ckQ5q7vNsusHpK+xTCxIg6Fr51IEB94zluujvjJtn7IZgIUce6xU=
X-Received: by 2002:a05:651c:301:: with SMTP id a1mr1386308ljp.275.1610436925816;
 Mon, 11 Jan 2021 23:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20201229214214.3413833-1-songliubraving@fb.com> <20201229214214.3413833-4-songliubraving@fb.com>
In-Reply-To: <20201229214214.3413833-4-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 12 Jan 2021 16:35:14 +0900
Message-ID: <CAM9d7chV0UEPaWFcPJppy++2dO6t16p+S7ah01+0r7r57dyTvQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF programs
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

Hi,

On Wed, Dec 30, 2020 at 6:42 AM Song Liu <songliubraving@fb.com> wrote:
>
> Introduce perf-stat -b option, which counts events for BPF programs, like:
>
> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>      1.487903822            115,200      ref-cycles
>      1.487903822             86,012      cycles
>      2.489147029             80,560      ref-cycles
>      2.489147029             73,784      cycles
>      3.490341825             60,720      ref-cycles
>      3.490341825             37,797      cycles
>      4.491540887             37,120      ref-cycles
>      4.491540887             31,963      cycles
>
> The example above counts cycles and ref-cycles of BPF program of id 254.
> This is similar to bpftool-prog-profile command, but more flexible.
>
> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> programs (monitor-progs) to the target BPF program (target-prog). The
> monitor-progs read perf_event before and after the target-prog, and
> aggregate the difference in a BPF map. Then the user space reads data
> from these maps.
>
> A new struct bpf_counter is introduced to provide common interface that
> uses BPF programs/maps to count perf events.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
