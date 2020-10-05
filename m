Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE833283096
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJEHHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:07:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:07:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id j2so8232061wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 00:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrohg36P0AZbHBSqRV5jqlVokCKEytO/oqHskmI6OCI=;
        b=YcXoe/nvJ8HAQOgjOdYwl1B5ourD6tiqcSdnF5u2CYBqYQoDoIlJGWjb5qgRc5Xy4z
         CwUQUG5nT9KsjjiY1vb4jeFWZ5oXlRIaXBLHlBuu6u2sUNA2NCJF3AhzcR/aGdh7XhXZ
         NN+aUwIHqX1pq13OxCTNyUVx9KOg3rR7RnaSgMTO8GnE2p6slq4W59QdyDf4TzXS1LX3
         K5DAyIzDesD5t0CpkMCdwls5WDTXYXzql1V47wLVSGQ/nrWNQNi3dyGB50W2cLozEgUu
         pYJ1MjDUY349cjRqTgGMEWS09mLSOTQjoQnl1UPL146X4hf423EhuKizjXYswfEw2E1G
         Zgxg==
X-Gm-Message-State: AOAM531vTRRPspRNYCs+719TvC6ddcDvGj3osAnioZMFUhcdF5IWeDV/
        3E/fU2JoofOdmGG3FMcgZyKYqWo/BzivSFZLbRI1tCKpG1k=
X-Google-Smtp-Source: ABdhPJyyg8vHJsEqsfgfWlhj6Sg/nDU8VQLjXtiu1sCdUWtt7OKm0LW5Q8a0KePzR8KBxOSJN6PBoHUAhpVm97hJhj8=
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr15352084wrx.133.1601881628903;
 Mon, 05 Oct 2020 00:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
 <20200611085900.49740-2-tomeu.vizoso@collabora.com> <1b72d5ad-365f-e7fb-624e-b88420ff264b@arm.com>
 <CAAObsKBHe1a4cSe0LS64ikEVzU55FBK4yQbLpMxvOJsP9s=1Nw@mail.gmail.com>
In-Reply-To: <CAAObsKBHe1a4cSe0LS64ikEVzU55FBK4yQbLpMxvOJsP9s=1Nw@mail.gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Mon, 5 Oct 2020 09:06:57 +0200
Message-ID: <CAAObsKBxnxHiQ_ZcTgF4iuJr7w7L=OcL_Eha23Z2U66gpK-8gg@mail.gmail.com>
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

On Mon, 5 Oct 2020 at 08:44, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> On Fri, 19 Jun 2020 at 11:00, Steven Price <steven.price@arm.com> wrote:
> >
> > On 11/06/2020 09:58, Tomeu Vizoso wrote:
> > > Mesa now supports some Bifrost devices, so enable it.
> > >
> > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >
> > Reviewed-by: Steven Price <steven.price@arm.com>
> >
> > I've also dug out my Hikey960 (from the box it's been in since lock down
> > started), so I'll see if I can get things running on there, at the
> > moment I'm seeing some DATA_INVALID_FAULT regressions running my hacked
> > DDK :(
>
> Hi!
>
> Has this one fallen through the cracks?

Oops, sorry about the noise, I had an old checkout.

Cheers,

Tomeu

> Thanks,
>
> Tomeu
>
> >
> > Steve
> >
> > > ---
> > >   drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > index 882fecc33fdb..8ff8e140f91e 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > @@ -677,6 +677,7 @@ static const struct of_device_id dt_match[] = {
> > >       { .compatible = "arm,mali-t830", .data = &default_data, },
> > >       { .compatible = "arm,mali-t860", .data = &default_data, },
> > >       { .compatible = "arm,mali-t880", .data = &default_data, },
> > > +     { .compatible = "arm,mali-bifrost", .data = &default_data, },
> > >       {}
> > >   };
> > >   MODULE_DEVICE_TABLE(of, dt_match);
> > >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
