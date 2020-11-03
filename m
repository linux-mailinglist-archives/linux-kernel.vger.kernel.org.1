Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566922A3B76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 05:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKCEkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 23:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 23:40:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 20:40:52 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so11390528wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 20:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsLiELZDgcODbFWwv/znA2TZHH9P89qCS6Bl8IJIhes=;
        b=MXiyWkoXcOBvIDIqhK/7qOuAxVzeBzwauMfq6g7W67XTP6rdqX3h4BkrPvcLMiYUaX
         Df79GopWOuKeglWChvyynkNPTYMC5e59eNVN4MojGsaN0q0bxUfZcUrNp+J9eskY5/ku
         HPVB8S47rbbEd6OCj88GuEVD0niVjehAZAZ096Yvh9ghh7O4u/NNZxahSkuKa1JgrrDm
         quRLqVkpKNs2VcfNs+GQyi+3y5S8K4twujeXLr1efTN8zakcGKSeyRsH72IgV78qx08v
         OfQdo0z0DErlpFAuHBIik3V5QNTXt8efZHcVAFpg5KSgTJawkoFsSPnWBrSgEWNLegZr
         IjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsLiELZDgcODbFWwv/znA2TZHH9P89qCS6Bl8IJIhes=;
        b=oPcmrW8qMmNPfzNKLfLegBzcUAhv3ISehX1HDYkwAZ0elOUbDgfLyOt5HoJG8n/tXw
         Y8Pu+CizvIceiRtn/C/iYUaC4Kw6giCQQeoau+0mek6YtqjkU1uw+vE4Qfkb2DnumnQE
         YJnIFAOslPSPyPwAaWMrWFI+vHDNOAmD2UDAa1CGz1scFrfIWUbjFGP/KV/4lLaJ+f+w
         pnR+i8YSZv+EIq73u2zEzQFEHCQmSzgvClwAo7ZUY1jmUFMfJlh/EK/RowRvqeEZXceo
         6kQNq4/bw1BPHme+0R52t0/dTqmQRDHFdwjWiGJYvn6zko9O8MoRO4vmnNeYcR5IZNgA
         bxYQ==
X-Gm-Message-State: AOAM531aWaSTEX00c1KemtMZO066LgTUN+oA0Pua2loF38Le2s3mLq66
        DrcX6thIK9efIF5vbLYkkxKa6Flnz1x0SOoHmWb4IypzmKZA
X-Google-Smtp-Source: ABdhPJxQpc0z0XrT27/+lJ8iKLXRrHcrLo1NjLe8WzIH9ejxMt/T2Mirus5FzjK4k8biDW4mWHMYyRRjS2/iV1pJIB8=
X-Received: by 2002:a7b:c305:: with SMTP id k5mr1455562wmj.102.1604378451087;
 Mon, 02 Nov 2020 20:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20201102193402.GA14965@Sleakybeast> <20201102194055.GA2429929@kroah.com>
In-Reply-To: <20201102194055.GA2429929@kroah.com>
From:   siddhant gupta <siddhantgupta416@gmail.com>
Date:   Tue, 3 Nov 2020 10:10:39 +0530
Message-ID: <CA+imup-scsOiVghh9UyO=3SXFqj614dqJ-FjppF7hzzgz_D+Qw@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-dma: Prefer Using BIT Macro instead of
 left shifting on 1.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Himadri Pandya <himadrispandya@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 at 01:10, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 03, 2020 at 01:04:02AM +0530, siddhant gupta(siddhant1223) wrote:
> >
> > Replace left shifting on 1 by a BIT macro to fix checkpatch warning.
> >
> > Signed-off-by: Siddhant Gupta <siddhantgupta416@gmail.com>
> >
> > ---
> >  drivers/staging/mt7621-dma/mtk-hsdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
> > index 354536783e1c..a9e1a1b14035 100644
> > --- a/drivers/staging/mt7621-dma/mtk-hsdma.c
> > +++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
> > @@ -72,7 +72,7 @@
> >  #define HSDMA_GLO_TX_DMA             BIT(0)
> >
> >  #define HSDMA_BT_SIZE_16BYTES                (0 << HSDMA_GLO_BT_SHIFT)
> > -#define HSDMA_BT_SIZE_32BYTES                (1 << HSDMA_GLO_BT_SHIFT)
> > +#define HSDMA_BT_SIZE_32BYTES                BIT(HSDMA_GLO_BT_SHIFT)
> >  #define HSDMA_BT_SIZE_64BYTES                (2 << HSDMA_GLO_BT_SHIFT)
> >  #define HSDMA_BT_SIZE_128BYTES               (3 << HSDMA_GLO_BT_SHIFT)
>
> In looking at the code, does this change really make sense?
>
> (hint, I don't think so...)

Following Checkpatch, I thought it might be good to do as checkpatch said,
but the code looks better and more readable without the change. This
is my first patch and also a
lesson that i should not fix every checkpatch warnings. I'll pick
something better next time
Thanks for your comment
.
