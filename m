Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A709929DE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgJ2Av3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgJ2Aub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:50:31 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530DCC0613CF;
        Wed, 28 Oct 2020 17:50:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p15so1615163ioh.0;
        Wed, 28 Oct 2020 17:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aw7ZHemSnajVRzYuFXmFbn4jbpV13Mk0VVFGbHWHtU=;
        b=CxDPTAZ9xoPOR2VRvQw+9E6WAmu71/qgxN+KqueOILrboadBMT+Rx/uQNdpPyOUu9V
         iO34P3hQt18DkXp66fjfvxorZWtTxqxCP89VrX5gUml/QAwfPuQqtzRFXuOepjiMmprs
         dex2ZNj7564llD2bUpw3+Bxtf/z950FiPX+Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aw7ZHemSnajVRzYuFXmFbn4jbpV13Mk0VVFGbHWHtU=;
        b=gWIP6Ogp50IBCTR9nPRfK7LFoZj0S1RPleSYNykIPUXaKmJmLNelPlE2CtlXyKNNi/
         lSYI7wuYRVSW5rweXFKLRc8AytV+a7rwNUwcCUiMQ9iSz6FfdN9GN9swLCn/oNABXJbM
         OJusBsvrmC8TIqPSKHqgptZZcLImV6d/SwMGev33u2nCEVvsLNYZmvVmK9OFGpfZ6na7
         eKGlftO5k4oG23d+akppL7UylkAuhQ9Cnh9WExBvgSZ4lwvRlQiXxfATGVHtiARAgjuR
         OMrzLdnUaYjcW2nBZ3gspkuHJ+KvS1tX3BhDmZzpn76NkorjXxKWhCNLqebzqqLY7DI1
         djGQ==
X-Gm-Message-State: AOAM530kKQ9+TdAU1EEEMr4aoAvanQQKACHqX3sxVHrUWlHq9fV7tOVh
        /XAj9kI4VOZwyaPP2MC6sQcUtWcHMgpfI6jtKd+leQNsoTOy2KK7
X-Google-Smtp-Source: ABdhPJwF26Jo+xfWPeZxUj30ahnn83k3ZAaKnMVTIkLm3zp3Zrdcuodf+uatXmR7Lray56YF9TVXu3DHmuQqMxbe2jc=
X-Received: by 2002:a37:a81:: with SMTP id 123mr5647706qkk.487.1603863175882;
 Tue, 27 Oct 2020 22:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201027123722.2935-1-aladyshev22@gmail.com> <CACPK8XcgKTEEfPL54Spd_AQTdJVm=xt+rqbteaYygLQw-GKRcQ@mail.gmail.com>
In-Reply-To: <CACPK8XcgKTEEfPL54Spd_AQTdJVm=xt+rqbteaYygLQw-GKRcQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Oct 2020 05:32:43 +0000
Message-ID: <CACPK8XeO2Cin2bNkjoHz-oK22mRb0LBHSYRTtd56r5trmihP-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to
 use v2 binding
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 at 05:25, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 27 Oct 2020 at 12:38, Konstantin Aladyshev
> <aladyshev22@gmail.com> wrote:
> >
> > KCS nodes compatible property in the 'aspeed-g5.dtsi' file was
> > changed to use v2 binding in the commit fa4c8ec6feaa
> > ("ARM: dts: aspeed: Change KCS nodes to v2 binding").
> > For the proper initialization of /dev/ipmi-kcs* devices
> > KCS node variables also need to be changed to use v2 binding.
> >
> > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
>
> Fixes: 09f5f680707e ("ipmi: kcs: aspeed: Implement v2 bindings")

Actually, this is probably better:

Fixes: fa4c8ec6feaa ("ARM: dts: aspeed: Change KCS nodes to v2 binding")

I slightly reworked your commit message when applying.

> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > index 60ba86f3e5bc..89ddc3847222 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > @@ -139,17 +139,17 @@
> >
> >  &kcs1 {
> >         status = "okay";
> > -       kcs_addr = <0x60>;
> > +       aspeed,lpc-io-reg = <0x60>;
> >  };
> >
> >  &kcs2 {
> >         status = "okay";
> > -       kcs_addr = <0x62>;
> > +       aspeed,lpc-io-reg = <0x62>;
> >  };
> >
> >  &kcs4 {
> >         status = "okay";
> > -       kcs_addr = <0x97DE>;
> > +       aspeed,lpc-io-reg = <0x97DE>;
> >  };
> >
> >  &lpc_snoop {
> > --
> > 2.17.1
> >
