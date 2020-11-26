Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9181D2C4FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbgKZIHx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Nov 2020 03:07:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37720 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgKZIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:07:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id h21so1403260wmb.2;
        Thu, 26 Nov 2020 00:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=touMMcxtN/klkfBzKGmR1GBeAIVZ5Q/OLb3bh+krvqw=;
        b=NHyfvK522HWNvxhnu8Aarb9k8q6E2+cvlxOlnssQJCf9zByQoDDjk8Kow9yB52g+tY
         67Vz98N/Fr6WlrKgEMGhvd8ycppwakmbAziMNnCpLJKYztehM1Ckt40jcVVg69zh6gG/
         v13lYTN59tCKCWL8qlZPl8skLijJ4HJe7rYZJaL1VMoUnA/e4sbtUckIkkc5xGdyeTax
         v+n/6QMd0agzdlpGRMrVF2P5bfoWEQmIEuiPUwTs5lSmJoAElDWZQEu+lSLdyY7mhMJn
         4DusXsnrTtnRAgYNds1uffJFlc+8QuUTn1lct0dfo/3dsCZJIXZHJsgwaX3m3gkpwkcb
         iWhA==
X-Gm-Message-State: AOAM531D7SCvCXfLyVsRnSwivQ30CJU6NMEOG8aAi2vSWS1PKD4IwrUv
        fxEyB2dlXKH8BzjnAp3kGKM=
X-Google-Smtp-Source: ABdhPJzBZ1+fYZhFRhcMpM8OBTLLHSNQoiR0ERzA+nGZZF28v4RH7uHopmtNRsmR6Xp2Medar4MN8Q==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr1927617wmh.160.1606378071210;
        Thu, 26 Nov 2020 00:07:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v20sm6904441wmh.44.2020.11.26.00.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 00:07:50 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:07:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     Adam Ford <aford173@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 4/4] soc: imx8m: change to use platform driver
Message-ID: <20201126080748.GC4347@kozik-lap>
References: <20201124015949.29262-1-alice.guo@nxp.com>
 <20201124015949.29262-4-alice.guo@nxp.com>
 <CAHCN7x+xRNZAEU0Y_nRSsKE5UtSvHT4E5WLx_NvLncbQMndnbw@mail.gmail.com>
 <AM6PR04MB60533EAB39259666F522E55DE2F90@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB60533EAB39259666F522E55DE2F90@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:15:35AM +0000, Alice Guo wrote:
> 
> 
> > -----Original Message-----
> > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> > Behalf Of Adam Ford
> > Sent: 2020年11月25日 8:45
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: devicetree <devicetree@vger.kernel.org>; Peng Fan <peng.fan@nxp.com>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Krzysztof Kozlowski <krzk@kernel.org>; Rob
> > Herring <robh+dt@kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Shawn Guo
> > <shawnguo@kernel.org>; arm-soc <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH v6 4/4] soc: imx8m: change to use platform driver
> > 
> > On Mon, Nov 23, 2020 at 8:04 PM Alice Guo <alice.guo@nxp.com> wrote:
> > >
> > > Directly reading ocotp register depends on that bootloader enables
> > > ocotp clk, which is not always effective, so change to use nvmem API.
> > > Using nvmem API requires to support driver defer probe and thus change
> > > soc-imx8m.c to use platform driver.
> > >
> > > The other reason is that directly reading ocotp register causes kexec
> > > kernel hang because the 1st kernel running will disable unused clks
> > > after kernel boots up, and then ocotp clk will be disabled even if
> > > bootloader enables it. When kexec kernel, ocotp clk needs to be
> > > enabled before reading ocotp registers, and nvmem API with platform
> > > driver supported can accomplish this.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >
> > The patch reads V6, but the change log only shows V2.  Can you elaborate on
> > what has changed between V2 and V6?
> > 
> > adam
> 
> Hi,
> 
> Sorry. The order of changlog is reversed. Thank Adam for pointing out the problem, and thank Krzysztof for reviewing my patch.
> Do I need to resend the patchset with the correct changelog order?

No, no need.

Best regards,
Krzysztof
