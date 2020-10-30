Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE212A0559
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgJ3M3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgJ3M2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:28:10 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F50221E2;
        Fri, 30 Oct 2020 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604060889;
        bh=EFQjpPzs6+zs3In1trOoj0dsDrcGpKZn/Za8nWpBU5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0NmcrekU1RQuiKrqf7PI6Kx8piii70zyqQldvAq3ckp4j/1ZNrHaKQ7MTdJXxGa6C
         Hr/t2nRg6Vse2q6dhIFgpv/XXQhwy50UmdQ3VabO2d+yPCXxEPYFyLJPZTnjqK977S
         nm4d/5un638F9Z57gsjJyIJtG2t+wAfCItEAC1ZY=
Received: by mail-ej1-f51.google.com with SMTP id t25so8284829ejd.13;
        Fri, 30 Oct 2020 05:28:08 -0700 (PDT)
X-Gm-Message-State: AOAM533XceNbgKQ6Dybf3aQqGbotptTR2fXN9sKOF3tI9cny6yGSyQWA
        7ebJmjZH99QTixS669m1Dy/ccnWdTzLT6FCOW8w=
X-Google-Smtp-Source: ABdhPJwHVqKszwSnnQLEU1dfZt50CmmH7f4dwjnlNbunSDH08cjOE9GaY26SRqe6LIemeRqyzSI5rlu9S0AwYHKJR3E=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr2097831ejx.215.1604060886714;
 Fri, 30 Oct 2020 05:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200927165947.7317-1-krzk@kernel.org> <20200927165947.7317-2-krzk@kernel.org>
 <CAHCN7xL2uda0OvkSvZ3tCBGT=WU9OxMqeXvmJaeBSpwb--4=zQ@mail.gmail.com> <CAHCN7xKd=ba9j2D-VSkQf=2YNEm0LR1C+nk8n4C-kCJ3e0NV4g@mail.gmail.com>
In-Reply-To: <CAHCN7xKd=ba9j2D-VSkQf=2YNEm0LR1C+nk8n4C-kCJ3e0NV4g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 30 Oct 2020 13:27:55 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeMv8Aq_SgwNG3TM7t1rCXSUZrFte9Urqm2McWsQi+1zA@mail.gmail.com>
Message-ID: <CAJKOXPeMv8Aq_SgwNG3TM7t1rCXSUZrFte9Urqm2McWsQi+1zA@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: imx8mm-beacon-som: fix missing PMIC's
 interrupt line pull-up
To:     Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 at 13:26, Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Oct 7, 2020 at 7:51 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Sun, Sep 27, 2020 at 12:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > The PMIC's interrupt is level low and should be pulled up.  The PMIC's
> > > device node had pinctrl-0 property but it lacked pinctrl-names which
> > > is required to apply the pin configuration.
> > >
> >
> > Thanks for the fixes!
> >
> > > Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
> > > Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Tested-by: Adam Ford <aford173@gmail.com>
> >
>
> Shawn,
>
> Any chance you can apply this series?  Without this patch, the pmic
> driver throws some splat due to a previous fix.

I think Shawn applied it already yesterday or today.

Thanks for checking back on this.

Best regards,
Krzysztof
