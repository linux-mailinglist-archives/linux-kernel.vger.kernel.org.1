Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1385E2E72E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgL2SKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2SKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:10:15 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4025CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 10:09:35 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id v3so12834970ilo.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 10:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8hFSHegvRni/zcx/EwJER4O39x8vyJVRb/CCLReg+FQ=;
        b=sEBLIbfcAHCT57zAtk0W1cjOsFTzU03sdXzqyOKtDY5fNAc7NVhvTbaGJDQwRl1T5/
         /+JeGXwXEUfN/BGDpiJbjqMw9BU6LzS0zAm9mFRaNMRgdMB47JcXAx33R6Wv0vZHOoHk
         N9Pp7wVBdXBLpY+cIkOcpIgaV0bfBLk7IYxsYKc9W2CF1Wz1KBQuVG96dm57W2/Y1HJA
         9Qr4IMJmcNzjbt93MsBi5PnhMK6EstlWDJwc8wiS1CinzIDHKH7z2BJe9qkbydP3oyX/
         qnu0hnqHI4x/d85cV/TATZm56qECcLEbE8jdVSKoFRJNUlvd2DXFXH6BLq4uc3Axmx4V
         cdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8hFSHegvRni/zcx/EwJER4O39x8vyJVRb/CCLReg+FQ=;
        b=lo1/Y6vrGKLSlahUyoejT5zTlr173fP2jay1x7VKBRB1TFPQ5p90XCebag9nr79E1c
         GfpNcd/IDcOVfRPu4jp5Xev3E/1bUW6uRQ1ybBhN5nuD/bTtXembQqMhW1ncIszVeBQi
         M0hU5ILEFAuhAYV5dKpiSgOoTIr5q62o+9lYYJSRv7S60jgAC9h68Mp2poSXM149E53A
         e344r3bvDrqGtRUTQOdOwVEvsNoEGU96QQegH2ljZA7j+Q28m2MqOfiPFxyOz3HPrZHu
         +S2RsuzjgjwX+EKO5WDEbed8ue9JqX7/ODgXsOrHfu/Ebm925ua+7q74YM+esUtwsE6O
         Gq7g==
X-Gm-Message-State: AOAM531xHRiJRbQSyye4zXooPleTeYRJrKMu3nKZVYT6CGLeu1H6r/qS
        y0BE6s/R+CFw+/gu1EFyBE9sotONXnvs0inhx3E=
X-Google-Smtp-Source: ABdhPJyVgAXWwFIRZ680Zg8uinTdL3QJBdg418SogueTnhR0JNFgqiMktTeJlmntYd6pKDyZlKAT2PGGfARYopUi8QU=
X-Received: by 2002:a92:418d:: with SMTP id o135mr50150808ila.213.1609265373448;
 Tue, 29 Dec 2020 10:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20201228194343.88880-1-yury.norov@gmail.com> <20201228195016.GD4077@smile.fi.intel.com>
 <CAAH8bW9UvDAB4NSQB6CuhBU6D=R6Ex6=5V=Ld74hYGK474_Trw@mail.gmail.com>
 <808b7555-5ba2-f1fe-3800-1d5f59c47b52@arm.com> <CAHp75Vd8PZM5Z5A0bCapeOEbvzqXtfUXUDK=6G1nxD527E3=rA@mail.gmail.com>
In-Reply-To: <CAHp75Vd8PZM5Z5A0bCapeOEbvzqXtfUXUDK=6G1nxD527E3=rA@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 29 Dec 2020 10:09:21 -0800
Message-ID: <CAAH8bW_gaA9m_tFX_HGJZ-fy0FHeVonO-jMU6Zpu7roo7kXQwA@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Carsten Haitzler <Carsten.Haitzler@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 5:50 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Dec 29, 2020 at 2:24 PM Carsten Haitzler
> <Carsten.Haitzler@arm.com> wrote:
> >
> > On 12/28/20 8:10 PM, Yury Norov wrote:
> > > On Mon, Dec 28, 2020 at 11:49 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > >> On Mon, Dec 28, 2020 at 11:43:43AM -0800, Yury Norov wrote:
> > >>> The commit be3e477effba636ad25 ("drm/komeda: Fix bit
> > >>> check to import to value of proper type") fixes possible
> > >>> out-of-bound issue related to find_first_bit() usage, but
> > >>> does not address the endianness problem.
> > >> Hmm... Can you elaborate?
> > >>
> > >> ...
> > >>
> > >>>                                    u32 comp_mask)
> > >>> -     unsigned long comp_mask_local =3D (unsigned long)comp_mask;
> > >> Here we convert u32 to unsigned long (LSB is kept LSB since it happe=
ns in
> > >> native endianess).
> > >>
> > >>> -     id =3D find_first_bit(&comp_mask_local, 32);
> > >> Here it takes an address to unsigned long and tries only lower 32 bi=
ts.
> > >>
> > >> Are you telling that find_first_bit() has an issue?
> > > It seems you're right, there's no issue with endianness in existing c=
ode.
> > > In fact, the line
> >
> > Indeed Andy covered this. Take LSB32 with the cast to "local on-stack
> > long" and possible extend upper 32bits with 0's if needed (64bit longs)=
.
> >
> > >>> -     unsigned long comp_mask_local =3D (unsigned long)comp_mask;
> > > is an opencoded version of bitmap_from_arr32(dst, src, 32).
> > >
> > > Maybe it would be better to use the bitmap API here, but existing cod=
e is
> > > correct. Sorry for the noise.
> > While your code is seemingly also valid (I can check to be sure with
> > KASAN if you want still), it does seem a little less "nice to read" wit=
h
> > more lines of code for the same work. Is it worth making the code a
> > little longer here as it's not actually fixing anything to do it this
> > other way? DECLARE_BITMAP() is a bit of an obscure way to declare a
> > single unsigned long (in this case) where the compiler does the right
> > thing anyway with a simple assign+cast making it easier to read/follow =
IMHO.
>
> What we can do is to declare BITS_PER_U32.
> Also we can pay attention on these definitions:
> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/btf.c#L168
> https://elixir.bootlin.com/linux/latest/source/security/selinux/ss/ebitma=
p.c#L27


> And define BITMAP_FROM_U32() macro.
>
> Then It would be written like
>
> DECLARE_BITMAP(comp_mask_local, BITS_PER_U32) =3D BITMAP_FROM_U32(comp_ma=
sk);
>
> But this is a bit verbose.
>
> Also, it can be something like DECLARE_BITMAP_U32(...) =3D BITMAP_FROM_U3=
2(...);
>
> > IMPORTANT NOTICE: The contents of this email and any attachments are co=
nfidential and may also be privileged. If you are not the intended recipien=
t, please notify the sender immediately and do not disclose the contents to=
 any other person, use it for any purpose, or store or copy the information=
 in any medium. Thank you.
>
> Hmm... you probably have to get rid of this footer.
>
> --
> With Best Regards,
> Andy Shevchenko
