Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159C92AFF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKLFvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgKLFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 00:50:59 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7330208FE;
        Thu, 12 Nov 2020 05:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605160258;
        bh=sUnEyP4i6nDSMic8kwaWeggT//BLpHV2h10fY8zdYd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLQTpc2Om076jzZ2cdtYFaQ+4osWtLdUGUcdj7ojc9LF4srcwRlNtfD6iPUZGJ9D8
         din+LaswQmwYc9PwMCkj2/dgnJYZ/LRBr4nbOp1y+DMveSFP7eSNLRztfc7A5sR6ov
         +Lva9Sr0QZvzV+5ppr2DaNqrjnDinoL+fbLFsLs0=
Date:   Thu, 12 Nov 2020 14:50:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: Re: bootconfig length parse error in kernel
Message-Id: <20201112145055.0029e5ca5973618a6cf2d887@kernel.org>
In-Reply-To: <CADjb_WQ2uueSuSAQJrbOLyms7zEvq9qqmoFA5Zkg9sD1P2C+zQ@mail.gmail.com>
References: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
        <20201111183742.e7c90597216343d9d2ffcb4e@kernel.org>
        <CADjb_WQ2uueSuSAQJrbOLyms7zEvq9qqmoFA5Zkg9sD1P2C+zQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On Thu, 12 Nov 2020 12:34:36 +0800
Chen Yu <yu.chen.surf@gmail.com> wrote:

> Hi Masami,
> 
> On Wed, Nov 11, 2020 at 5:37 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Chen,
> >
> > On Tue, 10 Nov 2020 23:39:53 +0800
> > Chen Yu <yu.chen.surf@gmail.com> wrote:
> >
> > > Hi Masami,
> > > Thanks for writing bootconfig and it is useful for boot up trace event
> > > debugging.
> >
> > Thanks for testing!
> >
> > > However it was found that on 5.10-rc2 the bootconfig does not work and it shows
> > > "'bootconfig' found on command line, but no bootconfig found"
> > > And the reason for this is the kernel found the magic number to be incorrect.
> > > I've added some hack in kernel to dump the first 12 bytes, it shows:
> > > "OTCONFIG". So printed more content ahead we can find
> > > "#BOOTCONFIG" ahead. So it looks that there is some alignment during
> > > initrd load, and get_boot_config_from_initrd() might also deal with it. That is
> > > to say:
> > > data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > > might do some alignment?
> >
> > Hrm, interesting. So initrd_end might be aligned. Could you print out the
> > actuall address of initrd_end?
> I've done some investigation, it looks like this issue is not related
> to alignment, but related to
> the bootloader that has provided an inaccurate ramdisk size via
> boot_params.hdr.ramdisk_size.

Yeah, it seems to happen. bootloader can pass wrong (bigger) size
to kernel. BTW, what bootloader would you use?

> The actual size of initrd is:
> ls /boot/initrd.img-5.10.0-rc3-e1000e-hw+ -l
> -rw-r--r-- 1 root root 48689230 11月 12 00:08
> /boot/initrd.img-5.10.0-rc3-e1000e-hw+
> while the ramdisk size provided by bootloader via
> boot_params.hdr.ramdisk_size is
> 48689232, which is 2 bytes bigger than the actual size, and this is
> why the initrd_end
> is bigger than expected and causing the missmatch of magic number.

OK. It seems that the bootloader might cut it up to 16 bytes
aligned. (But I think that's wrong behavior, there is no reason
to do it)

> Since there is no guarantee that bootloader provides the accurate
> ramdisk size, an compromised
> proposal might be that to search for the magic number a little ahead.

If the bootloader does such wrong behavior, there is no guarantee
that the size is "a little" bigger. IOW, it can be aligned to the
page size (4KB-)

> For example, the
> following patch works for me:
> diff --git a/init/main.c b/init/main.c
> index 130376ec10ba..60fb125d44f4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -273,7 +273,10 @@ static void * __init
> get_boot_config_from_initrd(u32 *_size, u32 *_csum)
>         if (!initrd_end)
>                 return NULL;
> 
> -       data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> +       data = memchr((char *)initrd_end - 2 * BOOTCONFIG_MAGIC_LEN,
> +                      '#', BOOTCONFIG_MAGIC_LEN);
> +       if (!data)
> +               return NULL;

So this also does not guarantee that we can find "#" in BOOTCONFIG_MAGIC_LEN.
We need to find actual code in the bootloader, what it does.

>         if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
>                 return NULL;
> 
> 
> > And could you tell me which platform are you tested?
> >
> It is HP ZHAN 99 Mobile Workstation G1 with i5-8300H, Ubuntu 20.04.

Hmm, this means x86 Grub2 does this change. Let me check it.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
