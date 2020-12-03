Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1C2CCD59
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgLCDbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLCDbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:31:12 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B6C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 19:30:26 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so521863pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 19:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ccj6b9pxrqpLMEQV5KpSS6RxrNoGGzMjVrA/qC32hfE=;
        b=TdmdMAXcbIkcPSaPzbV896gbNaogvjXSo8idr4V3kUarOjDeBV+aB2G9WX3zsoab26
         OBz5pWCSkCNzOkbDu9TkFxlEG+HNevlIqJ3UQb5YvIXNXpNLTJkJbRLHGnMUz9R8JDYV
         /KjQtCGGKqgObEyEs6lZGxXwHKmxaJnFFUTOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ccj6b9pxrqpLMEQV5KpSS6RxrNoGGzMjVrA/qC32hfE=;
        b=qB4TKac11PIg7jD9citheALJgwI2jnqM9iFisDmQqDIBVIlWdJgRiPyVtdBi3DZ+J0
         CnolAfZ5iQVNWoYB9oku4H1sgf0KhQ+STSzEvgKLHN6k+X+6TWBgqmPB2KoUI3FvlfWL
         79CdVo5Dk+DHfkNmNnYl7UOP5/Qohi1Gqv+u81lpRzudpQ/0ewAJHCFaoZW8q2iljmTK
         rHruq03azgzCa2YKgmg77e7ye73CgKZE0rEdreMLFrcGEwhH1MQNvecaUtAGhHMTd+6x
         yTSaI+1880Ipvc3tW6VTe/VeZ0c0b73K6+GeeRMJI/RAvriumIYZtHeVyIxI9t1GPpbF
         XOzA==
X-Gm-Message-State: AOAM531aet0twF5BOCu7NNLW2Jo2/4rdaQhVGF1msAzyDbPcRvfTLUuU
        3pyTkUA1DEPwTLlp+ZMfFytlIfwyN10vP1NzSqhIOw==
X-Google-Smtp-Source: ABdhPJzoBgT28c7z3yMIzACokhuRY837a+IEnLu4EkS/3QjHToN3HgaQLczFSCGvS7Y1qrTMIBNzmhNgyVK3OJWt/40=
X-Received: by 2002:aa7:9803:0:b029:198:26c8:51e8 with SMTP id
 e3-20020aa798030000b029019826c851e8mr1409486pfl.42.1606966225868; Wed, 02 Dec
 2020 19:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
 <20200930022159.5559-4-crystal.guo@mediatek.com> <20201130111340.GA3042402@chromium.org>
 <1606907202.14806.65.camel@mhfsdcap03>
In-Reply-To: <1606907202.14806.65.camel@mhfsdcap03>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 3 Dec 2020 11:30:15 +0800
Message-ID: <CAATdQgDXYHMst2TO_ohvaiYF3_SZunrzpKs3MW6tOgez5W2j=Q@mail.gmail.com>
Subject: Re: [v6, 3/3] reset-controller: ti: force the write operation when
 assert or deassert
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?WW9uZyBMaWFuZyAo5qKB5YuHKQ==?= <Yong.Liang@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <Yingjoe.Chen@mediatek.com>, "s-anna@ti.com" <s-anna@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 7:07 PM Crystal Guo <crystal.guo@mediatek.com> wrote:
>
> On Mon, 2020-11-30 at 19:13 +0800, Ikjoon Jang wrote:
> > On Wed, Sep 30, 2020 at 10:21:59AM +0800, Crystal Guo wrote:
> > > Force the write operation in case the read already happens
> > > to return the correct value.
> > >
> > > Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> > > ---
> > >  drivers/reset/reset-ti-syscon.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> > > index 5d1f8306cd4f..c34394f1e9e2 100644
> > > --- a/drivers/reset/reset-ti-syscon.c
> > > +++ b/drivers/reset/reset-ti-syscon.c
> > > @@ -97,7 +97,7 @@ static int ti_syscon_reset_assert(struct reset_controller_dev *rcdev,
> > >     mask = BIT(control->assert_bit);
> > >     value = (control->flags & ASSERT_SET) ? mask : 0x0;
> > >
> > > -   return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
> > > +   return regmap_write_bits(data->regmap, control->assert_offset, mask, value);
> > >  }
> >
> > I don't think there are no reset controllers with cached regmap,
> > thus I don't think this is needed.
> > Are there any specific reasons behind this, what I've missed here?
> >
> > We need to be sure that all other devices using this driver
> > should have no side effects on write.
> >
> > I can think of a weird controller doing unwanted things internally
> > on every write disregarding the current state. (or is this overly
> > paranoid?)
> >
> The specific reason is that, the clear bit may keep the same value with
> the set bit, but the clear operation can be only be completed by writing
> 1 to the clear bit, not just with the current fake state "1".
>

sorry. I didn't think of that case,
then I think this patch must be applied. 8-)

I've thought that the bit automatically flipped to the current reset state
after the internal operation is done.



> > >
> > >  /**
> > > @@ -128,7 +128,7 @@ static int ti_syscon_reset_deassert(struct reset_controller_dev *rcdev,
> > >     mask = BIT(control->deassert_bit);
> > >     value = (control->flags & DEASSERT_SET) ? mask : 0x0;
> > >
> > > -   return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
> > > +   return regmap_write_bits(data->regmap, control->deassert_offset, mask, value);
> > >  }
> > >
> > >  /**
>
