Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B829946B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788622AbgJZRxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780913AbgJZRxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:53:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C63720791;
        Mon, 26 Oct 2020 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603734832;
        bh=1+7x8X20mneBgmOpqia3W6ELvfpsExV2ATsV8SIe8ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCtZnhDs/sE7iw6ZGxPHBrsb6Jo/jdUFZy0AOrL1tSHO9Inr540hHV/I7fwQ2EfG0
         5UiWs+SX8voaGg4ULdsp/27DzxeLjqRtIB8hiyy2p9mDGjclYqMB/9Jyqzatoq9dqm
         10NrRiAgDGec9MDEwYROXQwQbmJadJ/bARGrvFMs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16E99403C2; Mon, 26 Oct 2020 14:53:49 -0300 (-03)
Date:   Mon, 26 Oct 2020 14:53:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 2/2] perf stat: Support regex pattern in
 --for-each-cgroup
Message-ID: <20201026175349.GA2449445@kernel.org>
References: <20201024025918.453431-1-namhyung@kernel.org>
 <20201024025918.453431-2-namhyung@kernel.org>
 <20201026114009.GD2726983@krava>
 <CAM9d7chdStkY7-tRjw9Fo+3wKdhrDYAkbNT0b-g6ftGoaZfMDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chdStkY7-tRjw9Fo+3wKdhrDYAkbNT0b-g6ftGoaZfMDQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 26, 2020 at 09:32:34PM +0900, Namhyung Kim escreveu:
> Hi Jiri,
> 
> On Mon, Oct 26, 2020 at 8:40 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Sat, Oct 24, 2020 at 11:59:18AM +0900, Namhyung Kim wrote:
> > > To make the command line even more compact with cgroups, support regex
> > > pattern matching in cgroup names.
> > >
> > >   $ perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1
> > >
> > >           3,000.73 msec cpu-clock                 foo #    2.998 CPUs utilized
> > >     12,530,992,699      cycles                    foo #    7.517 GHz                      (100.00%)
> > >           1,000.61 msec cpu-clock                 foo/bar #    1.000 CPUs utilized
> > >      4,178,529,579      cycles                    foo/bar #    2.506 GHz                      (100.00%)
> > >           1,000.03 msec cpu-clock                 foo/baz #    0.999 CPUs utilized
> > >      4,176,104,315      cycles                    foo/baz #    2.505 GHz                      (100.00%)
> >
> > just curious.. there was another foo/XXX group using the
> > rest of the cycles, right?
> 
> No, if so it should be displayed too.  But actually there was a process
> in the foo cgroup itself.
> 
> >
> > also perhaps we want to warn if there's no match found:
> >
> >         $ sudo ./perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1
> >
> >          Performance counter stats for 'system wide':
> >
> >
> >                1.002375575 seconds time elapsed
> >
> 
> Right, will check this case.

Hum, I thought that could be done on top of this one, but then, the
ambiguity of:

1. No samples for a cgroups matching that expression

2. No cgroups match that expression

Is real and warrants a warning for the 'no cgroups match the
--for-each-group regexp' case.

So I'll wait for v3 with that warning,

Thanks,

- Arnaldo
