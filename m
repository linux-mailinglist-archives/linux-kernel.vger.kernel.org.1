Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4312629D9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389960AbgJ1XAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389911AbgJ1XAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:00:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C0C0613CF;
        Wed, 28 Oct 2020 16:00:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so1329965ior.2;
        Wed, 28 Oct 2020 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VlqcSxbD+zLpLTx76uBLItIwcrcc3ZCFs1WdNdmfa0=;
        b=LQDMMEApne+8MoHy34kvudx2LbXKqf9+rPl1U6HMLUgdj3hVYJa6ZZqfOdt18khqtF
         Y8qR3e4tV6JpGfmTU5EVUT+0b3mtPH46XQJ2WnU4MexLWydQVDN7A11ZihckrdLm8yZR
         glpYN4J4/+dIxP1AsmxqbDfq7kD8m/FewNEl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VlqcSxbD+zLpLTx76uBLItIwcrcc3ZCFs1WdNdmfa0=;
        b=QFGG0BZt/oImzu2mqnta+UHPQTp1u2GvzvwZ2sqIvZXlakfUAG6qvSoHbAm8I8RWC0
         vu7ti0ZY+9Idev4n44df3wwfvlXaz8XkEnnsGuGkXVsybGzn5nvr5VktIoXwS12Rfdve
         gN2osaKQPRncKqcDBUXPggPV5fPB0f2W7Ok938fvtQb8EmY7ndbcPyy2TGtDt45bbc5L
         /yBYc8UZXPGuwKOWn92tLTACQW2Kwz+u3Jd4Fi44eNUvFNm4LyGnnqUl7Ot493m/fnKg
         70Q4NzvdE+aid2WCxPY4gir1rSvdfGnZPxjZo8vMIRERrE0Hk5Ywow07yQ6HH5vfeAje
         gMBA==
X-Gm-Message-State: AOAM530CmK+kgTyKNOBkK1tRYKjilyzcsT7xwCmDSJLb2d3L6pyIDp2v
        RFJMZJikeAW/yIpHCIHx+DObEkfpuYeW6Hbj6VoZ/+cGVjecxg==
X-Google-Smtp-Source: ABdhPJxGTvfUKiXdm0GufiMR7Kg/9Pu15EnXOZNLVhMaVAa/tdwnYilJ2+nd98SbbcNfTjVhm+hyCdE0889DRu1/mfE=
X-Received: by 2002:a05:620a:1e7:: with SMTP id x7mr6190070qkn.465.1603878641900;
 Wed, 28 Oct 2020 02:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201027123722.2935-1-aladyshev22@gmail.com> <f35152af-34ad-178b-61db-0e57c8d19f3f@amd.com>
In-Reply-To: <f35152af-34ad-178b-61db-0e57c8d19f3f@amd.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Oct 2020 09:50:26 +0000
Message-ID: <CACPK8Xfr=Gd+oowhzZrLfAyVA7_J9=WhZGXUvfqXeu2XtP2A7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to
 use v2 binding
To:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
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

On Wed, 28 Oct 2020 at 09:00, Supreeth Venkatesh
<supreeth.venkatesh@amd.com> wrote:
>
> These changes are already merged in https://github.com/openbmc/linux/blob/dev-5.8/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts by Joel.
> Please abandon these changes.

That is the openbmc kernel tree, where we stage patches on their way
to mainline. This submission is for mainline, where this patch has not
been merged.

Cheers,

Joel

>
> Thanks,
> Supreeth
>
> On 10/27/20 7:37 AM, Konstantin Aladyshev wrote:
> > [CAUTION: External Email]
> >
> > KCS nodes compatible property in the 'aspeed-g5.dtsi' file was
> > changed to use v2 binding in the commit fa4c8ec6feaa
> > ("ARM: dts: aspeed: Change KCS nodes to v2 binding").
> > For the proper initialization of /dev/ipmi-kcs* devices
> > KCS node variables also need to be changed to use v2 binding.
> >
> > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
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
