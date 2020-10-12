Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6964228AD79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgJLFFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:05:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37891 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgJLFFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:05:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id b127so3406470wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 22:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1y/66SFBK8HCqatyaY7CShEGaZoevPmXTBnB3ZF+cU=;
        b=U3Wb87JRpxuhYpfJIIMuR6CoJpvA+91Rkhr1PnacQrLwr+3FXlkTjkPfiJrvgkBO/r
         LHVQztM2OUFB6YL/Ax/Nln2IR6GtAm7zGU7yYwFzMG7jsXwidFHKCjJ7B6fOfU2uyvz4
         km03J5Sws4TGGipGireR0cNXnM3RksfFZc5+FQelcO/Qe/zsz33mjyilyu9AITBNGH4C
         trHCxYdi/ZBkKcbctCiaTaXr+2t/dOchdhnJeD68RWFJHGqo/xXprecfBjoAtZ03nLGI
         nmzf8ygWuRUIhV2aJy48C5OxtFiVfykJN/Y75jdgbp09H0p7iUoLQxhq2U8BqPUmFjNx
         Tb+w==
X-Gm-Message-State: AOAM533c1SGCg08YkVMcCySXElOtkr9uuXETCdzq3EWsEE893nq6cQeE
        AiV+KigZ0mlIUn0EILWVFL6BQhnRbUc717hUkTuafHA4CIM=
X-Google-Smtp-Source: ABdhPJwc+ZAGxteAxP9DYHxipKZPxiDvOMXQbeEmPaTEDgwpo7uUvD94KdDaRus469iIBHK1s6QYhhMqRccz02R3qd0=
X-Received: by 2002:a1c:960a:: with SMTP id y10mr8898620wmd.128.1602479099708;
 Sun, 11 Oct 2020 22:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201002130317.1356440-1-namhyung@kernel.org> <20201004195239.GA217601@krava>
 <CAM9d7cgsxkefHAgyMf-GoP4-OdSsaRmhSGLwPMoYn=-c9YXxDw@mail.gmail.com>
 <20201006023949.GA1682192@google.com> <20201006054032.GA1724372@google.com> <20201008090654.GA656950@krava>
In-Reply-To: <20201008090654.GA656950@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 12 Oct 2020 14:04:48 +0900
Message-ID: <CAM9d7cj87QqoVNGJm5TJ1YS_QRoZpukQD8GbDg5VqJWc8euWFA@mail.gmail.com>
Subject: Re: [PATCH] perf inject: Flush ordered events on FINISHED_ROUND
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Al Grant <al.grant@foss.arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Oct 8, 2020 at 6:07 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 06, 2020 at 02:40:32PM +0900, namhyung@kernel.org wrote:
> > This is the perf stat result:
> >
> > * Before
> >
> >      7,167,414,019      L1-dcache-loads
> >        337,471,761      L1-dcache-read-misses     #    4.71% of all L1-dcache hits
> >
> >       11.011224671 seconds time elapsed
> >
> >
> > * After
> >
> >      7,075,556,792      L1-dcache-loads
> >        771,810,388      L1-dcache-read-misses     #   10.91% of all L1-dcache hits
> >
> >       17.015901863 seconds time elapsed
> >
> >
> > Hmm.. it's a memory & time trade-off then.  Maybe we need a switch to
> > select which one?
>
> I'd keep the faster one ;-) so the one before

Yeah, it's hard to argue when it slows things down much.
But I'd like to note that memory consumption also can be a
big issue in some environments.  I'll bring this back later..

Thanks
Namhyung
