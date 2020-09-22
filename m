Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C47274CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgIVW54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:57:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46901 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVW54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:57:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id o5so18812898wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yz/dntHJAQmyWx39DxcIDsmJJPCYBH5IoHF45cttlA=;
        b=SSvI+2AR4b+qVlOYWZ72Fupp6LpXbdQqYWpd+U3gtE3dtbfyyZ3WqEjLOYYTf5m8Lv
         iIX3QHDNiqLXSyDSLjwn7EuDAJqlbMwLoG9PE2/e4rIKK3Ycu7Xb2SJi5dBhj7j+s9Rq
         9WQ/Qymnl95x1QVJVYDoYju7pCw+Vf6j6JFlwd+sfKAPn4E+l+t8r2dSUxQdaSpUaIBY
         GkP1HoIKXvqoYAyEihEGz1roRTPAkS3Jx35TLNKfbms1kkuo/lAgswKZ6n8wldE0cYIY
         8T7WgeDmTOe7egIDwA3KgTEYRXSY+uWxiEcH4gQmLxkLa5cY/b37dbW4vf3FGqGz1a+R
         ukoA==
X-Gm-Message-State: AOAM532AsSYyEGaZVgKm2ZNwREjkO779Vb6VhJK20UbrzS2tX40qZenT
        ZuNQ6E3h12o2hRT+TPrrXMNGjKCC33YsS34Va4Q=
X-Google-Smtp-Source: ABdhPJwIOluJ/iktY7gzbZybpFZK6LtVf+Z30aSQGhqVtz1DYGhg5+WjKoIZWAzDG4Jz+IaQlzWJ7qPS83I+Ru3lqOo=
X-Received: by 2002:adf:9e41:: with SMTP id v1mr8514600wre.60.1600815474589;
 Tue, 22 Sep 2020 15:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200921094610.83736-1-namhyung@kernel.org> <20200921094610.83736-3-namhyung@kernel.org>
In-Reply-To: <20200921094610.83736-3-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 07:57:43 +0900
Message-ID: <CAM9d7ci09Qrkc6w-ysCTD5ARAZNXb0rqAg+K6Xbn=KaHFQzM5g@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf stat: Add --for-each-cgroup option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
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

On Mon, Sep 21, 2020 at 6:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The --for-each-cgroup option is a syntax sugar to monitor large number
> of cgroups easily.  Current command line requires to list all the
> events and cgroups even if users want to monitor same events for each
> cgroup.  This patch addresses that usage by copying given events for
> each cgroup on user's behalf.
>
> For instance, if they want to monitor 6 events for 200 cgroups each
> they should write 1200 event names (with -e) AND 1200 cgroup names
> (with -G) on the command line.  But with this change, they can just
> specify 6 events and 200 cgroups with a new option.
>
> A simpler example below: It wants to measure 3 events for 2 cgroups
> ('A' and 'B').  The result is that total 6 events are counted like
> below.
>
>   $ ./perf stat -a -e cpu-clock,cycles,instructions --for-each-cgroup A,B sleep 1
>
>    Performance counter stats for 'system wide':
>
>               988.18 msec cpu-clock                 A #    0.987 CPUs utilized
>        3,153,761,702      cycles                    A #    3.200 GHz                      (100.00%)
>        8,067,769,847      instructions              A #    2.57  insn per cycle           (100.00%)
>               982.71 msec cpu-clock                 B #    0.982 CPUs utilized
>        3,136,093,298      cycles                    B #    3.182 GHz                      (99.99%)
>        8,109,619,327      instructions              B #    2.58  insn per cycle           (99.99%)
>
>          1.001228054 seconds time elapsed
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 20 +++++++++-
>  tools/perf/util/cgroup.c  | 84 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cgroup.h  |  1 +
>  tools/perf/util/stat.h    |  1 +
>  4 files changed, 105 insertions(+), 1 deletion(-)

Oh, I've realized that I didn't update the man page..
I'll send v4 soon.

Thanks
Namhyung
