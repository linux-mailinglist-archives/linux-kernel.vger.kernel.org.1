Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2673D2A4D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgKCR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:57:08 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:57:08 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id d125so3893535vkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cmd/vHU2XpWN9RrkikP/uwzcHGztQHriQenbhifoFws=;
        b=W0iZ2ViLtWiGtTh4tYyeDJSlRjuWrEiPeo9pyaiaeroAkDmBc1BIpf8HUF6uOc3PEv
         L80UWx65jnFxKYYMS2SWdtr5iLvO3OjvhUduWd0TrBSB93wqKTMdoZBBIoBmcoTurlUa
         uyLfEY5nW5an1PxqHpGCXvwavubfMieQmbi19LkWDEwqY9B39nMXnUxASOljucw3uQH4
         VUdDQGs4YMuI/aI2731nXHL7al3f4uWSCy2/uy+j5yxVMnkDw/sJSmOR6SINVeOjQTWN
         5wQKJy6ogYLCsidNhzl2MTBYahMH+niyTiYdeerSnzuOvXOEcI9bICh6HvlEI9hIpY3R
         pErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cmd/vHU2XpWN9RrkikP/uwzcHGztQHriQenbhifoFws=;
        b=nMuEbmvzT1FVPn6uo7b/k3UCCVZBo7e4PjaUVL50d5BiweG8Vpn6aDpcLx2egaUUBR
         WHL/kgoG/RXQH1/aIlDbbAI2vtv2KNGa7+dMSpQrQ1qlx2Cytyqc3by27Yk7vnaVuHh3
         2kO3o+dX291U78PWAkdni1u60qJ84Wn2LqtkBHuV35fo+khPwXP/vNs0R03NduSCxF6u
         /UupXpFB5NYjOilRw2laPiKqt+Ng0rFfVI4cB2xW2nh+Yo9L4pRwiIi7A/tVNEQ8Tglh
         xKtW5S2rbAPVKt4XI1wQilKdv8IsQDFrVUWUOK0LXdcYvNXux9pNJNPVqkwBIwGEoIlx
         zuQA==
X-Gm-Message-State: AOAM531nESSMgrzHDaU3WeY3CWSJtlR9qFAgtlLMD3iHOyB4l6fFIWyE
        kHpLNl7PhF71EUxvJaedc4K10tODOx0=
X-Google-Smtp-Source: ABdhPJzcU9Bi4xq+LAmfqZEujvopElG4dTVi+c8OS7zSueMNWL1iAQhUdj0hYL1IrgspPCPSw+GOcg==
X-Received: by 2002:a1f:5682:: with SMTP id k124mr1885265vkb.24.1604426226829;
        Tue, 03 Nov 2020 09:57:06 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id v26sm1057691vsq.20.2020.11.03.09.57.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 09:57:03 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id z123so5231965vsb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:57:02 -0800 (PST)
X-Received: by 2002:a67:c981:: with SMTP id y1mr17877861vsk.14.1604426222523;
 Tue, 03 Nov 2020 09:57:02 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR18MB2679A2F3A2CE18CFA2427EEDC5110@BYAPR18MB2679.namprd18.prod.outlook.com>
In-Reply-To: <BYAPR18MB2679A2F3A2CE18CFA2427EEDC5110@BYAPR18MB2679.namprd18.prod.outlook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 3 Nov 2020 12:56:25 -0500
X-Gmail-Original-Message-ID: <CA+FuTScwuWvbdZgAyVSzGnqsF=EzOMYwj4RbwjxCFoAQKG19OQ@mail.gmail.com>
Message-ID: <CA+FuTScwuWvbdZgAyVSzGnqsF=EzOMYwj4RbwjxCFoAQKG19OQ@mail.gmail.com>
Subject: Re: [net-next PATCH 2/3] octeontx2-af: Add devlink health reporters
 for NPA
To:     George Cherian <gcherian@marvell.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 12:43 PM George Cherian <gcherian@marvell.com> wrote:
>
> Hi Willem,
>
>
> > -----Original Message-----
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Sent: Tuesday, November 3, 2020 7:21 PM
> > To: George Cherian <gcherian@marvell.com>
> > Cc: Network Development <netdev@vger.kernel.org>; linux-kernel <linux-
> > kernel@vger.kernel.org>; Jakub Kicinski <kuba@kernel.org>; David Miller
> > <davem@davemloft.net>; Sunil Kovvuri Goutham
> > <sgoutham@marvell.com>; Linu Cherian <lcherian@marvell.com>;
> > Geethasowjanya Akula <gakula@marvell.com>; masahiroy@kernel.org
> > Subject: [EXT] Re: [net-next PATCH 2/3] octeontx2-af: Add devlink health
> > reporters for NPA
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> > > > >  static int rvu_devlink_info_get(struct devlink *devlink, struct
> > > > devlink_info_req *req,
> > > > >                                 struct netlink_ext_ack *extack)  { @@
> > > > > -53,7 +483,8 @@ int rvu_register_dl(struct rvu *rvu)
> > > > >         rvu_dl->dl = dl;
> > > > >         rvu_dl->rvu = rvu;
> > > > >         rvu->rvu_dl = rvu_dl;
> > > > > -       return 0;
> > > > > +
> > > > > +       return rvu_health_reporters_create(rvu);
> > > >
> > > > when would this be called with rvu->rvu_dl == NULL?
> > >
> > > During initialization.
> >
> > This is the only caller, and it is only reached if rvu_dl is non-zero.
>
> Did you mean to ask, where is it de-initialized?
> If so, it should be done in rvu_unregister_dl() after freeing rvu_dl.

No, I meant that rvu_health_reporters_create does not need an
!rvu->rvu_dl precondition test, as the only callers calls with with a
non-zero rvu_dl.
