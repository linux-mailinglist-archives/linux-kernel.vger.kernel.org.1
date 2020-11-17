Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7B2B5B72
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKQI6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKQI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:58:30 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8925DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:58:30 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id n189so4361156vkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHJFy/YZF0XB4eGF/ZvX/fiRUi3iszemfHnSFZkXlNY=;
        b=OKvVi+JxEmD2+psGAbyGXPeOLv8+JqivKOwIzQqu9FwRbF2CQ2PZwUdD5Tft7pB+lT
         p0JxjayOKIw8H8BuU2JElK5cvAG8OV9oyoqSuVZ6I01ttV1k4shF2uDgH+MdO5OHYCCT
         VV/YaOdH6/9NSMKdD9Hc4zyFFdynJbAh9Nqjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHJFy/YZF0XB4eGF/ZvX/fiRUi3iszemfHnSFZkXlNY=;
        b=sJm50+HjoWAo7YxWlefkoq4pQAzRU7Psa+Q3S11wOPFtlVfCrjIvMIwDPeCloM8fcp
         ffestmELWRoTOKX/0fPmMWlTMQiGsKQ2Jcihst93asoUoHAzs+ol9LNtLEXUo2CGEMD9
         APBLbqoPm6xTlhKyv2bPtZndilduhnJLogWYedRoOBLb9LF//CPP0JQzRfFVCALM3uVK
         zt65z0OheEfH6VzLJQWXEBXghE+MROzu9h0Yg9s71RdhprFLrnQgfg/DBOIM27Zm9CAr
         ktcBeZ1b/+jXC0d7zSIo8YU37wO7pI9d1kC5t9BlOem+yn0oV/z4Mb0LAydBcdl+9PB3
         obxw==
X-Gm-Message-State: AOAM5335uBE8jJjtdIL72m25XlKnitOZDhs96x9lF+f7zbqR/7APxWS6
        sO9O4FTGDziVK38/BE8ZIxCI7HRMZfpWm6la75jkCA==
X-Google-Smtp-Source: ABdhPJz7dVX7V4S5GX6p4Ws3QxlbSEWOxHA3mPIMcC/KgbBbY9HgY84i5+VQCIC021fFmrRGvEDpzrxSeQbjXOwwFD8=
X-Received: by 2002:ac5:c96c:: with SMTP id t12mr10487686vkm.19.1605603509197;
 Tue, 17 Nov 2020 00:58:29 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bUfavwMVv2SEMve5pabE_AwsDO0YsRBGZtYqX59a77vA@mail.gmail.com>
In-Reply-To: <CACT4Y+bUfavwMVv2SEMve5pabE_AwsDO0YsRBGZtYqX59a77vA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Nov 2020 09:58:18 +0100
Message-ID: <CAJfpegvoiGb5R1Y2a+_rNgTXgfJD=kFrkXBn7zSZDHKxwe992Q@mail.gmail.com>
Subject: Re: suspicious capability check in ovl_ioctl_set_flags
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Merna Zakaria <mernazakaria@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 8:56 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Hi Miklos,
>
> We've detected a suspicious double-fetch of user-space data in
> ovl_ioctl_set_flags using a prototype tool (see report below [1]).
>
> It points to ovl_ioctl_set_flags that does a capability check using
> flags, but then the real ioctl double-fetches flags and uses
> potentially different value:
>
> static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
>                 unsigned long arg, unsigned int flags)
> {
> ...
>     /* Check the capability before cred override */
>     oldflags = ovl_iflags_to_fsflags(READ_ONCE(inode->i_flags));
>     ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
>     if (ret)
>         goto unlock;
> ...
>     ret = ovl_real_ioctl(file, cmd, arg);
>
> All fs impls call vfs_ioc_setflags_prepare again, so the capability is
> checked again.
>
> But I think this makes the vfs_ioc_setflags_prepare check in overlayfs
> pointless (?) and the "Check the capability before cred override"
> comment misleading, user can skip this check by presenting benign
> flags first and then overwriting them to non-benign flags. Or, if this
> check is still needed... it is wrong (?). The code would need to
> arrange for both ioctl's to operate on the same data then.
> Does it make any sense?

Yes, looks like an oversight.

The only way to fix this properly, AFAICS is to add i_op->setflags.

Will look into this.

Thanks,
Miklos



> Thanks
>
> [1] BUG: multi-read in __x64_sys_ioctl  between ovl_ioctl and ext4_ioctl
> ======= First Address Range Stack =======
>  df_save_stack+0x33/0x70 lib/df-detection.c:208
>  add_address+0x2ac/0x352 lib/df-detection.c:47
>  ovl_ioctl_set_fsflags fs/overlayfs/file.c:607 [inline]
>  ovl_ioctl+0x7d/0x290 fs/overlayfs/file.c:654
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>  __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ======= Second Address Range Stack =======
>  df_save_stack+0x33/0x70 lib/df-detection.c:208
>  add_address+0x2ac/0x352 lib/df-detection.c:47
>  ext4_ioctl+0x13b1/0x27f0 fs/ext4/ioctl.c:833
>  vfs_ioctl+0x30/0x80 fs/ioctl.c:48
>  ovl_real_ioctl+0xed/0x100 fs/overlayfs/file.c:539
>  ovl_ioctl_set_flags+0x11d/0x180 fs/overlayfs/file.c:574
>  ovl_ioctl_set_fsflags fs/overlayfs/file.c:610 [inline]
>  ovl_ioctl+0x11e/0x290 fs/overlayfs/file.c:654
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>  __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> syscall number 16  System Call: __x64_sys_ioctl+0x0/0x140 fs/ioctl.c:800
> First 0000000020000000 len 4 Caller vfs_ioctl fs/ioctl.c:48 [inline]
> First 0000000020000000 len 4 Caller __do_sys_ioctl fs/ioctl.c:753 [inline]
> First 0000000020000000 len 4 Caller __se_sys_ioctl fs/ioctl.c:739 [inline]
> First 0000000020000000 len 4 Caller __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
> Second 0000000020000000 len 4 Caller vfs_ioctl+0x30/0x80 fs/ioctl.c:48
> ==================================================================
