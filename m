Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53322C0397
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgKWKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:44:30 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38131 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgKWKo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:44:29 -0500
Received: by mail-ot1-f54.google.com with SMTP id 92so12411200otd.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zg4vBn2BTnC6xfH9VgNqJXFdkto9KLIzrm0Lwwkr4I4=;
        b=EAq1inDsjyAGK/Exh/35BdwaXdi+8lOtx5dx6O2nKQQeE722c2patNwvQ57xUbXjO1
         slKTm+uDQdw/DG3IIUZjPD3KorJl53BWx1MoOAYCM5u9JvCHtH5lUgQM8SJSe/5smBT3
         WRjxl0UR63Km3CG91RSLZVv6R71FOR+w2G1eIAYEq1pyQhaYv2KHSwbs/mR30aTDQNCf
         X6bIyy4Bzq6bP5TXdONFwDMs4lDQF8pF0HgzMtGLgjy8izRzLAn0f/ssoxWEPtcGdfW5
         T45rDPs8bUYP8VF26Jy/vgbPIiwaqcShwb/yilsjnpz9qCkEbrn9Zz7fgykbl5sQ4LUz
         Oerw==
X-Gm-Message-State: AOAM532RIfg6ABN0dKNziBV7YfP4yLHV1GqaBNoDSt4cLBracLHa6NSX
        /h13+ZUADTAmhb1OXMQ1IyUXnwZxnh8PuLrQJqi0jrwbn2w=
X-Google-Smtp-Source: ABdhPJzVYzAUT/tPxRIBNmRftMqvyvjUNunaa9JXr6n4wC1KzJ+8Lq3erDyqquQurQGTVtwd80bQ7SidSky1dTXJSpk=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr21001859oti.107.1606128268658;
 Mon, 23 Nov 2020 02:44:28 -0800 (PST)
MIME-Version: 1.0
References: <551A9FAC.2010203@atmel.com> <f15a82c8-5960-34ea-e7fc-dffdfdd369c6@microchip.com>
 <20180823093045.00e751b0@canb.auug.org.au>
In-Reply-To: <20180823093045.00e751b0@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Nov 2020 11:44:17 +0100
Message-ID: <CAMuHMdUkQqJ_+8xy3q7tjCXCU4cZsnT7EOHtfTDroc4Ke0yPrw@mail.gmail.com>
Subject: Re: at91 git tree in linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Aug 23, 2018 at 1:31 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Wed, 22 Aug 2018 14:47:56 +0200 Nicolas Ferre <nicolas.ferre@microchip.com> wrote:
> > Alexandre Ludovic and myself are the group of maintainers for Microchip
> > ARM SoCs. The current tree that we have in linux-next is mine [1] and we
> > are moving to a common group kernel.org tree.
> >
> > So, can you please add our new tree to linux-next:
> > at91 git
> > git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-next
> >
> > instead of:
> > git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git#at91-next
> >
> > In addition to that, we also have now a "fixes" branch. Can you please
> > add it to your "fixes" tree?
> >
> > at91 git
> > git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-fixes
> >
> > Thanks for your help, best regards,
> >    Nicolas
> >
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Next/Trees#n84
>
> All done.  I added Alexandre and Ludovic as contacts for both trees as
> well.

How is this working?

From next-20201123:

    Merging at91/at91-next (0698efbb33ef Merge branches 'at91-soc',
'at91-dt' and 'at91-defconfig' into at91-next)

which is indeed a recent commit, while Next/Trees has the wrong repo
(linux-at91.git instead of linux.git):

$ git show linux-next/master:Next/Trees | grep at91
at91-fixes git git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-fixes
at91 git git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux-at91.git#at91-next
$ git ls-remote
git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux-at91.git
fatal: remote error: access denied or repository not exported:
/pub/scm/linux/kernel/git/at91/linux-at91.git

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
