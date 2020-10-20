Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF13293AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394175AbgJTMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393999AbgJTMLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:11:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C0120770;
        Tue, 20 Oct 2020 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603195894;
        bh=5ifDXMMMwLIgrmUZtW951yFBYkpk5nYjzmJ0TyOFnXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSdowltp/lUBNhIQgRgaS3AbOoM0KJa201H5KZ8HKdvHHPxdp3RxG/ryJmeCSYsSq
         SHwNfCqRP4aQEShjnE6khNulYuVHFyA8ZvLgRTkbhrRNvBJvMuGVJGyWMHeBTw973g
         YqbYdVP+MxZJT5p0o/gV2qev4whgD6bf7bEgGgs8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D185403C2; Tue, 20 Oct 2020 09:11:32 -0300 (-03)
Date:   Tue, 20 Oct 2020 09:11:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Fix crash with non-jited bpf progs
Message-ID: <20201020121132.GE2294271@kernel.org>
References: <20201016114718.54332-1-tommi.t.rantala@nokia.com>
 <20201019205343.GA2064287@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019205343.GA2064287@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 19, 2020 at 10:53:43PM +0200, Jiri Olsa escreveu:
> On Fri, Oct 16, 2020 at 02:47:18PM +0300, Tommi Rantala wrote:
> > The addr in PERF_RECORD_KSYMBOL events for non-jited bpf progs points to
> > the bpf interpreter, ie. within kernel text section. When processing the
> > unregister event, this causes unexpected removal of vmlinux_map,
> > crashing perf later in cleanup:
> > 
> >   # perf record -- timeout --signal=INT 2s /usr/share/bcc/tools/execsnoop
> >   PCOMM            PID    PPID   RET ARGS
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.208 MB perf.data (5155 samples) ]
> >   perf: tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.
> >   Aborted (core dumped)
> > 
> >   # perf script -D|grep KSYM
> >   0 0xa40 [0x48]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b530 len 0 type 1 flags 0x0 name bpf_prog_f958f6eb72ef5af6
> >   0 0xab0 [0x48]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b530 len 0 type 1 flags 0x0 name bpf_prog_8c42dee26e8cd4c2
> >   0 0xb20 [0x48]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b530 len 0 type 1 flags 0x0 name bpf_prog_f958f6eb72ef5af6
> >   108563691893 0x33d98 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3b0 len 0 type 1 flags 0x0 name bpf_prog_bc5697a410556fc2_syscall__execve
> >   108568518458 0x34098 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3f0 len 0 type 1 flags 0x0 name bpf_prog_45e2203c2928704d_do_ret_sys_execve
> >   109301967895 0x34830 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3b0 len 0 type 1 flags 0x1 name bpf_prog_bc5697a410556fc2_syscall__execve
> >   109302007356 0x348b0 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffa9b6b3f0 len 0 type 1 flags 0x1 name bpf_prog_45e2203c2928704d_do_ret_sys_execve
> >   perf: tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.
> > 
> > Here the addresses match the bpf interpreter:
> > 
> >   # grep -e ffffffffa9b6b530 -e ffffffffa9b6b3b0 -e ffffffffa9b6b3f0 /proc/kallsyms
> >   ffffffffa9b6b3b0 t __bpf_prog_run224
> >   ffffffffa9b6b3f0 t __bpf_prog_run192
> >   ffffffffa9b6b530 t __bpf_prog_run32
> > 
> > Fix by not allowing vmlinux_map to be removed by PERF_RECORD_KSYMBOL
> > unregister event.
> > 
> > Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> 
> nice, I almost forgot about non jit mode by now ;-)
> 
> Acked/Tested-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/machine.c | 11 ++++++++++-
> >  tools/perf/util/symbol.c  |  7 +++++++
> >  tools/perf/util/symbol.h  |  2 ++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 85587de027a5..d93d35463c61 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -786,11 +786,20 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
> >  					       union perf_event *event,
> >  					       struct perf_sample *sample __maybe_unused)
> >  {
> > +	struct symbol *sym;
> >  	struct map *map;
> >  
> >  	map = maps__find(&machine->kmaps, event->ksymbol.addr);
> > -	if (map)
> > +	if (!map)
> > +		return 0;
> > +
> > +	if (map != machine->vmlinux_map)
> >  		maps__remove(&machine->kmaps, map);
> > +	else {
> > +		sym = dso__find_symbol(map->dso, map->map_ip(map, map->start));
> > +		if (sym)
> > +			dso__delete_symbol(map->dso, sym);
> > +	}
> >  
> >  	return 0;
> >  }
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 5151a8c0b791..6bf8e74ea1d1 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -515,6 +515,13 @@ void dso__insert_symbol(struct dso *dso, struct symbol *sym)
> >  	}
> >  }
> >  
> > +void dso__delete_symbol(struct dso *dso, struct symbol *sym)
> > +{
> > +	rb_erase_cached(&sym->rb_node, &dso->symbols);
> > +	symbol__delete(sym);
> > +	dso__reset_find_symbol_cache(dso);
> > +}
> > +
> >  struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
> >  {
> >  	if (dso->last_find_result.addr != addr || dso->last_find_result.symbol == NULL) {
> > diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> > index 03e264a27cd3..60345691db09 100644
> > --- a/tools/perf/util/symbol.h
> > +++ b/tools/perf/util/symbol.h
> > @@ -130,6 +130,8 @@ int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
> >  
> >  void dso__insert_symbol(struct dso *dso,
> >  			struct symbol *sym);
> > +void dso__delete_symbol(struct dso *dso,
> > +			struct symbol *sym);
> >  
> >  struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
> >  struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name);
> > -- 
> > 2.26.2
> > 
> 

-- 

- Arnaldo
