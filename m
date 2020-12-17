Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6712DCF68
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgLQKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:20:17 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C386DC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:19:36 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 2so9854483qtt.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIbOVthlNTcsi+l1tR4PevWTEasEI2Fetl3tXpPfOGg=;
        b=QNOKmKNXNuuSt5Pf9n/iRLG0fkGnRxcR3T33VYNhSlSjgtfyS76dgtU6pv5xywg20T
         xxUXazrJQhp27WaJqLeVEKZd3anz22nQqy6AN98/+FFNtbIhbCX7tCPp5lNtVFe+2/m1
         XUj2xCVsGJxiaXG0PrO7n8vc9S/1flFyip/5xnhcRQdP4G4kRtXHoRIvREoZ3iPkEI1D
         G5qjutCN0QDNgcaBx5iIljCkGn+jfqTSE4wRBLAPJiIX7zay/KpG51FMxrkAOjH9dYs8
         8o6cmhQFequbWPtPwONYOU2qD6E0wW1OQYemdA/g+9jGI1Lb98yskCF3W/NLDZTzCvat
         4w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIbOVthlNTcsi+l1tR4PevWTEasEI2Fetl3tXpPfOGg=;
        b=od5IiMjJJinimvJHSVkbX+wk0zO/zJvXQYXxKd9yqA526hZupzqI3zYbEeuLwgyaT0
         /DMWBBTOI88r6egDIVOfApJaQPTaMjh6yBFldlCIKw9zhPBMHn+VqpVtqcFifiDtjwz7
         US4nQKNT+EkfEAPKqOmJBRNZFcY796fA7/6CvN3GI9KZsfnedwXa0YGzfyQSG03HhNKC
         2rwMoGkk6NqxJc2/TWAZgGbcGgaMOtFqw3ZSKOg4WuAK5CZm+WZcM4s6o4rGnNvxbIuy
         LKBmAwrwo8C6Rj2Yq+JUro2VxnTdyIxzRQAWztsSvbBnd3lm9r0xh551Tez80zFJcx2u
         mNbQ==
X-Gm-Message-State: AOAM533SMtZ8dTh79IvRAEGbOCsc6fuysCIYSqfEJt3rTJIdN5CSAW49
        RyUiGdZ2gsjR2IpmvicaAyyrmXaa2wJNOH91ruS6+A==
X-Google-Smtp-Source: ABdhPJyHp2EuBtwzoFje85DOOjI3EwPmLGC0KvTF3stJe/Ljxs3tgxMvh6R8f/VVLxUUhE3EuH2u2X0mycfHh7O/pUY=
X-Received: by 2002:aed:208f:: with SMTP id 15mr45442386qtb.290.1608200375684;
 Thu, 17 Dec 2020 02:19:35 -0800 (PST)
MIME-Version: 1.0
References: <1607576401-25609-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=VKsrYx+YOGPnZw_Q5t6Fx7B59FSUuphj7Ou+DDFKQ+8Q@mail.gmail.com>
 <77e98f0b-c9c3-9380-9a57-ff1cd4022502@codeaurora.org> <CAG_fn=WbN6unD3ASkLUcEmZvALOj=dvC0yp6CcJFkV+3mmhwxw@mail.gmail.com>
 <6cc89f7b-bf40-2fd3-96ce-2a02d7535c91@codeaurora.org> <CAG_fn=VOHag5AUwFbOj_cV+7RDAk8UnjjqEtv2xmkSDb_iTYcQ@mail.gmail.com>
 <255400db-67d5-7f42-8dcb-9a440e006b9d@codeaurora.org> <f901afa5-7c46-ceba-2ae9-6186afdd99c0@codeaurora.org>
 <CAG_fn=UjJQP_gfDm3eJTPY371QTwyDJKXBCN2gs4DvnLP2pbyQ@mail.gmail.com>
 <7f2e171f-fa44-ef96-6cc6-14e615e3e457@codeaurora.org> <CAG_fn=VihkHLx7nHRrzQRuHeL-UYRezcyGLDQMJY+d1O5AkJfA@mail.gmail.com>
 <601d4b1a-8526-f7ad-d0f3-305894682109@codeaurora.org> <CAG_fn=V8e8y1fbOaYUD5SfDSQ9+Tc3r7w6ZSoJ-ZNFJvvq-Aeg@mail.gmail.com>
 <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
In-Reply-To: <9e0d2c07-af1f-a1d3-fb0d-dbf2ae669f96@codeaurora.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Dec 2020 11:19:24 +0100
Message-ID: <CACT4Y+aUEdNjFsnMxFAbh+cWMGLG1bqX8-7uo8SQ0HPeNeDZBg@mail.gmail.com>
Subject: Re: [PATCH v3] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, qcai@redhat.com,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 6:42 AM Vijayanand Jitta <vjitta@codeaurora.org> wrote:
>
> On 12/16/2020 7:04 PM, Alexander Potapenko wrote:
> >>> To reiterate, I think you don't need a tunable stack_hash_order
> >>> parameter if the only use case is to disable the stack depot.
> >>> Maybe it is enough to just add a boolean flag?
> >>
> >> There are multiple users of stackdepot they might still want to use
> >> stack depot but with a lower memory footprint instead of MAX_SIZE
> >> so, a configurable size might help here ?
> >
> > Can you provide an example of a use case in which the user wants to
> > use the stack depot of a smaller size without disabling it completely,
> > and that size cannot be configured statically?
> > As far as I understand, for the page owner example you gave it's
> > sufficient to provide a switch that can disable the stack depot if
> > page_owner=off.
> >
> There are two use cases here,
>
> 1. We don't want to consume memory when page_owner=off ,boolean flag
> would work here.
>
> 2. We would want to enable page_owner on low ram devices but we don't
> want stack depot to consume 8 MB of memory, so for this case we would
> need a configurable stack_hash_size so that we can still use page_owner
> with lower memory consumption.
>
> So, a configurable stack_hash_size would work for both these use cases,
> we can set it to '0' for first case and set the required size for the
> second case.
>
> >>> Or even go further and disable the stack depot in the same place that
> >>> disables page owner, as the user probably doesn't want to set two
> >>> flags instead of one?
> >>>
> >>
> >> Since, page owner is not the only user of stack depot we can't take that
> >> decision of disabling stack depot if page owner is disabled.
> >
> > Agreed, but if multiple subsystems want to use stackdepot together, it
> > is even harder to estimate the total memory consumption.
> > How likely is it that none of them will need MAX_SIZE?
> >
> >>>> Minchan,
> >>>> This should be fine right ? Do you see any issue with disabling
> >>>> stack depot completely ?

+kasan-dev
