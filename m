Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC02296D59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462772AbgJWLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462696AbgJWLHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:07:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557BC0613D2;
        Fri, 23 Oct 2020 04:07:13 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p15so1296535ioh.0;
        Fri, 23 Oct 2020 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXEDsRDVV8rh1B3Q3cHpVLNUC2R37hblRE9BeFnKf+4=;
        b=qGLTdvNuHZ09pivlcifdSyuTQbtrcr9pOQbCVOnfZRyqZFuN57aFWLJNWZrjAhPso9
         0MZ2GvE861jlNTcTX3tmILWV1HmSUishWU032LSbYB9uIe4lzILKxWSs9imKZSPpaI9E
         zXqkjv7ob2sl0hwa5e3HM3gBucf7Tu/ErgiX7K6mXzhRnFoFlvxue49U8uIKJq60q2Rp
         Pf+QcsGvMm4KX899exbltZQpDY8l9J61NRcJ0THql9cRWGq5Qd1Itb/89QN3NUY/St3Y
         t7PKWNH1+Kz42sdb27dX+cqoQlfBo+W12k7OI3RNtcpgDx14jAvdwVByDKboeBiqfNyJ
         QP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXEDsRDVV8rh1B3Q3cHpVLNUC2R37hblRE9BeFnKf+4=;
        b=pS6JIBmr8lXmaS9+FMl23zmTYrsPVJD7GfMrzsuKU0QdkLaFHHGsxxRe2rqQSJGBql
         8fGGi5i9cmwWmqC+gtzjMu61vEMvCXiy2+8QIGdqku9o/wWoMnY8HwZEWDAtUquplBgU
         Tk4qFE6YiyWtuospVZqkmVLWitcPAlYiEeX7DR401P8UR30ETUJW3clZKkcoRXG43WE2
         +brW3j5ZRYRm7FLuH//bg3yHp8TZTPYIYQmHvz4+aF6gxnd3dfAkUKInYHOxS1PSk9sY
         IVt1DhiDPpjXA5+siosJcggnS/wTRvXXfToov8IB1zYZCg4Zg3yaV9uOGf8KpstK+8W4
         Cqcw==
X-Gm-Message-State: AOAM531mCjTT+VHqgJDwLoeu/Mt3+B7j5VqoPagJRMdC+CLwH4yrDbje
        JFzuae90h5VYSevA3KtV7uAx0D3UNR7/wmZwMSY=
X-Google-Smtp-Source: ABdhPJxb9ZHpoGqQKMWQbjXvTOR2C9bdWXUF64vdZXeqdAzXc8zgYWE9IkQ+QUDU1Z5+Dkl0DBEcpJOwFjtD7IoSK3k=
X-Received: by 2002:a02:76c5:: with SMTP id z188mr1514736jab.74.1603451233064;
 Fri, 23 Oct 2020 04:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201022171639.773702-1-aford173@gmail.com> <5d17f3de-6864-c8fb-6413-24de943df1fd@denx.de>
 <CAHCN7x+66Ziza0G2Q6iho9z3RKsiw9=PyqoCayXCXyAONcDLow@mail.gmail.com> <15c51fd40f3c79b9afd208e2890263bb936e8434.camel@pengutronix.de>
In-Reply-To: <15c51fd40f3c79b9afd208e2890263bb936e8434.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 23 Oct 2020 06:07:02 -0500
Message-ID: <CAHCN7xLupOP2ukGwXp00duJtDYiyHKj7av71zxeCne3yXwPkmg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add GPU node
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 3:25 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> On Do, 2020-10-22 at 13:31 -0500, Adam Ford wrote:
> > On Thu, Oct 22, 2020 at 1:17 PM Marek Vasut <marex@denx.de> wrote:
> > > On 10/22/20 7:16 PM, Adam Ford wrote:
> > > > According to the documentation from NXP, the i.MX8M Nano has a
> > > > Vivante GC7000 Ultra Lite as its GPU core.
> > > >
> > > > With this patch, the Etnaviv driver presents the GPU as:
> > > >    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> > > >
> > > > It uses the GPCV2 controller to enable the power domain for the
> > > > GPU.
> > >
> > > Subject should say 8mn , not 8mm .
> >
> > ugh.. My mistake.  I'll submit a V2 once other have had a chance to
> > give some feedback.
> >
> > Maybe NXP can comment on the dialog below.
> >
> > > Are the assigned-clock-rates correct ?
> >
> > I used the assigned clock rates from the vendor kernel, with the
> > exception of running at 400MHz instead of 600MHz.  According to the
> > datasheet, the GPU clock needs to be 400MHZ to run at 0.85V. The
> > 600MHz operating point for the GPU requires a 0.95V operating point.
> > Since the default operating point for the Nano shows 0.85V, I left
> > the
> > GPU clock lower to match the normal operating speed.  This varies a
> > bit from the vendor kernel, but their kernel is also showing a 0.95V
> > operating point, so I think that's why they are specifying a 600MHz
> > operating point.
> >
> > On the Beacon embedded board, we're driving the LPDDR to 800MHz which
> > requires the ARM to run at .95V.   I was able to override the
> > assigned-clock rates for my board to run at 600MHz, and change the
> > ARM
> > operating point to .95V to meet the spec.
> >
> > My intent was to use the defaults and let the board files override
> > them.   If you want, I can try to look through the board files to see
> > what operating point their using and propose updates to those
> > respective device trees to address the clocks on those boards.
>
> I think this is fine as-is with this explanation. At least we have a
> precedent in the i.MX8MQ DT where the assigned clocks are for the base
> (non overdrive) operating point and boards can choose to override it if
> they want to use the overdrive OPP. At least until we add proper
> frequency scaling in etnaviv, which should obsolete those fixed clock
> rates.

I have to do a V2 from the feedback of Krzysztof.  I will expand the
commit message to include the description of the 400MHz vs 600MHz
clocking and the need for adjusting the operating points.

adam
>
> Regards,
> Lucas
>
