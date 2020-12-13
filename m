Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94562D90E6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 23:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406822AbgLMWX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 17:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbgLMWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 17:23:27 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C15C0613CF;
        Sun, 13 Dec 2020 14:22:47 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u5so1056943qkf.0;
        Sun, 13 Dec 2020 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5+vLfFDvNakSqCOtqUMmjeuD2oJjrTqFBik/RumbYg=;
        b=pKFQ3rsAVTZGSkKZ56Ej2uDnh3330vM32jS+/M9FHwxxfn/rcSonfF2lEjJC0jd7Lr
         VAOtuRkzWAeqpg79l7PumKyDZEwGvJ8euhkQ7WQSIsRLf6SIvj4STR0jvyzklORraC4d
         8Y1XV9RyiiFYySt3CMlr6inxVr3GOapSMMQJ+EzZCaZyMYRbbZPIL3GU3pXtB4ZfmqVG
         PUMMlT7cMgYX9mnFCHceh8n3tT4TDMmQlZJHl7jMzU8uNOiEXXldlnPZZrR8n1oD3Gup
         h3NiLg8cATH0Fc4eUrtgXU4XjcGAW+H3GA8QUS/mWQdetHvVdCp6qOaxs/cDmg5tsguw
         a/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5+vLfFDvNakSqCOtqUMmjeuD2oJjrTqFBik/RumbYg=;
        b=aVA9lsYkuasbt2nh0MBYkPN863jxhYoJADdXKbPc4rzou5EsYT+eHQBEt6KjsiS4eY
         gV+NQ6b53BDFHI3xRzkuBwXsS/ThJ9mTZR7f8Gb4dAV+GxHAeIFYzcON3sOHyTfb6zAr
         CEXlcdA5JpRW1VK8N7g6c5oBrN5Cn9RP0DIKOuO7Bh+MFNbqCAfeby/EfkbXYFv0BCgS
         vt8wWUSDUithapDPn7LyA2jp74XFIR2uaFQZvYRg3Xh4J1uutptVBqufxA5VfbGiRy0j
         Tjv0vqxPPUsT4fA+P5itfFYy3yzeqrjw7tqB0gCirqu26JvwaJ00FYvIPoUe7VeyB1U+
         klPQ==
X-Gm-Message-State: AOAM530/3uODrRFEa91WKCU4NnpqxIOvFT5L+HaHXtK+/rIrJZ7zLwui
        ed7W7R2b6tgG4bWolzJfZPOofZENPyf5Fgy3Ros=
X-Google-Smtp-Source: ABdhPJz8KXbOpPSeBP+31xP0mmE2+4h+400j9puNLy2kH+QGFG8U7j3drWnHtlfWvKPm7KgH8sLGcUHTfN2IM/6RKXI=
X-Received: by 2002:a37:9a4a:: with SMTP id c71mr24828882qke.56.1607898166358;
 Sun, 13 Dec 2020 14:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20200911102321.22515-1-colin.king@canonical.com> <20200911175514.766eeaf1@xps13>
In-Reply-To: <20200911175514.766eeaf1@xps13>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 13 Dec 2020 23:22:35 +0100
Message-ID: <CAFLxGvy9LzJmNshqkxoC_kuVLJztgBDhfYPjkBUWtwd1-9UY-Q@mail.gmail.com>
Subject: Re: [PATCH] mtd: remove redundant assignment to pointer eb
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 5:59 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Colin,
>
> Colin King <colin.king@canonical.com> wrote on Fri, 11 Sep 2020
> 11:23:21 +0100:
>
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Pointer eb is being assigned a value that is never read, the assignment
> > is redundant and can be removed.
> >
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/mtd/mtdswap.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
> > index 58eefa43af14..795dec4483c2 100644
> > --- a/drivers/mtd/mtdswap.c
> > +++ b/drivers/mtd/mtdswap.c
> > @@ -1053,7 +1053,6 @@ static int mtdswap_writesect(struct mtd_blktrans_dev *dev,
> >       if (ret < 0)
> >               return ret;
> >
> > -     eb = d->eb_data + (newblock / d->pages_per_eblk);
> >       d->page_data[page] = newblock;
> >
> >       return 0;
>
> Yes it looks unused but perhaps it helps to catch the logic here. This
> is not a strong disagreement but I'd keep it this way. Let's see what
> other maintainers think.

This looks like dead code, let's rip it out.

-- 
Thanks,
//richard
