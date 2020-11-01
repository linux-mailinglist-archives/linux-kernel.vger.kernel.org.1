Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25DD2A204F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 18:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgKARZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 12:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKARZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:25:38 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DDBC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 09:25:37 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id dj6so1161253qvb.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GoREefk9aMvT7KBl/285APZiVNf5wtxBUMwiwvWBv4I=;
        b=DoHV+5VeDMpmDkK6SRxdhRQh7hRXgMSov0Pj+5it7JG7FBsYb+q1eNcaRgWUUtdp/S
         /IbqS1XVNGSMwX1N5TyxVi71K1uaTme4om7CTwBBRfs3XbEj88/knrnOrgzdR2UDu40l
         2pY3C53HGvV0X3pFrzgA8d3FRt/Is8xeFIirNQ0Jd0cpqi1EIVJ8OldikTtSIxnZ5fb6
         s8pCu3L0pDLKxtJkfFKjtmIzUSrkL8F6FXZIBqY3vKheIfM2qEChgXyLHf8y4fmG9/vY
         LGefnFN0zEdTDSKkCqMSI0PF4WuD7Dq9Todp7Wzn5ZRyT14gA7149lRFD4UCoNUiPOCa
         Kqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GoREefk9aMvT7KBl/285APZiVNf5wtxBUMwiwvWBv4I=;
        b=UmUrybMAlwMxjw36TMff6qL2MVmiJZdBxhbk1PgfZQMTy3hsxqK/nKwaU6lj2FQdgf
         z7YI5JSogJgoNBHfwCFJu84+cW4/OqaJMeicWb06F0Cr4LlOikvOQ1IYw92a7ClN84Ca
         88UjYPDbA437qfSbcL/Rh16bRvtUzekHxqCTOK3mV/Bv4bhmK740doJLPQMgEgILEOHF
         Zdv5u+ADkVXU4KWKsr9dBkErZPHILiyZPAP6BiV+uRjS0J1IPj7wXhSOoJPcwOkIpZPG
         CkxRdkFMwy+KSnKzE52yJmBrOWjPhhLkF6KYcF9bpKaLBPJpymAEhQ/ZnW4IWdlL2Z/c
         t12g==
X-Gm-Message-State: AOAM530SZFOHBVLDcobelQX8Y7lpjoggZARCCDZywMMej0wGwpqGuZuD
        njBJlaIDaMM7Lu+Z9k22TBA2uOEvtPSpwHwYhZ0=
X-Google-Smtp-Source: ABdhPJx9nwGJIHbLlJsTX9D3Ssa4rTU8fhrQ5Zxm3aMBbkWFEp8rxMpwxn0Dt6AswIQeqptGZ+2UcpxiC6o/X9usf5k=
X-Received: by 2002:a05:6214:12c4:: with SMTP id s4mr19051183qvv.33.1604251536935;
 Sun, 01 Nov 2020 09:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20201026155801.16053-1-harshalchau04@gmail.com> <SN4PR0201MB34725868C7009E7290B396FBCB150@SN4PR0201MB3472.namprd02.prod.outlook.com>
In-Reply-To: <SN4PR0201MB34725868C7009E7290B396FBCB150@SN4PR0201MB3472.namprd02.prod.outlook.com>
From:   harshal chaudhari <harshalchau04@gmail.com>
Date:   Sun, 1 Nov 2020 22:55:25 +0530
Message-ID: <CAFEvwunx-pXaSHfdRXig+b7B4sPzKWbbZd7a6kFubzhf9DguBA@mail.gmail.com>
Subject: Re: [PATCH] misc: xilinx_sdfec: add compat_ptr_ioctl()
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Derek Kiernan <dkiernan@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 3:47 PM Dragan Cvetic <draganc@xilinx.com> wrote:
>
> Hi Harshal,
>
> The code change is fine, no comment,
> but testing will be done at the beginning of the next week.
> Sorry for the late reply,

Thanks for your attention Dragan. i have send the another patch for
 to remove argument and command checks, so i request you to please
look into this patch and kindly confirm if anything needs to change
or any possibility.
Thanks once again.

> Regards
> Dragan
>
>
> > -----Original Message-----
> > From: Harshal Chaudhari <harshalchau04@gmail.com>
> > Sent: Monday 26 October 2020 15:58
> > To: gregkh@linuxfoundation.org
> > Cc: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>; arnd@arndb.de; Michal Simek
> > <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] misc: xilinx_sdfec: add compat_ptr_ioctl()
> >
> > Driver has a trivial helper function to convert
> > the pointer argument and then call the native ioctl handler.
> > But now we have a generic implementation for that, so we can use it.
> >
> > Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>
> > ---
> >  drivers/misc/xilinx_sdfec.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> > index 92291292756a..6f252793dceb 100644
> > --- a/drivers/misc/xilinx_sdfec.c
> > +++ b/drivers/misc/xilinx_sdfec.c
> > @@ -1016,14 +1016,6 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
> >       return rval;
> >  }
> >
> > -#ifdef CONFIG_COMPAT
> > -static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
> > -                                 unsigned long data)
> > -{
> > -     return xsdfec_dev_ioctl(file, cmd, (unsigned long)compat_ptr(data));
> > -}
> > -#endif
> > -
> >  static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
> >  {
> >       __poll_t mask = 0;
> > @@ -1054,9 +1046,7 @@ static const struct file_operations xsdfec_fops = {
> >       .release = xsdfec_dev_release,
> >       .unlocked_ioctl = xsdfec_dev_ioctl,
> >       .poll = xsdfec_poll,
> > -#ifdef CONFIG_COMPAT
> > -     .compat_ioctl = xsdfec_dev_compat_ioctl,
> > -#endif
> > +     .compat_ioctl = compat_ptr_ioctl,
> >  };
> >
> >  static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
> > --
> > 2.17.1
>
