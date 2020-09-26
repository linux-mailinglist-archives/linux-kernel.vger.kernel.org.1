Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C892797AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgIZH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIZH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:58:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782CC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 00:58:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o8so1641257ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30pt3/plV21ez9XG1zPQRLkLMAh3JevcIb4p0H7YqLE=;
        b=mNrK25T4y2Wy1M1VbeJwGkc2bnTzBljG+f+yWcgd0MhxCytvY4UBQ77SmbrFxl3tyw
         RopZrP/i9A/8qg/8Z2MFXKM0y+rlrsBaA5XMJkc9rHH1uatrvj3G07UIckxMvG+osvzd
         wYPQoqlV/A3vQmqW+oZ2+RmY6WB3rhQzAQal9/lQ/qf8ah5rtIUTPqpgLwLSeZ8VuyGx
         sRZeF3+cOr6/jPsClCjNFuqRko2tOgyLEnKwKJ8oRbo+49kfDnCj+zOYjs7KeP30LaaR
         DLselbtaU0V9Dv1rM6Scz57SuPdWGSZpl9nlViLy/SscjqHZu5yuEWz7c5+pm54JSNBS
         cTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30pt3/plV21ez9XG1zPQRLkLMAh3JevcIb4p0H7YqLE=;
        b=JzATwZTm67Wd7gWHO55iRSoavJbv0T6g4V54kDI3J1IRnhC5a0U/ftdp+Y4EPP2ccQ
         LGQCetGRuzm6RlIfq23ByAEtWxr7Tn5mhNi6DQv+VmzHNTaVH+DCrtYq2BgCykWUlz3A
         6SDx36U4votaf9fWF9Kg/NMp98Q9afQwje0Yh+uM8OlFvKexV+DVJUItcayR+cKDEbaJ
         Ygxh6V2XwSsOFI+4fsq+K55aZDUJvczNcgeDybNt1LEsLgdza7klCXHSvp0a35YkBo4F
         A2U3YiuRuBEbsTpYinRetZr0/TKeVAA66Ct7VUBn7m4LGH8DCTGsMOTItbBeF9WG+0CB
         LiIQ==
X-Gm-Message-State: AOAM5333XeA14ff28HDNOxIeOzQmGjsfxOBG+qwUJeEERHjPr1fva6wL
        e60XTNiw3cEAc7mAljMf+lxq3s/N3gJAMfD1ub8=
X-Google-Smtp-Source: ABdhPJwYywP0LrGBqPEAn0TebQyOISg+LCkpGuH869jgderXmE0ARm626+PtoRACZbP6DqGaoAkdqhLyWWsuy1OetLQ=
X-Received: by 2002:a17:906:d11a:: with SMTP id b26mr6282486ejz.191.1601107093982;
 Sat, 26 Sep 2020 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook> <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook> <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
 <202009251647.FD8CECD4@keescook>
In-Reply-To: <202009251647.FD8CECD4@keescook>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 26 Sep 2020 13:28:02 +0530
Message-ID: <CAOuPNLif93a1uHhqsKFwhd35nfCnmRu_uxpB62shOEKyQ96hNw@mail.gmail.com>
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

On Sat, 26 Sep 2020 at 05:17, Kees Cook <keescook@chromium.org> wrote:
> >
> > For a 3/1 split ARM kernel of the typical size, all kernel virtual
> > addresses start with 0xc0, and given that the kernel is located at the
> > start of the linear map, those addresses cannot change even if you
> > move the kernel around in physical memory.
>
> I wonder if this is an Android Common kernel? I think there was %p
> hashing in there before v4.15, but with a different implementation...
>

Hi,
Thank you all for all your reply and comments so far!
Here are some follow-up replies.

>> What device is this? Is it a stock kernel?
This is a Qualcomm Snapdragon Automotive board one with Linux Kernel
4.9 and one with 4.14.

>> Is the boot loader changing the base address? (What boot loader are you
>> using?)
Ohh I did not knew that the bootloader can also change the base address.
I think it uses UEFI.
How to check if bootloader is doing this ?
BTW, both 4.9 board and 4.14 board, uses same bootloader.

>> I wonder if this is an Android Common kernel?
It uses the below kernel for 4.14:
https://gitlab.com/quicla/kernel/msm-4.14/-/tree/LE.UM.3.4.2.r1.5  (or
similar branch).
==> The case where symbol addresses are changing.

kptr_restrict is set to 2 by default:
/ # cat /proc/sys/kernel/kptr_restrict
2

Basically, the goal is:
* To understand how addresses are changing in 4.14 Kernel (without
KASLR support)?
* Is it possible to support the same in 4.9 Kernel ?

--
Thanks,
Pintu
