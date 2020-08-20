Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF72C24C887
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 01:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgHTX2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 19:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTX2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:28:13 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3672620885
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597966092;
        bh=y1Wgqh1GAoyYsV2k+q2fc4yzCIr9vvCD20G5Zf/a4wU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TfZ+2cwjuT/n2Iv8QQEjGOa3CPaMieV05fFA+Oi7nEB4k7Hb4LDkEK0Db8aE1f2ym
         ewjv5j0/yOOFYVtyDctGcmmJZ5HDkRDAnaJv6cIFaTwzVq3yUI3TnvOzrRJi80NIqR
         XCd7dRHy3CdaiJfllFYq7XcfZHl1rNBSnSEkYv0Y=
Received: by mail-ed1-f52.google.com with SMTP id b2so1670107edw.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:28:12 -0700 (PDT)
X-Gm-Message-State: AOAM530EFh0ZNUThKO39QDh0AlW62/h6SKsuW8IHQOGF3SJohHxqQp9V
        Whrd0JVNEd+od+GsKGOxnah/z7QchZDO5dIuvw==
X-Google-Smtp-Source: ABdhPJwuSJgrsrEJbwW4ZqpZR1tI1e3gpAbID/lO2xREIPczRxBkfkEvXEqYrYh6exUoPX+WCswHFsJtNmhFGKdT6SM=
X-Received: by 2002:a50:d2c7:: with SMTP id q7mr239405edg.61.1597966090804;
 Thu, 20 Aug 2020 16:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200819154421.7013-1-chunkuang.hu@kernel.org>
 <20200819154421.7013-3-chunkuang.hu@kernel.org> <eec33300-f921-03d1-5bcf-788e4e2ce342@infradead.org>
In-Reply-To: <eec33300-f921-03d1-5bcf-788e4e2ce342@infradead.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:27:58 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-RZptS25adw7qoqZ-+dkK0vd+D_rd6KqChfm9ryF2RAw@mail.gmail.com>
Message-ID: <CAAOTY_-RZptS25adw7qoqZ-+dkK0vd+D_rd6KqChfm9ryF2RAw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/mediatek: Separate mtk_hdmi_phy to an
 independent module
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy:

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:58=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 8/19/20 8:44 AM, Chun-Kuang Hu wrote:
> > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediate=
k/Kconfig
> > index aa74aac3cbcc..ca3cd871a350 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -24,6 +24,13 @@ config DRM_MEDIATEK_HDMI
> >       tristate "DRM HDMI Support for Mediatek SoCs"
> >       depends on DRM_MEDIATEK
> >       select SND_SOC_HDMI_CODEC if SND_SOC
> > -     select GENERIC_PHY
> > +     select PHY_MTK_HDMI
> >       help
> >         DRM/KMS HDMI driver for Mediatek SoCs
> > +
> > +config PHY_MTK_HDMI
> > +    tristate "MediaTek HDMI-PHY Driver"
> > +    depends on ARCH_MEDIATEK && OF
> > +    select GENERIC_PHY
> > +    help
> > +          Enable this to support HDMI-PHY
>
> Please fix all of these newly added lines.
>
> from Documentation/process/coding-style.rst:
>
> Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
>

OK,

Regards,
Chun-Kuang.

>
> --
> ~Randy
>
