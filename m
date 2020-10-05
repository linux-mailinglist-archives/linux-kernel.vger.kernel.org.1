Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00928306E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgJEGoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:44:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:44:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so4535571wre.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 23:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzN1JPXKv6Spexj0EdyUYa+k+0ic40CtwBqEYlJv0uk=;
        b=c8bhvhnhBjP5jK5AeMYkiqxNK0zu/lboU4fLHLIp38CO7+yTdF6qhZ5BVDIj+cCKrE
         8TwZp1earI2N3vEBlCCFS/nqvsmQzBaKEXFShO0DE4B2Cf7jp9Ts3GbAjbcbuwPcY1Tr
         3lHb3e7RQ7yVlz8nAPJJqOeWx6/W8bs/X6GUDPGvq7xeuU9f/fdWh2O8Sq4lgS2lVorH
         lJCPOMzIG4S+4IjgSSRyVnTrc3sRNP0UTVricEFBArAlto46FnNXe3ZDIS3dLBIJATkX
         AD9tvajTipB1SIH6Dj+iBfh2GoocfoyHax5KW7PJUQLN0PYE7RhsUzzBvn89PqfkgjHZ
         JVlA==
X-Gm-Message-State: AOAM532WSf+heQZb/T7tN1Q5tL6giZO8Sv+QbBHclPOo156uxYYkOBYx
        AgM3KDq6w0sWjvcZ09gBSjFUK2kAQttEUfpSxzJsi5uFW48=
X-Google-Smtp-Source: ABdhPJzJraKz/rfOgCeb7Og+IIW+gvj3yn/RrgEdiZeXLCFiS1Menw7IFtSrPZBBB90TxwYwsWX0dVxlg/op711mQkk=
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr15240286wrx.133.1601880253409;
 Sun, 04 Oct 2020 23:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
 <20200611085900.49740-2-tomeu.vizoso@collabora.com> <1b72d5ad-365f-e7fb-624e-b88420ff264b@arm.com>
In-Reply-To: <1b72d5ad-365f-e7fb-624e-b88420ff264b@arm.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Mon, 5 Oct 2020 08:44:02 +0200
Message-ID: <CAAObsKBHe1a4cSe0LS64ikEVzU55FBK4yQbLpMxvOJsP9s=1Nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] panfrost: Add compatible string for bifrost
To:     Steven Price <steven.price@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 11:00, Steven Price <steven.price@arm.com> wrote:
>
> On 11/06/2020 09:58, Tomeu Vizoso wrote:
> > Mesa now supports some Bifrost devices, so enable it.
> >
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> Reviewed-by: Steven Price <steven.price@arm.com>
>
> I've also dug out my Hikey960 (from the box it's been in since lock down
> started), so I'll see if I can get things running on there, at the
> moment I'm seeing some DATA_INVALID_FAULT regressions running my hacked
> DDK :(

Hi!

Has this one fallen through the cracks?

Thanks,

Tomeu

>
> Steve
>
> > ---
> >   drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 882fecc33fdb..8ff8e140f91e 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -677,6 +677,7 @@ static const struct of_device_id dt_match[] = {
> >       { .compatible = "arm,mali-t830", .data = &default_data, },
> >       { .compatible = "arm,mali-t860", .data = &default_data, },
> >       { .compatible = "arm,mali-t880", .data = &default_data, },
> > +     { .compatible = "arm,mali-bifrost", .data = &default_data, },
> >       {}
> >   };
> >   MODULE_DEVICE_TABLE(of, dt_match);
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
