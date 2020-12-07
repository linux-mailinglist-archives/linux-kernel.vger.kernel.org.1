Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE962D1493
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLGPWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgLGPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:22:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032BFC06179C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:21:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y19so6515979lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODpSoEmNbq4jUl3WGrBL/gHgU8LJBlKLzw2q3hitzfk=;
        b=EeF4TpNM5822R8wksasofMeoyAGWabpPMoSiBzdU/Ydxmhe4LTINP0VR/nGQwt7dtm
         2vU6AyNCymAM+ZOq3UuxHO/kRnyq4yjfwo1yh2/VQacut+0XoV/wz9Vrp6e6u6Ccd3B2
         LUwDHXYbCqBUKbu6Nyu0g6+VXnQ9BHEs8wBtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODpSoEmNbq4jUl3WGrBL/gHgU8LJBlKLzw2q3hitzfk=;
        b=cCDiSoZV8ZH4bqgewqKACB64rmQzObm8htIhicEvQIEs0rgygo6qCm+0xlNqgpJcAY
         O8D68BJRXjy1Vg+WldKrFsYvhtX7puKutHiyaBNbiyppo6aPNtHCcjjh9F9EqC+pT9A9
         TKKxol5k+poeo37EC1g/AN8JAI4VFrSoi19QoHEMu+r+wvVgZ8pKbbmzYme58bQujtTq
         HL+qaozBubpFCOF2B3Wf5Us+phN9rbtmhhCKH9uZPnP9qEN94xtmG9dTjk93q/0+S53h
         cDffgtPhVdV8STrSvfh3maLSoVbk03F45E1bCxYvbPGipME7u//sKxTHy66kyX8EvIMG
         ZS7A==
X-Gm-Message-State: AOAM530oji8yq47o6siMtSF/xStoW7CKzYd+4A1GAERo0E3qJnzl1Upo
        pCJtwBM3y2Wdc3HaFtlUQ4i6XCyI7PEkOkKHvPor7q1KUCaGKNmZ
X-Google-Smtp-Source: ABdhPJwHEC0oFuYU7tv2dbpbzD3yAaNJNYk53+CAspsxguKOIGKzL9HNaC3UZ29ttjNVccWUmOEKbNHVYH46OCKAx7E=
X-Received: by 2002:a19:8a46:: with SMTP id m67mr8042040lfd.515.1607354491520;
 Mon, 07 Dec 2020 07:21:31 -0800 (PST)
MIME-Version: 1.0
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de> <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de> <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de> <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
 <20201202220826.5chy56mbgvrwmg3d@linutronix.de> <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de> <20201203133934.37aotbdjnd36lrxv@linutronix.de>
 <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de> <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
 <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de> <CAM4kBBL5+xNWq6DWHY6nQjwDTj8PZKem-rGuFvimi7jekjA+Xw@mail.gmail.com>
 <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
In-Reply-To: <3ec93680c6a27626b23e99d552aa778be7b2ecec.camel@gmx.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 7 Dec 2020 16:21:20 +0100
Message-ID: <CAM4kBBJ2jqBKdTPWPZEfuc17yiARMr_NwOSoHL_r0eC9n7UpUQ@mail.gmail.com>
Subject: Re: scheduling while atomic in z3fold
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 1:34 PM Mike Galbraith <efault@gmx.de> wrote:
>
> On Mon, 2020-12-07 at 12:52 +0100, Vitaly Wool wrote:
> >
> > Thanks. This trace beats me because I don't quite get how this could
> > have happened.
>
> I swear there's a mythical creature loose in there somewhere ;-)
> Everything looks just peachy up to the instant it goes boom, then you
> find in the wreckage that which was most definitely NOT there just a
> few ns ago.
>
> > Hitting write_unlock at line 341 would mean that HANDLES_ORPHANED bit
> > is set but obviously it isn't.
> > Could you please comment out the ".shrink = z3fold_zpool_shrink" line
> > and retry?
>
> Unfortunately, that made zero difference.

Okay, I suggest that you submit the patch that changes read_lock() to
write_lock() in __release_z3fold_page() and I'll ack it then.
I would like to rewrite the code so that write_lock is not necessary
there but I don't want to hold you back and it isn't likely that I'll
complete this today.

Best regards,
   Vitaly
