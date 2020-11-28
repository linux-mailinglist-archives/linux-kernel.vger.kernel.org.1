Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842802C7124
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbgK1Vxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgK1THa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:07:30 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE44C02A184;
        Sat, 28 Nov 2020 03:54:17 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d17so7156010ion.4;
        Sat, 28 Nov 2020 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kMJjaDqWu8SIrRxN1/QhPBWAa69bgxwXfwhv5mcpQCg=;
        b=tRxMJgXatjJlXrsne/uHFdIEERR3fjha/6l0gtIOY8lPlttwBGhFwS/7FOENu/bsS0
         ARo6/UoEn1eJ8mk2iJM5fLTlnrJWnyg/FUpaifFDYkQ84uWFHS+fURml8iK6ePTBT4v4
         7Ctm+ITLSylSWtsoUHBHLrOLLyjMhLyAZRQ44xLNCD5/36nC/1sBqFGWnzOOz28hVMJo
         n7rZPv/hEFLVeQqac3TOy3j6mM4ouaVwtcgeYy4NzBiYID6n5TxzlLRs2ZK4rJGp9CqG
         KbCybHEOp+YrautriY35UEXHVQ6tqiDzeZ+pi/TOjTUU9rvwTrEc+wqhlTLx8tC9kDFK
         hWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kMJjaDqWu8SIrRxN1/QhPBWAa69bgxwXfwhv5mcpQCg=;
        b=jbZqK4D6mp1iyb8sqIW0bUVVNecBjnRbVKVs1pyZx8/miOHLsR35nnQ2WQ2f/Ax1c8
         mYIHLp47Cq6U46BnShDNBKgSh3bVQlXojEGdlBhV4juf76ce/CFnB9TKJjkz0BOinIDM
         ihPNB0nLr565UFxJcknPL7tPvDfP7neSoi20mYVPcSEt/78PdeEBdPiIOkmP3GXhsTYj
         TS0xsS1I6sFTOskDsmdV6G6Kq6XUz34FD+mForQePN5t2ldOLcBwUFYeVblHGM/uGRIN
         OwLx/ddhTCc+pWTsubVU9O4YFadZ8x9zz2cx+HHLoxCZd2tWT4TYP3+FrcfawXzsOlau
         bi4Q==
X-Gm-Message-State: AOAM533KpYvkrXxbhoX1WGHh/qZxU1MZJlMuDwkngfMhTzjVas3OwNp/
        OnH9rA1d0lPpiMqXTRVAt9O3A1eXAhPUT9SY3LQ=
X-Google-Smtp-Source: ABdhPJxO/gfRABaLOYVENcxLdVOY2/zhTsTuA6eQ4fSpbMgtZvmiiVoHbOJAH2fA/Gh/o3fyhNQZ8225h6K7iO7pqWE=
X-Received: by 2002:a5d:9710:: with SMTP id h16mr3868396iol.123.1606564455484;
 Sat, 28 Nov 2020 03:54:15 -0800 (PST)
MIME-Version: 1.0
References: <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io> <20201116155508.364dg6ycklwylswe@gilmour.lan>
 <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io> <20201120155939.3ajmbny2pka2vsnf@gilmour>
 <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io> <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
 <20201123111512.y7lbwsipbkcpuleb@gilmour> <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
 <20201123125332.2p5z3ew7svszvyfs@gilmour> <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
 <20201128103827.d6sfc2eumli2betx@gilmour> <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io>
In-Reply-To: <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 28 Nov 2020 12:54:04 +0100
Message-ID: <CAJiuCcfEcM+Dksm4uoRPCiRepDSnEmp7pr8Qk5EsFSH_zEOTYA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Samuel Holland <samuel@sholland.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Sat, 28 Nov 2020 at 12:28, Icenowy Zheng <icenowy@aosc.io> wrote:
>
> =E5=9C=A8 2020-11-28=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 11:38 +0100=EF=
=BC=8CMaxime Ripard=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
> > > > > > > > Okay. But I'm not satisfied with a non-public sample
> > > > > > > > occupies
> > > > > > > > the pinetab name. Is rename it to pinetab-dev and add a
> > > > > > > > pinetab-retail okay?
> > > > > > >
> > > > > > > To me, naming the production version anything but "pinetab"
> > > > > > > isn't
> > > > > > > satisfying either.
> > > > > >
> > > > > > I understand where you're coming from, but the point I was
> > > > > > making my
> > > > > > previous mail is precisely that it's not really possible.
> > > > > >
> > > > > > You want to name the early adopter version _the_ production
> > > > > > version. Let's assume the hardware changes again between the
> > > > > > early
> > > > > > adopter and mass-production version. Which one will be _the_
> > > > > > production version? The early-adopter or the mass-produced
> > > > > > one?
> > > > > >
> > > > > > There's really no good answer here, and both would suck in
> > > > > > their
> > > > > > own way. The only way to deal with this is to simply avoid
> > > > > > defining one version as the one true board, and just loading
> > > > > > the
> > > > > > proper DT in u-boot based on whatever clue we have of the
> > > > > > hardware
> > > > > > revision.
> > > > > Then will it be okay to rename current pinetab DT to
> > > > > pinetab-sample and then introduce new DTs all with suffixes?
> > > >
> > > > No. From my previous mail:
> > >
> > > It can be seen as dropping the PineTab DT and introduce new DTs
> > > with
> > > suffix.
> > >
> > > Do we have rule that we cannot drop boards?
> >
> > Are you really arguing that removing a DT and then adding an
> > identical
> > one under a different name is not renaming it?
>
> Then we can just keep confusing name?

Sorry maybe I missed some information
But why don't you do like pinephone?
sun50i-a64-pinetab-1.0.dts
sun50i-a64-pinetab-1.1.dts

-dev is also a confusing name I think, as the board has been already shippe=
d.

Regards,
Clement


>
> If we do so, how can we mark the new DT as "the user should use this
> one"?
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel%40aosc.io.
