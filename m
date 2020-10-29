Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7429EA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgJ2LPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:15:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37620 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2LPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:15:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so2320478wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVqr9lwztpqywOtsey0CBnyoEYWrBx7CqfNTryzKB34=;
        b=H68ERvq/mdYwFWZz6bB/5Wof9BB/Jk9MFnIj4UgrFNdwYeOKDy37e6OR+Ir2Y07Bor
         Daw6sJATN7NZr8ZpjXdQ+zEI3bfloLp9lqRgA3dec6mx8CBJf4Ltu9DUasK6lAUDBf4l
         MPm5LXqeEuq7EoiCVg1U+ZojBvtSRo7VimSPiXu/IghOxGP5W1prdTDO2xqNoJSCPKxR
         G21H/erXWA/w1Bi6FMzYnkI/RbDFfIy9sBkcra3NyHQQrgpwTvI1MVHpWK/8ctbK2JaY
         OC6jkhWhVxXrMuw3tUjOiWbD489cBgyJMCmcPl7smSRfsW4KUcOpRaYIsEv+7CtzQfOx
         m9tQ==
X-Gm-Message-State: AOAM531MGAee6INFIOWnM0e8Y+MCvT8mh0AxstVzHVmacsmxftVmzc5f
        U5XDY5DJWcODacCoNMdDIxI2UVbgOGTg+9hn3QY=
X-Google-Smtp-Source: ABdhPJxZmmczmPXgUn7Yy1P0oWV1cNdgND9P2nSx/BQ5LxJUdQoaoUPzquMVPUp2izjHaFwePuch4eTydWFgapeC9As=
X-Received: by 2002:adf:bb43:: with SMTP id x3mr4974241wrg.250.1603970130184;
 Thu, 29 Oct 2020 04:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201028085632.825804-1-namhyung@kernel.org> <CAP-5=fWxPdE_UVRewNUGDrTi9A8j+OYsjsHQLJsVDkMV2tRMBA@mail.gmail.com>
In-Reply-To: <CAP-5=fWxPdE_UVRewNUGDrTi9A8j+OYsjsHQLJsVDkMV2tRMBA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Oct 2020 20:15:19 +0900
Message-ID: <CAM9d7cgikTxC9s86OYp_owoJ7JpdoC3PC42iC4oQpaxbMeudaw@mail.gmail.com>
Subject: Re: [PATCH] perf data: Allow to use stdio functions for pipe mode
To:     Ian Rogers <irogers@google.com>
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

Hi Ian,

On Thu, Oct 29, 2020 at 1:37 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Oct 28, 2020 at 1:56 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When perf data is in a pipe, it reads each event separately using
> > read(2) syscall.  This is a huge performance bottleneck when
> > processing large data like in perf inject.  Also perf inject needs to
> > use write(2) syscall for the output.
> >
> > So convert it to use buffer I/O functions in stdio library for pipe
> > data.  This makes inject-build-id bench time drops from 20ms to 8ms.
>
> This is great! Reading the numbers below the times are reduced to
> 67.9% of their previous, this is a little less than 20ms to 8ms so
> perhaps check that number.

The numbers before this patch:

$ ./perf bench internals inject-build-id
# Running 'internals/inject-build-id' benchmark:
  Average build-id injection took: 20.594 msec (+- 0.034 msec)
  Average time per event: 2.019 usec (+- 0.003 usec)
  Average memory usage: 8319 KB (+- 0 KB)
  Average build-id-all injection took: 19.443 msec (+- 0.177 msec)
  Average time per event: 1.906 usec (+- 0.017 usec)
  Average memory usage: 7490 KB (+- 0 KB)

>
> >   $ perf bench internals inject-build-id
> >   # Running 'internals/inject-build-id' benchmark:
> >     Average build-id injection took: 8.074 msec (+- 0.013 msec)
> >     Average time per event: 0.792 usec (+- 0.001 usec)
> >     Average memory usage: 8328 KB (+- 0 KB)
> >     Average build-id-all injection took: 5.490 msec (+- 0.008 msec)
> >     Average time per event: 0.538 usec (+- 0.001 usec)
> >     Average memory usage: 7563 KB (+- 0 KB)
> >
> > This patch enables it just for perf inject when used with pipe (it's a
> > default behavior).  Maybe we could do it for perf record and/or report
> > later..
>
> For perf record there is also the async IO used for writing. I like
> that this patch is adding the reading to perf_data. Should the async
> IO code live in perf_data rather than record? Should async IO be used
> for reading in that case? What would be the policy of using stdio,
> not-stdio and async IO?

I'm not sure but using async IO for read is meaningless since we cannot
do anything without the data.  The reason I added this was that the pipe
mode does so many small I/O with syscalls.  But perf record will mostly
do large I/O so I don't expect big speedup for that.

Thanks
Namhyung
