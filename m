Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006AC2AFFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKLGt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLGt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:49:28 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE42C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 22:49:28 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id q22so4397611qkq.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 22:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=elJz3dDAcUiPe6J3cNxqFC3PIDY9/vbTziU/ycl68bk=;
        b=Gs8QDGCHttzx94BsXmRVcBgNZdW4ivxrM9lAPkXHKFn0To/quGjg2Ad8ojJuZMw31z
         cF4Xa2UFYoa75EpCYw6bKtGKzkSdBCDxnlcnupyzzPJ5pv9DKGVkuD+/pdmiNOnZBy+3
         wUhIqUah8luVlzKqIkDWfI1B2nqa6SV8s8ifQa2K4vwJMKkE2qC3oceEoYe9SwKBtL5e
         FQ5KYmym10PO5GooUH2cLxru4eGt0GeFXdbCG8xp++fryXwGwWI+209lDcXLF2kkqTh+
         YsTxK3T6TaNv3rFGYwaG5Y2M7bg2/WfIS5fKwnXpksNg9czoQ3frpdS5EuhXOgOW6Xa/
         n1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=elJz3dDAcUiPe6J3cNxqFC3PIDY9/vbTziU/ycl68bk=;
        b=WnUkAydAbv65t6crgj51oYRDa4rU0/ClU/twu5Y8MORe/5Feje+/mrwqwk9KZ0163R
         T0CEYVuko2lrmZrNhpScWBcW2F+H3VSpdh6bsKZEe0KlX34yYHMrF30D293e36IufYMD
         lVUoJMLxJRrAVSJ2iCqC5dzUYyWs/qftQWazz4qL5bsI9Vm67D4wEPf0BnLOZvCSrTJj
         yu6rZ+5rertHCIiVS4ig17KvR2tcJKQ/YKtv9OSv1x31iq+2hA1+Yd9J+DemTFtSg3tf
         pG/twgz1cbCcpvpe2t0PyaepBdmQbuMDy+JrCsH6taWGSs7pv1BoZ3fknCwLpmDQaZS/
         1dLA==
X-Gm-Message-State: AOAM533bHM50I9CgKug54eppdmTbwvtKaYv/Fg6roaBogQz5pPhy0/bl
        QK6EKBTwyiAPSIwD2S1kkPkboOKuoXK2KrkYx0pH7ya0bh8=
X-Google-Smtp-Source: ABdhPJx7+Z8EA/WzLJxwTxapWkeJl32aaRPlL4rrvkfCPjHK8rPC/73SSZ/YjtfPcpOkNm4lxrt2lYTevAc7ykACXV0=
X-Received: by 2002:a37:6412:: with SMTP id y18mr12228967qkb.84.1605163767754;
 Wed, 11 Nov 2020 22:49:27 -0800 (PST)
MIME-Version: 1.0
References: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
 <20201111183742.e7c90597216343d9d2ffcb4e@kernel.org> <CADjb_WQ2uueSuSAQJrbOLyms7zEvq9qqmoFA5Zkg9sD1P2C+zQ@mail.gmail.com>
 <20201112145055.0029e5ca5973618a6cf2d887@kernel.org>
In-Reply-To: <20201112145055.0029e5ca5973618a6cf2d887@kernel.org>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Thu, 12 Nov 2020 14:49:16 +0800
Message-ID: <CADjb_WQQ+fJ7rMGzBw7KK-BVjB0nuVMZf-DR3izErLMzzAC_=w@mail.gmail.com>
Subject: Re: bootconfig length parse error in kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 1:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> Hi Chen,
>
> On Thu, 12 Nov 2020 12:34:36 +0800
> Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> > Hi Masami,
> >
> > On Wed, Nov 11, 2020 at 5:37 PM Masami Hiramatsu <mhiramat@kernel.org> =
wrote:
> > >
> > > Hi Chen,
> > >
> > > On Tue, 10 Nov 2020 23:39:53 +0800
> > > Chen Yu <yu.chen.surf@gmail.com> wrote:
> > >
> > > > Hi Masami,
> > > > Thanks for writing bootconfig and it is useful for boot up trace ev=
ent
> > > > debugging.
> > >
> > > Thanks for testing!
> > >
> > > > However it was found that on 5.10-rc2 the bootconfig does not work =
and it shows
> > > > "'bootconfig' found on command line, but no bootconfig found"
> > > > And the reason for this is the kernel found the magic number to be =
incorrect.
> > > > I've added some hack in kernel to dump the first 12 bytes, it shows=
:
> > > > "OTCONFIG". So printed more content ahead we can find
> > > > "#BOOTCONFIG" ahead. So it looks that there is some alignment durin=
g
> > > > initrd load, and get_boot_config_from_initrd() might also deal with=
 it. That is
> > > > to say:
> > > > data =3D (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > > > might do some alignment?
> > >
> > > Hrm, interesting. So initrd_end might be aligned. Could you print out=
 the
> > > actuall address of initrd_end?
> > I've done some investigation, it looks like this issue is not related
> > to alignment, but related to
> > the bootloader that has provided an inaccurate ramdisk size via
> > boot_params.hdr.ramdisk_size.
>
> Yeah, it seems to happen. bootloader can pass wrong (bigger) size
> to kernel. BTW, what bootloader would you use?
>
It is
$ grub-install --version
grub-install (GRUB) 2.04-1ubuntu26.2
> > The actual size of initrd is:
> > ls /boot/initrd.img-5.10.0-rc3-e1000e-hw+ -l
> > -rw-r--r-- 1 root root 48689230 11=E6=9C=88 12 00:08
> > /boot/initrd.img-5.10.0-rc3-e1000e-hw+
> > while the ramdisk size provided by bootloader via
> > boot_params.hdr.ramdisk_size is
> > 48689232, which is 2 bytes bigger than the actual size, and this is
> > why the initrd_end
> > is bigger than expected and causing the missmatch of magic number.
>
> OK. It seems that the bootloader might cut it up to 16 bytes
> aligned. (But I think that's wrong behavior, there is no reason
> to do it)
Agree.
>
> > Since there is no guarantee that bootloader provides the accurate
> > ramdisk size, an compromised
> > proposal might be that to search for the magic number a little ahead.
>
> If the bootloader does such wrong behavior, there is no guarantee
> that the size is "a little" bigger. IOW, it can be aligned to the
> page size (4KB-)
>
Right. How about inserting the bootconfig at initrd_start if
initrd_end could not be trusted?
> > For example, the
> > following patch works for me:
> > diff --git a/init/main.c b/init/main.c
> > index 130376ec10ba..60fb125d44f4 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -273,7 +273,10 @@ static void * __init
> > get_boot_config_from_initrd(u32 *_size, u32 *_csum)
> >         if (!initrd_end)
> >                 return NULL;
> >
> > -       data =3D (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > +       data =3D memchr((char *)initrd_end - 2 * BOOTCONFIG_MAGIC_LEN,
> > +                      '#', BOOTCONFIG_MAGIC_LEN);
> > +       if (!data)
> > +               return NULL;
>
> So this also does not guarantee that we can find "#" in BOOTCONFIG_MAGIC_=
LEN.
> We need to find actual code in the bootloader, what it does.
>
Indeed.
> >         if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
> >                 return NULL;
> >
> >
> > > And could you tell me which platform are you tested?
> > >
> > It is HP ZHAN 99 Mobile Workstation G1 with i5-8300H, Ubuntu 20.04.
>
> Hmm, this means x86 Grub2 does this change. Let me check it.
>
Okay.

Thanks,
Chenyu

> Thank you,
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
