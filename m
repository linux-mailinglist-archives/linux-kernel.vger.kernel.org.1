Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B92785D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgIYL3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgIYL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:29:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A8C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:29:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h17so1973348otr.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VATywaeCtSZal4icWJrV1Gr0nCEObC/TuWU6wNtTQEE=;
        b=lCOusS8hZtrC9qZoQGY3Ser/7yrF9BU9gLkQV5qqjgvZ8Y7dRiT7BIrvn9GiSrSH0L
         5FncwH4gjLeePETztJ4Q610W1/s0fBPAyxRobyznOWI530KgtGCx5ekOPFIRZIr551VG
         I3RqFyCSDX39gtr3FlhfhZceeKJBJNWFbR8iJWxFkpDhPr6IO1E6zyM7sTmxQcVz0Rk7
         VmOMVSSJTcVvmWPjjXa0nn8SDOurSrILPGYIaKa1OtU7J2Pa288YjGyLvZMIp3Dm4LNO
         a6JfdlgGyF1rDIHSaNYHpI+CXqUCxZqxv08OjquJ5V0Q3rlnyUFXrLziXR3w2JFgrIUm
         iHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VATywaeCtSZal4icWJrV1Gr0nCEObC/TuWU6wNtTQEE=;
        b=g6EDd4lE2OCSTgc7eaZOhNY4d/ehJNsLALDg6ZZfdeR6v7HxOvEJTxhUbz8ePloBs5
         Myd9O/mFiDilNqYIeTHQ3TII6QP0buk/8V3r7aPh3gY0dVv9qhKNJlpXDZ4mA8do4LDF
         TFPWff48HhPYE/woOA34mp8ba/DzJtfSkH9eNC0opM1/ZrasvOOmTsgbXrFmQLwz/cQ5
         Zbky5Bz83DiPu5RgN6aacmnAIhK3Vjtg8tsbpFfogwY06IqgwuXvck70F8+3TUZ93MFx
         oIovyzGgZrFMmuoDpWi5/xxniCy7OPDC1i6WSLjp3sl/kNoL81U3CY8bbGz3nUVTI7Fm
         zt4g==
X-Gm-Message-State: AOAM5320WMLEqyce4+6tFK4z4x969/VPl2RJSW7K1Sp7W2wEMj6Ml65u
        IuSbMq5gZsI5oWOD4+2+NQF4B/cLlktCaJhZVVcaBA==
X-Google-Smtp-Source: ABdhPJzE3K5xm1eViWbfi0ZoJZKCUt9N8Q3Hq1ZW+DlbeaaZM4VGEsGgYmRjWMfgQH8SjBMIwkPzlPlgFzTmLVtNvK0=
X-Received: by 2002:a9d:ecc:: with SMTP id 70mr2566408otj.66.1601033369873;
 Fri, 25 Sep 2020 04:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200915100623.708736-1-robert.marko@sartura.hr> <6693ac3b-bf07-4a02-caca-5285dabdbb14@ti.com>
In-Reply-To: <6693ac3b-bf07-4a02-caca-5285dabdbb14@ti.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 25 Sep 2020 13:29:19 +0200
Message-ID: <CA+HBbNEWsPvrx5U8dYfJ=Tsc4+ujCXzDJk0S_Jd5OKtVrQ0AqA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add SECT_4K to mx25l12805d
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     tudor.ambarus@microchip.com,
        Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 1:27 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi,
>
> On 9/15/20 3:36 PM, Robert Marko wrote:
> > According to the mx25l12805d datasheet it supports using 4K or 64K sectors.
> > So lets add the SECT_4K to enable 4K sector usage.
> >
> > Datasheet: https://www.mxic.com.tw/Lists/Datasheet/Attachments/7321/MX25L12805D,%203V,%20128Mb,%20v1.2.pdf
>
> Have you tested this feature on a real HW?
Hi,
Yes, this has been tested on Alfa AP120C-AC which uses mx25l12805d.
I have not spotted any issues with it.

Regards,
Robert
>
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> > index f97f3d127575..9203abaac229 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -50,7 +50,7 @@ static const struct flash_info macronix_parts[] = {
> >       { "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
> >       { "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
> >       { "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
> > -     { "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
> > +     { "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, SECT_4K) },
> >       { "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
> >       { "mx25r1635f",  INFO(0xc22815, 0, 64 * 1024,  32,
> >                             SECT_4K | SPI_NOR_DUAL_READ |
> >
>
> Regards
> Vignesh
