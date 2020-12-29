Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00F02E72FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgL2S21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2S20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:28:26 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF45C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 10:27:46 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id w17so12846768ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbV8d1t1Pgkhw+yWYebOZ+ycw1SMWEyFjO8QWJ9yTkk=;
        b=BrqIj0n39Sq2tt2mI8sl+0z7vc4Y69NHA50cLjX3P49bU3DySEWQ0XZKPDhOLq8vj+
         f8rw41o7xbZL4ZH8uQbfe44UqqR3kVJ/fVMJOQdFWO9q3/AHO4Ysv0QU5M11ZLzwMraw
         Vbvg/RIgAcT2xt7yxvMUkbVslazJ3Sl+19FalV06jiC5u00e9hFTSGNiBIzCPSIcGduM
         YgQUghpHUI0TgIEH3wtNm4w3HBz4QangkYps6XGhGPmHWsAG1pVkwrDdRVQ7kjMpRoC3
         qbR3pM5/t3AsDbUVhjCS6l3cBp2AtVw3PdL2/8zo1Sh2po84TJL4deZnWkh+RVU4Ugt5
         L2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbV8d1t1Pgkhw+yWYebOZ+ycw1SMWEyFjO8QWJ9yTkk=;
        b=T18WEC3y8f0gKaxT1rSUIr8ArTkshvC6Fbub6YN/92H78CYwOBam5iIXQW19z5lRG9
         qy14AIVQ0gT/e2S7Of8KQsR+POLeZDV5sdmmRWkQQo1HJPzpO1w8Tj/EfFOEUUhM3SOq
         utwUmf04mloFHRZoUdTi8z/9GkBoDJzPuivaMMm2Y4lyTDQbLidrEHbeU6hjmBoatM3Q
         rMPJEtK0A+tO23qPuSSJgPSr0ELv4oEh3d4+C0VNhPTiq3pzS9TC7C2Sxa3hFfnyPi5b
         44S0VwDfvu97B+aSasU2ToaEDAYEipzledZbyK0sUBAQtpmevkkbT6VcfFWfWJ2d6QuY
         7rxA==
X-Gm-Message-State: AOAM5320+SSYAfvPC1ohT9g9aoB+1exi7OwwKhwpF0lOLx2ukvtfghTu
        sa3fx42r+jxujVv3RuODSuSay4uRW3WBFL5zQ/k=
X-Google-Smtp-Source: ABdhPJwx+JncDGbJbZaq+Yf3bdr6VfsUakPDYwAeKEwzVq0Ho6Sw7xmoLCyVIMDxzHvZE5uEfS1l9461cRT5c63Y6pk=
X-Received: by 2002:a05:6e02:12e4:: with SMTP id l4mr47874192iln.252.1609266465473;
 Tue, 29 Dec 2020 10:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20201228194343.88880-1-yury.norov@gmail.com> <20201228195016.GD4077@smile.fi.intel.com>
 <CAAH8bW9UvDAB4NSQB6CuhBU6D=R6Ex6=5V=Ld74hYGK474_Trw@mail.gmail.com>
 <808b7555-5ba2-f1fe-3800-1d5f59c47b52@arm.com> <CAHp75Vd8PZM5Z5A0bCapeOEbvzqXtfUXUDK=6G1nxD527E3=rA@mail.gmail.com>
 <CAAH8bW_gaA9m_tFX_HGJZ-fy0FHeVonO-jMU6Zpu7roo7kXQwA@mail.gmail.com>
In-Reply-To: <CAAH8bW_gaA9m_tFX_HGJZ-fy0FHeVonO-jMU6Zpu7roo7kXQwA@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 29 Dec 2020 10:27:34 -0800
Message-ID: <CAAH8bW-6bR7gBdA+hsE5k-EwUycbiL4-wZ-AznxyxQg5SHuxcA@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Carsten Haitzler <Carsten.Haitzler@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:09 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Tue, Dec 29, 2020 at 5:50 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Dec 29, 2020 at 2:24 PM Carsten Haitzler
> > <Carsten.Haitzler@arm.com> wrote:
> > >
> > > On 12/28/20 8:10 PM, Yury Norov wrote:
> > > > On Mon, Dec 28, 2020 at 11:49 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >> On Mon, Dec 28, 2020 at 11:43:43AM -0800, Yury Norov wrote:
> > > >>> The commit be3e477effba636ad25 ("drm/komeda: Fix bit
> > > >>> check to import to value of proper type") fixes possible
> > > >>> out-of-bound issue related to find_first_bit() usage, but
> > > >>> does not address the endianness problem.
> > > >> Hmm... Can you elaborate?
> > > >>
> > > >> ...
> > > >>
> > > >>>                                    u32 comp_mask)
> > > >>> -     unsigned long comp_mask_local = (unsigned long)comp_mask;
> > > >> Here we convert u32 to unsigned long (LSB is kept LSB since it happens in
> > > >> native endianess).
> > > >>
> > > >>> -     id = find_first_bit(&comp_mask_local, 32);
> > > >> Here it takes an address to unsigned long and tries only lower 32 bits.
> > > >>
> > > >> Are you telling that find_first_bit() has an issue?
> > > > It seems you're right, there's no issue with endianness in existing code.
> > > > In fact, the line
> > >
> > > Indeed Andy covered this. Take LSB32 with the cast to "local on-stack
> > > long" and possible extend upper 32bits with 0's if needed (64bit longs).
> > >
> > > >>> -     unsigned long comp_mask_local = (unsigned long)comp_mask;
> > > > is an opencoded version of bitmap_from_arr32(dst, src, 32).
> > > >
> > > > Maybe it would be better to use the bitmap API here, but existing code is
> > > > correct. Sorry for the noise.
> > > While your code is seemingly also valid (I can check to be sure with
> > > KASAN if you want still), it does seem a little less "nice to read" with
> > > more lines of code for the same work. Is it worth making the code a
> > > little longer here as it's not actually fixing anything to do it this
> > > other way? DECLARE_BITMAP() is a bit of an obscure way to declare a
> > > single unsigned long (in this case) where the compiler does the right
> > > thing anyway with a simple assign+cast making it easier to read/follow IMHO.
> >
> > What we can do is to declare BITS_PER_U32.
> > Also we can pay attention on these definitions:
> > https://elixir.bootlin.com/linux/latest/source/kernel/bpf/btf.c#L168
> > https://elixir.bootlin.com/linux/latest/source/security/selinux/ss/ebitmap.c#L27

On the other hand, fixed width types are designed especially to
contain a specific
number of bits. I don't understand why BITS_PER_U32 is any better than
just 32 ...

> > And define BITMAP_FROM_U32() macro.
> >
> > Then It would be written like
> >
> > DECLARE_BITMAP(comp_mask_local, BITS_PER_U32) = BITMAP_FROM_U32(comp_mask);
> >
> > But this is a bit verbose.
> >
> > Also, it can be something like DECLARE_BITMAP_U32(...) = BITMAP_FROM_U32(...);

People often do things like this:
https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/pcie-hisi-error.c#L199

Maybe it's worth adding a shorthand for it, like CREATE_BITMAP32(name, val) and
CREATE_BITMAP64(name, val)?
