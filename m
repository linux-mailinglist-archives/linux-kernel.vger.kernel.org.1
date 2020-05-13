Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA11D1C18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbgEMRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 13:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389805AbgEMRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:20:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A66EC061A0C;
        Wed, 13 May 2020 10:20:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so29427109wmh.3;
        Wed, 13 May 2020 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nIFAViuHZiqmpu9Sg7QKKPVrFGX6QP/as79ZNgHWK64=;
        b=hfWMoQKcR4bQGuCuTtIaXSGIXb4+Jgw2zpvbboy2kTx19tnU+DNLni+f2HMjCX8UDp
         UaS3a6LhY9RTW76gUNtskIqszvZ6iPZg2PieYucYYulhU9YNQFswLbrer0vD46APYoH+
         fge0srFyw+aLJjpCJYf+n4gubaEHb+oPssjiqGAgdUWeT/Y3LZ2FhsXn1S9nOwNrJB3i
         4UDPIfzrXqfwfG8d7VmE7wkWl09DfXY1J/fLBV6sKrGHfwv2DokR+xR4dMD9Z5/efUHR
         qlpCZoNPj57clGIKYOAnajq8D5gomn32XQgGfFxAqEDWBmNW7sVP7WF+fKlVwegbfMJs
         E0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nIFAViuHZiqmpu9Sg7QKKPVrFGX6QP/as79ZNgHWK64=;
        b=JVznDinVyqpnci1QXRYdqI/xSGB08I+z1XtffBgAmUcRjk6KfxgJX+Z2jPsa84+2Th
         7lslA5LGg8mkeuiOIndaw1dn4MLdC//93+DCGDNOzC7OZrdylPxY3K17y01E2Qoc/bHC
         9zNZhMDeYLTeZG0Ww79CW4FXl6kF4FZkTjfUBAC3bBPbnUwm/61ZYOfH7lMf2Nr+c8Ab
         BOhwGlYNxPBXMcV0fdD59VvEqlvmPEAe+qxowaZyc8u48xiUWXWSKnLADBs1mCrSrU4G
         aHYDVl6RCPKPzoB29ASSd22XCbFK2Mvdv9myKcvEqOF2RHHXM1n68vX8rrxmLDDle3Yr
         xtJg==
X-Gm-Message-State: AGi0PuauQYYizxVBxYfpS8B+FY1kma5lybj4FeE5j3wIZIKoddMqUXMe
        a5CN4lGTiwiye9ghhidJMqA4NwZbbfSx6Du/Weo=
X-Google-Smtp-Source: APiQypIO0LBMdxmZ5sV7C7nGsn9iIDTT0FmNpLsVgIL7wAhjUQaTeT8vg6ENs59fjPtXhFTEUasU/iGtPyQeKktniUY=
X-Received: by 2002:a1c:f416:: with SMTP id z22mr44216615wma.32.1589390431769;
 Wed, 13 May 2020 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <1589388975-15499-1-git-send-email-alencar.fmce@imbel.gov.br> <CAHp75VeycGutrfTCrVP-9V61ag-KbNHfykQXHWU-8hwEFOerMQ@mail.gmail.com>
In-Reply-To: <CAHp75VeycGutrfTCrVP-9V61ag-KbNHfykQXHWU-8hwEFOerMQ@mail.gmail.com>
From:   Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Date:   Wed, 13 May 2020 14:20:17 -0300
Message-ID: <CACk9uef9zY_cEVhhSdnYfSf-XZxrwU+V+eLUz5-N=U9DRtVp4g@mail.gmail.com>
Subject: Re: [PATCH v2] video: fbdev: ssd1307fb: Added support to Column offset
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em qua., 13 de mai. de 2020 =C3=A0s 14:13, Andy Shevchenko
<andy.shevchenko@gmail.com> escreveu:
>
> On Wed, May 13, 2020 at 7:56 PM Rodrigo Rolim Mendes de Alencar
> <455.rodrigo.alencar@gmail.com> wrote:
> >
> > This patch provides support for displays like VGM128064B0W10,
> > which requires a column offset of 2, i.e., its segments starts
> > in SEG2 and ends in SEG129.
>
> Also, include Rob as well into Cc.
>
> ...
>
> > +       if (device_property_read_u32(node, "solomon,col-offset", &par->=
col_offset))
> > +               par->col_offset =3D 0;
> > +
> >         if (device_property_read_u32(dev, "solomon,com-offset", &par->c=
om_offset))
> >                 par->com_offset =3D 0;
>
> Have you ever compile it?

hmm I did it now. Sorry... found another issue. I'll fix it again

>
> --
> With Best Regards,
> Andy Shevchenko
