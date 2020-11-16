Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4372B4B74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgKPQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:40:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34034 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgKPQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:40:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id n132so17382501qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FB51splDv5Z/I0NlyhmgZmN3jlvj8opC+lx5Kt6wuk0=;
        b=mb+EStYBRs8Fm7tYE4b9g5AbniI+9QoZwQDJQmQfVEyetsBenyXwfdYos17bgsjJmA
         TYBo8KqpA7r6Mp49H9upZOUdO59DFasRA5celGzb2ucAeDUaDUsnXEGIbScslpvQ3zXN
         8WYS4HklzXn0LhzIwei1hB6HLGZ7Iku7KYI1mM/VxYNTc6f+QGMlsWg7rQ34lMxSPgpP
         q3Gm6EeavynZL17Za2f6BFouMYyrBTSmKH50UVjHS6rWKJSbIw1yOGRDa/PzQme43vnS
         OecuSqLLvB7txk3FnjSw4XyOEmbs7QhN/LoepXyRRV8L5TEr5CTPUQld51Cs97RgwOR9
         Emvg==
X-Gm-Message-State: AOAM531/njiP+qsQ3O+3krtvHF6JaNycKbjqg7wT3Hw5rR8JWsXddD3e
        MI4BzPLQR/qX0Uwmqw8SFCUG9O8KyahO9t9rxJI=
X-Google-Smtp-Source: ABdhPJw3Y0m9C7qs7AYCtm90MPDPZcOrOVMgQPoyqRxv0CKZxpOhAIJeXTHRVnwhyMZuztQBBA7po1h1d/Q0NvQ011g=
X-Received: by 2002:a37:a855:: with SMTP id r82mr9385136qke.132.1605544856367;
 Mon, 16 Nov 2020 08:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20201114023643.211313-1-namhyung@kernel.org> <20201115130524.GL894261@tassilo.jf.intel.com>
In-Reply-To: <20201115130524.GL894261@tassilo.jf.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 Nov 2020 01:40:45 +0900
Message-ID: <CAM9d7cibrsM-Nv-QnFzxKsZ43+sUAm=vE-Caqy3usKjzQ2phug@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Take cgroups into account for shadow stats
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Sun, Nov 15, 2020 at 10:05 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > @@ -57,6 +59,9 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
> >       if (a->ctx != b->ctx)
> >               return a->ctx - b->ctx;
> >
> > +     if (a->cgrp != b->cgrp)
> > +             return (char *)a->cgrp < (char *)b->cgrp ? -1 : +1;
>
> This means the sort order will depend on heap randomization,
> which will make it harder to debug.
>
> Better use something stable like the inode number of the cgroup.

I don't think they are used for sorting.  It's just to compare to find a
matching event value.

For heap randomization, we already used the same technique
for evsel and runtime_stat pointers.  I can make it use cgroup id
but not sure it is really worth it.

>
> Do we have the same problem with other filters?

I'm not aware of it.

>
> The rest of the patch looks good to me.

Thanks for the review!

Namhyung
