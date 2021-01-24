Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC11301EA8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 21:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbhAXUP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 15:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbhAXUPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 15:15:24 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17CC061573;
        Sun, 24 Jan 2021 12:14:44 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id l14so3243717qvp.2;
        Sun, 24 Jan 2021 12:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OSqM/+hDSvLrv13lOWN3p2jAOoGEE3+xx2u807DxGhI=;
        b=b3lztcn5pSshC/3esauyTw+hxCipPz+MJyymarpFLFxQhyqJRiK0Q5Glo6b7KifBk8
         f55+fm+KG4Hp913zv0oxXC3KyC8LgnsIjloAmXIq2wCyIablTcUrwIraJ0h7O9EXSpR0
         Wr6V8hzjL1U+31FiHwpqqh9bYJltn8zh8jssuRfjJAJQt0YuMFT5W6AaXSuyjnn3hOmo
         En0Au3qkMCJkc0EiQC+yEBuoFYSTDpZ/vyPsK+ggc778kKLn06Q3hahskXu2svqNBRqk
         XJTWw7Y7JCmJ5tXoaphmclJk8oREYPAkefDB7jWG4XjJ/yDeVkTTonLaKvi8HS6QexBn
         Y0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OSqM/+hDSvLrv13lOWN3p2jAOoGEE3+xx2u807DxGhI=;
        b=Mt9zkDhaQrqirTUg9JC0/AnZhBsS+/KNUJWcfVuIwKp4T6yNtnRAi/+GLLmhjEcaje
         oPIGBFHdYpyJu1jG2zjE12BByEN7r6B0UWW2OjO5YUk0H943mXmo+IPBS/UOiuqnGsTK
         aewJtarg85Y8ojIBxX/3RoUeeuKNO99Fv7hrN9j1lbRvC9xsU3pCpVrfeIyJT8c5z6Ir
         8/2NHd58ndxxK1zCr0IgI50FpP8DbJFHOIcFBR0NhQV05LiDZETfvr+WaoWbjYb7kroG
         1qcOzO2hJRm85SbqbGNo/3a4/qt/NUiZiojBcK0LrEV7mQEdJLx8FnDtA0tOqCz3MzF1
         j2FQ==
X-Gm-Message-State: AOAM533xXzKlw3BjQrm5Enx3urNvvLVmqrARytGVu5UNIqn8jt7kbv9a
        qCVGFlTLLDre4rDSVS74PfBbkh+AhRqdPJdKvla8+WV/XWU=
X-Google-Smtp-Source: ABdhPJxVOToYv0HkdS45AHJioCJ8pGX18Nrco3AhpQ3fAv/W1LW+yvun2Ke603zBouNanpWWNdyQ/PX8p+H6laXhHYQ=
X-Received: by 2002:a0c:9e5e:: with SMTP id z30mr4524736qve.56.1611519283494;
 Sun, 24 Jan 2021 12:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20210124073955.728797-1-christophe.jaillet@wanadoo.fr> <fe72d1d2-8222-5cda-74ff-9327725f196a@web.de>
In-Reply-To: <fe72d1d2-8222-5cda-74ff-9327725f196a@web.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 24 Jan 2021 21:14:32 +0100
Message-ID: <CAFLxGvzFDPBGY1uoB7vqJreOSfs9N2PGMDTbQ24PYBWBRVR4oQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: Fix an error handling path in 'ebu_dma_start()'
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc:     linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 9:13 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> > If 'dmaengine_prep_slave_single()' fails, we must undo a previous
> > 'dma_map_single()' call, as already done in all the other error handlin=
g
> > paths of this function.
>
> Would you ever like to use an imperative wording for the change descripti=
on?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?id=3Dfdbc80bdc4365078a0f7d65631=
171cb80e3ffd6e#n89
>
>
> =E2=80=A6
> > +++ b/drivers/mtd/nand/raw/intel-nand-controller.c
> > @@ -318,8 +318,10 @@ static int ebu_dma_start(struct ebu_nand_controlle=
r *ebu_host, u32 dir,
> >       }
> >
> >       tx =3D dmaengine_prep_slave_single(chan, buf_dma, len, dir, flags=
);
> > -     if (!tx)
> > -             return -ENXIO;
> > +     if (!tx) {
> > +             ret =3D -ENXIO;
> > +             goto err_unmap;
> > +     }
> >
> >       tx->callback =3D callback;
> =E2=80=A6
>
> By the way:
> Can it be nicer to achieve the statement =E2=80=9Cret =3D -EIO;=E2=80=9D =
by a jump for
> a target like =E2=80=9Ce_io=E2=80=9D so that less exception handling code=
 would be duplicated
> for this function implementation?

Please feel free to ignore Markus.

https://lore.kernel.org/lkml/X+x3pIanr18Ep4ga@kroah.com/

--=20
Thanks,
//richard
