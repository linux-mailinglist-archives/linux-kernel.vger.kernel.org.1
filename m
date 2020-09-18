Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB5270044
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIROz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIROz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:55:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:55:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so3106569plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2wjI5wyvHuB1DQE3VdNJfmgr0lLxVLpaWfOkRz2kHI=;
        b=szlsuR3SmVeVfl8jR5xN/Klz+kUmjgRAAo2NJL43BVNeC6udv4XGrZ7XKb7d5K+2ZT
         qMdolIv4NMMLrjU7xBBKh6sYgWAisOLY7jzZpZXDsNE/7P7ZCDdSMQHmZZ2uq7piDkAY
         blTrBbvuxXWv6WfeQKFKPbmoc0ZMxeSO0eW4VH/5g9eYZy0WxDHuDbw7BGb5iHEB26cc
         b0+wo4qNPZ1Day2m3mA8xdr87XF7mk+kkt730o42ZSxAngSaacN0Dz5WtLlihMmnr7ba
         3Gru7/5/vytt8+UXOrPuOWyD9Juy1ZwA5Jy1FKLzFsRg+aauUnoLF19VnG4nvaoWep/1
         Y6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2wjI5wyvHuB1DQE3VdNJfmgr0lLxVLpaWfOkRz2kHI=;
        b=Qtj0lRsrz01+AQzuXQPlUgnwUrK3AF21y6KVgSS9OamoHSeqlNfP7PWiwMQ7pxcOqX
         SjTIVoGqa8e1ENdeF5mqYqA/p5LxEc/p/ezy+Q/qJMxrYHmegrvWMH9ltXtIFFgxR/Kr
         /4d/e3CZJsLDxh40t6/H/IUB+pZ+wcGkgMkS2dvh7FkMFN5I0jYWAUfKP435hHFYUWM8
         tVOK8UpERMPLDUxPuzAfkkNLurwMMqDdVLqYmwqYfMDR5gl7J1mnkNVJnVtDtNgEjGKf
         c2wgdhXvnfb4QdgK5crwmGJUwPudmA3zBoC5XKkB15UtxJU+Azujb4bTEOHVOeWl4GMs
         pPjQ==
X-Gm-Message-State: AOAM530g9QAqRnse1a1kCK3ZdR6UNdJhtLZ/u9CDFOx4okTZeuFySULf
        JdX3VAouDF4kH5RNJ6Nehq1e1dtDF381ONA+funA0A==
X-Google-Smtp-Source: ABdhPJzi1tlbDphfl6SIdhj+afAqadotLeH1GeHkXsSe+RJ+PBqLlrI2nbWKP1+GRtl8/svQfqEgm5gETw/JR/FOAqo=
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id
 b8-20020a170902d888b02900d0cb2df274mr33383728plz.13.1600440956745; Fri, 18
 Sep 2020 07:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <f511f01a413c18c71ba9124ee3c341226919a5e8.1600204505.git.andreyknvl@google.com>
 <20200918144423.GF2384246@elver.google.com>
In-Reply-To: <20200918144423.GF2384246@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 16:55:45 +0200
Message-ID: <CAAeHK+yJ=86KfVN5bSvXpawjNtLuG4zvsPVtcYCBQR_PPfV4Bw@mail.gmail.com>
Subject: Re: [PATCH v2 35/37] kasan, slub: reset tags when accessing metadata
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 4:44 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> [...]
> >  static void set_track(struct kmem_cache *s, void *object,
> > @@ -583,7 +585,8 @@ static void set_track(struct kmem_cache *s, void *object,
> >               unsigned int nr_entries;
> >
> >               metadata_access_enable();
> > -             nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
> > +             nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> > +                                             TRACK_ADDRS_COUNT, 3);
>
> Suggested edit (below 100 cols):
>
> -               nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> -                                               TRACK_ADDRS_COUNT, 3);
> +               nr_entries = stack_trace_save(kasan_reset_tag(p->addrs), TRACK_ADDRS_COUNT, 3);
>

Ah, yes, it's a 100 lines now :) Will do in v3, thanks!
