Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05843296871
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374515AbgJWCJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374442AbgJWCJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:09:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F60C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:09:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so360320wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 19:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XM5GINNnk4Q+jjnuf6M4eZByCwx3mkXKdjH7Vp5dNog=;
        b=fkXuF5sJA6wgIB7CdHaZyPve0yYXFvCZfCWIcZ50zJ5Qn5yIE2/+X+GagVn56CxAKL
         0c9Prx+E6/lOmxohW7DuRNqgf1no2D6BStEmpdKa9pmSNXL8hnBZcvaojz+OCDSXk5H3
         9dkbLWcNaFQXezUXQiVsHvWNY8vJlMbnjsan2j965hvQDubjo/P0D1oN19dUURi65qqE
         ipojP9pixcPX8fUixYSVsSUqZQasbPkitD5xiyl28iOfG5NevFLHg962wuqoMS6iUPl9
         gecCXYqKH5UgRAh1MWLGtCXC9eAIUciMwW9DW4WDbF+5xQ/yrdbNFlVdh58PjAsQX6bY
         WauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XM5GINNnk4Q+jjnuf6M4eZByCwx3mkXKdjH7Vp5dNog=;
        b=b07uY/BZaPhObstEbWgkAIHAfQOdoMi0pawfvRvxS8LVosaetaoz3gg4ZrqESQ2kar
         hNPOPfdatcGvgGOuBQK5MeJEc8Sm0QzoNLZxm56D0nvS7SvCimyJo+eHzZ4A8ngR1QEq
         9aNkok7b2JwDXg4/qYuf0rJ9GodubIMOn/Efu/YK0Oj3m68YclUCh6ig80dniDTSRmZx
         pQSTTlAE5U7vOZ7Sc+mURO4NbtsiZVhkQyIiA54oMZYRX9N6FeqL2LT+IEX0Wf/JO1gx
         y4iD9xDJOrMB9Wwb90Xi5mDf6IhgeNEZm6OxvWUnM3puHeUzSX5qjtfEJg3UllGgAcdK
         XrBQ==
X-Gm-Message-State: AOAM5327nLQGUnJIJNGKb8V8M40XuW/cLAKBknZmpzNC9QGBRTjzt/W5
        UwigjK7OZcw0TO50Q7Jcs7rLbtrNRoAQgjcrXtx3Hg==
X-Google-Smtp-Source: ABdhPJzHaH4vNb8A/17hKM7Ekfp9aB4g5OcAA3Pi10umOoRWWhyehw1ZqovPx6BLoSLcuMXWCQfbEl+H/muGRQBYLqI=
X-Received: by 2002:a1c:9cd8:: with SMTP id f207mr179060wme.76.1603418964187;
 Thu, 22 Oct 2020 19:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201023020628.346257-1-namhyung@kernel.org>
In-Reply-To: <20201023020628.346257-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Oct 2020 19:09:12 -0700
Message-ID: <CAP-5=fW-0bQNZtYzMzQd-Gx59bkcLkAbp2_zRZ4EmJyfeN-Zcw@mail.gmail.com>
Subject: Re: [PATCH] perf trace beauty: Allow header files in a different path
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 7:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Current script to generate mmap flags and prot checks headers from the
> uapi/asm-generic directory but it might come from a different
> directory in some environment.  So change the pattern to accept it.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
>  tools/perf/trace/beauty/mmap_prot.sh  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
> index 39eb2595983b..76825710c725 100755
> --- a/tools/perf/trace/beauty/mmap_flags.sh
> +++ b/tools/perf/trace/beauty/mmap_flags.sh
> @@ -28,12 +28,12 @@ egrep -q $regex ${linux_mman} && \
>         egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
>         sed -r "s/$regex/\2 \1 \1 \1 \2/g" | \
>         xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
> -([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
> +([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
>  (egrep $regex ${header_dir}/mman-common.h | \
>         egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
>         sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
>         xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
> -([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
> +([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
>  (egrep $regex ${header_dir}/mman.h | \
>         sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
>         xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
> diff --git a/tools/perf/trace/beauty/mmap_prot.sh b/tools/perf/trace/beauty/mmap_prot.sh
> index 28f638f8d216..664d8d534a50 100755
> --- a/tools/perf/trace/beauty/mmap_prot.sh
> +++ b/tools/perf/trace/beauty/mmap_prot.sh
> @@ -17,7 +17,7 @@ prefix="PROT"
>
>  printf "static const char *mmap_prot[] = {\n"
>  regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+%s_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*' ${prefix}`
> -([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
> +([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
>  (egrep $regex ${common_mman} | \
>         egrep -vw PROT_NONE | \
>         sed -r "s/$regex/\2 \1 \1 \1 \2/g"      | \
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
