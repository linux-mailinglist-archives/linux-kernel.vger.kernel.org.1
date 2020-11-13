Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0C2B137C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgKMAuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMAuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:50:09 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EC4C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:50:09 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so7406495qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Dr7SBqjBugFe3+ybv4Q9X/5u+wg3N8/bD6/OjgCMIg=;
        b=PtYdkTFWozKQMUKZpjajR3uKJ5r+fUPIWBUmKYh2IChNOY8ML0303D5gABfhq5QMOv
         liCxXyr0eyAHQngI2eKvpQmWX3MjUjRekaW1mjaVnZ2k+KkBm1PARC7xHFPQC8tZoJY9
         TQ+7ZgtIhYuRmJUT+YdIGU9uBtzx2usUpsOr9huOB0WW6TuHMfQeDTaupAudPyQb+wcB
         AqViAfX/zOBI7YC0u1BXO824H2stt3e6tdwJcq16DC5KJA5BvlLyW+RIwx6HVpSK7rVQ
         oqdKjwEyXFXFu3TF+OD1KWB3d6PGXanGnyC++rRcE1He2tOYVtxo9Xn67QnRQTxYjoOT
         5qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Dr7SBqjBugFe3+ybv4Q9X/5u+wg3N8/bD6/OjgCMIg=;
        b=SoBJm6rnEKfBb90yNc7rnNRuf/VkVeialKzgABWO5VmXDiEGI7AO9CQ4uVNlPnpYnx
         Pe6Fa19MQc4ElukW8DtoDp/1YunXv9RCX82fQ/RQG56V+gFtWOHZdZNNXR6piCpYwyIS
         HTHN3dqsgvGIpuf/kYgFe/0Xbo5I0lEnch1H+Kjpleos+4QEAs1x9+OT7uVegYUsAgXd
         mpzCqVcppXG5hvCVkab08TCugG4tCPFXtN4wGc5eQUsnlWH3+0plIaUxJQ8PqU/WPbQq
         ja05YiPDPR6Tut/80u6URmnrOIo4by3euCUG7sfAdJx54e7UUpX9i/7U0aBaq5rKCeOF
         AF9w==
X-Gm-Message-State: AOAM533R4Kt48RBUT68tUG6YQ/qrUjDotQj5i913IZHIFnkojnifvXb3
        j72nj0WoWaiKwcdzB2SbJyYCvYYeISY+AK87QSE=
X-Google-Smtp-Source: ABdhPJzVJGSEVIIqwK8TvDQjtV9E+G2RcZT3d9wRgEeFEkCZwHApweSUPvmPwfWZrIFjySj3D5miVzv4T+BKAKVKvy0=
X-Received: by 2002:ae9:de45:: with SMTP id s66mr2612862qkf.281.1605228608698;
 Thu, 12 Nov 2020 16:50:08 -0800 (PST)
MIME-Version: 1.0
References: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
 <20201111183742.e7c90597216343d9d2ffcb4e@kernel.org> <CADjb_WQ2uueSuSAQJrbOLyms7zEvq9qqmoFA5Zkg9sD1P2C+zQ@mail.gmail.com>
 <20201112145055.0029e5ca5973618a6cf2d887@kernel.org> <CADjb_WQQ+fJ7rMGzBw7KK-BVjB0nuVMZf-DR3izErLMzzAC_=w@mail.gmail.com>
 <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org>
In-Reply-To: <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Fri, 13 Nov 2020 08:49:57 +0800
Message-ID: <CADjb_WRRYnPCVp8NzdLkoVg+L_HsovajiK4SO-51Lw-XNeoefQ@mail.gmail.com>
Subject: Re: bootconfig length parse error in kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:36 PM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
>
> On Thu, 12 Nov 2020 14:49:16 +0800
> Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> > On Thu, Nov 12, 2020 at 1:50 PM Masami Hiramatsu <mhiramat@kernel.org> =
wrote:
> > >
> > > Hi Chen,
> > >
> > > On Thu, 12 Nov 2020 12:34:36 +0800
> > > Chen Yu <yu.chen.surf@gmail.com> wrote:
> > >
> > > > Hi Masami,
> > > >
> > > > On Wed, Nov 11, 2020 at 5:37 PM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
> > > > >
> > > > > Hi Chen,
> > > > >
> > > > > On Tue, 10 Nov 2020 23:39:53 +0800
> > > > > Chen Yu <yu.chen.surf@gmail.com> wrote:
> > > > >
> > > > > > Hi Masami,
> > > > > > Thanks for writing bootconfig and it is useful for boot up trac=
e event
> > > > > > debugging.
> > > > >
> > > > > Thanks for testing!
> > > > >
> > > > > > However it was found that on 5.10-rc2 the bootconfig does not w=
ork and it shows
> > > > > > "'bootconfig' found on command line, but no bootconfig found"
> > > > > > And the reason for this is the kernel found the magic number to=
 be incorrect.
