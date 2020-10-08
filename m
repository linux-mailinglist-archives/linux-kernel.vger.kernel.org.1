Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6628770C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgJHPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgJHPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:22:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A33C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:22:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m6so7073458wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpuEMVNbSmMookoZuIiFxOhuCjbkYVS6c3Dh28U/Kf4=;
        b=PQ0kFEj3WXMAAhE+DjOOdKkt20OTfc4JbX3UoVo2P6SgQ3+tif3Be3U/wXVVEB/IUu
         qhGSMOWmixDG66VDaepIkY2QFMukiDUu5zjUGOmAsCKnz9k4rBJrwd+Zjq8tAO0cQKXZ
         T4NstH+yuwzjEJ+9RPtb8sXmluqZhah/gifGNif2NRFcehWBrDvNY1eEbw12rLvqQGT0
         feZVeIFveLz5XdmQB5DqfPfAuWqouZDiWnWXI4IRDNSL4AROM6w14wd9kKRHZ8u4ipY1
         QrLQdk0CSq2FXE9HGpzr4ilbyRKB1SLG9owgFo2buVAS6sjKmewa4vKieycj9Pa6GdMW
         ezbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpuEMVNbSmMookoZuIiFxOhuCjbkYVS6c3Dh28U/Kf4=;
        b=hTlPszqDOja+2j1FJTpPDatb7hRgddCQ2MEP/RLT3bINZWblr6lk1Sqe1+1JzvNmXh
         mFx/WCnatRiDFlKCv235G+4unDi2BMOBm5YD4LkCq7x9OUGimZ4TIhhchu6FT/RgP9EL
         gu7iErk1ZUMmYgh4hSauRguNMzh5jiq3OXuhZaSJfjxD/USbwXOu7Cf0HT974Uoi7nz0
         Q9usJm4ME63/zjnVcUogbH9LcpXQqdAC4PczpDh8ZJMWkx+oA283HpucwHR6cz/uO3Ni
         C4M4NdPNYghLM/LONFPnh6OEC6NYyRY/S699Q5Grx/2QKmmAsRhg2XBaCxBEdNKLPJ/7
         vt/Q==
X-Gm-Message-State: AOAM5302G8cAj09jTWyZCvouBa1/BF2hhK3q43SrYnIupcJD14ZnqvGa
        GSjY3nVoGlczFPGnnANJCfYFYHmbvdzup0BQf1mCMA==
X-Google-Smtp-Source: ABdhPJyp7iZ8KqryWvP3KdG+rynu11U5yw1vmis10aBL3RpHmAgCs1hNX5JOKeyoNgsZWmhGgjQ2IeHou0cOXXPXloE=
X-Received: by 2002:adf:b641:: with SMTP id i1mr9589309wre.376.1602170555340;
 Thu, 08 Oct 2020 08:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava> <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
 <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
 <20201002192944.GH3999500@krava> <CAM9d7cgoaU4wcid46+uScFcZtMZZQR+fijuE7XO1mjC2cLwX-A@mail.gmail.com>
 <20201008091153.GB656950@krava>
In-Reply-To: <20201008091153.GB656950@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Oct 2020 08:22:23 -0700
Message-ID: <CAP-5=fWM4X_AaFWc97s2m2KpEo7veE01gN9YQtnawbqQU=YH7w@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] perf tools: Add build id shell test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 2:12 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 06, 2020 at 10:37:45AM +0900, Namhyung Kim wrote:
> > On Sat, Oct 3, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Oct 02, 2020 at 10:34:51AM -0700, Ian Rogers wrote:
> > >
> > > SNIP
> > >
> > > > > > +
> > > > > >  LIBJVMTI = libperf-jvmti.so
> > > > > >
> > > > > >  ifndef NO_JVMTI
> > > > > > @@ -756,6 +763,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
> > > > > >         $(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
> > > > > >  endif
> > > > > >
> > > > > > +ifndef NO_BUILDID_EX
> > > > > > +$(OUTPUT)buildid-ex-sha1:
> > > > > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
> > > > > > +$(OUTPUT)buildid-ex-md5:
> > > > > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
> > > > > > +endif
> > > > >
> > > > > Can we just build them in the test shell script instead?
> > >
> > > it would solve the build-directory/install-directory
> > > lookup search.. but it'd need to do detect compiler
> > > and depend on it as Ian said
> > >
> > > do you have some other reason to compile it in test?
> >
> > No I just wanted to make it easy to find the binaries
> > and assumed a compiler is available in the test machine
> > (which is not true for my company setup.... :-/)
> >
> > But otherwise we should keep the binaries somewhere
> > in the install directory..
>
> hum, could we go in with the v3 and then you guys
> could customize it to what would work for you?

v3 is fine with me, it is progress to have a test. Longer term I hope
we can have binary dependencies on shell tests and get them installed,
etc. libperf would be a motivating case.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> thanks,
> jirka
>
