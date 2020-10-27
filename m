Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77F29CADA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373524AbgJ0VA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:00:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38976 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373511AbgJ0VA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:00:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id 184so4125523lfd.6;
        Tue, 27 Oct 2020 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7PGG156cg19twbXTKEP6KsKcgx/xu67BqCSAp2wGso=;
        b=ElUgjMkwUlxXH3aOdHNzbzqlkDzAJA6gyHEI6s8BCe6UAJHOGwsxQrICvT3kv33VuA
         0YkBLKrb5wtpEtzBgZvbAo3fIZBeUgwUvXRiTsPIJxwkXIAgqmqSV0/tY6qCjCsRh/on
         HjewOcE+Ya25yVwAuteuc0Rz+3pm1cCG/ddvUbZ7CoxJmVrDVThDR+mmEWPG8lYV7nha
         Y+FT9AgoJgNo7QfSz5PfDZi8qSeQ3b4d4wUaLUPvDZRM803nDa+VcryKHO2bvjQskukW
         nhs9rF87hmqrMehiK0AK0QRuvTqHsqO2pCwYkFqnEc+G48iDrMzsk5Vcdb2MRQyHQZXa
         G/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7PGG156cg19twbXTKEP6KsKcgx/xu67BqCSAp2wGso=;
        b=oP0nT1Hn/X/0WDxUGeV0HlJQnprj1LwhbC0PqxERes7mF3E2vsD4H/byGTIZ8bnq2k
         S5vdMoU4anszTz4etHv6BC/qlvZm1DF0u+M/UbtbGbgV1qm8R+O3pEOvVjhz7SZXrIjo
         vkL8tqbilCjyUKtju41BeA6UYnd23w45+3uwUdIjXMrp7e4UCzqYWeVKBKJSKS67AR1/
         TwynoUduV26RoyDfCJkQMQCiN2mOxK77gJkC3kyKdLlcVdhKVX+ARn8LCTzCs6TOlxSc
         RK9j1OdMrXx7qYdUV+cZupuncJWG21zYr24AnkRUKqFGZLDeYjMj4mF3BDD1swhRIFeS
         Pm3A==
X-Gm-Message-State: AOAM533SMG1ufAzjKcEEpbGDQEmm8EyRf+HPGleu8fKcPYya/xv/F7eX
        j9R/i4Ee2Kq67273mDXFszl8glTo49sRqoLR4tg=
X-Google-Smtp-Source: ABdhPJzRKV/YkyO+AIFyjgP7U9onChTXNYu9Sr4kL2PrmCdDG9M/zhQ40SSgrzzaoPkl6zwQRhTucXZ/9sRj9RSxEsg=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr1449082lfr.418.1603832453713;
 Tue, 27 Oct 2020 14:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201027123722.2935-1-aladyshev22@gmail.com> <f35152af-34ad-178b-61db-0e57c8d19f3f@amd.com>
In-Reply-To: <f35152af-34ad-178b-61db-0e57c8d19f3f@amd.com>
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Date:   Wed, 28 Oct 2020 00:00:41 +0300
Message-ID: <CACSj6VW_Nwwt=6fZG0OiKh4rySHPYs__uRzrN+=OdVwXVMz6og@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to
 use v2 binding
To:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes got picked up from my backport patch to the 'dev-5.8'
branch of the OpenBMC Linux repository.
This patch also needed to be added to the main ASPEED Linux kernel, so
it could get into subsequent branches of the OpenBMC Linux repository.

Best regards,
Konstantin Aladyshev


On Tue, Oct 27, 2020 at 5:10 PM Supreeth Venkatesh
<supreeth.venkatesh@amd.com> wrote:
>
> These changes are already merged in https://github.com/openbmc/linux/blob/dev-5.8/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts by Joel.
> Please abandon these changes.
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
