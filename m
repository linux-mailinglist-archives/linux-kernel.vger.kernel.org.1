Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0F2B95DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKSPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgKSPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:11:11 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBFC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:11:09 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id k26so6678205oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdqkWSW9a1z1SVdGoG8hy8zdS0knZMDZmMXxm1Wmdt8=;
        b=KrpNjX0WODmJF84y1iHPQX2qZzuES2LX2P221m9sJNTfwuwxu6hpK4JWFdrL2/H5lY
         Pu2WuXCypBceXoEf03QRJdC7ZJdypKeOjpID7SvyV9Kp8PqELasCnGMV2vabViZccRXg
         Z3lf1rvu/Q6tKBeVdO3AFO9IamwuuvldZgG68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdqkWSW9a1z1SVdGoG8hy8zdS0knZMDZmMXxm1Wmdt8=;
        b=FUPMZunuyFhx/yLrotvCLuotOISwID7kEFj4VQu8XrzWczkM/GeXRFXnDcuCGUGb0L
         voJZlsvHYySKiM+9mjw2NNdOMUSUrxftOTENWGXC4TBqHp4bZsBKOzE1VqrD3GC5gaM2
         Yi5QrU8rGXBuCymCx/cVNH4ax016jFSFyqnoYc/YQLUMQByZk/BntgBTjqv8Mp1GADkL
         VkbMpNF366eJnlhQywaPPK1t3JHwS1MlalMcPIaxRkMt+Dl6uSoMvumFdGTx/pkkvNy4
         RY69ruKxmFXv4Flncs66tgb8P48EjEPiDzGoI0r4oJjVbZrzLRxsoEmOe+Q8rg3cKRJ9
         YAzg==
X-Gm-Message-State: AOAM530JslfHVyZzmpvw4LO8B6b8H4ktOgew9/X6WfHe9s2qTvIiR2KK
        NbvUZ3TMP+2fNPp62XpZecoJGoM/Xv6pl2AN3LQL4qglQSg=
X-Google-Smtp-Source: ABdhPJyc3DHapCPUR/HHhc1a36YrqgEuXr50FTsLT0tmaXXDtJYaO8t+L+SGEMGffyuWBGHKy8w0p+PMlAMqkU19f0Q=
X-Received: by 2002:aca:7506:: with SMTP id q6mr3200770oic.128.1605798668916;
 Thu, 19 Nov 2020 07:11:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605169912.git.yepeilin.cs@gmail.com> <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com> <20201114081021.GA11811@PWN> <X6/K/S9V7rj2hI5p@kroah.com>
 <X6/L/lE2pA7csBwd@kroah.com> <20201119083257.GA9468@PWN>
In-Reply-To: <20201119083257.GA9468@PWN>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 19 Nov 2020 16:10:57 +0100
Message-ID: <CAKMK7uF_AOrfTDVZwmxn_C-5sTBDu_v9KGH07wO5hTa98Z8Ucg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 9:33 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> On Sat, Nov 14, 2020 at 01:22:22PM +0100, Greg Kroah-Hartman wrote:
> > Ah, here's a hint:
> >       https://wiki.archlinux.org/index.php/Linux_console#Fonts
> >
> > The setfont tool should help you out here.
>
> setfont seems to work fine, I tried Georgian-Fixed16 (256 chars) and
> Uni2-VGA16 (512 chars) under /usr/share/consolefonts/ in my Ubuntu box,
> including setting all consoles to the same font:
>
> for i in {1..6}; do
>         sudo setfont -C /dev/tty${i} /usr/share/consolefonts/Georgian-Fixed16.psf.gz
> done
>
> Font rotation also seems to work fine:
>
> for i in {1..4}; do
>         echo $i | sudo tee /sys/class/graphics/fbcon/rotate
>         sleep 1
> done

Thanks a lot for checking all this.

> One last thing I can think of is tile blitting, but I don't have the
> hardware (e.g. a Matrox G400 card, see FB_TILEBLITTING in
> drivers/video/fbdev/Kconfig) at hand, nor did I figure out how to
> simulate it after searching for a while.  However based on the other
> tests above I believe vc->vc_font.charcount is set properly.

tbh I'll just go ahead and delete it if it's broken :-)

Userspace we have to keep working (and there's actually people
creating new products on top of drm display drivers using fbdev
emulation and /dev/fb/0 interface!), but kernel internal stuff like
fbcon acceleration we can trim pretty aggressively I think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
