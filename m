Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42D627720A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIXNVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:21:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54782 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIXNVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:21:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id s13so3498738wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C80+fWd+0V+1fgC+8VJ6vC+xUBslYmMWMHrDcWbYQL0=;
        b=gUp33B7mxH/AfdvYBz1UPYpUwGRJWieA4K/HAPXg3ZMDzyGXGNvQ3ixqFSoJhRh/5O
         MFwk4vXPJg1vGcJH7nTMhS3h+oEOsPJiyXySluY4BOtfn0FATtG4jqmfBVMX9h2BB/5o
         dvo1D70jvM+XA3ooHGa970lf3L4iwto8AJfYADd5AyHtEYwYurw8xw12D+c4mBT9hE9n
         k+CsKILu9gUcsQ88KW659SLiVVt/C0Qcsok3TNp5PL1Trw8CqxeA54NgLf9J5+jl9GO8
         BrannoMzhQaYiSX0P8QNpNs6ELUs+7A0c9/aoQ5XW2iP87TcZAEsuuncMpPZ4Tuwq3ih
         NtEQ==
X-Gm-Message-State: AOAM533061voJG5vAMA5SD6zhaIJNRuUO8CCmHkYzSimPlXl3DWcrCl6
        tkPxApQgKyvRf/7rUeM30/n3ryuWYQJ9Jbwck+Y=
X-Google-Smtp-Source: ABdhPJyNJhy3efizoKaxpoACwBYhF8QhawSijcvcxjHhJ+EDF9sPtwFWL5lkLO0eU5uK20hIorQ1hfFg+v3/po6oiGQ=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr4950022wmt.92.1600953662618;
 Thu, 24 Sep 2020 06:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200923080537.155264-1-namhyung@kernel.org> <20200923080537.155264-5-namhyung@kernel.org>
 <20200924130909.GB3150401@krava>
In-Reply-To: <20200924130909.GB3150401@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Sep 2020 22:20:51 +0900
Message-ID: <CAM9d7ciWQa8rC91nOiak1ephg-+SfFXVkFLtU4H4Snaw2i_pWA@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf inject: Do not load map/dso when injecting build-id
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:09 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 23, 2020 at 05:05:34PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > -static inline int is_no_dso_memory(const char *filename)
> > -{
> > -     return !strncmp(filename, "[stack", 6) ||
> > -            !strncmp(filename, "/SYSV",5)   ||
> > -            !strcmp(filename, "[heap]");
> > -}
> > -
> >  static inline int is_android_lib(const char *filename)
> >  {
> >       return strstarts(filename, "/data/app-lib/") ||
> > @@ -158,7 +143,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >               int anon, no_dso, vdso, android;
> >
> >               android = is_android_lib(filename);
> > -             anon = is_anon_memory(filename, flags);
> > +             anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
>
> what's the reason to take 'flags & MAP_HUGETLB' out of is_anon_memory?

The MAP_HUGETLB is defined in uapi/linux/mman.h and I had trouble
when including the header in the map.h file.

Thanks
Namhyung
