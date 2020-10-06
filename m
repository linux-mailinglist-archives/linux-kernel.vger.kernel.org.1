Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E92843DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgJFBh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:37:59 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38731 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgJFBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:37:58 -0400
Received: by mail-wr1-f52.google.com with SMTP id n18so3781499wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 18:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XOkPuWAVksaYnpbdbI4+rs3vKcq8+w0HL/+QULyvzU=;
        b=r5OCtM1z6p8rULJ789sR8KLSRUWKRJDfjifaeEkv08sWJNDZprpjDk11TBTF9JeRzq
         VGOVwg4lpok3gvVs6HVKGQYYLxe057Qsn9UJuZd6668D8DwqZWSeQ+ZXwoi0dsdE5BOg
         EwrOb/6LOHl0NjJfaqLjOxSsCHPuxReauDz3v07njvKTxeHV+O0moCXMLxFIlz5hJgzO
         i4bJEAtHOm3eKHIML7Yiqa4H1dp12zIN8+y8M+bhchUWQegL+UiSwyXZXAFvSqYAoM3g
         rZAxP+dsbwfENLC3m917ePHmQDhw0Or0xnMvkQjUkrSCN7I/iAA5aeNJCnbluHjEjbCW
         U3Zw==
X-Gm-Message-State: AOAM532XiZ/HHcXU43n5R347O+57HYWIwAVRXpLPOyaCG4A8oB1qi22Z
        YqJWmUVBpRFavU2cUxqbEAWmoTPJLAaL2o5SpE8=
X-Google-Smtp-Source: ABdhPJwyqVss08r0Zo5xGYxMyLycQbmJn+NVAdh2lAKksXH/11wR+PmwiR/6mxjK/uUXpj77zcVVGaFqpXuLfNdxxIk=
X-Received: by 2002:adf:e481:: with SMTP id i1mr2021795wrm.391.1601948276735;
 Mon, 05 Oct 2020 18:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava> <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
 <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com> <20201002192944.GH3999500@krava>
In-Reply-To: <20201002192944.GH3999500@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Oct 2020 10:37:45 +0900
Message-ID: <CAM9d7cgoaU4wcid46+uScFcZtMZZQR+fijuE7XO1mjC2cLwX-A@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] perf tools: Add build id shell test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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

On Sat, Oct 3, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 02, 2020 at 10:34:51AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > > > +
> > > >  LIBJVMTI = libperf-jvmti.so
> > > >
> > > >  ifndef NO_JVMTI
> > > > @@ -756,6 +763,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
> > > >         $(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
> > > >  endif
> > > >
> > > > +ifndef NO_BUILDID_EX
> > > > +$(OUTPUT)buildid-ex-sha1:
> > > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
> > > > +$(OUTPUT)buildid-ex-md5:
> > > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
> > > > +endif
> > >
> > > Can we just build them in the test shell script instead?
>
> it would solve the build-directory/install-directory
> lookup search.. but it'd need to do detect compiler
> and depend on it as Ian said
>
> do you have some other reason to compile it in test?

No I just wanted to make it easy to find the binaries
and assumed a compiler is available in the test machine
(which is not true for my company setup.... :-/)

But otherwise we should keep the binaries somewhere
in the install directory..

Thanks
Namhyung
