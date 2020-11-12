Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94D72B087E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgKLPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgKLPgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:36:37 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E516820A8B;
        Thu, 12 Nov 2020 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605195396;
        bh=pxxT4+uXdO6sR11nvF6tksd+2wzZ2183bhj3EqQGVrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dWDE/o5+E+q1sB8AS1M6130Dtmx+4af/ID41/hNiFb5OylYdpWDtVunspb7XmdUJB
         egZgwXPakqCMfN6MLHFIKhd/iSMUnDbd6ARW1hyjGtL5PJRF3IlNJpCOxyowfQOnPl
         0CMvOhdxUn9qJmVRiudkI3PKry8DVrkTkwtlp1Gc=
Date:   Fri, 13 Nov 2020 00:36:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: bootconfig length parse error in kernel
Message-Id: <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org>
In-Reply-To: <CADjb_WQQ+fJ7rMGzBw7KK-BVjB0nuVMZf-DR3izErLMzzAC_=w@mail.gmail.com>
References: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
        <20201111183742.e7c90597216343d9d2ffcb4e@kernel.org>
        <CADjb_WQ2uueSuSAQJrbOLyms7zEvq9qqmoFA5Zkg9sD1P2C+zQ@mail.gmail.com>
        <20201112145055.0029e5ca5973618a6cf2d887@kernel.org>
        <CADjb_WQQ+fJ7rMGzBw7KK-BVjB0nuVMZf-DR3izErLMzzAC_=w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 14:49:16 +0800
Chen Yu <yu.chen.surf@gmail.com> wrote:

> On Thu, Nov 12, 2020 at 1:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Chen,
> >
> > On Thu, 12 Nov 2020 12:34:36 +0800
> > Chen Yu <yu.chen.surf@gmail.com> wrote:
> >
> > > Hi Masami,
> > >
> > > On Wed, Nov 11, 2020 at 5:37 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > Hi Chen,
> > > >
> > > > On Tue, 10 Nov 2020 23:39:53 +0800
> > > > Chen Yu <yu.chen.surf@gmail.com> wrote:
> > > >
> > > > > Hi Masami,
> > > > > Thanks for writing bootconfig and it is useful for boot up trace event
> > > > > debugging.
> > > >
> > > > Thanks for testing!
> > > >
> > > > > However it was found that on 5.10-rc2 the bootconfig does not work and it shows
> > > > > "'bootconfig' found on command line, but no bootconfig found"
> > > > > And the reason for this is the kernel found the magic number to be incorrect.
> > > > > I've added some hack in kernel to dump the first 12 bytes, it shows:
> > > > > "OTCONFIG". So printed more content ahead we can find
> > > > > "#BOOTCONFIG" ahead. So it looks that there is some alignment during
> > > > > initrd load, and get_boot_config_from_initrd() might also deal with it. That is
> > > > > to say:
> > > > > data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > > > > might do some alignment?
> > > >
> > > > Hrm, interesting. So initrd_end might be aligned. Could you print out the
> > > > actuall address of initrd_end?
> > > I've done some investigation, it looks like this issue is not related
> > > to alignment, but related to
> > > the bootloader that has provided an inaccurate ramdisk size via
> > > boot_params.hdr.ramdisk_size.
> >
> > Yeah, it seems to happen. bootloader can pass wrong (bigger) size
> > to kernel. BTW, what bootloader would you use?
> >
> It is
> $ grub-install --version
> grub-install (GRUB) 2.04-1ubuntu26.2
> > > The actual size of initrd is:
> > > ls /boot/initrd.img-5.10.0-rc3-e1000e-hw+ -l
> > > -rw-r--r-- 1 root root 48689230 11月 12 00:08
> > > /boot/initrd.img-5.10.0-rc3-e1000e-hw+
> > > while the ramdisk size provided by bootloader via
> > > boot_params.hdr.ramdisk_size is
> > > 48689232, which is 2 bytes bigger than the actual size, and this is
> > > why the initrd_end
> > > is bigger than expected and causing the missmatch of magic number.
> >
> > OK. It seems that the bootloader might cut it up to 16 bytes
> > aligned. (But I think that's wrong behavior, there is no reason
> > to do it)
> Agree.
> >
> > > Since there is no guarantee that bootloader provides the accurate
> > > ramdisk size, an compromised
> > > proposal might be that to search for the magic number a little ahead.
> >
> > If the bootloader does such wrong behavior, there is no guarantee
> > that the size is "a little" bigger. IOW, it can be aligned to the
> > page size (4KB-)
> >
> Right. How about inserting the bootconfig at initrd_start if
> initrd_end could not be trusted?
> > > For example, the
> > > following patch works for me:
> > > diff --git a/init/main.c b/init/main.c
> > > index 130376ec10ba..60fb125d44f4 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -273,7 +273,10 @@ static void * __init
> > > get_boot_config_from_initrd(u32 *_size, u32 *_csum)
> > >         if (!initrd_end)
> > >                 return NULL;
> > >
> > > -       data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > > +       data = memchr((char *)initrd_end - 2 * BOOTCONFIG_MAGIC_LEN,
> > > +                      '#', BOOTCONFIG_MAGIC_LEN);
> > > +       if (!data)
> > > +               return NULL;
> >
> > So this also does not guarantee that we can find "#" in BOOTCONFIG_MAGIC_LEN.
> > We need to find actual code in the bootloader, what it does.
> >
> Indeed.
> > >         if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
> > >                 return NULL;
> > >
> > >
> > > > And could you tell me which platform are you tested?
> > > >
> > > It is HP ZHAN 99 Mobile Workstation G1 with i5-8300H, Ubuntu 20.04.
> >
> > Hmm, this means x86 Grub2 does this change. Let me check it.
> >

I found the 4 byte alignment code in the grub 
(grub_initrd_init()grub-core/loader/linux.c), but that seems to happen
only when load a file with newc:/PACKAGE/FILE format. (And this is not
documented.) At a glance, u-boot may not do that (but of course user
can pass different size directly by command), EDK2 doesn't too.
So, we should check at least 3 byte back for grub. 

BTW, just out of curious, what is your "initrd" command line in grub.conf? :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
