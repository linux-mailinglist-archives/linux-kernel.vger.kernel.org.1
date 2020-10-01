Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD1280466
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbgJAQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:58:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E21C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 09:58:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so3920186wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04b8qKJemsp+OZHSsPknzFEwjnTI950R60M+0aR7dvI=;
        b=gxe/UpQivnd0eSGnbQnycHIu+NI+9Xwnbm6zBWBhDwJAmY4/d7G+GrUwll7XVMbQPi
         73xK/fZlGO55LMKY0m+BiV1lvGClhJ+rAuLTRw6YRdCcwJtDldDinQXbJg899/zLJDXj
         JVAZU27otkoZsege+R+NZ6KZhhFTrlTiHShR8UGqzxVYGq/SCLoxkx07nb2wAGabEqjd
         vfgJbN07vOuKgxjd7L5o3GpJak1qqdRrgJz4ym/9XH3M7zzb88JsRStF/+ZoLSDMPyJN
         Y0RXyfZOFDqt7zBBdVtPoZXuQNQqt/Yoh28So5b1jebRIXox7+oI27N9HJbuBvs7tHBG
         n0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04b8qKJemsp+OZHSsPknzFEwjnTI950R60M+0aR7dvI=;
        b=umHfLQwkE3xywUNrjJQgxdOE1zreimwvL6KGS1p8BJKUL426AMb32iRJKC0gJ8AyBD
         aNmF1s3TILCgTIdbGgd19CA2S+7kM9Jc5tQ8eYTjtdy6ccpaYNyeudzRTGBjMQlrn5U5
         Et63Yedu/hYYC+zoyAEMDdF4/wqWJW/v6Y+OopPx2AiLgTBOMyp5VdtQ4DOAGLbxPO1B
         kBb9ScHDNfwRP/Y5I6rwuf+qhdKj4h7VH1yla/s2zbwmjvwcp9uWpC3VA4/RPOYJcfiG
         Dxaa7Y5UVTw9mK75Ba3yOX4UYUrvt1ji3a5xQ5sELvRtcparKPcm/0ilEaiZGU4NZCiB
         vqCA==
X-Gm-Message-State: AOAM533Nzpz8YSF9Dr+ZoayKLKVJPryQSvXwO9HOiuRuqkzNXMYwmwAX
        Os5RLC9IwmQgUMFFaSYjGKo9YLga7bQHK8mCcyG8HQ==
X-Google-Smtp-Source: ABdhPJzxbevu6ZlieL7qehMSzf89h975PGC4VD9uTIYuaBkbM7/w0UqCLz97ekXcEjiDe81wLW4CiVTrhgAqcYdREhg=
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr971181wmg.124.1601571515134;
 Thu, 01 Oct 2020 09:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-2-jolsa@kernel.org>
 <CAP-5=fVwe5wowm9Z6RgMAKA-nRd01U6DL0LGuUJSnPc_H=w17w@mail.gmail.com>
 <20201001092530.GB3999500@krava> <20201001102517.GC3999500@krava>
In-Reply-To: <20201001102517.GC3999500@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 1 Oct 2020 09:58:23 -0700
Message-ID: <CAP-5=fW17Ju5w9PWvdaHvwGSL5iYoaWP4OeyQk+eSDgNYhLVVQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf tools: Add build id shell test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 3:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Oct 01, 2020 at 11:25:34AM +0200, Jiri Olsa wrote:
> > On Wed, Sep 30, 2020 at 07:00:05PM -0700, Ian Rogers wrote:
> > > On Wed, Sep 30, 2020 at 10:15 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding test for build id cache that adds binary
> > > > with sha1 and md5 build ids and verifies it's
> > > > added properly.
> > > >
> > > > The test updates build id cache with perf record
> > > > and perf buildid-cache -a.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > Acked-by: Ian Rogers <irogers@google.com>
> > >
> > > This is great! If I build perf and test from the build directory the
> > > test gets run. If I build using O=/tmp/perf and run from that
> > > directory then ./tests/shell isn't found and the test doesn't run.
> > > Similarly the install directory doesn't contain the executables and so
> > > the test is skipped. Is there any way to get the test running in these
> > > other scenarios?
> >
> > ok, if there's already some way to get the build path I did not see that
> > I'll check and add something if it's missing
>
> would the patch below work for you?

Thanks! I'm ok with the patch as is, this addition also looks good. I
think the ideal we should aim for is perf test passing from the
installed location. I appreciate this change is setting up groundwork
that other tests could build upon. I'd particularly like a shell test
to run the libperf tests, it should be little more than just running
the executables. The build/install set up and the paths are the
difficult part.

Thanks,
Ian

> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
> index 57fcd28bc4bd..dd9f9c306c34 100755
> --- a/tools/perf/tests/shell/buildid.sh
> +++ b/tools/perf/tests/shell/buildid.sh
> @@ -2,12 +2,23 @@
>  # build id cache operations
>  # SPDX-License-Identifier: GPL-2.0
>
> +ex_md5=buildid-ex-md5
> +ex_sha1=buildid-ex-sha1
> +
>  # skip if there are no test binaries
>  if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
> -       echo "failed: no test binaries"
> -       exit 2
> +       ex_dir=$(dirname `which perf`)
> +       ex_md5=${ex_dir}/buildid-ex-md5
> +       ex_sha1=${ex_dir}/buildid-ex-sha1
> +
> +       if [ ! -x ${ex_sha1} -a ! -x ${ex_md5} ]; then
> +               echo "failed: no test binaries"
> +               exit 2
> +       fi
>  fi
>
> +echo "test binaries: ${ex_sha1} ${ex_md5}"
> +
>  # skip if there's no readelf
>  if [ ! -x `which readelf` ]; then
>         echo "failed: no readelf, install binutils"
> @@ -80,11 +91,11 @@ test_record()
>  }
>
>  # add binaries manual via perf buildid-cache -a
> -test_add buildid-ex-sha1
> -test_add buildid-ex-md5
> +test_add ${ex_sha1}
> +test_add ${ex_md5}
>
>  # add binaries via perf record post processing
> -test_record buildid-ex-sha1
> -test_record buildid-ex-md5
> +test_record ${ex_sha1}
> +test_record ${ex_md5}
>
>  exit ${err}
>
