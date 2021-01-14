Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD572F5CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbhANJAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbhANJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:00:06 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB99C061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:59:25 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i6so4575974otr.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qb9hNQO6OcJCASI04u8t2R6xrNDq5cvZ9kC7Nrcqfts=;
        b=piQg1o8r4FhEXT0RSbsmO2soNb90nnFIJjC5h++xC3FiKSH2yq5CR+PeWqQq0NFeP0
         Fsdmj3vuaswo6Rerq/fqsAm6P3qLfDq8Q7OUL7piPW+RIVpFm4px9WPQXyoznVzP0xfw
         JiCbvGMylmXTi+qH58eFtxD4e5sh+iel9wJSnoxJaw/KuMFIPlUPmXrT3R4/wLLd8n1X
         eqQBjzTBIkXsoOtB6wTaY+lsrZblj9jk+k6jrGwvgyE4wGRYQXcJYigq0MyHSsdwJwp4
         oxbuxvDE+trK//Kcd9pyS4g0QZsFGtXUj2XZCE947slfKuhIf+HHNrLrU9c6ZdZxRKjg
         hLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qb9hNQO6OcJCASI04u8t2R6xrNDq5cvZ9kC7Nrcqfts=;
        b=eA7H7KC6npHoVobt8OFuqwd5snyalz40pV8Nfh78L2m1g7ltIOp8GJTaypBzLqn1eR
         dAGmmK8aXDHivj62lFcXw9aNL/GS3IY4vRjX7aQWm+TvZBsvoY4xdgqkdJcRLpQTzYla
         5JkRpoUKwc2rk44aq1VJ+9Yh8IoPTO7Lp6JLgzH+tL1b4Hl275fGaSHRljYwM1tb9Lm7
         fgcJjvnCCpQuYaerlwTe94wY0CTLJ9fe1dmNmfy7l/wkby3RpGwRVjEnQ+qp08fiAvPI
         AJ9GT7UAB0kjrRKEnK+IZh4cGqn3605EzKpYFuyFBtd9GBmu+JSwlSDdB37wIq6KdGhA
         ocog==
X-Gm-Message-State: AOAM532CgMlMM7kgKvMXX3ah2e1DNedzHPkJUb9MYndCYUA48yMPf6W5
        XttxQSw3ciBe34ClKiGY/WV6y0Xj3P1DVFsKP75uTw==
X-Google-Smtp-Source: ABdhPJzoe+c4TcZ0g79ZoNvHvj6bRfYCiY0rcTjlf8D0qLJEA1KuBVL5FJT2zoe5JW0+TDRn1YMTklchb0Tc3Plx1Ic=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr4126160ots.251.1610614764525;
 Thu, 14 Jan 2021 00:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com> <20210113091657.1456216-2-glider@google.com>
 <20210113161044.43bc1c1a@gandalf.local.home> <CAG_fn=XSkOChCwBp=Vg6jWhZ8K44seCo=0Zu38iUpAj6eCUxjQ@mail.gmail.com>
In-Reply-To: <CAG_fn=XSkOChCwBp=Vg6jWhZ8K44seCo=0Zu38iUpAj6eCUxjQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 Jan 2021 09:59:13 +0100
Message-ID: <CANpmjNP+MC4DYAE6K07sa_mcQ3c59zZ-g5yFotMVFdY+jPUyGw@mail.gmail.com>
Subject: Re: [PATCH 1/4] tracing: add error_report trace points
To:     Alexander Potapenko <glider@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 08:50, Alexander Potapenko <glider@google.com> wrote:
>
> On Wed, Jan 13, 2021 at 10:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 13 Jan 2021 10:16:54 +0100
> > Alexander Potapenko <glider@google.com> wrote:
> >
> > > +DECLARE_EVENT_CLASS(error_report_template,
> > > +                 TP_PROTO(const char *error_detector, unsigned long id),
> >
> > Instead of having a random string, as this should be used by a small finite
> > set of subsystems, why not make the above into an enum?
>
> You're probably right.
> I just thought it might be a good idea to minimize the effort needed
> from tools' authors to add these tracepoints to the tools (see the
> following two patches), and leave room for some extensibility (e.g.
> passing bug type together with the tool name etc.)
>
> > > +                 TP_ARGS(error_detector, id),
> > > +                 TP_STRUCT__entry(__field(const char *, error_detector)
> > > +                                          __field(unsigned long, id)),
> > > +                 TP_fast_assign(__entry->error_detector = error_detector;
> > > +                                __entry->id = id;),
> > > +                 TP_printk("[%s] %lx", __entry->error_detector,
> >
> > Then the [%s] portion of this could also be just a __print_symbolic().
>
> We'll need to explicitly list the enum values once again in
> __print_symbolic(), right? E.g.:
>
> enum debugging_tool {

We need to use TRACE_DEFINE_ENUM().

>          TOOL_KFENCE,

For consistency I would call the enum simply "ERROR_DETECTOR" as well.
(Hypothetically, there could also be an "error detector" that is not a
"debugging tool".)

>          TOOL_KASAN,
>          ...
> }
>
> TP_printk(__print_symbolic(__entry->error_detector, TOOL_KFENCE,
> TOOL_KASAN, ...),

It takes a list of val -> str. E.g.
__print_symbolic(__entry->error_detector, { TOOL_KFENCE, "KFENCE" }, {
TOOL_KASAN, "KASAN" }).

Looking around the kernel, sometimes this is simplified with macros,
but not sure if it's worth it. Typing the same thing 3 times is fine,
given this list won't grow really fast.

Thanks,
-- Marco
