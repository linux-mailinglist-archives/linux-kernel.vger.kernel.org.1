Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1192EED5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 07:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhAHGLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 01:11:13 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34871 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHGLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:11:13 -0500
Received: by mail-lf1-f51.google.com with SMTP id h22so20460738lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 22:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iqw5rn8zPjljc07AyGATHn+lGPwHkfEHSe8mwW1VJrw=;
        b=pJaVmkg97lJ4V37NC49mpkpsX5S7oUFopFPMwfO+iud47Fww62sdQc9XM4ya5RC2au
         UxJMXTv6jcb3ibDgMS/ZwttIo/SVoHPZao+j0IWdjB44QiZU70AsAlUlZCRU/Zl2wIyN
         PUCT+IHuB1+THQ92ejbgFESbk3LrrV+kll3CnojyNSf/3BDDgp1jPU5DHZon00iPZ6F/
         QAX97hsv2XpVwTWbriGpBFOd1zUBGfCwgsD260IZvgeQO2zk+hGZFjhvQNqh1VqhB7XV
         k9xPri1wH2V90gNYYG7Gh3ut7ybmLKKXPwrZW6OFohvrsk8j5JGzTY61gRKNpct++37t
         Mrsw==
X-Gm-Message-State: AOAM532q8IG81157aE76KQbTtCA9IyLtuQfgwppG9CY6vRN2UamAZUfB
        KAv2i3nG5qBp61hlVA4j3kZSQMc9fjD4SRPY3QI=
X-Google-Smtp-Source: ABdhPJzUaejcS4cHrEXP4qTaBgJ2fgaqnXnJUhLwcH7rdl2Je0McTdxWGxfNoipqCKw9XjJsUjs+mvgw5w1sy967cuY=
X-Received: by 2002:a19:6459:: with SMTP id b25mr919656lfj.635.1610086230813;
 Thu, 07 Jan 2021 22:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20201226232038.390883-1-jolsa@kernel.org> <20210107121240.GA1019522@krava>
In-Reply-To: <20210107121240.GA1019522@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Jan 2021 15:10:19 +0900
Message-ID: <CAM9d7cgjzD+LMsdwGL6vD+YHhCBgvR_5PrG5HgWn-vqAOQWNKg@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] perf tools: Allow to enable/disable events via
 control pipe
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Jan 7, 2021 at 9:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, Dec 27, 2020 at 12:20:34AM +0100, Jiri Olsa wrote:
> > hi,
> > adding support to enable/disable specific events via control
> > file via following commands:
> >
> >     # echo 'enable sched:sched_process_fork' > control
> >     # echo 'disabled sched:sched_process_fork' > control
> >
> > v4 changes:
> >   - some of the patches got merged
> >   - rebased to latest perf/core
> >   - fixed changelogs
> >   - added 'ping' command
>
> any reviews?

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
