Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34F22A1ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgJaVoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJaVoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:44:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3CAC0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:44:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g13so4483560qvu.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sahw264sE/LyEO7a7nLEXCUZeUzMZhuha1nEtTxABu8=;
        b=HY8uz+B+X3dSpv2OFDQdkGdx5TH54JcsL5igPmcmOPU9ZxQCYeqWWmGVYLxyWGTYNF
         AFoT2o2SD6vOUc0/poZJBcF90i9ToTQJY2I73AX0udzS77bH+LbvMGSD+DxBlsruHdBx
         WJSzlICycgeiEdP4E+ZvqgwuojGCn+/TZBTw6mYixY+VS6zd5ubygGT2b4OAKUYq7nSv
         RD+E8HSYKqOeMZuPe3xowvZMFwbRyrqah2X5kYyBDrJdY1XAfuuE3c1rTuhCmOSe0gpk
         yOnCfN7y+cZR5E95IKxO3z/+EnwLnKiCkSFkZXMoP7CeKCzr6pVLkIIxVBK0WJVsVpHO
         wf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sahw264sE/LyEO7a7nLEXCUZeUzMZhuha1nEtTxABu8=;
        b=Lkcl8UlsIPs+wHnpPNFIHICEAFRyTXgBZYEqO8VT0+PNwtWhnX1x4nyv7kmN2gMNzG
         53FubFrahWsD6ZboOfcf+1ONt5RUTlcnfNY/Hj1QKUVyUgosWvl6mw0bok7ByWj6xQiT
         qzU6CayuK/6rseKyf5gI5+9YO2kjcoCimV9vFDDvww/ZyT/ooT8OIUZRL6wU+TaenKNu
         /Bml3+e2gJmCioKrQFlh/NkhIKNE9rGoj9KAxYiZRI5HBAj4yT9aZZ6VNguqS0w/7isQ
         ubFLM0CIlDgn0cErM31c7zXg2G0x8KaV6XmEwfrm51dNfwXsGh6HuzaBihtSCxix25qe
         JUxw==
X-Gm-Message-State: AOAM532I6YcOnovty6MaOi7lLuyv+MhAnXZ0NTPqm4EWKDkKVeKrA5ig
        rQgX9xrjAG8eg2NxMVbPD3TEmR0+jYie1hQ9mFk=
X-Google-Smtp-Source: ABdhPJyDPvjPeLtGW1e1DiY98ub4lJ6jFhNtt4OdJc8KmWSMIwbGa0YHKbUUVfy7accf7Hm7/6ql+WcnGMAGe43PFiE=
X-Received: by 2002:a0c:a261:: with SMTP id f88mr16170913qva.56.1604180694346;
 Sat, 31 Oct 2020 14:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201012180404.6476-1-p.yadav@ti.com> <20201027111804.e27pyvf62eksngmp@ti.com>
In-Reply-To: <20201027111804.e27pyvf62eksngmp@ti.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 31 Oct 2020 22:44:43 +0100
Message-ID: <CAFLxGvxc=EqBStzLz3ApwYDomKMe=WeK22ohfPQs1WrMCsaVQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:24 PM Pratyush Yadav <p.yadav@ti.com> wrote:
> > [0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/
>
> Ping. Any comments on the series?

From the UBIFS point of view I'd like to avoid as many device specific
settings as possible.
We check already for NOR flash, checking for NOR *and* SPI_NOR_NO_MULTI_PASS_PP
feels a bit clumsy.

Tudor, what do you think about SPI_NOR_NO_MULTI_PASS_PP?
This kind of NOR seems to be a little NAND'ish. Maybe we can hide this detail
in the mtd framework?

-- 
Thanks,
//richard
