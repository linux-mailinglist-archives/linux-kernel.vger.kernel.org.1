Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6104D26D09B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQBbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:31:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37470 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQBbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:31:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so374084wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXoIbXzgcc+a9Nuqz6QLmgpLC7jamvauDUiy+563tNg=;
        b=MnZCM9nXlIJPbwM23uSi/uy8fw3GDI9vWMUGxTNmSJxvkLGPvL+P6CX5lcpT8oU+b5
         ZIXbmCLDf/+YZKIdHpGhk/Da24syh685cuaMYxARYBFRaHnoodN4uK3MWdD7fUaox1NU
         jhYAP3eZwguDfadWIJwmyxjX8UwMtAAaZ1L9sdLoaQKXHLSL7EXgbBY5HF10Izh2dFLi
         QOMwWmFz2aLUPfX7fyf8oSZNHKnoMDcFjILiocxjmAkfM3Whc8X5FugJsxpCq3+yQzF3
         RTEQII/XrXjkIcLeJOBQCiljDJbhjIBjL5589DT5fdVCJ2Z6ZAQKyBOyUU7wr6ttJ6hQ
         wa5Q==
X-Gm-Message-State: AOAM532kHnjA+aRmPPaHZDl/aczYh9gwqyf109Mn3O/jG1ukd0CQmpAS
        iNcJ7an5fh+zvKnUrIXhoXvz+z5qnWjEKwQFtb94lRqi
X-Google-Smtp-Source: ABdhPJwvY7a6rCKNqCxefomED/UrY21ZIS6bqz9lRPm4t3fRokuQP0KJXf72VA2vm2o5rPoobo67t6elv8SKTD2S3Cw=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr7298553wmi.168.1600306306736;
 Wed, 16 Sep 2020 18:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200914141859.332459-1-namhyung@kernel.org> <20200914141859.332459-3-namhyung@kernel.org>
 <20200915100533.GC2171499@krava>
In-Reply-To: <20200915100533.GC2171499@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Sep 2020 10:31:35 +0900
Message-ID: <CAM9d7cga1AFs=GAT8GttoA_fSxM70kvxFDj9xirEDL8GHGVvaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf inject: Do not load map/dso when injecting build-id
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 7:05 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 14, 2020 at 11:18:59PM +0900, Namhyung Kim wrote:
> > @@ -478,19 +479,8 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
> >       if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
> >               if (!al.map->dso->hit) {
> >                       al.map->dso->hit = 1;
> > -                     if (map__load(al.map) >= 0) {
>
> nice, that might do some nice speedup, did you see any?

I've checked it but the speed up was tiny on my machine.
I guess it's because the machine was idle and had everything
in memory.  But I also found some more points to improve.
Will share the result in the next spin.

Thanks
Namhyung
