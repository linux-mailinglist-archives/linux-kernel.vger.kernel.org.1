Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D427EEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgI3QRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgI3QRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:17:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C54C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:17:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o21so1650777qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZY7IkOxUO2WtSrHCoZN7KXpMFh8Rwt0omYmTHUHNl4=;
        b=i7/525RLEklIyW3bA2LXx382jGzfNe95GLBndd9505PWMw9xr1wDofo7qjfs3kB9Pf
         9qnwJQxxOVHy+5RwvUHslqgBNJmATW5BV/DTA6Rpm9OEsnFAhh2SOq8evnWd9GvQq0I+
         B3MFKxgvsZvNbknoLD/ZqxQ6tEIolmOCJXXb0jGCph5SZHW2jmD9y27BF43y/5CNmzYu
         sQ+5kF35xp405EfTwPRUbILNBRSsabNIZIlIYox69xiXXdQMc/5t9NGkd5btnDuTWaRB
         LoaAetDrGqG2px22wE71GnTNX0lQ93ukkYWCA2wWUUp0u/vi4gOJenopnCdZiqTpTon3
         b9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZY7IkOxUO2WtSrHCoZN7KXpMFh8Rwt0omYmTHUHNl4=;
        b=EmXPwuTDTkQ2bOghSWpu6pTVFaWBvjxlByf0nKYlCyo5DETetbbQ8khcYcukgVa6Tw
         hbRgYAaGGcd+IGEZzTHJfVMWkC8gYIKODowAQkW638tLNRT686IF9p+2+BH9ld1UITD6
         iad1Us3rYG73ulCgKJMviWpX4Y9I8C48g3bTFgPmpIWNwPOO9nTsdWv9ntOovbvy4ogE
         JkIMdM7aK4WIYbRprxX8dF0O1tP97G4whN4snfgVZgisy8WTTPRQl3UXeDsIW7Xc2BkZ
         tzbFzgW8pzMi3o1h3VhzslhPS4MsPhRW+GJ9qutZ1T+KHGO81ggYR/ww5x24huzRmRwY
         ZRZw==
X-Gm-Message-State: AOAM5339vn5QIdpGMaOwcmUlBdTNzeDNPqrSe2k98cyAsy0T8UnYOggf
        e+LUY6er96BosudtKDSe8ZIEkU9DL5N9VXNjbuW6Ww==
X-Google-Smtp-Source: ABdhPJxBEkBgZgKjnM7X/Mmh3bTRF1FeA7vARxKZypuzswiC74hpD6oVnVF4qSdlYjVuxr+tF4ZYhzExMKNZwMjmbsI=
X-Received: by 2002:ac8:5215:: with SMTP id r21mr2978567qtn.257.1601482621148;
 Wed, 30 Sep 2020 09:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAKBsNO=G_t6KrAYXcnMy07HyR8yrFELFoknd=9CnHBM-CJij=A@mail.gmail.com>
 <000000000000b8d3ef05b02efa93@google.com> <CACT4Y+aBTN3HzDWADsvD053T=qszSu5wGTCijM-kj9xZXDHTyg@mail.gmail.com>
 <20200926065704.GA661191@kroah.com> <f7073a07-d00a-8f0e-c9b1-7878a3c065f8@gmail.com>
In-Reply-To: <f7073a07-d00a-8f0e-c9b1-7878a3c065f8@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Sep 2020 18:16:49 +0200
Message-ID: <CACT4Y+a3-_C3MJtyo1UC6NcwNPnU2bmhGeGKo7OPh54CVkq1CQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] KMSAN: uninit-value in rt2500usb_probe_hw
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Andrey Konovalov <andreyknvl@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        syzbot <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 5:57 PM Anant Thazhemadam
<anant.thazhemadam@gmail.com> wrote:
> On 26/09/20 12:27 pm, Greg KH wrote:
> > On Sat, Sep 26, 2020 at 08:53:07AM +0200, Dmitry Vyukov via Linux-kernel-mentees wrote:
> >> On Sat, Sep 26, 2020 at 5:25 AM syzbot
> >> <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com> wrote:
> >>> Hello,
> >>>
> >>> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> >>>
> >>> Reported-and-tested-by: syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com
> >>>
> >>> Tested on:
> >>>
> >>> commit:         c5a13b33 kmsan: clang-format core
> >>> git tree:       https://github.com/google/kmsan.git master
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=41fca8ac7f9e770a
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=35c80b2190255a410f66
> >>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >>>
> >>> Note: testing is done by a robot and is best-effort only.
> >> Hi Anant,
> >>
> >> I see you are testing lots of USB bugs. USB subsystem is currently
> >> broken, testing of any USB bugs will give false "no crash" results,
> >> see:
> >> https://lore.kernel.org/linux-kernel-mentees/CACT4Y+YmbmrH9gCCnCzP-FYa-dKxx9qhKZ+RQxi1f-+Hoj1SUg@mail.gmail.com/
> > Fixes for this USB problem are in my tree now and should show up in
> > linux-next on Monday.
> >
> > thanks,
> >
> > greg k-h
>
> Is there any chance you could identify the commit that fixes this bug?
> It would help us close the bug for good. :)

I think Greg meant the fix for the general USB brokenness, not a fix
for this syzbot bug. This bug is not fixed to the best of syzbot
knowledge.
