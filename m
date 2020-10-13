Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A038F28D0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgJMOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgJMOt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:49:29 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03263C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:49:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j13so51304ilc.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5A/wMexNlERgv8ndahg0Kfhkqmz/+pr0QsOW0t5ANKM=;
        b=t/cF5NTWVLah/DtugHW3FFg3mklSNSAwyTblssQl1DRqR+f8ITZWTXjG+AWt0FZ7Fj
         0ozZy2D5Q0aUNkm1BJudD1pCUyLScUo8K77paKuGwX0j4Ittpy+nnDujrkexKl7ZrYj9
         IqDGM810NIhQYt6qZyTr9rdtpQu8ceuoZlXkmhEU4ng77SQNWjO9pVEi8VsEu1manwm2
         gtBJpiKD+IR8j+QYWvLC481xFOwxm6qm2ytJSYKcTp0uZ6QJKx9XiQ6YAilW4Mcr07HR
         DB+FlzlG6Nw2n1bFd/yLr9s1aMYhqyLkFjVYYe3+ldMO2tn3SXPdTuzmOFdtzLHBhhfB
         L51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5A/wMexNlERgv8ndahg0Kfhkqmz/+pr0QsOW0t5ANKM=;
        b=TuavodgRDSFtogMZdvPZvhfOYNtmHE/9Fw5YBBIA9KsYszewa7GeRTHaAj7GQKMDAU
         LhFrvBQSdJt0mvJMmN9QTliPogZa6pXQBFnHYDVdNjpRk0UFgZTllGptm/DXZjxukM1P
         stCwtijGaLvGmZ8ATeCnKz47/U70T9E+3CIBKamslcyBHPj7EhZ3P/lvf0EKREJu5l94
         uJK2XdHm63eKxwlLRsry+r8o+aAxx6gW8ybet4ClrEfQb+zP6xO4oxEpc5KnIzK0dbws
         bPHwmFipCB5lg43uepeHdxZIahFyOJC1IDa6NXSmefMsiX883oz/uxvNuqls8hvJOW+3
         mDbQ==
X-Gm-Message-State: AOAM5313gNAxZ080KQYbh/Tef9qvoz2gmayQ5paGh/cLhoz4SWm7tVGl
        psERrvrmlmsczkwTEgZw5pbi0mAkn3zJKfTsdn0=
X-Google-Smtp-Source: ABdhPJxmrcBZp7iqWcNWyJYRWXZmxG86Ij4bxbFlv+zCbKn3PiB25SVgqeC3ezIo+30W0cj3hg5DyJTrqObBhrYLsr0=
X-Received: by 2002:a92:7914:: with SMTP id u20mr230617ilc.203.1602600568275;
 Tue, 13 Oct 2020 07:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201013055454.52634-1-laoar.shao@gmail.com> <20201013090511.1f2f71f6@gandalf.local.home>
In-Reply-To: <20201013090511.1f2f71f6@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 13 Oct 2020 22:48:52 +0800
Message-ID: <CALOAHbBb2D+iYHfaXaE+Nux7EtxwLW-cT-BXw2=o_2nfMYakmw@mail.gmail.com>
Subject: Re: [PATCH] tracing: add tgid into common field
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 9:05 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 13 Oct 2020 13:54:54 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -67,6 +67,7 @@ struct trace_entry {
> >       unsigned char           flags;
> >       unsigned char           preempt_count;
> >       int                     pid;
> > +     int                     tgid;
> >  };
> >
>
> Sorry, this adds another 4 bytes to *every* event, if you want it to or
> not. I'd rather have some ways to remove fields from this header, and not
> add more to it.
>
> I can't take this patch.
>

Right, that is an overhead. I will think about some ways to avoid adding it.


-- 
Thanks
Yafang
