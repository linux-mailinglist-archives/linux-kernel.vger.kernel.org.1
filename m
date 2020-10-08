Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63290287C89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgJHTfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:35:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:35:50 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MmU5P-1kqpqm1A25-00iSZd for <linux-kernel@vger.kernel.org>; Thu, 08 Oct
 2020 21:35:49 +0200
Received: by mail-qk1-f174.google.com with SMTP id w12so8261100qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:35:49 -0700 (PDT)
X-Gm-Message-State: AOAM533aQGRS3NBCxLOMLGmyxf7dSRS6PUd3NI7aUH4Vxgz7d5LD6ANM
        RP7NCuQmSjPKdA0zDcAzcF21JOIXhWkO3PYjDrw=
X-Google-Smtp-Source: ABdhPJxtDgXmC1qVf05wiZe1kDndVdMeWJAsi0qywXzfsOVjo9EDTqBUxlCzoCxwUuqPAwm31T0uguA+Zbet5mxoSNI=
X-Received: by 2002:a05:620a:74f:: with SMTP id i15mr10183732qki.352.1602185748173;
 Thu, 08 Oct 2020 12:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201008182713.2764-1-harshalchau04@gmail.com>
In-Reply-To: <20201008182713.2764-1-harshalchau04@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Oct 2020 21:35:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1cSCDAHDNFX9KrqQ3-7TNsidzyX6_Yn-fmVOQGqyCHCA@mail.gmail.com>
Message-ID: <CAK8P3a1cSCDAHDNFX9KrqQ3-7TNsidzyX6_Yn-fmVOQGqyCHCA@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
To:     Harshal Chaudhari <harshalchau04@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rI3NjZO4yvP03LzfIjtXm9SpBQH9C8QA7KlDkI5y0TC0eHxTURX
 5Bg63H3rUC/SXnuvpGYwYp/Xw/3/x1D+Wo8hKxdO1MzJXUXDp1Tvp/S3Y1wyukwOtFGyciC
 fAXs3EuNv28xiHcIKYOQcw1ZDlkyEO9txlJ+nXmdE6dLKdOoS3YwACX9Lxuq80FD5aLop0d
 S5PcSn1uTDKqxH3zk1/jQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CYh94WlcGfA=:lp4blldvLxedzPLwwyjInM
 OrHOwC9IzJKAqwc/UUJoEJOGPNrKPq669gONKQmI8XZphjX8epUCODZTb/Rqps3MBuJ5S3K0I
 /1sg1EWNuYjFls2O7MyEPBjxXccYs4zyvgDtaN0c64498JHlZ74jPGPOenzC6ofOFuuSOrB4a
 mJGE4i91RI/1H8dosfExNIkTrU+uwbuR99w4tAIXcD96sypfTRErVKl65XC2x0NZAlzQhJPbL
 hqKfqDORVN7c5NANo5V/4gKFjE8Vvz/edluiaw9y4ycrHF6JGymTOi7Wkt8XmBIPsWLfghdno
 qCAafHR/Ynx53jpTMoAyLXMrTXiDbQg80+ev9I84+gNCOZXgf9SfquZr30BiK2U0ZK6RCGtWU
 sFaTeAAjx3hYYUHtgrIkYCDXOpZOsYph13MV6mPoE+KGNhy5qsiWIooUWqSImzpLOAJ13uOMu
 wvsbj3quiKidRsqN88OBq7bCSrbuKpNXRKD9PTGYay+t+80mcMuN/epWXcX/u6lQ1yNKVTBNy
 EBkGknK0ebT5tkaJ91gBFhpgYtxAM0p00Q/NCXKAtIJ3IG4Mm0qWd4wt3tsdAer3hK03m2CXi
 8f5eGBTzeqr4KGaI4A1YpNCDof9z0QBPfsPaAuOzfa7MZYMCHWXPXy2iOlEsIy8ISl1ImaUB9
 XDlEsNTaCSeUvHfMKm1vyeFWAzxll1zeJO9th4aTbK9KvvCiwAgm8BvZZtibs/ercpRrfCa1U
 t6WZT4AehVp7LUwZcy6iOLaFg+FHoz7YpafyzGSqFZBNUyhI8lEiBG9yHM6UtA0biqBqfGc7r
 CNrErHsObybOXkWDE9zQPPaivc1Q6RECKgaY2aSWeVD4OB2DsxVDLKbr8XYw0BKq1PaD+YS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 8:27 PM Harshal Chaudhari
<harshalchau04@gmail.com> wrote:
>
> Checking the argument passed to the ioctl is valid
> or not. if not then return -EINVAL.
>
> Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
> ---
>  drivers/char/ppdev.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> index 38b46c7d1737..001392980202 100644
> --- a/drivers/char/ppdev.c
> +++ b/drivers/char/ppdev.c
> @@ -354,7 +354,7 @@ static int pp_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         unsigned int minor = iminor(file_inode(file));
>         struct pp_struct *pp = file->private_data;
>         struct parport *port;
> -       void __user *argp = (void __user *)arg;
> +       void __user *argp = NULL;
>         struct ieee1284_info *info;
>         unsigned char reg;
>         unsigned char mask;

Assigning to NULL serves no purpose here.

> @@ -364,6 +364,16 @@ static int pp_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         struct timespec64 ts;
>         int ret;
>
> +       if (_IOC_TYPE(cmd) != PP_IOCTL)
> +               return -ENOTTY;

This looks correct but is normally done as a "default" case

> +       /* check if ioctl argument is present and valid */
> +       if (_IOC_DIR(cmd) != _IOC_NONE) {
> +               argp = (void __user *)arg;
> +               if (!argp)
> +                       return -EINVAL;
> +       }

This is a change in behavior, it changes the return code from the correct
-EFAULT to an unusual -EINVAL for the special case that the pointer
is NULL compared to other invalid pointers.

      Arnd
