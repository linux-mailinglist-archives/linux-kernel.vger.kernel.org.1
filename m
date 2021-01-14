Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205E92F5A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 05:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhANEzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 23:55:00 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:40156 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbhANEy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 23:54:58 -0500
Received: by mail-lf1-f53.google.com with SMTP id m12so6226065lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 20:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QNuc5f5wtLLJ36D9lt2nfW/3BD8HkXS2QxBwmwSVa8=;
        b=j5v2yu92MTOT8+OboLb/0Waa27BMHe3tLuP0S8yVLpkHWBY1bDRAbxK77sLpn6F4XS
         AQiW5Vp5uwzz+gBeb6xzZrCvxxZsjdASLQfrgj6EsqrtDoTInEVk6qclpnl8yP6gAJAb
         4d8mxPdbKnnm3/NNFH0zCaHR1wO2Lde2ZOpEq7TBNPaHv8CHQVeObM7kiI2g0jWzgd/t
         ZmrF8KP00/Yr1Zo2kilfC4FVrPtVJhNfAvEAFyql8qLYbyd+u73RSoSZGr0+JO7VIJ+M
         KGRzIoOef8IDA6t81eDcWN0nCXFuE445LJ9E3BJJmTvnENCeSp1SPv6h6eBVkAcXPMHT
         eOcQ==
X-Gm-Message-State: AOAM531fJjmZ9X1EwJoVkiC5TIv7t8ZdowxwLcokpK//dX09hUb3Occ7
        sSTGnyR6iZDkyrJ2wISa8sifUaaAUzXa10szKqxLwvbYR7Y=
X-Google-Smtp-Source: ABdhPJwIoCOczUufg2qa2oKWPRqPOtlucA6dn40C0SaO7Ked72QkH4MA5vrl1RMC89iee0EPMcniw8nO6/dbDVxpPjQ=
X-Received: by 2002:a19:8584:: with SMTP id h126mr2512631lfd.152.1610600058061;
 Wed, 13 Jan 2021 20:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20210113080128.10286-1-jslaby@suse.cz> <20210113104618.GB1331835@krava>
 <388a2e21-14ee-4609-84d0-c8824154c015@suse.cz>
In-Reply-To: <388a2e21-14ee-4609-84d0-c8824154c015@suse.cz>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Jan 2021 13:54:06 +0900
Message-ID: <CAM9d7cgmUqLX+C1wDPe9qaxDh1tY4sVmLx2qZqey3CQSmZSo2Q@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi both of Jiri,

On Wed, Jan 13, 2021 at 8:43 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 13. 01. 21, 11:46, Jiri Olsa wrote:
> > On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
> >> With LTO, there are symbols like these:
> >> /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
> >>   10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
> >>
> >> This comes from a runtime/debug split done by the standard way:
> >> objcopy --only-keep-debug $runtime $debug
> >> objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
> >>
> >> perf currently cannot resolve such symbols (relicts of LTO), as section
> >> 29 exists only in the debug file (29 is .debug_info). And perf resolves
> >> symbols only against runtime file. This results in all symbols from such
> >> a library being unresolved:
> >>       0.38%  main2    libantlr4-runtime.so.4.8  [.] 0x00000000000671e0
> >>
> >> So try resolving against the debug file first. And only if it fails (the
> >> section has NOBITS set), try runtime file. We can do this, as "objcopy
> >> --only-keep-debug" per documentation preserves all sections, but clears
> >> data of some of them (the runtime ones) and marks them as NOBITS.
> >>
> >> The correct result is now:
> >>       0.38%  main2    libantlr4-runtime.so.4.8  [.] antlr4::IntStream::~IntStream
> >>
> >> Note that these LTO symbols are properly skipped anyway as they belong
> >> neither to *text* nor to *data* (is_label && !elf_sec__filter(&shdr,
> >> secstrs) is true).
> >>
> >> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> ---
> >>   tools/perf/util/symbol-elf.c | 10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> >> index f3577f7d72fe..a31b716fa61c 100644
> >> --- a/tools/perf/util/symbol-elf.c
> >> +++ b/tools/perf/util/symbol-elf.c
> >> @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
> >>              if (sym.st_shndx == SHN_ABS)
> >>                      continue;
> >>
> >> -            sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> >> +            sec = elf_getscn(syms_ss->elf, sym.st_shndx);
> >>              if (!sec)
> >>                      goto out_elf_end;
> >
> > we iterate symbols from syms_ss, so the fix seems to be correct
> > to call elf_getscn on syms_ss, not on runtime_ss as we do now
> >
> > I'd think this worked only when runtime_ss == syms_ss
>
> No, because the headers are copied 1:1 from runtime_ss to syms_ss. And
> runtime_ss is then stripped, so only .debug* sections are removed there.
> (And syms_ss's are set as NOBITS.)
>
> We iterated .debug* sections in syms_ss and used runtime_ss section
> _headers_ only to adjust symbols (sometimes). That worked.

It seems PPC has an opd section only in the runtime_ss and that's why
we use it for section headers.

>
> >>              gelf_getshdr(sec, &shdr);
> >>
> >> +            if (shdr.sh_type == SHT_NOBITS) {
> >> +                    sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> >> +                    if (!sec)
> >> +                            goto out_elf_end;
> >> +
> >> +                    gelf_getshdr(sec, &shdr);
> >> +            }
> >
> > is that fallback necessary? the symbol is from syms_ss
>
> Provided the above, we don't need the section data here, only headers,
> so the NOBITS test is superfluous and the fallback shouldn't be needed.
> Let me test it.

We need to talk to PPC folks like I said.  Or maybe we can change the
default ss depending on the arch.

Thanks,
Namhyung
