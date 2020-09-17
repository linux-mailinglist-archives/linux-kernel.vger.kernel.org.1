Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8771126D0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIQBeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:34:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32862 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIQBdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:33:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id m6so260234wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXYdbE0ylL+xj4NMQULiDTw+nKl+A7qV0MkVXOJKLsw=;
        b=kEAAvgVzzi9ihm+TKy4Tv1p2JO5DY8c8U21F+T8+TSfonP28pDTGfMc7Muun/zPFsA
         bViPNHu1Gfw415EIKVy1pWhKrZTVV8ysBkQYcVNm1sCZnYAsCviyKEula5F9mAhD3BNH
         nCvYvQXNpNAvw0Q+2nuhxa1GbQ01ZmbgR1PLafd3ZlkZPKlz/+qwPG+oXZA00ZzdzRIr
         mmtWDVTnfF4u8sob73OEauF11gJbxqteDk57piDx3sOvqSA27QZWEMFLyVz+4OMRA0o3
         0agPyceBj0t7ty0XcO3JprgojtKb2k/4CbAcQIf0mPXPL5cWzW/ZfDNH5uMAPY4GTI24
         egjg==
X-Gm-Message-State: AOAM531O1qu27AgTISldaL447BA9Kccj5sl0INDi+bg/gBeYed2fy1sm
        hbXdfV8gkSol4BwObUWQ9987afQlG90Oo3sjdK0=
X-Google-Smtp-Source: ABdhPJzh5UUASvNAagA1ZQAoC4/o/+0acKQdzUFozeFkljZqM7rDcKdZ/b4LLei0Y00280kpujNFh20L3QhtTdmXtZQ=
X-Received: by 2002:adf:9e41:: with SMTP id v1mr32043462wre.60.1600306401171;
 Wed, 16 Sep 2020 18:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200916063129.1061487-1-namhyung@kernel.org> <20200916063129.1061487-3-namhyung@kernel.org>
 <20200916135123.GO720847@kernel.org>
In-Reply-To: <20200916135123.GO720847@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Sep 2020 10:33:10 +0900
Message-ID: <CAM9d7cixyyND8EOKRn8XdZj=Lf2S68bosMYMnAS4sGdc2x6zDg@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf stat: Add --for-each-cgroup option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:51 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Sep 16, 2020 at 03:31:27PM +0900, Namhyung Kim escreveu:
> > The --for-each-cgroup option is a syntax sugar to monitor large number
>
> You forgot to add the man page entry for this new option.

OK, will add.. any more comments?

Thanks
Namhyung

>
> > of cgroups easily.  Current command line requires to list all the
> > events and cgroups even if users want to monitor same events for each
> > cgroup.  This patch addresses that usage by copying given events for
> > each cgroup on user's behalf.
> >
> > For instance, if they want to monitor 6 events for 200 cgroups each
> > they should write 1200 event names (with -e) AND 1200 cgroup names
> > (with -G) on the command line.  But with this change, they can just
> > specify 6 events and 200 cgroups with a new option.
> >
> > A simpler example below: It wants to measure 3 events for 2 cgroups
> > ('A' and 'B').  The result is that total 6 events are counted like
> > below.
> >
> >   $ ./perf stat -a -e cpu-clock,cycles,instructions --for-each-cgroup A,B sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >               988.18 msec cpu-clock                 A #    0.987 CPUs utilized
> >        3,153,761,702      cycles                    A #    3.200 GHz                      (100.00%)
> >        8,067,769,847      instructions              A #    2.57  insn per cycle           (100.00%)
> >               982.71 msec cpu-clock                 B #    0.982 CPUs utilized
> >        3,136,093,298      cycles                    B #    3.182 GHz                      (99.99%)
> >        8,109,619,327      instructions              B #    2.58  insn per cycle           (99.99%)
> >
> >          1.001228054 seconds time elapsed
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
