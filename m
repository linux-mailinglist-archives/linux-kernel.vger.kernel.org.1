Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3221297E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764329AbgJXUQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760381AbgJXUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 16:16:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC40C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 13:16:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h140so4896149qke.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNibd5271qltOBrFTFlcW1OzSSGz8hEoaHyOgvca/yQ=;
        b=IFcMQrkTZBs1x3u+BfZVylQ7KVCjnzIL06JqzCFR7pPR98Un2Yre/mK8K4ZEpBJaiQ
         lDMdX0Leh6d46OKYPHLeRC66YAzvVgxpqvDp84GUcsuzbm81j+CqjcCKB08goPiBL/E4
         DdH0QrHkoJIxCFYSRNRGSxK8DVNF0UMx0syuvE5+L9hTEjXrIFTiOqFt3tvSNiPHT6dg
         u6KdsVJTGr6XwZOnxqbnXdACG25cu4J9CLzj15p4R6b0luGvamKP2MuPMH79tDO3uW+n
         dTFzeVxcOtMSAOe3S6uBafLq+fm294dP+m8ItJJK+DJT127+8viu/4XYCrKwPQ1xOCQs
         2FwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNibd5271qltOBrFTFlcW1OzSSGz8hEoaHyOgvca/yQ=;
        b=qfg6kcmNl6lhLZRzOOAP9t3fcAa7c2ymtEXK0pB7Itintbi4JbMCETMpbfM2sZfiOT
         E7rIxjB9QJwfIv/dbOtS/WOtWkQXTRz4MqBlGTGVV+/la7R7HJQ63Wf2im/UV1GG8t7B
         55GYvm7ubgxsnkiQDR8Z0BMcRsa2AmQmchbnstyGe0s57N4doaPuc7P1mC3LXCyKcjMp
         WlEO/vn57PseGmjKJ/FTt+SnTz9FYk6OWwj/icxXdg4DOpbwi2JVPPW4LQMtgwO4NGmD
         J1O0wiTOr/o2kPVRw5IJpoYe13hy70SbxgCAEr5EEvi2zVe50HHlZ0fl9aXkledBRJqO
         A+sg==
X-Gm-Message-State: AOAM530WUDqoy5U2op8Y7APqTU5Rpw2e4+0T5oN3+tIg1qzhDrIIp/7L
        vOY2zdt5+C5r1Cos2zo8iZd3x0j7DZ4dUebA9Sg=
X-Google-Smtp-Source: ABdhPJyOk1Llh4n/0AuvDW92FcJ4KCA5Dg8irNeNLfSJBQKoVDiCwkVNoz2H9/obehtEh0invVOFTnWEINdZyyr2PcU=
X-Received: by 2002:a37:9d0c:: with SMTP id g12mr8263523qke.264.1603570574548;
 Sat, 24 Oct 2020 13:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201008182713.2764-1-harshalchau04@gmail.com>
 <20201009045734.GA112189@kroah.com> <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
 <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
 <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
 <0eb6f48d05624c8abaf00ae1bd4d88a9@AcuMS.aculab.com> <CAFEvwu=76mPtXSEgpwSoRC0rC0tkU5BiEx1X5O2VwVSPJ7m4Rw@mail.gmail.com>
 <CAK8P3a0y5MjP7AXOpmqc7xpGFCSvTGWHPT_eev5OpJJGVcRVdA@mail.gmail.com>
In-Reply-To: <CAK8P3a0y5MjP7AXOpmqc7xpGFCSvTGWHPT_eev5OpJJGVcRVdA@mail.gmail.com>
From:   harshal chaudhari <harshalchau04@gmail.com>
Date:   Sun, 25 Oct 2020 01:46:02 +0530
Message-ID: <CAFEvwukjrxjPj5wUAv1ngCyu3yHPRqeOiB8ActopkQ4rfv7T0Q@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 12:51 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, Oct 24, 2020 at 5:54 PM harshal chaudhari
> <harshalchau04@gmail.com> wrote:
> > On Tue, Oct 13, 2020 at 4:42 PM David Laight <David.Laight@aculab.com> wrote:
>
> > So I am a little bit confused about this check whether it's required or not
> > Please could you point me in the right direction?
> >
> > In any case, thanks for your help ...
> >
> > Here is a driver source located in: linux/drivers/misc/xilinx_sdfec.c
> >
> > static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
> > unsigned long data)
> > {
> > struct xsdfec_dev *xsdfec;
> > void __user *arg = NULL;
> > int rval = -EINVAL;
> >
> > if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
> >                return -ENOTTY;
> >
> > /* check if ioctl argument is present and valid */
> > if (_IOC_DIR(cmd) != _IOC_NONE)
> > {
> >         arg = (void __user *)data;
> >         if (!arg)
> >                    return rval;
> > }
> >
>
> All of this can be removed, and replaced with unconditional
>
>      void __user *arg = (void __user *)data;
>      int rval;
>
> with an "rval = -ENOTTY" added in the 'default' case. This will
> make it behave more like other drivers, returning -ENOTTY for
> any unknown ioctl command, and returning -EFAULT for all
> invalid pointers, including NULL.
>
> xsdfec_dev_compat_ioctl() can removed as well, with the file operations
> changed to an unconditional (removing the #ifdef)
>
>       .compat_ioctl = compat_ptr_ioctl(),
>
> This will not affect behavior, it's just another simplification.

Thanks a lot Arnd. Got the point. and i will make the change
and i will send it to relevant maintainers of that driver file.

Once again thanks!

>           Arnd
