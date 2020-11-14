Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9057D2B29D2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgKNAXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:23:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41558 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKNAXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:23:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id w142so16670736lff.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJHk4qfWuVzx38s7nu/Sl1qnsKktld+vhnX7xT/2xW0=;
        b=PV99L0ogiDY1JXSvMhJ0BNquFPW6vsn4gQgwDpps95N/oREFzgdPxrbGqqt8YgF7o6
         EasxCDtx0ZmAXKdCW1ywbzvhYcOFJr3Y5ov2Fl4CM4JuwolctAO41VhhIf55sRn8k9xb
         izIwEbHC7vXEIZyAium/HQR7WY1bZFcpLeWjbmYVtglw+vyMOEqQci8l9xSKsjP7uGpQ
         T+UXycwG1E+RcJpeD2YBISj0ltc0wuqwQfSchepUNQqJ1pAosjhLbiLlCzuabmEK3+Ay
         Gah6NU78MgTnPsE1D11mhIlcj9Q2gRuKqWbGmRVC8QXDI94ZgDKn5b3prP7IloVHgo4O
         bDDg==
X-Gm-Message-State: AOAM533K+lcqZxCdDtmMM4dYLc9H/2hPoh1sezH73ro4G+fVGiGSNIaX
        ueSw7E7TJsO2FR8QoCDfg2tRqs8vjb3EkMmt6Hs=
X-Google-Smtp-Source: ABdhPJyJSpVgBZzTFmIKkHCWgL04d9KS0GLYp+UNS8xuvwRX0HqaSterGmHsS/eJvHGV121lrHlvzwp9KeVbzN3HjmU=
X-Received: by 2002:a19:838c:: with SMTP id f134mr1758007lfd.540.1605313429798;
 Fri, 13 Nov 2020 16:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20201113050236.175141-1-namhyung@kernel.org> <20201113221601.GE842058@krava>
In-Reply-To: <20201113221601.GE842058@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 14 Nov 2020 09:23:39 +0900
Message-ID: <CAM9d7ch_A37EAbbfRabSiJQpzCJ4XDrusBL=z+Rj28Db81aQkA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Use proper cpu for shadow stats
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, Sam Xi <xyzsam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 7:16 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 13, 2020 at 02:02:36PM +0900, Namhyung Kim wrote:
> > Currently perf stat shows some metrics (like IPC) for defined events.
> > But when no aggregation mode is used (-A option), it shows incorrect
> > values since it used a value from a different cpu.
> >
> > Before:
> >
> >   $ perf stat -aA -e cycles,instructions sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   CPU0      116,057,380      cycles
> >   CPU1       86,084,722      cycles
> >   CPU2       99,423,125      cycles
> >   CPU3       98,272,994      cycles
> >   CPU0       53,369,217      instructions      #    0.46  insn per cycle
> >   CPU1       33,378,058      instructions      #    0.29  insn per cycle
> >   CPU2       58,150,086      instructions      #    0.50  insn per cycle
> >   CPU3       40,029,703      instructions      #    0.34  insn per cycle
> >
> >        1.001816971 seconds time elapsed
> >
> > So the IPC for CPU1 should be 0.38 (= 33,378,058 / 86,084,722)
> > but it was 0.29 (= 33,378,058 / 116,057,380) and so on.
> >
> > After:
> >
> >   $ perf stat -aA -e cycles,instructions sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   CPU0      109,621,384      cycles
> >   CPU1      159,026,454      cycles
> >   CPU2       99,460,366      cycles
> >   CPU3      124,144,142      cycles
> >   CPU0       44,396,706      instructions      #    0.41  insn per cycle
> >   CPU1      120,195,425      instructions      #    0.76  insn per cycle
> >   CPU2       44,763,978      instructions      #    0.45  insn per cycle
> >   CPU3       69,049,079      instructions      #    0.56  insn per cycle
> >
> >        1.001910444 seconds time elapsed
> >
> > Reported-by: Sam Xi <xyzsam@google.com>
> > Fixes: 44d49a600259 ("perf stat: Support metrics in --per-core/socket mode")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> nice catch! would be great to have test for this
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks!  Will add a test later.

Thanks,
Namhyung
