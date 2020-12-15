Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9F2DA9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgLOJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgLOJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:04:39 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB20C06179C;
        Tue, 15 Dec 2020 01:03:59 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s26so2709542lfc.8;
        Tue, 15 Dec 2020 01:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qlzzoAIKNvep133MTIpFmxgEg1ThjOyD3DYXCkLaku8=;
        b=QeS9UMG4xB2CSyn1i7d2WqG1r49iJz+vU0j2JygOT0davu0MrbpjBKPn/jTldnScWv
         k7+vHJUJogaabBb3HY/yj8PBkkn23HGed1K8auxnI6O7/xwIS1BbYcyyNUE1GQ5DQBZR
         KfDlKwHgsNkYtXWwQ+P/lTyXShM0FDqKbSLEO2cJ9N9VH82fIs4N982SxrVxRXg60wQw
         g7v3C9ZpBz8OtlsXnto+9MCkA3BSGhTiqjMhgkKB+QiOJcsJU6Vzd3gUsPZuCE2U4+jU
         fhfFBQeRqt9rI7IVGLgDaS/kMuQF4SNjnJYUmAA6trXWZlJg5/G6vUAO8n/XwK1AeJ7H
         7nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qlzzoAIKNvep133MTIpFmxgEg1ThjOyD3DYXCkLaku8=;
        b=LYM8rFWN53Yt8BIOOVK7j97dla6T/LR8uBaz0OFuTrHIRHd+n4ELYB2V0C+KBlPjXy
         P8EERBEvkV8xTSDXl4xHWSpjGcggmTVLKG3ELARt0DKuPqTaXjprJbHITLcEuNU7frF2
         OuiSe2MoV5wlHnL8DWMcgm0o1rQbZeT4tj0vJfNNCHFISbOMSUTZ7G32BZcit4ByIpaQ
         PnhKkmF+Qt43zuOnGG+JROEu+7g/KSTGsbR4iCzk7HE88WCGkiNyZ3XmrDE8NEvuo3m+
         2EujtpO+M9znvlzxR6vlz5xuqrWA9eObITWF7uBpli1L7N9Z6Xc5u0vqvLlQ/ghr8eZS
         s0Tw==
X-Gm-Message-State: AOAM531nzYBkfbT51Ur9MzeLPrkVc1jfeMcFa0TAUJhdF4S1zh3bndnw
        WyUYCStxySFRN8fYd5vm9mA/rrJGfV9tgq/GaPA=
X-Google-Smtp-Source: ABdhPJxanHdNcff5iisASwz+QSOx+wS7UVfxaJeQB8zNd0+WmYfobbL+cPrHA64fyiJQWo/1e04mksflPQMHlLrJdcA=
X-Received: by 2002:a19:747:: with SMTP id 68mr10308918lfh.408.1608023037447;
 Tue, 15 Dec 2020 01:03:57 -0800 (PST)
MIME-Version: 1.0
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com> <20201214095916.4g47zlueng4wa3hv@holly.lan>
 <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
 <20201214151409.qdqh2i5hr4g3eboe@holly.lan> <20201215075308.GI5029@dell>
In-Reply-To: <20201215075308.GI5029@dell>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 15 Dec 2020 17:03:45 +0800
Message-ID: <CADiBU3-MesTvXm31+W1szXDnYOm=2E21J=a3nP2LZ0i7Rs+Kkw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lee:

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=8815=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 14 Dec 2020, Daniel Thompson wrote:
>
> > On Mon, Dec 14, 2020 at 10:40:55PM +0800, ChiYuan Huang wrote:
> > > Hi,
> > >
> > > Daniel Thompson <daniel.thompson@linaro.org> =E6=96=BC 2020=E5=B9=B41=
2=E6=9C=8814=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:59=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > >
> > > > Hi CY
> > > >
> > > > On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > >
> > > > > Adds DT binding document for Richtek RT4831 backlight.
> > > > >
> > > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > This patch got keyword filtered and brought to my attention
> > > > but the rest of the series did not.
> > > >
> > > > If it was a backlight patch series you need to send it To: the
> > > > all the backlight maintainers.
> > > >
> > > Yes, I'm waiting for mfd reviewing.
> > > Due to mfd patch, I need to add backlight dt-binding patch prior to
> > > backlight source code.
> > > Or autobuild robot will said mfd dt-binding build fail from Rob.
> > > That's why I send the backlight dt-binding prior to the source code.
> > >
> > > I still have backlight/regulator source code patch after mfd reviewin=
g.
> > > Do you want me to send all the patches without waiting for mfd review=
ing?
> >
> > To some extent it's up to you.
> >
> > I think I would have shared all the pieces at once (although not it Lee=
,
> > as mfd maintainer, had suggested otherwise).
>
> You should not need to concern yourself with patch ordering outside
> of the realms of the set i.e. [PATCH 1/x], [PATCH 2/x], etc.
>
> If you just send the whole patch set and you do not specify otherwise,
> it will be applied, in order, as a set.
>
> Sending subsystem patches without the correct maintainers as recipients
> is bad form.  Many of us have filters on, so this tactic will seldom
> work in any case.
>

In my case, there're mfd/backlight/regulator for RT4831.
You mean I can just send the whole patch set directly to whole
mfd/backlight/regulator maintainers.
And you can filter like as the keyword to review the related contents, righ=
t?

From my original thought, the order is mfd -> backlight-> regulator,
one by one due to different maintainers.
Maybe I think too much about the patch ordering

If so, after getting the comment from Rob, I'll send the whole patch to you=
.
Thanks for the notice.
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
