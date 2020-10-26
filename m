Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026B8298CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775166AbgJZMcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:32:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38982 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767813AbgJZMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:32:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id d3so12283480wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 05:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mPG9kxgffFTRkjAQY/IMTqi1t20ao+eTWiXrIBwNB4=;
        b=nrBGahKS9gt90seRsUR97NGtN06DHavBktktTrnlIK7JASV07MLq8MvjJqt7rz6vBt
         crnE4CP08rgie4z2UEXFwincdONfCcuCZCcX0EwaGcEfRKuUwxBhY+6OGkzNK8JQSSU2
         C5/oOu2/JQilE8eoYz7im0XLslHF7TpTXXMe0BNUPxj+S8gnpyWqCP0LTMw7dyMMAlNM
         qFW6zPkd1fl6ZrqCEBMNywQn0GLQIxt9VDTPCmzEJBaNmvFkO0eRaXmpSigufSOrPUc1
         cABgEfyllin6O6I2D/kl0RSw405Iu96UpDJjwfv00z3i6HGNtAgTRAGRY950Hf865Bgo
         A/DQ==
X-Gm-Message-State: AOAM5325ysl2c8DplAkGqLz+yxVrHuwyBr2/aigPWVO8rScZ+SM9x5Ag
        wfW6PN8bZE6xP/ec9BHygp6YRixWS3avBtHcPT4=
X-Google-Smtp-Source: ABdhPJxz0uN2vEQ8E9ggMNFCWrePFkBG2OlFiM75WtsiKyU3tEdzQN7oUVNuWKSFbKPdMZu3hbt5qKS+zAAIgHLLT6g=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr15830898wmj.146.1603715565242;
 Mon, 26 Oct 2020 05:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201024025918.453431-1-namhyung@kernel.org> <20201024025918.453431-2-namhyung@kernel.org>
 <20201026114009.GD2726983@krava>
In-Reply-To: <20201026114009.GD2726983@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Oct 2020 21:32:34 +0900
Message-ID: <CAM9d7chdStkY7-tRjw9Fo+3wKdhrDYAkbNT0b-g6ftGoaZfMDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf stat: Support regex pattern in --for-each-cgroup
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Oct 26, 2020 at 8:40 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Oct 24, 2020 at 11:59:18AM +0900, Namhyung Kim wrote:
> > To make the command line even more compact with cgroups, support regex
> > pattern matching in cgroup names.
> >
> >   $ perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1
> >
> >           3,000.73 msec cpu-clock                 foo #    2.998 CPUs utilized
> >     12,530,992,699      cycles                    foo #    7.517 GHz                      (100.00%)
> >           1,000.61 msec cpu-clock                 foo/bar #    1.000 CPUs utilized
> >      4,178,529,579      cycles                    foo/bar #    2.506 GHz                      (100.00%)
> >           1,000.03 msec cpu-clock                 foo/baz #    0.999 CPUs utilized
> >      4,176,104,315      cycles                    foo/baz #    2.505 GHz                      (100.00%)
>
> just curious.. there was another foo/XXX group using the
> rest of the cycles, right?

No, if so it should be displayed too.  But actually there was a process
in the foo cgroup itself.

>
> also perhaps we want to warn if there's no match found:
>
>         $ sudo ./perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1
>
>          Performance counter stats for 'system wide':
>
>
>                1.002375575 seconds time elapsed
>

Right, will check this case.

Thanks
Namhyung
