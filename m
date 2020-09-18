Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41AC270064
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgIRPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:01:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4BC0613CE;
        Fri, 18 Sep 2020 08:01:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so7152788ioa.2;
        Fri, 18 Sep 2020 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ueNKaDShpIRFMlqpId/qjUXAnjNovMg7//TW7VMdNwE=;
        b=HVomqNkH9fjmpdVFa00o7WWRQDW8pd4dSb3yMqpbHDo13MRPJZFYw2nW+N95Bnvx9h
         uGMlX6rV5lW0Eh6GU3GbpDmxL8/kGsFaQjktmQLAZIdVMdfNLfmZMtzxD2BSSyBB900I
         W64GHqiXeVAGg4ZuGA4FcyHse/z/ZuHMHW/PqbnbTpanE0H3b7m3mm3kmIZr46ww1Trk
         mdme9eUeks/VcIYNvO3cViVqWXVZSNsUBLUY0nt0IEg71EBRVZOv6YdzNsFEI9L5vSub
         AALuUZ1G5y5xXr5RLolDUgb8IpC4BT9a1qRaOjYKutv09nce7VQbFo/p6nzT34DJ8Rro
         PIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ueNKaDShpIRFMlqpId/qjUXAnjNovMg7//TW7VMdNwE=;
        b=DhMb7JlMk51mMcUpTYDnwFN8iZ3EeR+AZsp+sFsicrxHfOvvoJN/FV4gRZGchji5fn
         JzmHrT0pEKbuP2FVV0JbD4Nbh4RBwgsTF0S0Pr5YYlIHsef2cnMotdP7i+n6L4eozv4y
         e6qjhPe54k06aell1BC1njQZZQURMRcSBR3XGt8h0JZCr7tfZL6L3mnk6iW8Bc8/sCzW
         QgcrkVtFW4ADvqwjuAYJJM5W0hwnY8MhKG0hOvsRFQzPEocT59IfobTofR4Qsqx2kZR0
         p1LdsHOvnj2Ep97yemtfM7jzWyo1QnGM8kQ/iuZm561QBLEhqO15PZwwMJqAPfm3nWT+
         bTNQ==
X-Gm-Message-State: AOAM532BvGspn/T6GmgQWi38B6k7jIzsmWbt2BHtkHgZDMpB7khKcdKj
        1SZzM0LTsZy6aaojINfIb93ZFpgJ7Q5xoL3jHt0=
X-Google-Smtp-Source: ABdhPJyznMbeRUByPOlP3l7UP5aSu7ipHEDRQMZC0iihbgUHSRxFze8vy2FEHfUsI1IX+5fuJCUXkrhNgiBNVb2HE1A=
X-Received: by 2002:a5e:890c:: with SMTP id k12mr27273847ioj.75.1600441274447;
 Fri, 18 Sep 2020 08:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEt1Rjq+Fz85KU-aKO+boNE5yL7GiwdopmRd3-FxEL+mzEui-g@mail.gmail.com>
 <20200907155052.2450-1-yazzep@gmail.com> <20200907155052.2450-2-yazzep@gmail.com>
 <20200908190402.GA797206@rowland.harvard.edu> <CAEt1RjquJZzTctN6dNQSDbUZ9YG2FnEtzTZsoA3a9RtXHxwUmA@mail.gmail.com>
 <CAEt1RjpGcZ4T70tr83pmcD--PzAMboBkbv55qFcRfMz11ZUggw@mail.gmail.com>
 <20200911151228.GA883311@rowland.harvard.edu> <20200915094531.GA8046@lxhi-065.adit-jv.com>
 <20200915110111.GA269380@kroah.com> <20200915145258.GC1002979@rowland.harvard.edu>
 <CAEt1Rjop72j8Hb8s+yW5edfF0+dSV2DQHtqsPoK65QQ-+HRwZg@mail.gmail.com>
In-Reply-To: <CAEt1Rjop72j8Hb8s+yW5edfF0+dSV2DQHtqsPoK65QQ-+HRwZg@mail.gmail.com>
From:   yasushi asano <yazzep@gmail.com>
Date:   Sat, 19 Sep 2020 00:00:10 +0900
Message-ID: <CAEt1RjpNHPuV8T2ufkHw4hk9otJXKdm-mAddxHCir6_+q2tXvg@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan,
Could you please proceed with your proposal(Kconfig option)?
After all, Customer products need to get USB certification.
Thank you for considering my request.