> > > > > > I've added some hack in kernel to dump the first 12 bytes, it s=
hows:
> > > > > > "OTCONFIG". So printed more content ahead we can find
> > > > > > "#BOOTCONFIG" ahead. So it looks that there is some alignment d=
uring
> > > > > > initrd load, and get_boot_config_from_initrd() might also deal =
with it. That is
> > > > > > to say:
> > > > > > data =3D (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > > > > > might do some alignment?
> > > > >
> > > > > Hrm, interesting. So initrd_end might be aligned. Could you print=
 out the
> > > > > actuall address of initrd_end?
> > > > I've done some investigation, it looks like this issue is not relat=
ed
> > > > to alignment, but related to
> > > > the bootloader that has provided an inaccurate ramdisk size via
> > > > boot_params.hdr.ramdisk_size.
> > >
> > > Yeah, it seems to happen. bootloader can pass wrong (bigger) size
> > > to kernel. BTW, what bootloader would you use?
> > >
> > It is
> > $ grub-install --version
> > grub-install (GRUB) 2.04-1ubuntu26.2
> > > > The actual size of initrd is:
> > > > ls /boot/initrd.img-5.10.0-rc3-e1000e-hw+ -l
> > > > -rw-r--r-- 1 root root 48689230 11=E6=9C=88 12 00:08
> > > > /boot/initrd.img-5.10.0-rc3-e1000e-hw+
> > > > while the ramdisk size provided by bootloader via
> > > > boot_params.hdr.ramdisk_size is
> > > > 48689232, which is 2 bytes bigger than the actual size, and this is
> > > > why the initrd_end
> > > > is bigger than expected and causing the missmatch of magic number.
> > >
> > > OK. It seems that the bootloader might cut it up to 16 bytes
> > > aligned. (But I think that's wrong behavior, there is no reason
> > > to do it)
> > Agree.
> > >
> > > > Since there is no guarantee that bootloader provides the accurate
> > > > ramdisk size, an compromised
> > > > proposal might be that to search for the magic number a little ahea=
d.
> > >
> > > If the bootloader does such wrong behavior, there is no guarantee
> > > that the size is "a little" bigger. IOW, it can be aligned to the
> > > page size (4KB-)
> > >
> > Right. How about inserting the bootconfig at initrd_start if
> > initrd_end could not be trusted?
> > > > For example, the
> > > > following patch works for me:
> > > > diff --git a/init/main.c b/init/main.c
> > > > index 130376ec10ba..60fb125d44f4 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -273,7 +273,10 @@ static void * __init
> > > > get_boot_config_from_initrd(u32 *_size, u32 *_csum)
> > > >         if (!initrd_end)
> > > >                 return NULL;
> > > >
> > > > -       data =3D (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > > > +       data =3D memchr((char *)initrd_end - 2 * BOOTCONFIG_MAGIC_L=
EN,
> > > > +                      '#', BOOTCONFIG_MAGIC_LEN);
> > > > +       if (!data)
> > > > +               return NULL;
> > >
> > > So this also does not guarantee that we can find "#" in BOOTCONFIG_MA=
GIC_LEN.
> > > We need to find actual code in the bootloader, what it does.
> > >
> > Indeed.
> > > >         if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
> > > >                 return NULL;
> > > >
> > > >
> > > > > And could you tell me which platform are you tested?
> > > > >
> > > > It is HP ZHAN 99 Mobile Workstation G1 with i5-8300H, Ubuntu 20.04.
> > >
> > > Hmm, this means x86 Grub2 does this change. Let me check it.
> > >
>
> I found the 4 byte alignment code in the grub
> (grub_initrd_init()grub-core/loader/linux.c), but that seems to happen
> only when load a file with newc:/PACKAGE/FILE format. (And this is not
> documented.) At a glance, u-boot may not do that (but of course user
> can pass different size directly by command), EDK2 doesn't too.
> So, we should check at least 3 byte back for grub.
>
> BTW, just out of curious, what is your "initrd" command line in grub.conf=
? :)
>
It is:
 linux   /boot/vmlinuz-5.10.0-rc3-e1000e-hw+
root=3DUUID=3D21f729c7-4ab0-40a9-b8cf-6f22b3851b9f ro  ignore_loglevel
no_console_suspend bootconfig
 initrd  /boot/initrd.img-5.10.0-rc3-e1000e-hw+
Thanks,
Chenyu

> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
