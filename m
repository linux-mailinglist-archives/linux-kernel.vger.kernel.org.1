Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5E2B10BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKLVzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgKLVzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:55:49 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC61C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:55:49 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q10so5827387pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZdzQMnylo5i+1X6F6BJquvAy5ORPsCe3ydlZZ54zqU=;
        b=cVFvPLpg/zQRZofpaZ10wTEkfw6Z1RTWB/DIOiCGLL86ijkiP7xBoDk32u5jvD0/lq
         ZT7fie65V62+GkE8nHfKQPfofM44KgUn8a8VQkfXev6HX6lf6w5Z0wi2gEEi0IXxbpbP
         snf7/8+T2MqWC+MM/QyIco2oniQI9zQpkGDDKXmjs28hhAKDHZy/wa2mUxLvu8T9chih
         i/Gk7m6m1rHLNCzBl9wiBEDPeBxNaKMueYkSXCt/Bkl5VrhoWOG51tYq5SRGB2VIVOAy
         0dm9n9TryUwkumV3KeqibsGyne6UUm1qR+Ap8JApT7sdDTMCphQjirhoHeV5R5MhK9BP
         Td0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZdzQMnylo5i+1X6F6BJquvAy5ORPsCe3ydlZZ54zqU=;
        b=gqBPtqsp7FzUwgJ9yEmWHe+AlFrqidFIkbWNXuuERRGp5D11m1s9eODEByra/OBDhk
         ltwwAly62gLquH+IfdZUPmxv8tbQaF9d/ZGerI9SpFxio3VQCDxEagz08550WkOnhpEX
         l0/waGoCvmRImFqRYVMu/SHssmnA0pCa8YzNrrXUoZ2m3m7FRAFRf2KAHI4IbGiU+8F6
         8xKR51zWoKcnJib4LjKmb3dXNzd102HL2h6aYrwG6LHihfmQ8tvRcnSqgxRqmbmmP8En
         1dztZ/1C3/h4hs6Be9UDz2bs4h/wOo442QiuDKWLNlwylQoLj/VVZ26t31AAxQsEXExo
         kTlg==
X-Gm-Message-State: AOAM533ud1MmGQCStTp+msvi3YbiBOv2vY2Rmpw79oGj4nEW+ZHjemua
        QmtahJuu+TiH+/AixRgfEzNGzXmaBUafWwb3Jn7vQg==
X-Google-Smtp-Source: ABdhPJw/dzcU/R4J/NC0Ca8BEkhiIQYc+G3dtoFsKvoOMUoYnbl8GJ+yssbZ6VGehdp8NRRx2Xunmt784tRQp5RV2PQ=
X-Received: by 2002:a62:ed0d:0:b029:18b:78d:626 with SMTP id
 u13-20020a62ed0d0000b029018b078d0626mr1362687pfh.15.1605218148644; Thu, 12
 Nov 2020 13:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com> <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
 <87sg9ghil5.fsf@collabora.com> <CAKwvOd=QrU6rCQ4_Ji=XsskPovOSXpk0NkjTqVjLijw1-CZ17Q@mail.gmail.com>
 <87lff8gesg.fsf@collabora.com> <20201112215033.GA438824@rani.riverdale.lan>
In-Reply-To: <20201112215033.GA438824@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Nov 2020 13:55:36 -0800
Message-ID: <CAKwvOdmCgWFgHof8fqep1hymeNc368Fn8rLDwzzCU58tV5wyXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 1:50 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Nov 11, 2020 at 04:15:59PM +0200, Adrian Ratiu wrote:
> > On Tue, 10 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> > wrote:
> > >
> > > Yes, though additionally Arvind points out that this code is
> > > kind of curious if there was overlap; maybe the parameters
> > > should just be restrict-qualified.
> > >
> >
> > For now I think I'll just re-send the GCC changes and leave the
> > Clang optimization as is, until we better understand what's
> > happening and what's the best way to enable it.
> >
>
> Note that the __restrict__ keywords also help GCC -- it saves it from
> having to emit the non-vectorized version and switch between the two at
> runtime. If we can verify it's safe, it's a good thing to add all
> around.

100% agree.  Even a BUILD_BUG_ON or WARN_ON in callers to validate
such an invariant might be nice.
-- 
Thanks,
~Nick Desaulniers