2020=E5=B9=B49=E6=9C=8816=E6=97=A5(=E6=B0=B4) 19:16 yasushi asano <yazzep@g=
mail.com>:
>
> Dear Alan
> Dear Greg
>
> Thank you very much for your feedback.
> I understood that there is a gap between real system and ideal specificat=
ion,
> and the Linux community stands on the real system side.(of course).
>
> I really appreciate your proposal(Kconfig option).
>
> > But let's start with
> > testing the patch I sent you.  After all, the first step is to get
> > something that does what you want correctly.
>
> The patch you provided worked fine.
> https://marc.info/?l=3Dlinux-usb&m=3D159984230312068&w=3D4
> An excerpt from dmesg is as follows.
> It detected the enumeration failure after 27.7seconds since the test star=
ted.
> so,the PET test passed. [2]-[1] =3D27.7seconds
>
> [  111.482541] *** Setting Test Suite ***
> [  130.226648] *** Ready OK Test Start***
> [  134.808206] usb 1-1.1: new full-speed USB device number 7 using
> ehci-platform ... [1]
> [  140.034944] usb 1-1.1: device descriptor read/64, error -110
> [  140.118069] usb 1-1.1: new full-speed USB device number 8 using ehci-p=
latform
> [  145.155142] usb 1-1.1: device descriptor read/64, error -110
> [  145.163074] usb 1-1-port1: attempt power cycle
> [  147.037094] usb 1-1.1: new full-speed USB device number 9 using ehci-p=
latform
> [  152.323168] usb 1-1.1: device descriptor read/64, error -110
> [  152.407069] usb 1-1.1: new full-speed USB device number 10 using
> ehci-platform
> [  157.442518] usb 1-1.1: device not accepting address 10, error -110
> [  157.527067] usb 1-1.1: new full-speed USB device number 11 using
> ehci-platform
> [  162.563123] usb 1-1.1: device not accepting address 11, error -110
> [  162.571302] usb 1-1-port1: unable to enumerate USB device ... [2]
> [  176.523060] *** End of Test        ***
>
> 2020=E5=B9=B49=E6=9C=8815=E6=97=A5(=E7=81=AB) 23:52 Alan Stern <stern@row=
land.harvard.edu>:
> >
> > On Tue, Sep 15, 2020 at 01:01:11PM +0200, Greg KH wrote:
> > > On Tue, Sep 15, 2020 at 11:45:31AM +0200, Eugeniu Rosca wrote:
> > > > Dear Alan,
> > > > Dear Greg,
> > > >
> > > > On Fri, Sep 11, 2020 at 11:12:28AM -0400, Alan Stern wrote:
> > > >
> > > > > The thing is, I'm afraid that without these retry loops, some dev=
ices
> > > > > will stop working.  If that happens, we will not be able to keep =
this
> > > > > patch in place; we will just have to accept that we fail the PET =
test.
> > > > >
> > > > > Alan Stern
> > > >
> > > > Does this mean that Linux community leaves no choice but to ship a
> > > > forked kernel (with no chance of alignment to upstream) for
> > > > organizations which design embedded devices where USB plays a key
> > > > role, hence requires passing the USB-IF Compliance Program [*]?
> > >
> > > We are saying that if you ship such a kernel, we _KNOW_ that it will
> > > fail to work in a number of known systems.  I doubt you want that to
> > > happen if you care about shipping a device, right?
> > >
> > > > Is there hope to give users a knob (build-time or run-time) which w=
ould
> > > > enable the behavior expected and thoroughly described in compliance
> > > > docs, particularly chapter "6.7.22 A-UUT Device No Response for
> > > > connection timeout" of "USB On-The-Go and Embedded Host Automated
> > > > Compliance Plan" [**]?
> > >
> > > Given that the USB-IF has explicitly kicked-out the Linux community f=
rom
> > > its specification work and orginization, I personally don't really ca=
re
> > > what they say here.  If you are a member of the USB-IF, please work w=
ith
> > > them to fix the test to reflect real-world systems and not an idealiz=
ed
> > > system.  Last I heard, they wanted nothing to do with Linux systems a=
t
> > > all :(
> >
> > <irony>If the USB-IF were the final authority regarding USB devices, we
> > wouldn't have this problem in the first place.</irony> Every device
> > would respond properly to the very first port initialization attempt an=
d
> > no retries would be needed.
> >
> > But real hardware doesn't always follow the official spec.  And then
> > when it fails to work with Linux, _we_ are the people who get blamed.
> >
> > Alan Stern
