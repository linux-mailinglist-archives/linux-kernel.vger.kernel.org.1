Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07B2EBB3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAFIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAFIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:45:12 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F7C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:44:31 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id q10so1393528vsr.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BtqrpAZ+ssFRAoqkcqoX+i0pgFKIbpTJROkFhKnB54=;
        b=X6NOAGdSiz/IW64htDr3odCGFCPzWLdw7XHUJBvbZ00IdN6jDKzb1siXxIaPi6D5A4
         5SY3alIe8rbRH0qev5KIOe0isaJ7wHkYHKpmsWbmKEocFdYPWRLY5uyQIMJum8Q1qUOk
         bfZgrO8BjvLdMl6IN7roLOGRKB7/n15FTRqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BtqrpAZ+ssFRAoqkcqoX+i0pgFKIbpTJROkFhKnB54=;
        b=sPVf03pXqJDMY8N2wC3ScMd86NR+16sFPSHK3qBgjc0vQPcTl+3d8H6c2JRpnrPcQt
         KvvsUepzzUUBY4RRYmARqXB+d+G4g3puWmNiiA87uL8nbXsyjrYeuuNJF4bx/7jgK//9
         b/VwSEyPAvodPCdzVDKbwo3Nuu9FmL9UAxyGh4iE8e7TbRxGVKpBIjdwHQf847wzUUEr
         LJPGYR4k2NyKIx1aEnjdF6f8LkfXAaWxb+RRhfX3CIgh/TWiQlLKJB13hnE9F4VydLJI
         uAA4pEWInzB6ib/dwdjUNiD1ka1bX0qo1FQL3rthYCBs4dYb5V+CLs3FvzJZVYI9SqAH
         Ml/A==
X-Gm-Message-State: AOAM532Ocv2gdLlJVvPoqrbU6h+cgnMwJe9BBI7VXjKduJRkDE63Qyu+
        5YV3DedFwfvYiICLEutAxbey7/J2gO81s+91JnmGpA==
X-Google-Smtp-Source: ABdhPJyvWwQuY4TJxmlVoIBqvuScGueMmhttXzbYyJihh6nXvK0B7iBhP8fCeeXeXIPqoFUXoWoASZIehmQdnjNOooo=
X-Received: by 2002:a67:5c03:: with SMTP id q3mr2298164vsb.47.1609922670668;
 Wed, 06 Jan 2021 00:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20201227105449.11452-1-roger.lu@mediatek.com> <20201227105449.11452-4-roger.lu@mediatek.com>
 <CANMq1KBNKy708Vz67WOc+n7V7ne4L1EZVkUVGj6abd5voxKjxA@mail.gmail.com>
 <1609750266.20758.40.camel@mtksdaap41> <1609922515.18506.17.camel@mtksdaap41>
In-Reply-To: <1609922515.18506.17.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 6 Jan 2021 16:44:19 +0800
Message-ID: <CANMq1KCDPn6vRXMC5piH=Ym+ZGTiF=B4KAJ-5iKSWwVQLWgYNA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] [v10, 3/7]: soc: mediatek: SVS: introduce MTK SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 4:41 PM Roger Lu <roger.lu@mediatek.com> wrote:
>
> Hi Nicolas,
>
> [snip]
> > >
> > > > +
> > > > +       /* Svs efuse parsing */
> > > > +       ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
> > > > +
> > > > +       for (idx = 0; idx < svsp->bank_num; idx++) {
> > > > +               svsb = &svsp->banks[idx];
> > > > +
> > > > +               if (ft_pgm <= 1)
> > > > +                       svsb->init01_volt_flag = SVSB_INIT01_VOLT_IGNORE;
> > > > +
> > > > +               switch (svsb->sw_id) {
> > > > +               case SVSB_CPU_LITTLE:
> > > > +                       svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
> > > > +                       svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
> > > > +                       svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
> > > > +                       svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
> > > > +                       svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
> > >
> > > Again, if all of those values were u8, there'd be no need for these GENMASK
> >
> > Ok, I'll use u8 instead of GENMASK. Thanks.
>
> After refining the codes, I think it's much explicit to assign the bits
> I want by GENMASK() and will remove other GENMASK() that are repetitive
> like in svs_set_bank_phase() or svs_set_freqs_pct_v2().

I'm not sure what you mean, but, sure, you can go ahead with v11 and
we'll see how it looks.

Thanks,

> [snip]
>
