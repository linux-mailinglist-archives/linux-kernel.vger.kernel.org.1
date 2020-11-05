Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7030F2A89A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbgKEWTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:19:46 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046BAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:19:45 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id c129so2715203yba.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R99YW6naQkjTKNrYbkDdoRsHBx6NElPxT3Iw4sTWwBI=;
        b=bSu7029BVsxtkGkG9XdftxNpc76W2uH46do1RtX/bVMy4mgfoP+OEVI4mAk+RQiEKE
         3f3VLzAV87IZwtVWIeS4YetaHVXiSIJ9TGxHPmq1hpdNs5y11zThne9G6w6tk/sGYYkP
         EheoBzcZkqlHR9eHxQ8vzvakop5zyLS853cqsT7ypOkHbx3ckp+NXqpRYdbVqdQRdmYS
         MCKaFswPlLu+6kaNakEePlKwUaL86qh/XIGG2AQiuzMqlZ+9k9jAnIeH1c9G00TB/QIN
         ufkexZLbeUzCt33sjdrBXeiiTpMVj+5UsEYgy4ZBA90JZc+3YDxfQfArt+JjuPtYntbk
         M6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R99YW6naQkjTKNrYbkDdoRsHBx6NElPxT3Iw4sTWwBI=;
        b=HUfa8DopvkDw0KC7rLl6yHsGHd/n/bQz5mPp9JtKarbqAsd27EDLKxlNZoBFCAhYT4
         5geXj7Nz9OpI4HZK2g0BB2gb2O+4jXGwB4kaPMy499jL8QbrJ7MVV/qnyJa6bou4FoyI
         g1CiBOr42FDN9Ex3eLXE7LQtuQz3K1buCJ3EllY9jQdfTbezdMIkyQYHwEyx8ljwhyjX
         1nPLe41OQ5PFWazAISftwEt3rguTUsedfe79JqievR/io9XSqJwuZHBWNwmjPPxhtosq
         3xYOvYcrgGLVueR+PWoZSU6o0n5J5mUX4aIwyehlWsMkEcrm2yzXq9MEBGdXA1sRSQia
         Np+g==
X-Gm-Message-State: AOAM530EplKrwb2Zv38nhvKnfNZS6bUCdwMEngewQkSg9e6UkuhYv9gx
        2XwbnRknhPPoD2+jxQzG3+dOgFiWbjW4Yl0t2MJ+Pg==
X-Google-Smtp-Source: ABdhPJwysPeQHX76FeXX+a3Ov6HF1AN0RHmBAgIdB3EHMiZqQaUWKAccauUaskO9vV4diWXfH62sUpQFgV4qAgTr6NM=
X-Received: by 2002:a25:9c87:: with SMTP id y7mr6858310ybo.314.1604614784094;
 Thu, 05 Nov 2020 14:19:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com> <CAFKCwrgCfx_DBf_b0bJum5Y6w1hp_xzQ_xqgMe1OH2Kqw6qrxQ@mail.gmail.com>
 <CAAeHK+zHpfwABe2Xj7U1=d2dzu4NTpBsv7vG1th14G7f=t7unw@mail.gmail.com>
In-Reply-To: <CAAeHK+zHpfwABe2Xj7U1=d2dzu4NTpBsv7vG1th14G7f=t7unw@mail.gmail.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Thu, 5 Nov 2020 14:19:33 -0800
Message-ID: <CAFKCwrgvPD_EvCnzOsCvdMRW0uYPmUd+FRwugU0VBJOeRHtO8Q@mail.gmail.com>
Subject: Re: [PATCH 00/20] kasan: boot parameters for hardware tag-based mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 12:55 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Nov 5, 2020 at 9:49 PM Evgenii Stepanov <eugenis@google.com> wrote:
> >
> > > The chosen mode provides default control values for the features mentioned
> > > above. However it's also possible to override the default values by
> > > providing:
> > >
> > > - kasan.stack=off/on - enable stacks collection
> > >                    (default: on for mode=full, otherwise off)
> >
> > I think this was discussed before, but should this be kasan.stacktrace
> > or something like that?
> > In other places "kasan stack" refers to stack instrumentation, not
> > stack trace collection.
> > Ex.: CONFIG_KASAN_STACK
>
> Forgot to update it here, but it's kasan.stacks now (with an s at the
> end). kasan.stacktrace might be better, although it's somewhat long.
> WDYT?

I like kasan.stacktrace, but I would not insist.
