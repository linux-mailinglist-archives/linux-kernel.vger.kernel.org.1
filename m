Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF32DB031
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgLOPfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:35:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbgLOPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:35:26 -0500
Date:   Tue, 15 Dec 2020 12:34:48 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608046476;
        bh=52A4ekBlPoxabGGEHzBDiC3rCXzZ5CrR7GUKzWMiBHs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojTqYk0a8J2vXMXc7L/cIs8bYOvF+eiHlWQVneN8dCUhUUqzf32813BCfcJUfh6e6
         MJ5lDkyU6uurS8rf5vIXa0Y9u/9k3cxJkdUNgZuDGiqm2idYdfxzB6ETx2Fd35co8J
         98YUsk4atCti3ArXWVK1enMWLmGcbYI74lP/HWtv64s93xgG3+2yiilrcbMjUl08fE
         vogE1iVsC8I1J3I5P+QSCmzu3mJ9TxE/t/zXrJ8lsSv86B3mcIButCybtO3hXwMljN
         OuG0Uld+OiNgX7mAC8riPutfrUdzmZ5ugptbvQ6SZk1PIeKctDGzooBGEA1sG6uodf
         H5+FpOBhS8hpQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2] perf callchain: Return directly when use
 '--call-graph dwarf' under !HAVE_DWARF_SUPPORT
Message-ID: <20201215153448.GA258566@kernel.org>
References: <1607996131-9340-1-git-send-email-yangtiezhu@loongson.cn>
 <CAM9d7chMkKBschy=abDqyOBg8_jxXBXhSN30k2m+MhPca_g2ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chMkKBschy=abDqyOBg8_jxXBXhSN30k2m+MhPca_g2ig@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 15, 2020 at 10:49:59PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Tue, Dec 15, 2020 at 10:35 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > DWARF register mappings have not been defined for some architectures,
> > at least for mips, so we can print an error message and then return
> > directly when use '--call-graph dwarf'.
> >
> > E.g. without this patch:
> >
> > [root@linux perf]# ./perf record --call-graph dwarf cd
> > Error:
> > The sys_perf_event_open() syscall returned with 89 (Function not implemented) for event (cycles).
> > /bin/dmesg | grep -i perf may provide additional information.
> >
> > With this patch:
> >
> > [root@linux perf]# ./perf record --call-graph dwarf cd
> > DWARF is not supported for architecture mips64
> >
> >  Usage: perf record [<options>] [<command>]
> >     or: perf record [<options>] -- <command> [<options>]
> >
> >         --call-graph <record_mode[,record_size]>
> >                           setup and enables call-graph (stack chain/backtrace):
> >
> >                                 record_mode:    call graph recording mode (fp|dwarf|lbr)
> >                                 record_size:    if record_mode is 'dwarf', max size of stack recording (<bytes>)
> >                                                 default: 8192 (bytes)
> >
> >                                 Default: fp
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >
> > v2: Use HAVE_DWARF_SUPPORT to check
> 
> I'm not sure whether this is because of lack of dwarf library or kernel support.
> Based on the error message, I guess it's from the kernel.  Then I think this
> patch won't be sufficient..

tools/perf/Makefile.config

  ifndef NO_DWARF
    ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
      msg := $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled);
      NO_DWARF := 1
    else
      CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
      LDFLAGS += $(LIBDW_LDFLAGS)
      EXTLIBS += ${DWARFLIBS}
      $(call detected,CONFIG_DWARF)
    endif # PERF_HAVE_DWARF_REGS
  endif # NO_DWARF

[acme@five perf]$ find tools/perf -type f | xargs grep PERF_HAVE_DWARF_REGS
tools/perf/arch/xtensa/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/x86/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/arm64/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/arm/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/s390/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/powerpc/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/sh/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/riscv/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/sparc/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/arch/csky/Makefile:PERF_HAVE_DWARF_REGS := 1
tools/perf/Makefile.config:    ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
tools/perf/Makefile.config:    endif # PERF_HAVE_DWARF_REGS
[acme@five perf]$

Ouch:

[acme@five perf]$ cat tools/perf/arch/xtensa/Makefile
# SPDX-License-Identifier: GPL-2.0-only
ifndef NO_DWARF
PERF_HAVE_DWARF_REGS := 1
endif
[acme@five perf]$

So you have a point, only if NO_DWARF is not defined, then
PERF_HAVE_DWARF_REGS is can be used to define HAVE_DWARF_SUPPORT, too
clumsy.

So probably my hunch that this should be done at
evsel__open_strerror() and use perf_missing_features.dwarf_regs is
what we should go...

I'm removing this patch from my current tree, please take a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=f55c66234c1967f6e56e56c3e084f80b417c124b

For how I did this for another feature that the kernel may or not
support, perf_event_open() fails, it notices that in
perf_missing_features and then later evsel__open_strerror() returns a
sensible warning, reacting to something the running kernel returned.

- Arnaldo
