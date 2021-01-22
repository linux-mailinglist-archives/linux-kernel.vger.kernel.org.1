Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09D430006E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhAVKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbhAVJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:34:18 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5740C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:33:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s15so2861094plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FM+2hrQKzw0+jV5nK0rdpq8894a2bIFKc/lfKkTBg4=;
        b=Qkv/g5VOtL445v3qxViP0S9pKFycyrdbBVhtCnbhqIAzCFYReBkfsNzIDkIdKJWX5S
         3uViOqQRWClQh9WgtQXvHZD9sPUhgHqDsZHwWRDkY8NDXd+COqI6ZMUc+98mgCWiVmzW
         G3/BSsm3KcV5jbNTQbFi3R/GUBmncr0IH9t294fXuGHMQ9W2v5G9SdfRtT2LdSWT61R1
         uoUkrNwrrVCLsC/wkpo2xq19X7xPh719QeHaFRuci0M3cYN+2WLnFfPBGTeD28cvyRRQ
         RPPN7vrtNT4pWidbJQibKP3A86F8+NVho7Kf4ZGaLeSbrg8yPb2Cz517puQhsMhA2+Ql
         zNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FM+2hrQKzw0+jV5nK0rdpq8894a2bIFKc/lfKkTBg4=;
        b=k4CXGBqLUiLyvYPU+cY7FN9zB50Js7D/VlZVyLRgSrXh7WiQ5YcB+hPTw/QRGTOnVM
         UzQM5JwwxpYGeuCuXrS4GeUHkLrZvFG8FFPXFPTfAb0aTI0jz5EFbqb3vo9BW5gJv0pj
         3j/EVg3vwx9BVOxikBoz0kZwoosr/PcseaRU8LxwjH/6E92ljkn2qq5t7SiyW1amP4vQ
         Z9OkVP0GwqGso1rPYATevh6BNfxKIfooszaAmHVEJlGkpF48Gl0hzBYJ5LlTaEp2xUAK
         jyM1OoYmSay3qFqa9E9MUhd0gMiJxWK6Kbkttyozcae61zqo32suABzqQsn/AHqd4Q4i
         HM6g==
X-Gm-Message-State: AOAM532xeiOZBo05z0quFVTxsAHkFNLSJqEGxgvnY2jfdO3NdLNbLFNo
        keGcAS74h/tHbrd2/QkLSALwXbCJ0DzmYGpinbHIbfizVBXwUg==
X-Google-Smtp-Source: ABdhPJyvbeDk2UJxxRhwKoU5cMux1++wIEIuux2n3uF2Mw+o6pfcGvUqe8SeH9+0rXZ5cO4UgFUl2MbjDv+rK30sQeE=
X-Received: by 2002:a17:902:758b:b029:df:d1f6:9af9 with SMTP id
 j11-20020a170902758bb02900dfd1f69af9mr4099067pll.21.1611308017333; Fri, 22
 Jan 2021 01:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20210121170736.2266-1-scott.branden@broadcom.com>
 <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
 <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
 <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com> <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com>
In-Reply-To: <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Jan 2021 11:34:26 +0200
Message-ID: <CAHp75VevqSSR7OWADkuQVtf2a-bK_f1fEHbB0W+y=N1e=08sgQ@mail.gmail.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 12:07 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Fri, Jan 22, 2021 at 5:35 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jan 21, 2021 at 10:31 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:

...

> > For the record, you seems haven't noticed:
> > https://lkml.org/lkml/2020/12/9/446
>
>
> Ohh, I missed it.
> I know many patches are falling into a crack.
>
> To respect the first submitter, and it solves
> another file, I just picked up Andy's one.

Thanks!

> I use Ubuntu, where /usr/bin/python is a symlink
> to /usr/bin/python3.

JFYI: on some forums / mailing lists it was discussed and Python
people are against this decision in order to prevent python2 script
breakage on Python3 platform due to Python language nature (you may
not notice problem until you got a traceback at some point).

> I just booted Debian in a VM, and confirmed
> /usr/bin/python no longer exists.
>
> Thanks for the explanation.

You're welcome!

-- 
With Best Regards,
Andy Shevchenko
