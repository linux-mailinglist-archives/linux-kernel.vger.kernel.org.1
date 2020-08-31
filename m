Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354202573DE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 08:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgHaGll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 02:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:41:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABFFC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:41:39 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j21so111526oii.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBJNIRqUExiPeZF8xMwliEHPk0u0KNgv6oRniOleVd8=;
        b=UYoh3tKAOAIrKDKQ4n/n3fg9NdqM4Zdv+pRbjqMsouewV6+NDU7kiuLwYNg0yfygvn
         d+xvGICR8hgMeHYkQQUBF9nQbYNuPrXbFZ358Dnu5mprBOHgvtLUbzvndQOczfjLqDKp
         4h5PpVTouOutgcfX6xFnVqrMrRXGpXyPSGcyrmuWMjBg5lzbyKZ1sVHwil4lUxQewNvq
         hFxS+3CeDCaLYJBX9IiPoUtWgPc1/JrnT6TyBqC1Udmoyw40YOhe9mssfVtf2bgpCWme
         qEmn+sJH/QE0bUHZI/H8CNSyPZeVoVYVDdgMx2ZJL9s3KDcNAAjxk17odKg6ahH+GaBL
         4L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBJNIRqUExiPeZF8xMwliEHPk0u0KNgv6oRniOleVd8=;
        b=tsobvGzkhJpSVyniJP0aKtR/x+xRiEjwGtVNaPnvqCRS1T3kZjT8ISb4WzJHKgkcnp
         FZ9LFo66bqf5Hoo+9QO7b7N8ZivLAWVBbBmIIvP3sT36tfMased6vr9fe6RTMWq26VIL
         NXHkCFrWAwbfAf7D46qjTBXWFcCElEUcjuFcYdNV92lqb2vzip6rmwDMPb/Q9dNb0pHa
         5Guu0q/zvFuen1vsXrsMLrilSI/tVi3AL0zAS0I0SHkC93GaHGODmVJTtswd00g9oU2S
         fSvv+Evx95O9qx7G34kCDwZkz2DtKZH+kkGHpzISbPfRRuKT2NVa2l0Bcxn/dNc3b0Hz
         zMqg==
X-Gm-Message-State: AOAM533o8V9xvVJ1gJwyRrIQYdkK79sbZwctIsDENyXmTTN3SMuB3OfJ
        T5QLhbmjWV0J6I1vkE82rcKe5UNingVs4H2DRtq2MzvHa7k=
X-Google-Smtp-Source: ABdhPJzEm5vqrWCF7/cXwQ8t6SBioL0RPh9Y5s1KMXFlKBj7LghejkC9MfNkDumcK19Wqm1Khf0CkABoW0G9EPAu0mw=
X-Received: by 2002:aca:5158:: with SMTP id f85mr53219oib.121.1598856098398;
 Sun, 30 Aug 2020 23:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <159881061564.27993.11909051048930389391.tglx@nanos>
 <159881061804.27993.16119786735164087221.tglx@nanos> <CAHk-=wi6ufj=O-PDu=HVYw0QXpK52GPWKJfBaU4Djr0h6OFpKg@mail.gmail.com>
In-Reply-To: <CAHk-=wi6ufj=O-PDu=HVYw0QXpK52GPWKJfBaU4Djr0h6OFpKg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 31 Aug 2020 08:41:27 +0200
Message-ID: <CANpmjNPc7Hs0LvXPe540rgCzFAe9B7ec-ddStGfxVU_mtvFKOQ@mail.gmail.com>
Subject: Re: [GIT pull] sched/urgent for v5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 at 20:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Aug 30, 2020 at 11:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >  - Make is_idle_task() __always_inline to prevent the compiler from putting
> >    it out of line into the wrong section because it's used inside noinstr
> >    sections.
>
> What completely broken compiler uninlined that single-instruction function?
>
> I've obviously pulled this, but it sounds like there should be a
> compiler bug-report for this insane behavior.
>
> Or is Marco building the kernel without optimizations or something
> like that? That has not been a supported model, for various good
> reasons..

Certainly with optimizations, but also with various debug options and
sanitizer instrumentation. (FTR, the config used:
https://lore.kernel.org/lkml/20200820144931.GA4120397@elver.google.com/3-a.txt
on GCC 10.1 with GCC 11's KCSAN patches backported.)

Checking GCC's sources, the inlining policy here is that the compiler
tries to sanitize as many functions as possible, and if only 'inline'
is used, it'll avoid inlining such a function into a 'no_sanitize'
function in favor of instrumenting it.

With a normal non-debug config this should therefore never happen.

Thanks,
-- Marco
