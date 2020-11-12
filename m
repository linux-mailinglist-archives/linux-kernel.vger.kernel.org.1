Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F2F2AFE62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgKLFhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgKLEet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 23:34:49 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233AEC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 20:34:48 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id z13so229662qvs.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 20:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FvKmtLsodAJiwGkHclSFzMGG45Y0oGWPQUWCaMlMxJY=;
        b=apCiDsHVWk0DV63kvw2JJVFhsEUeVdJu0oBfz/LwmHBwDhniHmchUjL92U7r27/hjH
         IIMQqnVgu+KDxnCt4XgL5KdNtze9OiDg5dG0LTVDjKmcHG74zroM9O4MbnPG10G35cvm
         hmkLpaPtvSUrk2ftgxuDsN+1+Yg6mSwXZPikx5vDYBaMF+DPcBTrqy4r2CkF0CwQqD8+
         nz0qYVNcrs9GAGB4SYA/mzj14y58J+K6LcLocLTl3hergpfsC2POdc8ERfXrF3voO/bi
         0q69ucgYIzaRUJzo0wiz/P2/7vXurSnGEyv3lZZ2gBTkkfsiDV5MAFcQ1H9w9chz026g
         adMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FvKmtLsodAJiwGkHclSFzMGG45Y0oGWPQUWCaMlMxJY=;
        b=rybXu+GqdytD/iTYajqQNdQyuyRjMhK7QrTAP8WxUVt3XWVV5CNhGjObzyulzqWnqz
         5gQREcnzS7U+ypDWD5YbCQDAHKKxDbqMdlX2259+EL2Kidjw/Yo1+CjedOK0glBTFdo8
         3O3wVvqsmlyY9oTZSkuq0r5SWZJRTUKJllp9LjPIiutH4lN8dXYl2kYfAxJ8pl8i35xR
         QrMg8/nnAQsJZ7aZQO54xM68Ay5IUoofhgMAQnMg+c8KX+Q8A9Za8zxV4+za88ApcVLO
         AuXTVr6pbrkos9FGlwzfPxi6IjHvtc3C5FqOmpxW6eGFu49bgnqefKBGuVFtcHezFDRE
         MbJw==
X-Gm-Message-State: AOAM53031abjbgojxW4bWcCEmjBtJ4jU97SrTlSEsj3uolybbOoJFcpv
        VRLAGTi/8sgExxqqWEuuoiS00Kp9CQkyVQ/JtDM=
X-Google-Smtp-Source: ABdhPJyrXpi63m7MXkQZQGZ/xT7V1j7PdARJU+uEFHpBMhaysQ1QTRu++tTqti9yx07yry5vE/o51eAERkM1Wv1ViI0=
X-Received: by 2002:a0c:b603:: with SMTP id f3mr21809054qve.42.1605155687283;
 Wed, 11 Nov 2020 20:34:47 -0800 (PST)
MIME-Version: 1.0
References: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
 <20201111183742.e7c90597216343d9d2ffcb4e@kernel.org>
In-Reply-To: <20201111183742.e7c90597216343d9d2ffcb4e@kernel.org>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Thu, 12 Nov 2020 12:34:36 +0800
Message-ID: <CADjb_WQ2uueSuSAQJrbOLyms7zEvq9qqmoFA5Zkg9sD1P2C+zQ@mail.gmail.com>
Subject: Re: bootconfig length parse error in kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, Nov 11, 2020 at 5:37 PM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> Hi Chen,
>
> On Tue, 10 Nov 2020 23:39:53 +0800
> Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> > Hi Masami,
> > Thanks for writing bootconfig and it is useful for boot up trace event
> > debugging.
>
> Thanks for testing!
>
> > However it was found that on 5.10-rc2 the bootconfig does not work and =
it shows
> > "'bootconfig' found on command line, but no bootconfig found"
> > And the reason for this is the kernel found the magic number to be inco=
rrect.
> > I've added some hack in kernel to dump the first 12 bytes, it shows:
> > "OTCONFIG". So printed more content ahead we can find
> > "#BOOTCONFIG" ahead. So it looks that there is some alignment during
> > initrd load, and get_boot_config_from_initrd() might also deal with it.=
 That is
> > to say:
> > data =3D (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > might do some alignment?
>
> Hrm, interesting. So initrd_end might be aligned. Could you print out the
> actuall address of initrd_end?
I've done some investigation, it looks like this issue is not related
to alignment, but related to
the bootloader that has provided an inaccurate ramdisk size via
boot_params.hdr.ramdisk_size.
The actual size of initrd is:
ls /boot/initrd.img-5.10.0-rc3-e1000e-hw+ -l
-rw-r--r-- 1 root root 48689230 11=E6=9C=88 12 00:08
/boot/initrd.img-5.10.0-rc3-e1000e-hw+
while the ramdisk size provided by bootloader via
boot_params.hdr.ramdisk_size is
48689232, which is 2 bytes bigger than the actual size, and this is
why the initrd_end
is bigger than expected and causing the missmatch of magic number.
Since there is no guarantee that bootloader provides the accurate
ramdisk size, an compromised
proposal might be that to search for the magic number a little ahead.
For example, the
following patch works for me:
diff --git a/init/main.c b/init/main.c
index 130376ec10ba..60fb125d44f4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -273,7 +273,10 @@ static void * __init
get_boot_config_from_initrd(u32 *_size, u32 *_csum)
        if (!initrd_end)
                return NULL;

-       data =3D (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
+       data =3D memchr((char *)initrd_end - 2 * BOOTCONFIG_MAGIC_LEN,
+                      '#', BOOTCONFIG_MAGIC_LEN);
+       if (!data)
+               return NULL;
        if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
                return NULL;


> And could you tell me which platform are you tested?
>
It is HP ZHAN 99 Mobile Workstation G1 with i5-8300H, Ubuntu 20.04.

Thanks,
Chenyu

> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
