Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCD2F1EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbhAKTMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAKTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:12:37 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE10C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:11:57 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id v3so229796ilo.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=810FEXKXHgKArsdDAMgoY00MSSyM0BmX9OCgjLnP4Og=;
        b=UJTB+Bj11DFpIdm8er17rTscKDWE51w0Xw2dRRyGlLp/iO1XvzF3ESU45wDzK7AgLL
         KDzHNNcr0gD+4aSNEwy7d3hA0u2nWCIQA2DYbaGf+UeAYwShkiZ+6XXgEPg5aWBKG4Wu
         sNfwkvLkTFcF4Mjt9QBGXOd/6dSm3eTcjMYKx+Ixf2ZU2fmyqSEmGTiNtZC6wti70BYv
         VkZfW1ubZkvtjiu8as4xrHA+6DVXD1jDP7IHftAqlADXYweBvB9auFpDwzrWnVdfkAe5
         g73Tzg5BbqKTLA6PxoFatGMVIdra+iw66fP1QXBemXrcBZIh7Uq5zHA7VsrIG0HID5Y0
         QwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=810FEXKXHgKArsdDAMgoY00MSSyM0BmX9OCgjLnP4Og=;
        b=Y0NlyF0sKXDDKizMM7Hty3IqZqnzuiY6yH1a4P0Grspy4EPDXlLvi1X/pE4rh17l4W
         Uaj3tI4vedYcvqvSdPFWYjJ5Ulb0bHz6HT3moEYofXgzjtH/JGUWIF/ngVNB7IDWmnxh
         8iOoxyiOj2O2tjNdffWsjo4GKwS7QmiL8AuUt5AgiueMkssrRn04mi82UXFTKyMvIU62
         K0y8PPSAxQOZzsAbaZBBIgLqGTm3cDiulbQn+w+C8Iy30KMd2wexn2+04JfAEazDda2f
         O6ysngQYGREja9Mfq4IxU7TqhEGIdY3Lpf7VIh5Gxt9l8ZfApvp2Bk/g65VJcOeNBLEs
         VIJg==
X-Gm-Message-State: AOAM533vlpybDcwwU18z9H2juId5o1X7I3I4ccRWOoGDwIJ7U2yYWmsg
        qmHGaFFaZo6G2IrNlfYtx3k=
X-Google-Smtp-Source: ABdhPJyhbehmXWz3weu+cQnoRjDTjfr+Jz7S4Ow/uhQ6OpqWgtRhziYeTCnADFiQaWp9ee8lKcg0aw==
X-Received: by 2002:a92:d2ce:: with SMTP id w14mr628841ilg.182.1610392316821;
        Mon, 11 Jan 2021 11:11:56 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 143sm316464ila.4.2021.01.11.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:11:55 -0800 (PST)
Date:   Mon, 11 Jan 2021 12:11:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3] kasan: remove redundant config option
Message-ID: <20210111191154.GA2941328@ubuntu-m3-large-x86>
References: <20210108040940.1138-1-walter-zh.wu@mediatek.com>
 <CAAeHK+weY_DMNbYGz0ZEWXp7yho3_L3qfzY94QbH9pxPgqczoQ@mail.gmail.com>
 <20210111185902.GA2112090@ubuntu-m3-large-x86>
 <CAAeHK+y8B9x2av0C3kj_nFEjgHmkxu1Y=5Y3U4-HzxWgTMh1uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+y8B9x2av0C3kj_nFEjgHmkxu1Y=5Y3U4-HzxWgTMh1uQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 08:03:29PM +0100, Andrey Konovalov wrote:
> On Mon, Jan 11, 2021 at 7:59 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > > > -config KASAN_STACK_ENABLE
> > > > +config KASAN_STACK
> > > >         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> > >
> > > Does this syntax mean that KASAN_STACK is only present for
> > > CC_IS_CLANG? Or that it can only be disabled for CC_IS_CLANG?
> >
> > It means that the option can only be disabled for clang.
> 
> OK, got it.
> 
> > > Anyway, I think it's better to 1. allow to control KASAN_STACK
> > > regardless of the compiler (as it was possible before), and 2. avoid
> >
> > It has never been possible to control KASAN_STACK for GCC because of the
> > bool ... if ... syntax. This patch does not change that logic. Making it
> > possible to control KASAN_STACK with GCC seems fine but that is going to
> > be a new change that would probably be suited for a new patch on top of
> > this one.
> 
> The if syntax was never applied to KASAN_STACK, only to
> KASAN_STACK_ENABLE, so it should have been possible (although I've
> never specifically tried it).

CONFIG_KASAN_STACK was not a user selectable symbol so it was always 1
for GCC.

Cheers,
Nathan
