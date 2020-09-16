Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB426C191
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgIPKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIPKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:17:55 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F5C06178C;
        Wed, 16 Sep 2020 03:17:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y2so5930352ilp.7;
        Wed, 16 Sep 2020 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hW6e225ijIrEmLkhjbGVuIZvBM+RSB3R3ImDbnUzot8=;
        b=Yvj+jhCX3XKId2mi6F3O/iS4wvJQVHSzqADg4yKDRqqW3QfXKlAySlc8eQiH07XrGJ
         uxxkbW9sCDIW+odUB5ConUwdQ59wFckut5NIVKB+We3cYn3/wy1kfyp7A5myfdKc/g1x
         qeuqQQ++ooSltJ/NcuAd/IGqIYtwXTufg9E+aWPY5Jsc5Wdmy93tjA5Myh+1+B9tRVWm
         3d5ibW+l5OHya3eSG8RMweI3o2HPtKjK+C51OoKdc5JBJYhR4LQuRgQbqsDa5PRhr1bx
         HNUpw6Wf02a5kMmPQW6vMo/1Z4UtdEPgibOm6FgMucXw6i+TzVsq5p1GxkHe/ZkVGhiY
         cFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hW6e225ijIrEmLkhjbGVuIZvBM+RSB3R3ImDbnUzot8=;
        b=bQBVRtMXGhhvnxw4uTGmecJNk6Dgnj7Cz8rBZl5+MJSldGBETvKDBJPK4FqGnZuczL
         FgVMmZFxkRle7uYoLEAKR9/WV+x545h/YDWhf15qvWSoiAUJiPXsUfJNS2jc4hSEO0Ua
         afQub8tvUyZ4n+39W7ZYl5m4O2hMxCtusGTknvqYZzqstqR10xBfN5WMQyvLskWVd9Kp
         t/gnQCUqzJocytPh2HHhbKvYnhp0hSjcIV8cXzqXQTjfa0K+nP7Rv7y5cdCeeSjdOvJm
         cQkzaa/tLhKZW1fKquYPAj9ICO9up9Bp23OFYGEJckdo9ZeZvt2MCU6HhZftsmE6Gc14
         yy6A==
X-Gm-Message-State: AOAM533hB0b4/VHNBhGiMR12pVMTQxUqKrsspNTqjrZ5tOD7ALHFdtvL
        9YZAez1bz/yD8Xgm+44woFJM0IrMqZfklwVAYqsqOxqEo+MIew==
X-Google-Smtp-Source: ABdhPJwgeXw7cH6/4tJhD9dQcHPMy5Fw0lx3J5BYxdms+cUD4V+jUWNg7NGm8QNBEZE9nTPcBazKKLCyixUuIU0XrOE=
X-Received: by 2002:a05:6e02:1210:: with SMTP id a16mr14597556ilq.183.1600251465924;
 Wed, 16 Sep 2020 03:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEt1Rjq+Fz85KU-aKO+boNE5yL7GiwdopmRd3-FxEL+mzEui-g@mail.gmail.com>
 <20200907155052.2450-1-yazzep@gmail.com> <20200907155052.2450-2-yazzep@gmail.com>
 <20200908190402.GA797206@rowland.harvard.edu> <CAEt1RjquJZzTctN6dNQSDbUZ9YG2FnEtzTZsoA3a9RtXHxwUmA@mail.gmail.com>
 <CAEt1RjpGcZ4T70tr83pmcD--PzAMboBkbv55qFcRfMz11ZUggw@mail.gmail.com>
 <20200911151228.GA883311@rowland.harvard.edu> <20200915094531.GA8046@lxhi-065.adit-jv.com>
 <20200915110111.GA269380@kroah.com> <20200915145258.GC1002979@rowland.harvard.edu>
In-Reply-To: <20200915145258.GC1002979@rowland.harvard.edu>
From:   yasushi asano <yazzep@gmail.com>
Date:   Wed, 16 Sep 2020 19:16:44 +0900
Message-ID: <CAEt1Rjop72j8Hb8s+yW5edfF0+dSV2DQHtqsPoK65QQ-+HRwZg@mail.gmail.com>
Subject: Re: [PATCH v3] USB: hub.c: decrease the number of attempts of
 enumeration scheme
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew_gabbasov@mentor.com, Baxter Jim <jim_baxter@mentor.com>,
        "Natsume, Wataru (ADITJ/SWG)" <wnatsume@jp.adit-jv.com>,
        "Nishiguchi, Naohiro (ADITJ/SWG)" <nnishiguchi@jp.adit-jv.com>,
        =?UTF-8?B?5rWF6YeO5oGt5Y+y?= <yasano@jp.adit-jv.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Martin Mueller <Martin.Mueller5@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan
Dear Greg

Thank you very much for your feedback.
I understood that there is a gap between real system and ideal specificatio=
n,
and the Linux community stands on the real system side.(of course).

I really appreciate your proposal(Kconfig option).

> But let's start with
> testing the patch I sent you.  After all, the first step is to get
> something that does what you want correctly.

The patch you provided worked fine.
https://marc.info/?l=3Dlinux-usb&m=3D159984230312068&w=3D4
An excerpt from dmesg is as follows.
It detected the enumeration failure after 27.7seconds since the test starte=
d.
so,the PET test passed. [2]-[1] =3D27.7seconds

[  111.482541] *** Setting Test Suite ***
[  130.226648] *** Ready OK Test Start***
[  134.808206] usb 1-1.1: new full-speed USB device number 7 using
ehci-platform ... [1]
[  140.034944] usb 1-1.1: device descriptor read/64, error -110
[  140.118069] usb 1-1.1: new full-speed USB device number 8 using ehci-pla=
tform
[  145.155142] usb 1-1.1: device descriptor read/64, error -110
[  145.163074] usb 1-1-port1: attempt power cycle
[  147.037094] usb 1-1.1: new full-speed USB device number 9 using ehci-pla=
tform
[  152.323168] usb 1-1.1: device descriptor read/64, error -110
[  152.407069] usb 1-1.1: new full-speed USB device number 10 using
ehci-platform
[  157.442518] usb 1-1.1: device not accepting address 10, error -110
[  157.527067] usb 1-1.1: new full-speed USB device number 11 using
ehci-platform
[  162.563123] usb 1-1.1: device not accepting address 11, error -110
[  162.571302] usb 1-1-port1: unable to enumerate USB device ... [2]
[  176.523060] *** End of Test        ***

2020=E5=B9=B49=E6=9C=8815=E6=97=A5(=E7=81=AB) 23:52 Alan Stern <stern@rowla=
nd.harvard.edu>:
>
> On Tue, Sep 15, 2020 at 01:01:11PM +0200, Greg KH wrote:
> > On Tue, Sep 15, 2020 at 11:45:31AM +0200, Eugeniu Rosca wrote:
> > > Dear Alan,
> > > Dear Greg,
> > >
> > > On Fri, Sep 11, 2020 at 11:12:28AM -0400, Alan Stern wrote:
> > >
> > > > The thing is, I'm afraid that without these retry loops, some devic=
es
> > > > will stop working.  If that happens, we will not be able to keep th=
is
> > > > patch in place; we will just have to accept that we fail the PET te=
st.
> > > >
> > > > Alan Stern
> > >
> > > Does this mean that Linux community leaves no choice but to ship a
> > > forked kernel (with no chance of alignment to upstream) for
> > > organizations which design embedded devices where USB plays a key
> > > role, hence requires passing the USB-IF Compliance Program [*]?
> >
> > We are saying that if you ship such a kernel, we _KNOW_ that it will
> > fail to work in a number of known systems.  I doubt you want that to
> > happen if you care about shipping a device, right?
> >
> > > Is there hope to give users a knob (build-time or run-time) which wou=
ld
> > > enable the behavior expected and thoroughly described in compliance
> > > docs, particularly chapter "6.7.22 A-UUT Device No Response for
> > > connection timeout" of "USB On-The-Go and Embedded Host Automated
> > > Compliance Plan" [**]?
> >
> > Given that the USB-IF has explicitly kicked-out the Linux community fro=
m
> > its specification work and orginization, I personally don't really care
> > what they say here.  If you are a member of the USB-IF, please work wit=
h
> > them to fix the test to reflect real-world systems and not an idealized
> > system.  Last I heard, they wanted nothing to do with Linux systems at
> > all :(
>
> <irony>If the USB-IF were the final authority regarding USB devices, we
> wouldn't have this problem in the first place.</irony> Every device
> would respond properly to the very first port initialization attempt and
> no retries would be needed.
>
> But real hardware doesn't always follow the official spec.  And then
> when it fails to work with Linux, _we_ are the people who get blamed.
>
> Alan Stern
