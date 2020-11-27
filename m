Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FEA2C6A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbgK0RRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbgK0RRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:17:05 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5624C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:17:05 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id y24so5284503otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVf1+D1FitCmzDCqljbAyGPy2s/xJk5tkKzZBsWqVg8=;
        b=ToKoCtwL5hrCEbaN1epEGxz/qIabnwThN4AoMKbt9bAZDVg5Ev2ATQfgVdNXlmtvfX
         biCWTB+b1EKb9p8bSEKJWCxN0WfFwejxuMiBuBDeF3xs9oXgcQWfPQSD0V77rU8P5uqt
         SBDV/kA3FIFd390L+H5szLjGIR1oIxiN+56vKhFPEVhLFD85U6KGSSOmVxJkuK1Z/w+R
         uxRXLGINPxkU3SPyVMwZt5e/hY4Uzfi1WME8U9tQMeBmRiLjVMQ1MGHHCTTQleg+dYCp
         b+Ck+nsvHxDZ3FCwLEM/tJhJsg4yfNHwkbgTEFqIy5rD45Z6O2Sh6jrl/X/2ppijiGaC
         4zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVf1+D1FitCmzDCqljbAyGPy2s/xJk5tkKzZBsWqVg8=;
        b=GsTTkMRapsqekU4vzBsDlc85AGVeVUZpqIhwbiu93DX5LQ1Gln6pATy3FlUl7W2SxA
         3Ln2CfuwoizMOnVVGQw5UMX/GEyer33V+hhTb4m8AlKwb7sXRLrcS0N/woUfemrfuopd
         +pkeHUiXVWNJxzxCYt72Enm+5+P3W8M1WyqWMdHgl6/A3gHXkxTlYHpDv2z85eIVm/k0
         zoWoxXYFsts0GjrPti0lYfYCvkdvAZOG2wOkSrWIjSBJJ+SJaE2P82GRDarzuJzfmGu2
         Mhq/7N4y2MNHoQlgWhy07N9fi18MVs6kWyLwhM7RAz0UfMOz+MuQbdvDIIkWuTa1E1y9
         nj5A==
X-Gm-Message-State: AOAM5305iMnZkO1eFrl3i+mHOT3eOYo+RF5m+BUyo9ubzHr7kgykCgkr
        8+pV7G+tbMZTh0gZWhm80SNuhaFYFLNhHESMrl1c2gok4As=
X-Google-Smtp-Source: ABdhPJzxVnhEqWmwFdGU1bsYOr7tgQEutpm8lSGGPb+njqBUECMoiOZ1IA/9ZfeZKoGt5uAgNB1ZyNyKSVqee4Lp/pE=
X-Received: by 2002:a9d:889:: with SMTP id 9mr6794559otf.6.1606497425150; Fri,
 27 Nov 2020 09:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20200429165347.48909-1-rminnich@google.com> <7171837.EvYhyI6sBW@sven-edge>
 <CAP6exYKEN-sQXGxTC1CSzfyuYmbbMPHKEosCP7DciFTLOhAFCQ@mail.gmail.com> <2666350.AiC22s8V5E@sven-edge>
In-Reply-To: <2666350.AiC22s8V5E@sven-edge>
From:   ron minnich <rminnich@gmail.com>
Date:   Fri, 27 Nov 2020 09:16:54 -0800
Message-ID: <CAP6exY+hHrVvaMcF2tWUUJT=JS_J9NHx=92DzO=GAN==ACSh1Q@mail.gmail.com>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or
 more colons
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        jstefek@datto.com, Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah ha, I see how different my world is from yours :-)

My world is linuxboot, which means the command line is always under
control of linux, as linux is my bootloader. So this kind of thing is
very easy for me to change.

Let me go back to the initial problem and hope I can make better sense.

The original problem was that ':' was used to separate the device from
the partitions. A problem came along in that PCI device specifiers
have ':', and the original parsing code broke. The patch that caused
you trouble fixed that by using the right-most ':' as the separator
for device and partitions.

What none of the people involved in the original patch knew was that
there would be other ':' in use. Sorry!

But you are right, my idea is a complete non-starter, don't know what
I was thinking.

So it seems your patch, if it works, is the way to go? I can't think
of anything better that lets us preserve current behavior and support
PCI device specifiers?

Ron


On Fri, Nov 27, 2020 at 9:06 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Friday, 27 November 2020 17:32:02 CET ron minnich wrote:
> > I'm a bit worried about how tricky this starts to get. I'm inclined to
> > go back to an earlier implementation which used a character that had
> > not yet been used (iirc I used [] around the PCI ID in a very early
> > version). What if we used, e.g, a single ! and searched for that? It
> > need not be !; pick a character. Just something not already in use, as
> > the ambiguity around which ':' delimits the device has become an
> > issue, as you show.
> >
> > Almost nothing in the original patch would change, save the character
> > being searched for. By using a character we'd never used, we'd avoid
> > breaking existing usage.
>
> What? Doesn't make any sense to me. The mtdparts shown in the the commit
> message is as it is. I cannot simply change it because it is in the control of
> the bootloader - not the linux kernel or me. So I can also not introduce a
> different character like ! for separating things.
>
> KInd regards,
>         Sven
>
