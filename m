Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D371D7B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEROfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 10:35:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726918AbgEROfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589812535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbnnOdQafl6gQHXat5hApk7VtrFtnDd/NOvHUjESf0U=;
        b=fiq4qrFLnca89SZ8FQ2WgC2qS0yWn6bK0Pdbtmad6rKrkgYnVXaeG73lIyXk6SD1GTG/Tt
        Ob+kxdwXP0zFsW8WGuKFcEvC+1kqW1C83JZqfHtIdEn1LptuGlofUIgqfIJAQD9dLXUVaO
        9/u6ProMMtDvHd9/gNMWwh41DJNLp9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-ulAkMvmjMxu08_UIxCMsKw-1; Mon, 18 May 2020 10:35:34 -0400
X-MC-Unique: ulAkMvmjMxu08_UIxCMsKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5192418FE860;
        Mon, 18 May 2020 14:35:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7A9DB6297D;
        Mon, 18 May 2020 14:35:29 +0000 (UTC)
Date:   Mon, 18 May 2020 16:35:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC] perf trace: Fix compilation error for make NO_LIBBPF=1
 DEBUG=1
Message-ID: <20200518143528.GA2809@krava>
References: <20200518141027.3765877-1-jolsa@kernel.org>
 <20200518141915.GA24211@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518141915.GA24211@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:19:15AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 18, 2020 at 04:10:27PM +0200, Jiri Olsa escreveu:
> > I haven't tested if this breaks some perf trace functionality,
> > hence RFC ;-)
> 
> Thanks for the patch, looks ok, applying, please let me know if you need
> to do something else with it.

just wasn't sure the hook will work with NULL,
so if you're ok with it, then it's ok ;-)

thanks,
jirka

> 
> - Arnaldo
>  
> > The perf compilation fails for NO_LIBBPF=1 DEBUG=1 with:
> > 
> >   $ make NO_LIBBPF=1 DEBUG=1
> >     BUILD:   Doing 'make -j8' parallel build
> >     CC       builtin-trace.o
> >     LD       perf-in.o
> >     LINK     perf
> >   /usr/bin/ld: perf-in.o: in function `trace__find_bpf_map_by_name':
> >   /home/jolsa/kernel/linux-perf/tools/perf/builtin-trace.c:4608: undefined reference to `bpf_object__find_map_by_name'
> >   collect2: error: ld returned 1 exit status
> >   make[2]: *** [Makefile.perf:631: perf] Error 1
> >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> >   make: *** [Makefile:70: all] Error 2
> > 
> > Moving trace__find_bpf_map_by_name calls under HAVE_LIBBPF_SUPPORT
> > ifdef and add make test for this.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-trace.c | 54 ++++++++++++++++++++++++--------------
> >  tools/perf/tests/make      |  1 +
> >  2 files changed, 35 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 56bcf1ab19f8..61bafca1018a 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3174,6 +3174,26 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
> >  }
> >  
> >  #ifdef HAVE_LIBBPF_SUPPORT
> > +static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
> > +{
> > +	if (trace->bpf_obj == NULL)
> > +		return NULL;
> > +
> > +	return bpf_object__find_map_by_name(trace->bpf_obj, name);
> > +}
> > +
> > +static void trace__set_bpf_map_filtered_pids(struct trace *trace)
> > +{
> > +	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
> > +}
> > +
> > +static void trace__set_bpf_map_syscalls(struct trace *trace)
> > +{
> > +	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
> > +	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
> > +	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
> > +}
> > +
> >  static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
> >  {
> >  	if (trace->bpf_obj == NULL)
> > @@ -3512,6 +3532,20 @@ static void trace__delete_augmented_syscalls(struct trace *trace)
> >  	trace->bpf_obj = NULL;
> >  }
> >  #else // HAVE_LIBBPF_SUPPORT
> > +static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace __maybe_unused,
> > +						   const char *name __maybe_unused)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static void trace__set_bpf_map_filtered_pids(struct trace *trace __maybe_unused)
> > +{
> > +}
> > +
> > +static void trace__set_bpf_map_syscalls(struct trace *trace __maybe_unused)
> > +{
> > +}
> > +
> >  static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
> >  {
> >  	return 0;
> > @@ -4600,26 +4634,6 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
> >  	return 0;
> >  }
> >  
> > -static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
> > -{
> > -	if (trace->bpf_obj == NULL)
> > -		return NULL;
> > -
> > -	return bpf_object__find_map_by_name(trace->bpf_obj, name);
> > -}
> > -
> > -static void trace__set_bpf_map_filtered_pids(struct trace *trace)
> > -{
> > -	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
> > -}
> > -
> > -static void trace__set_bpf_map_syscalls(struct trace *trace)
> > -{
> > -	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
> > -	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
> > -	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
> > -}
> > -
> >  static int trace__config(const char *var, const char *value, void *arg)
> >  {
> >  	struct trace *trace = arg;
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index 5d0c3a9c47a1..c3c59def9f87 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -84,6 +84,7 @@ make_no_libaudit    := NO_LIBAUDIT=1
> >  make_no_libbionic   := NO_LIBBIONIC=1
> >  make_no_auxtrace    := NO_AUXTRACE=1
> >  make_no_libbpf	    := NO_LIBBPF=1
> > +make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
> >  make_no_libcrypto   := NO_LIBCRYPTO=1
> >  make_with_babeltrace:= LIBBABELTRACE=1
> >  make_no_sdt	    := NO_SDT=1
> > -- 
> > 2.25.4
> > 
> 
> -- 
> 
> - Arnaldo
> 

