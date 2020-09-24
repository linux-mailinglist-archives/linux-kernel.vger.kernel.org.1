Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255D42768AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIXGIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIXGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:08:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609DAC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:08:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c2so53405otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lXB9dmAirmi4v7GPBCGSMea4z8h+BAFIgAuNXXHOb2Y=;
        b=ClueS1ymp1lS1bXGw323101aciaXB9Sy2hZzOZiXvnx89GOnngJVSqAJVDrbWf9jDd
         tZn9SE2Pf9bofHHPqwvtvpToCD9PqPhRbd9L1rxg8LqPL1ijL8ZkTURSRDA0dvRpFrWo
         kYnJ4uAcoc0wrDadvw8GMIN/4UjBCIiucM+me+sdVXT3LnrLfFQvyVjKVsabsVv2mbuB
         /OLoYlljvBMZS+KLcR10JpAyeuMCMd23GSDukYvejF+5U6rD70/fiP4q5pT89FN4Lp7I
         tcDUSD8//IKRUi1b4kZEdJVdQZ4ws6V7lhXdElNdjiig1qbzSjH6MbtGbOspHyAc71Hv
         yD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lXB9dmAirmi4v7GPBCGSMea4z8h+BAFIgAuNXXHOb2Y=;
        b=FCHoI8ZSddDm60yAVgagHYntigRWUTOqxF4TRDE07M+JV1yOb3BI8wSXQwpPdtfQXt
         TnDc4j8AHdKlEfL35amMwt4Sej/i2hf+TZr6Ch/xrpTaJmXDy2ZoE8k0oewBpdGpCvUk
         DkTdfWrkNumoTZYdj8BXmkCgpodzhLzDvlTSd+VepEDqp/vnq4NeBePUcZ2zWJ4VsphN
         DHK7lzY7kn5mvNrKN5uNQdmqq+cO5ReebW6S4tN2SjHQXWtPJXEQF8ydkS2O5Aq3H+22
         47qYBAj50HJZA7QSHEX1Fypf6V2kftR+YdmsPqf0lXmlZgPOCwAZrS+TqHczYFm+dslO
         hOIw==
X-Gm-Message-State: AOAM531ZsZ9N/CT3/RvnkM4ZvQ0lTaCHRFyYjgfxAt7jroKzN0RfG991
        R3X3fTRDl7xNDxXdLVYnNjRSgSvc3B3DWoMp1Av5gw==
X-Google-Smtp-Source: ABdhPJxubDtbjxJFVherYQTEFtOHUjR1TTTplL/wr/L2yXlHF76XKLGA0cLfr+PpH2sR1GKWN2mntDi5katKmLkzutY=
X-Received: by 2002:a05:6830:1e22:: with SMTP id t2mr2242455otr.100.1600927721055;
 Wed, 23 Sep 2020 23:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPpJ_efHX70Ej0uzRi-iRf7N0n6ZO5sMN-wK_YpszvVD-Un9RQ@mail.gmail.com>
 <20200923065900.658666-1-jhp@endlessos.org> <439c4b59-b1e6-88bb-568e-1c2a0feceed4@arm.com>
 <4641984.dSft4sXKFs@diego>
In-Reply-To: <4641984.dSft4sXKFs@diego>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Thu, 24 Sep 2020 14:07:04 +0800
Message-ID: <CAPpJ_efjVXq6BNQDfiwmEYPyjJyBH5xP2hBdGdNjT7E7=fkMXw@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: skip probed failed device
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko St=C3=BCbner <heiko@sntech.de> =E6=96=BC 2020=E5=B9=B49=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Am Mittwoch, 23. September 2020, 13:05:26 CEST schrieb Robin Murphy:
> > On 2020-09-23 07:59, Jian-Hong Pan wrote:
> > > The cdn-dp sub driver probes the device failed on PINEBOOK Pro.
> > >
> > > kernel: cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* =
missing extcon or phy
> > > kernel: cdn-dp: probe of fec00000.dp failed with error -22
> >
> > Wouldn't it make more sense to simply not enable the DisplayPort node i=
n
> > the upstream DT, until the type-C phy work has been done to make it
> > usable at all?
>
> Or alternatively just disable the cdn-dp Rockchip driver in the kernel co=
nfig,
> which results in it also not getting probed.

This may be the simplest way.
However, considering generic distro kernels have a policy to enable
all drivers, disabling the DisplayPort node in the upstream DT, until
the type-C phy work has been done may be a better solution for now.
I can prepare a patch for this.

Jian-Hong Pan

> > AIUI the "official" Manjaro kernel is carrying a bunch of
> > hacks to make type-C work via extcon, but they know that isn't an
> > upstreamable solution.
> >
> > Robin.
> >
> > > Then, the device halts all of the DRM related device jobs. For exampl=
e,
> > > the operations: vop_component_ops, vop_component_ops and
> > > rockchip_dp_component_ops cannot be bound to corresponding devices. S=
o,
> > > Xorg cannot find the correct DRM device.
> > >
> > > This patch skips the probing failed devices to fix this issue.
> > >
> > > Link: http://lists.infradead.org/pipermail/linux-rockchip/2020-Septem=
ber/022352.html
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > ---
> > >   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gp=
u/drm/rockchip/rockchip_drm_drv.c
> > > index 0f3eb392fe39..de13588602b4 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > > @@ -331,6 +331,12 @@ static struct component_match *rockchip_drm_matc=
h_add(struct device *dev)
> > >
> > >                     if (!d)
> > >                             break;
> > > +                   if (!d->driver) {
> > > +                           DRM_DEV_ERROR(d,
> > > +                                         "%s did not probe successfu=
lly",
> > > +                                         drv->driver.name);
> > > +                           continue;
> > > +                   }
> > >
> > >                     device_link_add(dev, d, DL_FLAG_STATELESS);
> > >                     component_match_add(dev, &match, compare_dev, d);
