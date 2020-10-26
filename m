Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EAB298896
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771996AbgJZIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:39:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42073 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771987AbgJZIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:39:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id a7so10646127lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MgzziDtWia0Qt6LjrjyL/SczFKo3h9Y19cub3ha/Qec=;
        b=vzl1pTCIFx0XneZS6Ajx+G1Y+z/NUN55AaL/xLinXriNDsoDzOVBlAtHDnkpJ5aut6
         CKGXeEjqJTs0RtB/10s5dXNALqTTsqCCMQD3eTj/ymO9oD9SIDPdKMvsEBYi6rnf27of
         tfgpCI6tY4L/4zfqfJ5IDLvRfnvJhTkqBMoWplEaDEq+vxARCyijUNGrbgrElCQqFgvu
         VWvQ1+qfMe44NKQzU+Q3fNIOXxVoXAzM5B13ZKH7qZZnfFrfuYpedYlbg9yN4ikbZRtx
         u0BkHrFF64UrPzXp0zy11HoEx5Jv7fKRuy77EcZEKGeV/PRlthPlJnxubKrqu9Q4RcfN
         hH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MgzziDtWia0Qt6LjrjyL/SczFKo3h9Y19cub3ha/Qec=;
        b=bDMRc1g9xe4ykLhSwh0VoZaOTMSuYSheR80v5CWItk1A53JuOmHzUP6ZKdM019oDRu
         4Gqj5YzUYhDYJM7hCktEpwm1my/18b3kKxc/054jbhV7e0Cu/oXlETkQocio/b6DxGOE
         HQuHYY5ooL4gj4hY0C0gB0+hgFx2xzchPqd2GEcPDfia8ZTm2nCUe8e8jziArptwjeni
         ULoccGBtp/8Ol229ioJBW4TRpMQcUIdDqMGvmYXBZMVzYYx6Ua1OSU9M3XrQpYG1tfw8
         ktpoJzik0iAzBaIS/Le0kA0AtmbsLYfFMWh+LgtQfk5W+AEHp1qumOKtR2jqOgGV9T4h
         mn1w==
X-Gm-Message-State: AOAM531edQC2D76xThZdo8RjtQW9tmr9hYJ7WUwuu3TVmDIb2EBLU0fG
        /Ggy95bF6ERrloljHrPuGglJmTrCYpJiIU2YFwCbuA==
X-Google-Smtp-Source: ABdhPJzr3s5M87pQoi5VCQrf33nF7wyyQtVgqXKiWuV6DlgnHehk+Od/YgyN+Lzm8SVUZT24AthLuKOgE7kZleugWXg=
X-Received: by 2002:a19:4a88:: with SMTP id x130mr4414957lfa.31.1603701584698;
 Mon, 26 Oct 2020 01:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
In-Reply-To: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 26 Oct 2020 09:39:32 +0100
Message-ID: <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework load_balance()"
To:     Chris Mason <clm@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris

On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
>
> Hi everyone,
>
> We=E2=80=99re validating a new kernel in the fleet, and compared with v5.=
2,

Which version are you using ?
several improvements have been added since v5.5 and the rework of load_bala=
nce

> performance is ~2-3% lower for some of our workloads.  After some
> digging, Johannes found that our involuntary context switch rate was ~2x
> higher, and we were leaving a CPU idle a higher percentage of the time,
> even though the workload was trying to saturate the system.
>
> We were able to reproduce the problem with schbench, and Johannes
> bisected down to:
>
> commit 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912
> Author: Vincent Guittot <vincent.guittot@linaro.org>
> Date:   Fri Oct 18 15:26:31 2019 +0200
>
>      sched/fair: Rework load_balance()
>
> Our working theory is the load balancing changes are leaving processes
> behind busy CPUs instead of moving them onto idle ones.  I made a few
> schbench modifications to make this easier to demonstrate:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git/
>
> My VM has 40 cpus (20 cores, 2 threads per core), and my schbench
> command line is:

What is the topology ? are they all part of the same LLC ?

>
> schbench -t 20 -r 0 -c 1000000 -s 1000 -i 30 -z 120
>
> This has two message threads, and 20 workers per message thread.  Once
> woken up, the workers think for a full second, which means you=E2=80=99ll=
 have
> some long latencies if you=E2=80=99re stuck behind one of these workers i=
n the
> runqueue.  The message thread does a little bit of work and then sleeps,
> so we end up with 40 threads hammering full blast on the CPU and 2
> threads popping in and out of idle.
>
> schbench times the delay from when a message thread wakes a worker to
> when the worker runs.  On a good kernel, the output looks like this:
>
> Latency percentiles (usec) runtime 1290 (s) (3280 total samples)
>          50.0th: 155 (1653 samples)
>          75.0th: 189 (808 samples)
>          90.0th: 216 (501 samples)
>          95.0th: 227 (163 samples)
>          *99.0th: 256 (123 samples)
>          99.5th: 1510 (16 samples)
>          99.9th: 3132 (13 samples)
>          min=3D21, max=3D3286
>
> With 0b0695f2b34a, we get this:
>
> Latency percentiles (usec) runtime 1440 (s) (4480 total samples)
>          50.0th: 147 (2261 samples)
>          75.0th: 182 (1116 samples)
>          90.0th: 205 (671 samples)
>          95.0th: 224 (215 samples)
>          *99.0th: 12240 (173 samples) <=E2=80=94=E2=80=94 much higher p99=
 and up
>          99.5th: 12752 (22 samples)
>          99.9th: 13104 (18 samples)
>          min=3D21, max=3D13172
>
> Since the idea is to fully load the machine with schbench, use schbench
> -t <your_num_cpus/2>, and make sure the box doesn=E2=80=99t have other st=
uff
> running in the background.  I used a VM because it ended up giving more
> consistent results on our kernel test machines, which have some periodic
> noise running in the background.
>
> We=E2=80=99ve tried a few different approaches, but don=E2=80=99t quite h=
ave a solid
> fix yet.  I thought I=E2=80=99d kick off the discussion with my most usef=
ul
> hunks so far:
>
> diff a/kernel/sched/fair.c b/kernel/sched/fair.c
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
>
> -chris
