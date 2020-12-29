Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928B52E7113
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgL2Nvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgL2Nva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:51:30 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C768CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 05:50:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l23so1533940pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E1q/oK503CaRe+t2sMH527xi1I29YuRwcOvvSeEj3U8=;
        b=GMQ8wfXyGQ7e6cz1xTPc9LqGtJtVrN8xZnzn+3SuQ+vH7Lu2VkV5MCAJcL9qY887Df
         4gOMDA8WByOxUvR2qstq5k68le/8MOlFROEL5rBWoCehBsFGY1lHKcsmghyx+ms0aSFb
         p9VK2bwsODLqjNSA03fUVzQgcBAUWcRp3wuzPuihjvpFIuMzawm8amjn9tzRZ9csh8VW
         CK19r9Va2loH0JLNqCizK94EwrDO/7uDXGykeeaM5HuTZAudQg4PCaxDazb8ct6UTaPl
         g3BxTA0hsYNzdzAUssDQHCKbw+rfdSm8v2Jdok1+tp4Q3f8IxDFpKcO5zW5//m8e4EY3
         z+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E1q/oK503CaRe+t2sMH527xi1I29YuRwcOvvSeEj3U8=;
        b=SuddPjNRBlS+BtERm2ZGaCNJVpm2xRCfWU18a0HzKtg/M1rDYamreu3fxPtwvEMIA1
         a7bk8rqwmzY4fyKyP97y90pyBvj6A4n4FiY04XUPwx7LqeuNEGx8qPv/Jx0uq47MZ1y4
         qADmReFCRq///szNjsHS0SzNr2ddh/1NcIUBR6bauOSh1rjUNwTjISNyxtBmPFMgfuUQ
         M2KIBXqx133xC/eSGd1FONmO3nkIsZ0uU8HTzJ5zorkVT3pi+ZfueMWCa85u6+p0Aa6O
         befK+IxseqMO+TweQ3gq/Dgf649yH0cVxlG0h2ksqFnRS5k1jRs6V0BnPTXpSo8TE9RG
         8SAg==
X-Gm-Message-State: AOAM530GVAyNfF+UzMLK0XeYQv1NvpTZlzVET+IjTELhfgglgt5qy1B3
        QS/jrCwMCCD6cDE49uhXOLR729BmzkzgbFHdbbk=
X-Google-Smtp-Source: ABdhPJz/Pdh3BOGotIYEfbWY0y/NMYxN+RWuASzcnhLjkMxcEB9vjZPB8lDVvY5qsCaFrAbD4KRIL7T6u7HM9T+Ja0w=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr4116917pjt.228.1609249849298;
 Tue, 29 Dec 2020 05:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20201228194343.88880-1-yury.norov@gmail.com> <20201228195016.GD4077@smile.fi.intel.com>
 <CAAH8bW9UvDAB4NSQB6CuhBU6D=R6Ex6=5V=Ld74hYGK474_Trw@mail.gmail.com> <808b7555-5ba2-f1fe-3800-1d5f59c47b52@arm.com>
In-Reply-To: <808b7555-5ba2-f1fe-3800-1d5f59c47b52@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Dec 2020 15:50:32 +0200
Message-ID: <CAHp75Vd8PZM5Z5A0bCapeOEbvzqXtfUXUDK=6G1nxD527E3=rA@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
To:     Carsten Haitzler <Carsten.Haitzler@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
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

On Tue, Dec 29, 2020 at 2:24 PM Carsten Haitzler
<Carsten.Haitzler@arm.com> wrote:
>
> On 12/28/20 8:10 PM, Yury Norov wrote:
> > On Mon, Dec 28, 2020 at 11:49 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >> On Mon, Dec 28, 2020 at 11:43:43AM -0800, Yury Norov wrote:
> >>> The commit be3e477effba636ad25 ("drm/komeda: Fix bit
> >>> check to import to value of proper type") fixes possible
> >>> out-of-bound issue related to find_first_bit() usage, but
> >>> does not address the endianness problem.
> >> Hmm... Can you elaborate?
> >>
> >> ...
> >>
> >>>                                    u32 comp_mask)
> >>> -     unsigned long comp_mask_local =3D (unsigned long)comp_mask;
> >> Here we convert u32 to unsigned long (LSB is kept LSB since it happens=
 in
> >> native endianess).
> >>
> >>> -     id =3D find_first_bit(&comp_mask_local, 32);
> >> Here it takes an address to unsigned long and tries only lower 32 bits=
.
> >>
> >> Are you telling that find_first_bit() has an issue?
> > It seems you're right, there's no issue with endianness in existing cod=
e.
> > In fact, the line
>
> Indeed Andy covered this. Take LSB32 with the cast to "local on-stack
> long" and possible extend upper 32bits with 0's if needed (64bit longs).
>
> >>> -     unsigned long comp_mask_local =3D (unsigned long)comp_mask;
> > is an opencoded version of bitmap_from_arr32(dst, src, 32).
> >
> > Maybe it would be better to use the bitmap API here, but existing code =
is
> > correct. Sorry for the noise.
> While your code is seemingly also valid (I can check to be sure with
> KASAN if you want still), it does seem a little less "nice to read" with
> more lines of code for the same work. Is it worth making the code a
> little longer here as it's not actually fixing anything to do it this
> other way? DECLARE_BITMAP() is a bit of an obscure way to declare a
> single unsigned long (in this case) where the compiler does the right
> thing anyway with a simple assign+cast making it easier to read/follow IM=
HO.

What we can do is to declare BITS_PER_U32.
Also we can pay attention on these definitions:
https://elixir.bootlin.com/linux/latest/source/kernel/bpf/btf.c#L168
https://elixir.bootlin.com/linux/latest/source/security/selinux/ss/ebitmap.=
c#L27

And define BITMAP_FROM_U32() macro.

Then It would be written like

DECLARE_BITMAP(comp_mask_local, BITS_PER_U32) =3D BITMAP_FROM_U32(comp_mask=
);

But this is a bit verbose.

Also, it can be something like DECLARE_BITMAP_U32(...) =3D BITMAP_FROM_U32(=
...);

> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

Hmm... you probably have to get rid of this footer.

--=20
With Best Regards,
Andy Shevchenko
