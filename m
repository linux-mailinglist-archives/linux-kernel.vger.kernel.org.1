Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0126E27975B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgIZGxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 02:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIZGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 02:53:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA45C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:53:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 19so4250548qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLvvuBRQdycEtX1hNlsAY1qAkWuLjqss4U5s0SXoGUY=;
        b=dift4Z8tjU0Ce445UABIK7WDYnjIgcajhY5rOF+2tGytUkEPkkEa7A4rek8uc784U5
         2K7tORos0wmqlyCuCNxxVtBDY81ztf4HcJwAfW/nXHDJXA128hBd6wrUQ6HBhlgcpmi6
         TVsqJ5aKCxifQschGqzTs1sP3eYfJenRITHy8vh27oUrsiGDVdPgBVo5/T7Obyul+95e
         SwUJvLx5qbXrkz1m1hHEUJoY6603wI4Izhy8J5s6UPxK7b84+FfGxWOi6X+fOYvl5uAY
         FAky6Diid1JSQHfxMrAAeoitNpKfFOLFevWya6wLIOVEWzlMAErhl55vcqsEAb4j5gal
         TJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLvvuBRQdycEtX1hNlsAY1qAkWuLjqss4U5s0SXoGUY=;
        b=ok4+HuD5QhXGGwYmQ5OMM4SCmn1izA7op+TfR1r20WD3dxGihRF4bISOirT6MX+1Ri
         lYShSaYGXy/605Q7p8VQswOOrhggkJiht2gbwFHO2khCpjHZHpyslfiyWwal93ddoa+Z
         opblue/K4raWC0jxKs+iLmL+7m9PozRxHnb4jOVIFxG9X6gcfyn5Ye07/55PIMrmx0Kj
         wolKYi/CJhdGPHDBYQzanaBsGt98Q9Ydd+UHz8yDWzyZK4FmDnWizQX9GzwbkXjNHCBa
         DREhSzUt03LU6Te66gyZ9Fv5hS+oQImT6HZ9Eb/Dvob8S1M01eOicD6oY+nLqGI8Zs+v
         95Pg==
X-Gm-Message-State: AOAM5301KMFEWEMg0S2HNR2fpXjGUkyKx7BiNPOGsgTe6cRGl/FPPpBA
        k/y0L1z1wGw/qMIBNViFna8RW0L8+0xLeA/XiT5oPA==
X-Google-Smtp-Source: ABdhPJzpV39Mkz7QDs8SD8oXqAzRHZ0eYUVMZqHjk8Ot7Lqe/Sgo098zK8WMZ9hvvjDCqMhL1J3xo5gPkXXyrgiEl0o=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr3297636qto.158.1601103198676;
 Fri, 25 Sep 2020 23:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAKBsNO=G_t6KrAYXcnMy07HyR8yrFELFoknd=9CnHBM-CJij=A@mail.gmail.com>
 <000000000000b8d3ef05b02efa93@google.com>
In-Reply-To: <000000000000b8d3ef05b02efa93@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 26 Sep 2020 08:53:07 +0200
Message-ID: <CACT4Y+aBTN3HzDWADsvD053T=qszSu5wGTCijM-kj9xZXDHTyg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in rt2500usb_probe_hw
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 5:25 AM syzbot
<syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-and-tested-by: syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         c5a13b33 kmsan: clang-format core
> git tree:       https://github.com/google/kmsan.git master
> kernel config:  https://syzkaller.appspot.com/x/.config?x=41fca8ac7f9e770a
> dashboard link: https://syzkaller.appspot.com/bug?extid=35c80b2190255a410f66
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>
> Note: testing is done by a robot and is best-effort only.

Hi Anant,

I see you are testing lots of USB bugs. USB subsystem is currently
broken, testing of any USB bugs will give false "no crash" results,
see:
https://lore.kernel.org/linux-kernel-mentees/CACT4Y+YmbmrH9gCCnCzP-FYa-dKxx9qhKZ+RQxi1f-+Hoj1SUg@mail.gmail.com/
