Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5192F5FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbhANLSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:18:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41297 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbhANLSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:18:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DGhc76r2cz9s2g;
        Thu, 14 Jan 2021 22:17:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1610623049;
        bh=g5Oz3V3jZktqK95uiv3rPpxchACuTU1uFgEbh5ltcbo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Sr3GWt03xjCOvNaqNtx/K59FP1sLhhrrm36EaKf/c6vJVOoK6u9zmCIpFJ5B+Yl0o
         KxzuSY9Lp9mjZhRxvOQTUsmNOf4sim3b4WhKm+KY4B7XNMr3PRDhF+MbSnTv92UgrN
         ypyqqe5Ulp0UGHaomWUGaNiAFjBaU9hTeGp+cYPUWXuDDnyGyq7dFAj/uL+xmJ1iO9
         EASuN7BW89pdtCTuiX0wJzBeuI6XG14AVlv+flKr7VO/7GEwoP9sHEBCHrBQGo9Q6P
         /Y3/WsUpb2JuEtg2TfIhks9hxH/HmjyfmH/38cy2s+x3KuKYtWmPGSnU2S8C47LmYW
         /BC8Rc0mIO6Jw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Namhyung Kim <namhyung@kernel.org>, Jiri Slaby <jslaby@suse.cz>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
In-Reply-To: <CAM9d7cgmUqLX+C1wDPe9qaxDh1tY4sVmLx2qZqey3CQSmZSo2Q@mail.gmail.com>
References: <20210113080128.10286-1-jslaby@suse.cz> <20210113104618.GB1331835@krava> <388a2e21-14ee-4609-84d0-c8824154c015@suse.cz> <CAM9d7cgmUqLX+C1wDPe9qaxDh1tY4sVmLx2qZqey3CQSmZSo2Q@mail.gmail.com>
Date:   Thu, 14 Jan 2021 22:17:25 +1100
Message-ID: <87sg73kbsq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namhyung Kim <namhyung@kernel.org> writes:
> On Wed, Jan 13, 2021 at 8:43 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> On 13. 01. 21, 11:46, Jiri Olsa wrote:
>> > On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
>> >> With LTO, there are symbols like these:
>> >> /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
>> >>   10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
>> >>
>> >> This comes from a runtime/debug split done by the standard way:
>> >> objcopy --only-keep-debug $runtime $debug
>> >> objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
>> >>
...
>> >> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> >> index f3577f7d72fe..a31b716fa61c 100644
>> >> --- a/tools/perf/util/symbol-elf.c
>> >> +++ b/tools/perf/util/symbol-elf.c
>> >> @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>> >>              if (sym.st_shndx == SHN_ABS)
>> >>                      continue;
>> >>
>> >> -            sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
>> >> +            sec = elf_getscn(syms_ss->elf, sym.st_shndx);
>> >>              if (!sec)
>> >>                      goto out_elf_end;
>> >
>> > we iterate symbols from syms_ss, so the fix seems to be correct
>> > to call elf_getscn on syms_ss, not on runtime_ss as we do now
>> >
>> > I'd think this worked only when runtime_ss == syms_ss
>>
>> No, because the headers are copied 1:1 from runtime_ss to syms_ss. And
>> runtime_ss is then stripped, so only .debug* sections are removed there.
>> (And syms_ss's are set as NOBITS.)
>>
>> We iterated .debug* sections in syms_ss and used runtime_ss section
>> _headers_ only to adjust symbols (sometimes). That worked.
>
> It seems PPC has an opd section only in the runtime_ss and that's why
> we use it for section headers.

At least on my system (Ubuntu 20.04.1) I see .opd in the debug file with
NOBITS set:

$ readelf -e vmlinux.debug | grep opd
  [37] .opd              NOBITS           c000000001c1f548  01202e14


But possibly that's not the case with older toolchains?

cheers
