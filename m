Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0851B29DAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbgJ1X03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:26:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55262 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390418AbgJ1X0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:26:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id w23so800077wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SS40df89lZEGyvg63MO4TxFrSMgpg8lrX0GUBDHf0A=;
        b=Y6iSDlmSW1gLm+Mbphd/vYJZp+Md7/MwLL7CW9nhSeXd8Z1JnUr2nKkADUPeWBfSWQ
         8fWX2dgfuEj5dcEBPC4PQ2pwzAkWlkDPwc4a39ZSzJEacZtIU39D9DpPQ+OT7kMPVbkh
         fKvNtmFPMQIyCm9v0blNIpNWZtqEteFbnVqaTTscixXPjBKIc7vE7UZB7Qt0SweC3A6y
         owhlvzS/mgKupPS1P+R3YFKyDT0TWJi9GLtqec0Nn+aAlind30FY13d0Es9/9VbrHW+/
         f8Y9cq46BpzdMmYMmQfFC/XkLM+tOwwngl7hP7nw4B+kNjLcLPxZ10PAdLsgsGPsGJX+
         A6kg==
X-Gm-Message-State: AOAM533ASMggxptCRGhPGuMR3+P0AKQ3VF6ryiKNsFBcIJSGC7E3Y6Fh
        oWaG1H7Zf+T5evNLH70XQrJxxU1rtB5DUGHrct+s0JoL
X-Google-Smtp-Source: ABdhPJwyLkaOKrsIQK3PL5S5Usk3dlQ/WoogNwrErs+j0fyIbSYKPMY61Y7ofrY/f4pDZVhuPEp1brr0FMst1AddmiE=
X-Received: by 2002:a1c:9c51:: with SMTP id f78mr6881455wme.189.1603869780311;
 Wed, 28 Oct 2020 00:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <d28243e3-3178-d7cd-7b96-7ed63fd83493@linux.intel.com> <20201024154349.GC2589351@krava>
 <43d5e54f-b56e-729f-d08e-2c6b6799c797@linux.intel.com> <20201027122154.GF2900849@krava>
 <872f5052-788b-fe6d-d0ac-82e9639910d2@linux.intel.com>
In-Reply-To: <872f5052-788b-fe6d-d0ac-82e9639910d2@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Oct 2020 16:22:49 +0900
Message-ID: <CAM9d7cifhL--aYn05dYABmqoxGXX6xRC9W+Q+cWSnKqGUPPvzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] perf session: load data directory into tool
 process memory
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:43 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> On 27.10.2020 15:21, Jiri Olsa wrote:
> > On Tue, Oct 27, 2020 at 10:37:58AM +0300, Alexey Budankov wrote:
> >> I agree perf report OOM issue can exist on really-big servers but data
> >> directories support for report mode for not-so-big servers and desktops
> >> is already enabled with this smaller change. Also really-big-servers
> >> come with really-big amount of memory and collection could possibly be
> >> limited to only interesting phases of execution so the issue could likely
> >> be avoided. At the same time threaded trace streaming could clarify on
> >> real use cases that are blocked by perf report OOM issue and that would
> >> clarify on exact required solution. So perf report OOM issue shouldn't
> >> be the showstopper for upstream of threaded trace streaming.
> >
> > so the short answer is no, right? ;-)
>
> Answer to what question? Resolve OOM in perf report for data directories?
> I don't see a simple solution for that. The next issue after OOM is resolved
> is a very long processing of data directories. And again there is no simple
> solution for that as well. But it still need progress in order to be resolved
> eventually.

I think we should find a better way than just adding all events to the
ordered events queue in memory then processing them one by one.

Separating tracking events (FORK/MMAP/...) might be the first step.

Thanks
Namhyung
