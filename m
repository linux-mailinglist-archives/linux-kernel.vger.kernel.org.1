Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3502FB804
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbhASLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391429AbhASLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:33:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1EBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 03:33:16 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m25so28545262lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 03:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRlRwCXBQqFWBVQb1zxfXYyPGsjBcCLpVDNGTdRqxtk=;
        b=w5ezaKFSagLiSQtyJ5EBHgQ8Z9ZhoLdjDpIRdr/IF03cy2B9syiorfadKJKCgZ8rzE
         SosTBZWVr2zPBPHSJwjZm9+uVgtWPiGWvKbGZjiF6TxfnAS25+lkL536X8I/6P8tcmZD
         cHMMduFkSX7VPoiwNfcolXWIFh1O684klOEIWOFkzZbhpOpSKWJnlvkbVg0KmfxwHFpS
         rqrKJcewER0l6tdzotY+1V04O50MYaznH/Ns6hGY/fGI6+TDOaIEwtsP8XkIkrtgIiE2
         WGiFqpdspWLmXw0XgIwZMxqSep3DNUxvEGoKLSkxGvav7Za4f9yL5SK336slnks8H/z2
         5qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRlRwCXBQqFWBVQb1zxfXYyPGsjBcCLpVDNGTdRqxtk=;
        b=m6yqtq1msk0HWPIKz3ssD3El4boPTmPUQ6T8CUHyUhRrMwYw+SP8x+M2tJEKpoeEP/
         eh25HMnYVB1b3Dicuv00wKVk7fdO8pexKtnN3MyAGbNmtviNiW0+/KgX/KrVAvEYhZvQ
         5vpjj2uq0w6xEDQoUFDZQMLds51ZnCl3KyNcIQuJXZWXzJJs9ToJDpMMdlh+8iSI2HTs
         FKm1bsyXjUHw07PpnBddhRNgiHm56jOzbsb5r0rksGWDAX9VPdx3ZseKZWB3dQlv+c+L
         phDjl8bI0hbwypCSVbZYLfuQAcR/RtUr6+gmJM5hWfTfiI5PGsznQPKdjgP8OIA8OIRE
         QtPg==
X-Gm-Message-State: AOAM5312q7ypwYlg+LtjK+vbvBpFtKsS+WeNzI269G2UVO+2OrRVjv5f
        fPM2Kul53UifKuMUxrRbZ09bEwWyhaWKejuDaM/rrw==
X-Google-Smtp-Source: ABdhPJw8M7hx4EJOqs8r2zYitGe2UpXVEv83ikFof+ZMFQjHwRZCbWTQmRSjiUWhD8tpULCww4rv1xE6hRSWE515mUw=
X-Received: by 2002:ac2:4d91:: with SMTP id g17mr1728565lfe.254.1611055995059;
 Tue, 19 Jan 2021 03:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20210119112211.3196-1-mgorman@techsingularity.net>
In-Reply-To: <20210119112211.3196-1-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jan 2021 12:33:04 +0100
Message-ID: <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 12:22, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Changelog since v2
> o Remove unnecessary parameters
> o Update nr during scan only when scanning for cpus

Hi Mel,

I haven't looked at your previous version mainly because I'm chasing a
performance regression on v5.11-rcx which prevents me from testing the
impact of your patchset on my !SMT2 system.
Will do this as soon as this problem is fixed

>
> Changlog since v1
> o Move extern declaration to header for coding style
> o Remove unnecessary parameter from __select_idle_cpu
>
> This series of 5 patches reposts three patches from Peter entitled
> "select_idle_sibling() wreckage". It only scans the runqueues in a single
> pass when searching for an idle sibling.
>
> Two patches from Peter were dropped. The first patch altered how scan
> depth was calculated. Scan depth deletion is a random number generator
> with two major limitations. The avg_idle time is based on the time
> between a CPU going idle and being woken up clamped approximately by
> 2*sysctl_sched_migration_cost.  This is difficult to compare in a sensible
> fashion to avg_scan_cost. The second issue is that only the avg_scan_cost
> of scan failures is recorded and it does not decay.  This requires deeper
> surgery that would justify a patch on its own although Peter notes that
> https://lkml.kernel.org/r/20180530143105.977759909@infradead.org is
> potentially useful for an alternative avg_idle metric.
>
> The second patch dropped converted the idle core scan throttling
> mechanism to SIS_PROP. While this would unify the throttling of core
> and CPU scanning, it was not free of regressions and has_idle_cores is
> a fairly effective throttling mechanism with the caveat that it can have
> a lot of false positives for workloads like hackbench.
>
> Peter's series tried to solve three problems at once, this subset addresses
> one problem. As with anything select_idle_sibling, it's a mix of wins and
> losses but won more than it lost across a range of workloads and machines.
>
>  kernel/sched/core.c     |  18 +++--
>  kernel/sched/fair.c     | 161 ++++++++++++++++++++--------------------
>  kernel/sched/features.h |   1 -
>  kernel/sched/sched.h    |   2 +
>  4 files changed, 95 insertions(+), 87 deletions(-)
>
> --
> 2.26.2
>
