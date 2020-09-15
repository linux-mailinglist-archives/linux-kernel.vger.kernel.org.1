Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16EE269C34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIOC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:58:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37277 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgIOC63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:58:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id a9so1909683wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwltHGs0iqAC35v2T55P20uPrtFE8yYg7UUsLf2XVf8=;
        b=CrJT7M7bkiXdPg/UNb3Flwj6gZpRDlWAADH8MTjnTrpKFEtQawX63oRE+hDQdBwrDn
         JzMZxi1pxJ952s26fFzLAAqIlPHUdv140rWt/F8ueaixbDjLtZanQttKUStOIRcqJvrc
         9RuyF0ClNXMp9TB30iuLh0a6USFStYIRgEhp5AQETRMNc/E14UF8XEHryT1wkJf0GMvd
         u8XV8+j4flONUmivNz8vOiD8JfclNKEolH2QWYALfEQan1eocPVWGV4tZ9j87GctUalQ
         wMSKChPp5DavRju7CsmgfJubmoUsKVJxymIyOfnwWA+bfDXYKCCdHYOtU53iPYcJ5v0s
         BaVQ==
X-Gm-Message-State: AOAM533Oues2CsZRRdivHwI3fxHFbHrPYzEEZVF51D4jRV2P1WCni362
        Sjun9g1vE6VZttI1clYnf5UpEKjYQgTT67sJhhU=
X-Google-Smtp-Source: ABdhPJyujCIP+jmHjk8GDAhE0E/x4YMfttFnX2VcZG1koiEezGRBLInYApCfxHEJpnnyIa0h8o/I5pWL4A7t/Ko5jfo=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr2366504wmc.154.1600138707275;
 Mon, 14 Sep 2020 19:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-10-jolsa@kernel.org>
 <CAM9d7ch7TqHr8dwCQ3_OZjpvp4yv+u=ipdDJR=AcCdUb2zSw2Q@mail.gmail.com> <20200914202925.GU1714160@krava>
In-Reply-To: <20200914202925.GU1714160@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Sep 2020 11:58:16 +0900
Message-ID: <CAM9d7cgOnwR9qRiJhf8kz0YGphVNyoBCXHuAtc-dSNtoUMeasA@mail.gmail.com>
Subject: Re: [PATCH 09/26] perf tools: Try load vmlinux from buildid database
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 5:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 14, 2020 at 03:25:39PM +0900, Namhyung Kim wrote:
> > On Mon, Sep 14, 2020 at 6:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Currently we don't check on kernel's vmlinux the same way as
> > > we do for normal binaries, but we either look for kallsyms
> > > file in build id database or check on known vmlinux locations
> > > (plus some other optional paths).
> > >
> > > This patch adds the check for standard build id binary location,
> > > so we are ready once we start to store it there from debuginfod
> > > in following changes.
> >
> > But dso__load_vmlinux_path() already has the logic.
> > Also you should check symbol_conf.ignore_vmlinux_buildid.
>
> I wanted to have it not dependent on !symbol_conf.ignore_vmlinux
> which is needed to call dso__load_vmlinux_path

Note that it's a different config variable to suppress using build-id
when loading kernel DSO from perf record.

Thanks
Namhyung

>
> also the idea was to try the build id vmlinux before the configured
> vmlinux locations, because they found the vmlinux in my setup ;-)
>
> I'll double check the logic again
>
> thanks,
> jirka
>
