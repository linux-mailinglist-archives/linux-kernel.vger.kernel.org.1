Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C8D2C6BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgK0SzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgK0Syu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:54:50 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD66C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:54:41 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id s18so6880689oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3DOpGKcNuqaqLPfhIybZ4DKwkBEL6Fp9+iinumCxq0=;
        b=BPYHoK7WvONz5Wu61Z/bKc5Bhr3rGM9q5Jrq9ztWStaBRd0HCTZJLrMLcIszKg+cy/
         9FHdRpFB5C+PBidIIMmZkppgXVbhfAoAHZ2wAapO475ctjKcumPS4ocr2Ly9jJ/VRnD6
         15lI8JRnKAD7ujNzyOdUZr+9BFu8Kqonb5kaAqwnU6rDaQQx3duZUNtuP/4rJeogw5ND
         ZNX2MHtvujQGz8TSyTntnjgz/eidDVCYHJwB3IBBDO+rTa7XIoCnKSpKehv/G06N6RAr
         TmUg4+ozAsJr/nRWkfukP5YzBCpkpPXtCHYjvjTLXV8a4FlsfAoVdIfMpdr7hnmVu5o+
         aATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3DOpGKcNuqaqLPfhIybZ4DKwkBEL6Fp9+iinumCxq0=;
        b=c4yyw2wiW3yz2AE6Dw4ewqnXr6gA7+ps0+IE3oJlOJ1D0n5wxzkxGWZsQE8ZlKtEn9
         YtveRxdztn5EJfxIj/sNu0lJOX6y1XV87y2WqPHfRr9rmSY99TJS+I8zWDZkXE2ERKyB
         edVcROhjbTNmuFc7e552/dBX8jGqemQofLAVE29G3LBxQODisOCCG5JokpCTrXLPvtjK
         lGzl8AduDaHI60Fpi+A7mgX1zGZpgVHSdehDXlxvR0a6xvbtbIukyd/XGGSF88okd9wD
         1pnOfIDaD7ob4zY4yXaSnMCnEMJlGrAqfzLFEEWnYBrc/i8k0RdUGmR2ige8QK1WAfak
         UR9w==
X-Gm-Message-State: AOAM532Vro3jzd0tf8p0LbyXED9gY44JJ9L+EKG7gZlbsj+xS8eN3RYx
        opupzJv2YGTF+uiQY7KTlnvpvYezzXB5N+ywlM8=
X-Google-Smtp-Source: ABdhPJxDTdz92QYgFKxhNOR2iBXHl8FwZTKA2U9M6iM+aK85NFetSAcJSq2aQejbK5dHboX9GvZdmnRycdcHtOhhpBc=
X-Received: by 2002:a05:6808:d:: with SMTP id u13mr6619175oic.49.1606503281228;
 Fri, 27 Nov 2020 10:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20200429165347.48909-1-rminnich@google.com> <2666350.AiC22s8V5E@sven-edge>
 <CAP6exY+hHrVvaMcF2tWUUJT=JS_J9NHx=92DzO=GAN==ACSh1Q@mail.gmail.com> <2124367.HovnAMPojK@sven-edge>
In-Reply-To: <2124367.HovnAMPojK@sven-edge>
From:   ron minnich <rminnich@gmail.com>
Date:   Fri, 27 Nov 2020 10:54:30 -0800
Message-ID: <CAP6exYJ7QR+Y7Vsumecx_3rUC4cNY4xJj4e6759S8US6FX7ADg@mail.gmail.com>
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

Thanks, Sven, for your patience, I will indeed try to test this next week.

On Fri, Nov 27, 2020 at 9:35 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Friday, 27 November 2020 18:16:54 CET ron minnich wrote:
> > What none of the people involved in the original patch knew was that
> > there would be other ':' in use. Sorry!
> >
> > But you are right, my idea is a complete non-starter, don't know what
> > I was thinking.
>
> I am still not sure because I still didn't get what you actually wanted to
> change. I first thought that you wanted to change
>
>     mtdparts=spi0.0:256k(0:SBL1)
>
> to
>
>     mtdparts=spi0.0!256k(0:SBL1)
>
> which wouldn't work for me when ":" is not supported anymore. And it would
> break a lot of already working installations.
>
> But maybe I completely misread it. Maybe you wanted to introduce an
> optional(!!!) stop marker like !
>
>     mtdparts=spi0.0!:256k(0:SBL1)
>
> to inform the parser that it doesn't have to search for : before the !. While
> this could work for me, I am not qualified enough to say which character is
> not yet used and can be utilized.
>
> But the note about [ and ] at least makes sense to me (if it is optional):
>
>     mtdparts=[spi0.0]:256k(0:SBL1)
>
> But I am not sure if this will be a problem for people which already adopted
> PCI IDs inside the mtdparts without [ and ].
>
> > So it seems your patch, if it works, is the way to go?
>
> At least this is a workaround [1] which can be pushed to all the stable
> kernels which broke with the "Support MTD names containing one or more colons"
> patch. And the one which OpenWrt adopted now to get the devices booting again.
> It is only waiting for a Tested-by from you.
>
> > I can't think
> > of anything better that lets us preserve current behavior and support
> > PCI device specifiers?
>
> I am not that deep in this topic. So I am not sure what else could be done.
>
> Kind regards,
>         Sven
>
> [1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20201124062506.185392-1-sven@narfation.org/
