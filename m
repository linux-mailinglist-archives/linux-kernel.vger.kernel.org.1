Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28C2F73C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbhAOHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:38:37 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:40455 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbhAOHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:38:37 -0500
Received: by mail-qk1-f177.google.com with SMTP id z11so10877027qkj.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VQLhch2tvznClXcvsEtRp0FtI7Q9qiifzg7hnwGe2Y=;
        b=An4gL3Rp6xBQZqv+FGP4NDth61OYzjNg/9RPfOJ/SxGKKMP+EJSBKkrcBTzwbeMttG
         lgRPcGlfI83ZwZZlOjukyCx+8o53logj0mLH5V1KQRJVxzJgBnzGGiInspcm2isWIKbm
         8kY2habDcNNqHeIi6U5BxHW7GclFNuBHvvw/QMIftLAgBLJ72wgDCxn53gKQVpxoQFlV
         PGmQO2M4vzQxh1d/sHk1UM2FMDRwkBlNTGNYfnU0YOpuuVLed5yCKMlj7YT6XqLwFYPk
         mKUJSP4Kkl94O7tzo5mEoGYGs1pDbZcI6AYyvrkdhSxaW0y5zZ5wZw1n7rAgxuxBooKv
         vpIA==
X-Gm-Message-State: AOAM530mFlZrr+IqlMBdMyMPXIQM57DtsuivZvsE+Zjd6QgzACxv3wfw
        jEXKZMZEWPJ/1k236aJMJC2AjAerUqF6XCGgRycJYWY7CImyMw==
X-Google-Smtp-Source: ABdhPJwlUosA4V5gN1uUNGSCPi+KOJSFEDqHzEVZldToXcd/a0pXtbK4/llHzOVo/MjUrR0CNxaW5uttIhERTvn/K8A=
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr11003851qkl.132.1610696276033;
 Thu, 14 Jan 2021 23:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20210113080128.10286-1-jslaby@suse.cz> <20210113104618.GB1331835@krava>
 <388a2e21-14ee-4609-84d0-c8824154c015@suse.cz> <CAM9d7cgmUqLX+C1wDPe9qaxDh1tY4sVmLx2qZqey3CQSmZSo2Q@mail.gmail.com>
 <87sg73kbsq.fsf@mpe.ellerman.id.au>
In-Reply-To: <87sg73kbsq.fsf@mpe.ellerman.id.au>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 15 Jan 2021 16:37:44 +0900
Message-ID: <CAM9d7cicU-Nhi+eHMshv5QMbBK__yEF2UfyJxeeuNy9c-bX7-w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jiri Slaby <jslaby@suse.cz>, Jiri Olsa <jolsa@redhat.com>,
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

Hello,

On Thu, Jan 14, 2021 at 8:17 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Namhyung Kim <namhyung@kernel.org> writes:
> > On Wed, Jan 13, 2021 at 8:43 PM Jiri Slaby <jslaby@suse.cz> wrote:
> >>
> >> On 13. 01. 21, 11:46, Jiri Olsa wrote:
> >> > On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
> >> >> With LTO, there are symbols like these:
> >> >> /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
> >> >>   10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
> >> >>
> >> >> This comes from a runtime/debug split done by the standard way:
> >> >> objcopy --only-keep-debug $runtime $debug
> >> >> objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
> >> >>
> ...
> >> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> >> >> index f3577f7d72fe..a31b716fa61c 100644
> >> >> --- a/tools/perf/util/symbol-elf.c
> >> >> +++ b/tools/perf/util/symbol-elf.c
> >> >> @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
> >> >>              if (sym.st_shndx == SHN_ABS)
> >> >>                      continue;
> >> >>
> >> >> -            sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> >> >> +            sec = elf_getscn(syms_ss->elf, sym.st_shndx);
> >> >>              if (!sec)
> >> >>                      goto out_elf_end;
> >> >
> >> > we iterate symbols from syms_ss, so the fix seems to be correct
> >> > to call elf_getscn on syms_ss, not on runtime_ss as we do now
> >> >
> >> > I'd think this worked only when runtime_ss == syms_ss
> >>
> >> No, because the headers are copied 1:1 from runtime_ss to syms_ss. And
> >> runtime_ss is then stripped, so only .debug* sections are removed there.
> >> (And syms_ss's are set as NOBITS.)
> >>
> >> We iterated .debug* sections in syms_ss and used runtime_ss section
> >> _headers_ only to adjust symbols (sometimes). That worked.
> >
> > It seems PPC has an opd section only in the runtime_ss and that's why
> > we use it for section headers.
>
> At least on my system (Ubuntu 20.04.1) I see .opd in the debug file with
> NOBITS set:
>
> $ readelf -e vmlinux.debug | grep opd
>   [37] .opd              NOBITS           c000000001c1f548  01202e14
>
>
> But possibly that's not the case with older toolchains?

I was referring to this commit:

commit 261360b6e90a782f0a63d8f61a67683c376c88cf
Author: Cody P Schafer <cody@linux.vnet.ibm.com>
Date:   Fri Aug 10 15:23:01 2012 -0700

    perf symbols: Convert dso__load_syms to take 2 symsrc's

    To properly handle platforms with an opd section, both a runtime image
    (which contains the opd section but possibly lacks symbols) and a symbol
    image (which probably lacks an opd section but has symbols).

    The next patch ("perf symbol: use both runtime and debug images")
    adjusts the callsite in dso__load() to take advantage of being able to
    pass both runtime & debug images.

    Assumptions made here:

     - The opd section, if it exists in the runtime image, has headers in
       both the runtime image and the debug/syms image.

     - The index of the opd section (again, only if it exists in the runtime
       image) is the same in both the runtime and debug/symbols image.

    Both of these are true on RHEL, but it is unclear how accurate they are
    in general (on platforms with function descriptors in opd sections).

    Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>


Thanks,
Namhyung
