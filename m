Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3262D27AF54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1Npg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1Npg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:45:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:45:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p15so8565073ejm.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oYLNU2owXItYr9P/AcypoLK4YHCnMHvEUEZ0T21Kmw=;
        b=BNVdcEwmKLu7UYdR5qEDszaHp8AwI5/LgsYb7Hsdtjf7D6i3k7AeC78Jo/GaShyX40
         PQp0zwjoAscJL836jYurIzDYfagXQ9Q2Q3zMYgBzhS6uPDvLnRht11A1HYT5uLviDzlq
         zfTbKGWHeztMEoUQt0x6zGuswkmdnfDRKnVUODUGJoa42OebAGOLt9f1TRaOUqn3/pUo
         yo8QuGFykfpZdiU2PziKjCdLoAt4hVRr+wdmIGvw0LMT+UeyOML9+2iPZegCefE5jsGW
         7G7kwdnV88wpbmLrdHWwxe1C9ck44FX6rUFcXAjWeiSbTW4wgKmSTA7vtbdaNvTamRCF
         uDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oYLNU2owXItYr9P/AcypoLK4YHCnMHvEUEZ0T21Kmw=;
        b=PZhbtZc8KdMY2k+Pzn9np7S4X6uJOXeMcjPczLq7ziirZmddgN4aP/ToQX9UC9QJOc
         uxd9GJF0kQePk+MyyKPpukzCFVo0O4x3cPp4vnMgTUYt/FWawrhv68JMOkYRwFPwgo3b
         SBsQUGi6975NbaTbvMwGKQEvWjfbyI8MP7UuyAmFVtEz64pXRgDVWXQB7gIV08DzeAaQ
         ny9LhlYd2qOxo1j7GBlePOBP1TN5WezOGUZNO8JoqM+q5CKVUysACdL4dTpZ6AigNIvF
         9G2MF8elOfuLjg6pPRjmjia0HG+Ii0r13GW+D0hapXPyzLonUX9sdrXHEraHelaYNcjE
         WNtA==
X-Gm-Message-State: AOAM531+jT50CM07QMV0OfEunjoz3+mdyYvtXA0JI4Wtz/sSihmX0kq1
        nOomRldgsISfdRyTrnro+0GrY7E3XNl+I1hDKYc=
X-Google-Smtp-Source: ABdhPJyUtjxTt6+MXoHHOw+wBmFQ0H6ldEi6lU+XXFNWOxLIdQofZk+MD8H9mvrP4gIxCYsb4i63/1jUgoRiERxUheE=
X-Received: by 2002:a17:906:e24d:: with SMTP id gq13mr1671104ejb.152.1601300734379;
 Mon, 28 Sep 2020 06:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook> <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook> <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
 <202009251647.FD8CECD4@keescook> <CAOuPNLif93a1uHhqsKFwhd35nfCnmRu_uxpB62shOEKyQ96hNw@mail.gmail.com>
 <202009260933.C603CD8@keescook>
In-Reply-To: <202009260933.C603CD8@keescook>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 28 Sep 2020 19:15:23 +0530
Message-ID: <CAOuPNLiM+ghH_7eNkAfA=jDgHrc+2_jB_n3FvYG-JMN0EiNfGA@mail.gmail.com>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, matt@codeblueprint.co.uk,
        nico@linaro.org, Thomas Garnier <thgarnie@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 at 22:10, Kees Cook <keescook@chromium.org> wrote:

> > >> I wonder if this is an Android Common kernel?
> > It uses the below kernel for 4.14:
> > https://gitlab.com/quicla/kernel/msm-4.14/-/tree/LE.UM.3.4.2.r1.5  (or
> > similar branch).
>
> Okay, so yes. And this appears to have the hashing of %p backported. I
> cannot, however, explain why it's showing hashed pointers instead of
> just NULL, though.
>
> It might be related to these commits but they're not in that kernel:
> 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
> 7bd57fbc4a4d ("vsprintf: don't obfuscate NULL and error pointers")
>
> > ==> The case where symbol addresses are changing.
> >
> > kptr_restrict is set to 2 by default:
> > / # cat /proc/sys/kernel/kptr_restrict
> > 2
> >
> > Basically, the goal is:
> > * To understand how addresses are changing in 4.14 Kernel (without
> > KASLR support)?
> > * Is it possible to support the same in 4.9 Kernel ?
>
> Try setting kptr_restrict to 0 and see if the symbol addresses change? I
> suspect Ard is correct: there's no KASLR here, just hashed pointers
> behaving weird on an old non-stock kernel. :)
>

Okay. Thank you so much for your comments and suggestions.
You mean to say, setting kptr_restrict to 0 may avoid changing symbol
addresses in 4.14 ?
And, sorry, I could not understand the thing about this "hashed pointers".
How can I check this behavior in source code to understand better?
Is it possible to give some reference ?
I wanted to disable this hash pointer on 4.14 kernel and check the behavior.
Also if possible, we would like to make this similar change on 4.9
kernel as well.


Thanks,
Pintu
