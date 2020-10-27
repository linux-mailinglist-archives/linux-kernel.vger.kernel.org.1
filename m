Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D76D29BAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807614AbgJ0QMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1806753AbgJ0QHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:07:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CBE206B2;
        Tue, 27 Oct 2020 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603814867;
        bh=+HAGE5okrHiBhnWFIPAO5CKv2KORQamF2J0Be9V5SwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpcX00IKXUl6xSbuoIx7mcl49GK4YH2SNPeukthb+Ogu51Onii1+WP8hoSHqT7ESk
         PeO1aer5tzC8qdb+KW47P/D9+XqP2J+3BV9Kp7oEYsmyvluZFrB0TrH7V27jxaDyog
         iNSVDKfYiDqDwAkvZhTR3pbym+/pBqSzvJcYLuqs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 533B0403C2; Tue, 27 Oct 2020 13:07:45 -0300 (-03)
Date:   Tue, 27 Oct 2020 13:07:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf trace beauty: Allow header files in a different path
Message-ID: <20201027160745.GF2479604@kernel.org>
References: <20201023020628.346257-1-namhyung@kernel.org>
 <CAP-5=fW-0bQNZtYzMzQd-Gx59bkcLkAbp2_zRZ4EmJyfeN-Zcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW-0bQNZtYzMzQd-Gx59bkcLkAbp2_zRZ4EmJyfeN-Zcw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 22, 2020 at 07:09:12PM -0700, Ian Rogers escreveu:
> On Thu, Oct 22, 2020 at 7:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Current script to generate mmap flags and prot checks headers from the
> > uapi/asm-generic directory but it might come from a different
> > directory in some environment.  So change the pattern to accept it.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
> >  tools/perf/trace/beauty/mmap_prot.sh  | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
> > index 39eb2595983b..76825710c725 100755
> > --- a/tools/perf/trace/beauty/mmap_flags.sh
> > +++ b/tools/perf/trace/beauty/mmap_flags.sh
> > @@ -28,12 +28,12 @@ egrep -q $regex ${linux_mman} && \
> >         egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
> >         sed -r "s/$regex/\2 \1 \1 \1 \2/g" | \
> >         xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
> > -([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
> > +([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
> >  (egrep $regex ${header_dir}/mman-common.h | \
> >         egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
> >         sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
> >         xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
> > -([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
> > +([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
> >  (egrep $regex ${header_dir}/mman.h | \
> >         sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
> >         xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
> > diff --git a/tools/perf/trace/beauty/mmap_prot.sh b/tools/perf/trace/beauty/mmap_prot.sh
> > index 28f638f8d216..664d8d534a50 100755
> > --- a/tools/perf/trace/beauty/mmap_prot.sh
> > +++ b/tools/perf/trace/beauty/mmap_prot.sh
> > @@ -17,7 +17,7 @@ prefix="PROT"
> >
> >  printf "static const char *mmap_prot[] = {\n"
> >  regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+%s_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*' ${prefix}`
> > -([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
> > +([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
> >  (egrep $regex ${common_mman} | \
> >         egrep -vw PROT_NONE | \
> >         sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
> > --
> > 2.29.0.rc1.297.gfa9743e501-goog
> >

-- 

- Arnaldo
