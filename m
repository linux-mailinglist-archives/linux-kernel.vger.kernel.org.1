Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1761A2FE147
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbhAUE5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:57:41 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39638 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbhAUEyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:54:15 -0500
Received: by mail-qt1-f176.google.com with SMTP id z9so737649qtv.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bO5kdT82Vrh4eQuh74lxmzPt+aCWsgro9BaYoqvspoM=;
        b=bJhFQFsBynBRmAxN6mCG5fNndTgO8iYI93tfVZ7VAgV18XRUasknGgmtuHHuNZu8/9
         TXTEzs0HpnP3m6mjBjgCTRgCbF0Auys5lqWocemODLXRxxlX0RjqheXiR/lJ7qEoIqCx
         rRY3JfJYQHrTjhF1z+iSo0J2z2Iv02QWr8aEY6yyIX7KYpPYe/s9wg26UVt6LLzSmxw1
         zYMDBXkpYMsEdZYHGfk/0r8ixdQCbX9kK0g7EK2/yAW1Px87otLSpTj6yyGn2n3m0Bd6
         PNKAt+IUmdib4L1F2WZEvJcXiS154V05N4gEGGuGUFRX8eFKxqwqU98IWr/OC+p0GKP6
         VGfw==
X-Gm-Message-State: AOAM532k2plf7NkzEx5xteudRmJXPGjq2V2Cu+zIy2gKB9sVTuznZbjV
        yx/BAio45oZEFfqCrIZnZ7Djr7AzzYCr9TEkBLI=
X-Google-Smtp-Source: ABdhPJwSKiwAgl7gMf8SbWmQaqGVSlMPzDm9jyID9KnDjA2+c4uM72zIlW4nCMQtus1D9XinCnjm1YRWwAiUhMt3xj8=
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr12124795qtv.385.1611204813675;
 Wed, 20 Jan 2021 20:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20210102220441.794923-1-jolsa@kernel.org> <20210102220441.794923-8-jolsa@kernel.org>
 <CAM9d7ciSkns0=0LqWK2BrTFOON2z4wx5vjb=zhP5=iUoXXjeDQ@mail.gmail.com> <20210119183119.GE1717058@krava>
In-Reply-To: <20210119183119.GE1717058@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Jan 2021 13:53:22 +0900
Message-ID: <CAM9d7cg0vStd_zwXmdy4kbF5fGw54d+gTToENmTNAQQQrmju_A@mail.gmail.com>
Subject: Re: [PATCH 07/22] perf daemon: Add daemon command
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

On Wed, Jan 20, 2021 at 3:31 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 19, 2021 at 01:08:17PM +0900, Namhyung Kim wrote:
> > > +               /* Reconfig session. */
> > > +               pr_debug2("reconfig: session '%s' start\n", session->name);
> > > +               if (session->pid > 0) {
> > > +                       session__kill(session);
> > > +                       pr_info("reconfig: session '%s' killed\n", session->name);
> > > +               }
> > > +               if (session__run(session, daemon))
> >
> > Does it call a config function?  Or is it called already?
>
> daemon__reconfig kills and starts sessions based
> on the config data read by setup_server_config
>
> >
> > > +                       return -1;
> > > +               pr_debug2("reconfig: session '%s' done\n", session->name);
> > > +               session->state = SESSION_STATE__OK;
> >
> > I think RUNNING is a better name.
>
> I'll check, I'll put the state graph in comment,
> so we can discuss the changes

Yeah, that would be helpful.

Thanks,
Namhyung
