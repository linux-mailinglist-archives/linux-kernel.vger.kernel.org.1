Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9B2DEE67
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgLSLGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 06:06:49 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:35956 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLSLGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 06:06:49 -0500
Received: by mail-ej1-f50.google.com with SMTP id lt17so6917620ejb.3;
        Sat, 19 Dec 2020 03:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNKpcAvCckFtSnR2woLhuVnvJHZHQ3Z8UruGn8Oav2o=;
        b=cGS5gSg5NEgMqzxKDcWLlwc/Q6Dg/luGLDHr8TmCLpuOR14DLEIrsg//ij7x02i6Wk
         OpWkvd3NmUjh6NNFfSngPxOucI1cosVQGM3RGH9tvO+ZMbNqJ4pQin7ff2Nko9MACM5D
         UMbqvLVYaJ47ukgcpCF3pjJOFJWdDR8FvOGUBi8ycDlww0wUBnJljtJlhBRlmhSqoG07
         dU3pHYd3CxUzYd0P23UFXaGA2Xn1grW0paq0wPrLdL81d84vgT4in/vYicDhHwjts0B+
         SzLXTKNjSlZto4kW4HScmXCxcWeax0rWER3wd4jQovO0bzsIkVq52x0NVppsbX/V57ue
         aFRA==
X-Gm-Message-State: AOAM5332apcJNpXMkQ7dGBrs63pyFYa38yy3iJ97bpvX6nKvCsqR3Apg
        UFLTghHpkSPGWIun2a8E5Ao=
X-Google-Smtp-Source: ABdhPJzO9DNkFxh+zlxlbvHsEFM0VyzpmW79FhwTf3ogBtV+93P0q6SflgR8tQtTk1A7V51TjYNP0g==
X-Received: by 2002:a17:907:4243:: with SMTP id np3mr7881715ejb.212.1608375966504;
        Sat, 19 Dec 2020 03:06:06 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n22sm26169490edr.11.2020.12.19.03.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 03:06:05 -0800 (PST)
Date:   Sat, 19 Dec 2020 12:06:03 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 16/18] arm64: dts: hi3660: Harmonize DWC USB3 DT nodes
 name
Message-ID: <20201219110603.GA8061@kozik-lap>
References: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
 <20201111091552.15593-17-Sergey.Semin@baikalelectronics.ru>
 <CALAqxLWGujgR7p8Vb5S_RimRVYxwm5XF-c4NkKgMH-43wEBaWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALAqxLWGujgR7p8Vb5S_RimRVYxwm5XF-c4NkKgMH-43wEBaWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 09:11:42PM -0800, John Stultz wrote:
> On Wed, Nov 11, 2020 at 1:22 AM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > In accordance with the DWC USB3 bindings the corresponding node
> > name is suppose to comply with the Generic USB HCD DT schema, which
> > requires the USB nodes to have the name acceptable by the regexp:
> > "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> > named.
> >
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index d25aac5e0bf8..aea3800029b5 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -1166,7 +1166,7 @@ usb_phy: usb-phy {
> >                         };
> >                 };
> >
> > -               dwc3: dwc3@ff100000 {
> > +               dwc3: usb@ff100000 {
> >                         compatible = "snps,dwc3";
> >                         reg = <0x0 0xff100000 0x0 0x100000>;
> 
> 
> Oof. So this patch is breaking the usb gadget functionality on HiKey960 w/ AOSP.
> 
> In order to choose the right controller for gadget mode with AOSP, one
> sets the "sys.usb.controller" property, which until now for HiKey960
> has been "ff100000.dwc3".
> After this patch, the controller isn't found and we would have to
> change userland to use "ff100000.usb", which would then break booting
> on older kernels (testing various LTS releases on AOSP is one of the
> key uses of the HiKey960).
> 
> So while I understand the desire to unify the schema, as HiKey960
> really isn't likely to be used outside of AOSP, I wonder if reverting
> this one change is in the best interest of not breaking existing
> userland?

The node names are not part of an ABI, are they? I expect only
compatibles and properties to be stable. If user-space looks for
something by name, it's a user-space's mistake.  Not mentioning that you
also look for specific address... Imagine remapping of addresses with
ranges (for whatever reason) - AOSP also would be broken? Addresses are
definitely not an ABI.

Best regards,
Krzysztof

