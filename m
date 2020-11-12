Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FAB2AFC63
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgKLBgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgKKX2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:28:18 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647DC0613D4;
        Wed, 11 Nov 2020 15:28:18 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d28so3613652qka.11;
        Wed, 11 Nov 2020 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/pzSG/qY4kmN8qTffKOlLUErabhAzy6PW1pTMcSYxQ=;
        b=D1JWYbNjDgUOzZSIPZ8BN2CZsCIlgGjdqv7XrZYfFcWgDtKRKeTrhWWr6r31Uu//JA
         25VTHgRHj8XX+GB4JAJM2jtsR8ALyBMMZJP0osnrDCjjHzz8mTjRL6JLvGKJ3F1QuYZ7
         ebVBcCinXn8VTW/6R2XRzRGsU5gkUOevBT+RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/pzSG/qY4kmN8qTffKOlLUErabhAzy6PW1pTMcSYxQ=;
        b=M3rLkzg0rNdVBuBWOsXMrXNRuiaszOtYDEEqVfKsPNI+T6Q+oaLUiaUQDD/doFvzDq
         GsKY9fCGegC3pIRWBUnMXcqULqlfdsSmdqoGVj99/qg07saY341eJj5idFtjFfhwNRY5
         JubEOfAa6Z6AzghVqTJPO4NR6YaQRpNuznJVgkp5/xMAORFkTJ0hx/9ad9+gpjojNFzQ
         t6dKFZLXlk2stjGdH+D/M8F1s2jD6oWhUHxpWnQjade9YHvPT4CFgHZgkudoR1zuD+5R
         GaZVyn5q+rGPDA1+q9MYbElIItpXnlFu5jBBW4KpFfSl7YSSx6m6EDJTNyyEJyZjkrUc
         svSQ==
X-Gm-Message-State: AOAM531Onw7EojhWUtmmU+LX0d6l/YlMh20MMMeigU3VdH7B32hykpTv
        9k0XJ5DMwaLPlqCgp2TdMrpdKokrJeGqEuvGQ/w=
X-Google-Smtp-Source: ABdhPJyB+NvaUkOEgaloFMbC0GaxJHVeM1PcZvrlT6egRNPlwOrz0Tsa5BDYQDj1cLr7Y4YR91wqBJDgwazu8lLapj8=
X-Received: by 2002:ae9:e90d:: with SMTP id x13mr28158378qkf.66.1605137297631;
 Wed, 11 Nov 2020 15:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20201111132133.1253-1-aladyshev22@gmail.com> <1a223f4d-8654-89e9-3b39-97e4b1128700@amd.com>
In-Reply-To: <1a223f4d-8654-89e9-3b39-97e4b1128700@amd.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Nov 2020 23:28:02 +0000
Message-ID: <CACPK8Xehikj3ztsez-X-54MhacLKB-1xCnExWt49ELYfjTzecQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: amd-ethanolx: Add GPIO line names
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

On Wed, 11 Nov 2020 at 22:44, Supreeth Venkatesh
<supreeth.venkatesh@amd.com> wrote:
>
>
>
> On 11/11/20 7:21 AM, Konstantin Aladyshev wrote:
> > [CAUTION: External Email]
> >
> > Add GPIO line names for AMD EthanolX customer reference board.
> > It populates AST2500 GPIO lines (A0-A7 to AC0-AC7) with AMD EthanolX
> > designated names.
> >
> > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> Reviewed-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>

Applied to dt-for-v5.11.

Thanks,

Joel

> > ---
> >  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > index b93ed44eba0c..96ff0aea64e5 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> > @@ -97,6 +97,50 @@
> >                      &pinctrl_adc4_default>;
> >  };
> >
> > +&gpio {
> > +       status = "okay";
> > +       gpio-line-names =
> > +       /*A0-A7*/       "","","FAULT_LED","CHASSIS_ID_LED","","","","",
> > +       /*B0-B7*/       "","","","","","","","",
> > +       /*C0-C7*/       "CHASSIS_ID_BTN","INTRUDER","AC_LOSS","","","","","",
> > +       /*D0-D7*/       "HDT_DBREQ","LOCAL_SPI_ROM_SEL","FPGA_SPI_ROM_SEL","JTAG_MUX_S",
> > +                       "JTAG_MUX_OE","HDT_SEL","ASERT_WARM_RST_BTN","FPGA_RSVD",
> > +       /*E0-E7*/       "","","MON_P0_PWR_BTN","MON_P0_RST_BTN","MON_P0_NMI_BTN",
> > +                       "MON_P0_PWR_GOOD","MON_PWROK","MON_RESET",
> > +       /*F0-F7*/       "MON_P0_PROCHOT","MON_P1_PROCHOT","MON_P0_THERMTRIP",
> > +                       "MON_P1_THERMTRIP","P0_PRESENT","P1_PRESENT","MON_ATX_PWR_OK","",
> > +       /*G0-G7*/       "BRD_REV_ID_3","BRD_REV_ID_2","BRD_REV_ID_1","BRD_REV_ID_0",
> > +                       "P0_APML_ALERT","P1_APML_ALERT","FPGA ALERT","",
> > +       /*H0-H7*/       "BRD_ID_0","BRD_ID_1","BRD_ID_2","BRD_ID_3",
> > +                       "PCIE_DISCONNECTED","USB_DISCONNECTED","SPARE_0","SPARE_1",
> > +       /*I0-I7*/       "","","","","","","","",
> > +       /*J0-J7*/       "","","","","","","","",
> > +       /*K0-K7*/       "","","","","","","","",
> > +       /*L0-L7*/       "","","","","","","","",
> > +       /*M0-M7*/       "ASSERT_PWR_BTN","ASSERT_RST_BTN","ASSERT_NMI_BTN",
> > +                       "ASSERT_LOCAL_LOCK","ASSERT_P0_PROCHOT","ASSERT_P1_PROCHOT",
> > +                       "ASSERT_CLR_CMOS","ASSERT_BMC_READY",
> > +       /*N0-N7*/       "","","","","","","","",
> > +       /*O0-O7*/       "","","","","","","","",
> > +       /*P0-P7*/       "P0_VDD_CORE_RUN_VRHOT","P0_VDD_SOC_RUN_VRHOT",
> > +                       "P0_VDD_MEM_ABCD_SUS_VRHOT","P0_VDD_MEM_EFGH_SUS_VRHOT",
> > +                       "P1_VDD_CORE_RUN_VRHOT","P1_VDD_SOC_RUN_VRHOT",
> > +                       "P1_VDD_MEM_ABCD_SUS_VRHOT","P1_VDD_MEM_EFGH_SUS_VRHOT",
> > +       /*Q0-Q7*/       "","","","","","","","",
> > +       /*R0-R7*/       "","","","","","","","",
> > +       /*S0-S7*/       "","","","","","","","",
> > +       /*T0-T7*/       "","","","","","","","",
> > +       /*U0-U7*/       "","","","","","","","",
> > +       /*V0-V7*/       "","","","","","","","",
> > +       /*W0-W7*/       "","","","","","","","",
> > +       /*X0-X7*/       "","","","","","","","",
> > +       /*Y0-Y7*/       "","","","","","","","",
> > +       /*Z0-Z7*/       "","","","","","","","",
> > +       /*AA0-AA7*/     "","SENSOR THERM","","","","","","",
> > +       /*AB0-AB7*/     "","","","","","","","",
> > +       /*AC0-AC7*/     "","","","","","","","";
> > +};
> > +
> >  //APML for P0
> >  &i2c0 {
> >         status = "okay";
> > --
> > 2.17.1
> >
