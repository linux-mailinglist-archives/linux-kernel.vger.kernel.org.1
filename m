Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B2D273932
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgIVDSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgIVDSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:18:48 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3E0C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 20:18:47 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id q124so3918632vkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a399iMwad77Pjy4LzbXkCDo8iyJ1PbYFH+ke+Rxn7Uk=;
        b=Xi5CVdRBDwfUKjomm9GdawzAxb2XCK50F3VmBba6sFTowJpj1kg5sr6jMdCAkrreKx
         tYJZLP8yRu60u5UqSBBwD5zLI3RbelyV3qU61jwX1hbL+AbWBBXHP6ZUFhLUS3jFcYzI
         kBC3qP1woDhGEXSYfDOmU0SxQy2CNSIsks7ag2iz89GxaMXvg60Q20CMwxLRZ7gw+6Al
         HCfM/ffysfoBMTaDH2JzS5xcv0JVnn7CDYmdD15kerq94H2k853s5oyaiCfecLJcgNuc
         inHVCS120DGZGy68+nORlSUKZdJjgYrDI7jw8k/9Lh0fKFy2ceRB+PSnwNo+omicCP+O
         slWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a399iMwad77Pjy4LzbXkCDo8iyJ1PbYFH+ke+Rxn7Uk=;
        b=JP655iwzHTYLRxh4fkV0IPudEDnR7LfhZzjsyrgc3Y1bVJ97cc8x0FVkaNkjVKuMtx
         4CW3oPaLNJ3HzHWDU+8AjJiPLVoryAuHcpEGOSPvbqeLZzxtQZ30DWes0i3wiyq61oRc
         fJs5P92a6yOjf99LX55Uq4dcjr7kjKcX/fMT9LRDyKxtX3Y6ZoQzDvMgep4qtIu4fInq
         vhf5L6jkIvn4pP7ySPMQ8qC/LKHnzBBANVPkgDT8eLbJFsE7otNenEthRVHtC78GKqU4
         m7D4m0E2aAqL7aQ5l/yZedwkg9S6b93x6q8NHqnFr/KnIwRsFrMcILtEXXkXFXozUV+J
         nB9Q==
X-Gm-Message-State: AOAM532YiEESIFOhspF53T4mi5+f2xh3bO4qpuhZ8JaDQyx7ptuxd9Bu
        hflybjCiszHzqlLvykqXR4jZUfCUG+YC/69CU5tmpQ==
X-Google-Smtp-Source: ABdhPJyxBLzdXdTesnpHTplStB5Xn7/rADNj/6HmT1maoy3kyBYH52XP9XDJfcMA2cA3I131efLv9swvLxvGLmjFEs8=
X-Received: by 2002:a1f:fec9:: with SMTP id l192mr2121611vki.21.1600744726839;
 Mon, 21 Sep 2020 20:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200612073549.1658336-1-noltari@gmail.com> <20200615091740.2958303-1-noltari@gmail.com>
 <20200814085617.GA129183@roeck-us.net>
In-Reply-To: <20200814085617.GA129183@roeck-us.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Sep 2020 08:48:35 +0530
Message-ID: <CA+G9fYvGkowdQmi1eBfoq2dhzBfgkFh9+7tgdNw75LydxkAEPw@mail.gmail.com>
Subject: Re: [PATCH v4] mtd: parsers: bcm63xx: simplify CFE detection
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, jonas.gorski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, lkft-triage@lists.linaro.org,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 at 14:26, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Jun 15, 2020 at 11:17:40AM +0200, =C3=81lvaro Fern=C3=A1ndez Roja=
s wrote:
> > Instead of trying to parse CFE version string, which is customized by s=
ome
> > vendors, let's just check that "CFE1" was passed on argument 3.
> >
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>

We still see mips: allmodconfig build failure on Linus tree

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux ARCH=3Dmips
CROSS_COMPILE=3Dmips-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
mips-linux-gnu-gcc" O=3Dbuild allmodconfig

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Dmips
CROSS_COMPILE=3Dmips-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
mips-linux-gnu-gcc" O=3Dbuild


> mips:allmodconfig:
>
> ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!

ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Full build link,
https://builds.tuxbuild.com/Sm59_9tjFMpIvT27qf5kNA/build.log

>
> This is not surprising, since fw_arg3 is not exported.
>
> Guenter
>
> > ---
> >  v4: shorten conditional compilation part as suggested by Miqu=C3=A8l.
> >  v3: keep COMPILE_TEST compatibility by adding a new function that only=
 checks
> >      fw_arg3 when CONFIG_MIPS is defined.
> >  v2: use CFE_EPTSEAL definition and avoid using an additional function.
> >
> >  drivers/mtd/parsers/bcm63xxpart.c | 32 ++++++++++++-------------------
> >  1 file changed, 12 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/mtd/parsers/bcm63xxpart.c b/drivers/mtd/parsers/bc=
m63xxpart.c
> > index 78f90c6c18fd..b15bdadaedb5 100644
> > --- a/drivers/mtd/parsers/bcm63xxpart.c
> > +++ b/drivers/mtd/parsers/bcm63xxpart.c
> > @@ -22,6 +22,11 @@
> >  #include <linux/mtd/partitions.h>
> >  #include <linux/of.h>
> >
> > +#ifdef CONFIG_MIPS
> > +#include <asm/bootinfo.h>
> > +#include <asm/fw/cfe/cfe_api.h>
> > +#endif /* CONFIG_MIPS */
> > +
> >  #define BCM963XX_CFE_BLOCK_SIZE              SZ_64K  /* always at leas=
t 64KiB */
> >
> >  #define BCM963XX_CFE_MAGIC_OFFSET    0x4e0
> > @@ -32,28 +37,15 @@
> >  #define STR_NULL_TERMINATE(x) \
> >       do { char *_str =3D (x); _str[sizeof(x) - 1] =3D 0; } while (0)
> >
> > -static int bcm63xx_detect_cfe(struct mtd_info *master)
> > +static inline int bcm63xx_detect_cfe(void)
> >  {
> > -     char buf[9];
> > -     int ret;
> > -     size_t retlen;
> > +     int ret =3D 0;
> >
> > -     ret =3D mtd_read(master, BCM963XX_CFE_VERSION_OFFSET, 5, &retlen,
> > -                    (void *)buf);
> > -     buf[retlen] =3D 0;
> > +#ifdef CONFIG_MIPS
> > +     ret =3D (fw_arg3 =3D=3D CFE_EPTSEAL);
> > +#endif /* CONFIG_MIPS */
> >
> > -     if (ret)
> > -             return ret;
> > -
> > -     if (strncmp("cfe-v", buf, 5) =3D=3D 0)
> > -             return 0;
> > -
> > -     /* very old CFE's do not have the cfe-v string, so check for magi=
c */
> > -     ret =3D mtd_read(master, BCM963XX_CFE_MAGIC_OFFSET, 8, &retlen,
> > -                    (void *)buf);
> > -     buf[retlen] =3D 0;
> > -
> > -     return strncmp("CFE1CFE1", buf, 8);
> > +     return ret;
> >  }
> >
> >  static int bcm63xx_read_nvram(struct mtd_info *master,
> > @@ -138,7 +130,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_=
info *master,
> >       struct bcm963xx_nvram *nvram =3D NULL;
> >       int ret;
> >
> > -     if (bcm63xx_detect_cfe(master))
> > +     if (!bcm63xx_detect_cfe())
> >               return -EINVAL;
> >
> >       nvram =3D vzalloc(sizeof(*nvram));
