Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B1298D97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774156AbgJZNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405626AbgJZNMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603717956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hpzod9ZzwfXRZZwTkJycH0HwA5tXWGgoOukCTxfEWak=;
        b=IsQ06YhaojDQvVei6HIt7WVbPtSPS0yZ7QpBFepT0cWrAi1k0iSoPGrkVi/tPVP7vmbPkX
        IxIWsXvKcMRBFlJg3a3auyBTxLWAh4+tZaxHeQP2stAkd+o5//MIiRApwoMGvK/xkD40Ux
        FWvfRK1zqTX6IbYyMpc7+y9KkjwXTCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-UsSMgJFBNkSBwu2ENR5nrA-1; Mon, 26 Oct 2020 09:12:32 -0400
X-MC-Unique: UsSMgJFBNkSBwu2ENR5nrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E0C1084C85;
        Mon, 26 Oct 2020 13:12:30 +0000 (UTC)
Received: from krava (unknown [10.40.195.226])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9AF195B4A4;
        Mon, 26 Oct 2020 13:12:27 +0000 (UTC)
Date:   Mon, 26 Oct 2020 14:12:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 2/2] perf stat: Support regex pattern in
 --for-each-cgroup
Message-ID: <20201026131226.GF2726983@krava>
References: <20201024025918.453431-1-namhyung@kernel.org>
 <20201024025918.453431-2-namhyung@kernel.org>
 <20201026114009.GD2726983@krava>
 <CAM9d7chdStkY7-tRjw9Fo+3wKdhrDYAkbNT0b-g6ftGoaZfMDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chdStkY7-tRjw9Fo+3wKdhrDYAkbNT0b-g6ftGoaZfMDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:32:34PM +0900, Namhyung Kim wrote:
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

nah, right ;-) ok

jirka

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
> 
> Thanks
> Namhyung
> 

