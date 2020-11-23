Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CEC2C1862
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgKWW1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgKWW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606170430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7dLfFtgRm9y3CEI8VoKW/G9H4I0NA/BgsiziAd56T0=;
        b=TKpzDrjETucAmcqiKG1pp+Sij57XiHxkw3MmDfmYONoOnTz4qTW1auxakg8eKT3S31VRKE
        rgquzCrURluFVcezP9c+XlggRLLYcbdRfPva68hGaQVemTn0v4rbNmbaECDYSLwfTgxF/H
        481QAQ+rIdpGrEOuUUcOSOTBygTp6yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-KeBH2hRiO7WzQIUoO-lTGA-1; Mon, 23 Nov 2020 17:27:07 -0500
X-MC-Unique: KeBH2hRiO7WzQIUoO-lTGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D58D5185;
        Mon, 23 Nov 2020 22:27:04 +0000 (UTC)
Received: from krava (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with SMTP id CF28810016FA;
        Mon, 23 Nov 2020 22:27:00 +0000 (UTC)
Date:   Mon, 23 Nov 2020 23:26:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 22/24] perf buildid-cache: Add --debuginfod option
Message-ID: <20201123222659.GA2088148@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-23-jolsa@kernel.org>
 <CAP-5=fUDtTU2XYr6w6wYndP6RVFDLoJSnC31m+djA-r9EVMQiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUDtTU2XYr6w6wYndP6RVFDLoJSnC31m+djA-r9EVMQiw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:23:53PM -0800, Ian Rogers wrote:
> On Mon, Nov 9, 2020 at 1:55 PM Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding --debuginfod option to specify debuginfod url and
> > support to do that through config file as well.
> >
> > Use following in ~/.perfconfig file:
> >
> >   [buildid-cache]
> >   debuginfod=http://192.168.122.174:8002
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../perf/Documentation/perf-buildid-cache.txt |  4 +++
> >  tools/perf/builtin-buildid-cache.c            | 28 +++++++++++++++++--
> >  2 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-buildid-cache.txt
> > b/tools/perf/Documentation/perf-buildid-cache.txt
> > index b77da5138bca..0152d8b5cfbe 100644
> > --- a/tools/perf/Documentation/perf-buildid-cache.txt
> > +++ b/tools/perf/Documentation/perf-buildid-cache.txt
> > @@ -84,6 +84,10 @@ OPTIONS
> >         used when creating a uprobe for a process that resides in a
> >         different mount namespace from the perf(1) utility.
> >
> > +--debuginfod=URL::
> > +       Specify debuginfod URL to be used when retrieving perf.data
> > binaries,
> > +       it follows the same syntax as the DEBUGINFOD_URLS variable.
> > +
> >
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Nit: the environment variable name hints at this being a list, perhaps
> change URL:: above to URLs:: to keep this clear.

true, will change that

thanks,
jirka

