Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE32CC6C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgLBTiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:38:15 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:36246 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgLBTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:38:14 -0500
Received: by mail-ej1-f50.google.com with SMTP id lt17so6207476ejb.3;
        Wed, 02 Dec 2020 11:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqcmkOFuCaTHVbXHjOOh4znxdETiilgokDAWKjVlhTs=;
        b=dKTfdAmt1Y2X7fhkg8+jQKOHYAHFJI7FrL1Y974dhtIGmPwK+cAACZk0LcaBNRWOPL
         InhjxyuNFyLupU+1DrbX4eTh4sTsqQ1k4XFC/ydl4PsABNPwMBmo/axHUZ5YqR/nxyal
         H53s6jKryU51FQp73SjB+7Q12LDUxkqclpkO7YFkY6p+KQU6dqnO2nevtcxOLZ5y5CYt
         pG4ZHmCiKeEvORb2P5A+UzformbOZH2kMe7wlFa+/RqB4b50+EbEDeKe4ZMXgCvqvhg3
         EgRKhvtTnEd9ke7VCN3qVhFN6MPHSKS+XTrR/oCL9GQljA3fBHuN7zSy0trdLtMAofJZ
         mG4w==
X-Gm-Message-State: AOAM532DQTfnxnRYZ4X3pUO/nvRMGXdV6Bdt0ZA62jkF0Jqhj5XZtjx+
        vw3Rn6cPz7OTn55WD6aXd10=
X-Google-Smtp-Source: ABdhPJwAsksTvdSbHVxbr54BasGj2CDw87QofabD7Y4VuiI9Aq32e705fsdkmsvafdkPlyS+qLaO+A==
X-Received: by 2002:a17:906:8151:: with SMTP id z17mr1382726ejw.48.1606937846532;
        Wed, 02 Dec 2020 11:37:26 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n17sm532613ejh.49.2020.12.02.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:37:25 -0800 (PST)
Date:   Wed, 2 Dec 2020 21:37:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH 04/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 SOM
Message-ID: <20201202193724.GB85884@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-5-jagan@amarulasolutions.com>
 <20201202173405.GD3490@kozik-lap>
 <CAMty3ZDg-7J9zk14Y-L1LBJsVnoK7KvposzBNnDP7gRdR3NHEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZDg-7J9zk14Y-L1LBJsVnoK7KvposzBNnDP7gRdR3NHEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 01:00:59AM +0530, Jagan Teki wrote:
> Hi Krzysztof,
> 
> On Wed, Dec 2, 2020 at 11:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, Dec 02, 2020 at 05:42:35PM +0530, Jagan Teki wrote:
> > > i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> >
> > s/SOM/SoM/
> >
> > >
> > > General features:
> > > - NXP i.MX8MM
> >
> > i.MX 8M Mini
> > as named by NXP:
> > https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-processors/i-mx-8m-mini-arm-cortex-a53-cortex-m4-audio-voice-video:i.MX8MMINI
> >
> > > - Up to 2GB LDDR4
> > > - 8/16GB eMMC
> > > - Gigabit Ethernet
> > > - USB 2.0 Host/OTG
> > > - PCIe Gen2 interface
> > > - I2S
> > > - MIPI DSI to LVDS
> > > - rest of i.MX8MM features
> >
> > Ditto
> >
> > >
> > > i.Core MX8M Mini needs to mount on top of Engicam baseboards for
> > > creating complete platform boards.
> > >
> > > Possible baseboards are,
> > > - EDIMM2.2
> > > - C.TOUCH 2.0
> >
> > Don't describe baseboards. You add here only SoM.
> 
> It's just information on how this SoM is being used. Let me know any
> issues while explaining the combinations being used here.

Don't describe baseboards. No point to blow up description. Include only
information relevant to this patch.

Best regards,
Krzysztof
