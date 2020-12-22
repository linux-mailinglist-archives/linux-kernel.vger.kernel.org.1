Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C462E08A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 11:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgLVKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLVKRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:17:09 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F42CC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:16:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e25so1651658wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qSbfk2F0eLFvwitEVSRjmdfYajz3GYQ51dbqSno7+aM=;
        b=WU6+4VMuyH/NBgUkks4ek4vv1jlVpt8LD/huC52vlmC4oVbZR74fqJJEkmCZDxCAbI
         smz4IKQkpvxiuZog+NGbP7sjOqXnElCLEIt53X9SHCAec+1luZyktn4DjeSGFrXoF7dq
         6mOnj8bppWCNR0DclEC29jqMIUqv2Xhh3dCEXU25c28BMDI7FZcYk6UsRVe65BvBfzcl
         CupuHwCYNDq6NXg+kytlRxq3BIEJjMK1p9sT5gMfO8jhz/azkDhf/3fuqgtI4jRekQhi
         sV/YdemtHs+MC4WNNJ0QxDB0/luQT7qqI88xNvc/pv/xFNw0SrEPawcpu/oSYZiwwFM9
         9iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qSbfk2F0eLFvwitEVSRjmdfYajz3GYQ51dbqSno7+aM=;
        b=NTPEzFGKgeFaUfEn1XYjxyvKtRpzlR64Bvf14r06rYrb8bd1SRcPkG53xwOqxzSriK
         lwO+Nej22ZXh22XUY7BIGRSdfHW0NBcFz7fPT4FJF0xuQG2JsPqaLj7zbPfPVBHYdY92
         XmCN/3WZZOe6fwHu6K9Fmy7bf+rvesqdXOJbSvX5xAAC1uLhw+R+hfdzjJp+hobAKqhR
         0tTdP2NAUmKx297cIFiDJjkzeGPa07RczGPjJGMID8ERmcWwS2C07fkGSX4raegobAxi
         ugkv+Phuu6Bgc2HN3ezijiEPed8oAbEWUaUTUjYQU79Rn7/RyiNi0EOrKoV2cItMv3Q1
         9AxQ==
X-Gm-Message-State: AOAM530NovGR5sis5ySlz7IrxBi8zYWU/RawhywPAh/OuZKB4sXZGA4C
        3OonDq724ALI7GgGs8l/wcWVLg==
X-Google-Smtp-Source: ABdhPJyOEK775E6e76t0lNQWsoM8ETC1I6bp/3ryi5wdBf4HfpttIEcevtqe5cht+mu6WmxyVT1MeQ==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr21589162wme.5.1608632187921;
        Tue, 22 Dec 2020 02:16:27 -0800 (PST)
Received: from dell ([91.110.221.175])
        by smtp.gmail.com with ESMTPSA id m81sm26537823wmf.29.2020.12.22.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 02:16:27 -0800 (PST)
Date:   Tue, 22 Dec 2020 10:16:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mfd: qca639x: add support for QCA639x powerup
 sequence
Message-ID: <20201222101625.GE53991@dell>
References: <20201220165845.3712599-1-dmitry.baryshkov@linaro.org>
 <20201220165845.3712599-3-dmitry.baryshkov@linaro.org>
 <20201221090244.GA53991@dell>
 <CAA8EJpo7oHVdDWjhnoknt0vAPYHL0LsZsT8q6MpQs20a+OiCAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpo7oHVdDWjhnoknt0vAPYHL0LsZsT8q6MpQs20a+OiCAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020, Dmitry Baryshkov wrote:

> Hello,
> 
> On Mon, 21 Dec 2020 at 12:02, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Sun, 20 Dec 2020, Dmitry Baryshkov wrote:
> >
> > > Qualcomm QCA639x is a family of WiFi + Bluetooth SoCs, with BT part
> > > being controlled through the UART and WiFi being present on PCIe
> > > bus. Both blocks share common power sources. So add mfd device driver
> > > handling power sequencing of QCA6390/1.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/mfd/Kconfig        |  12 +++
> > >  drivers/mfd/Makefile       |   1 +
> > >  drivers/mfd/qcom-qca639x.c | 168 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 181 insertions(+)
> > >  create mode 100644 drivers/mfd/qcom-qca639x.c
> >
> > This is not an MFD, since it utilised neither the MFD API nor
> > of_platform_populate() to register child devices.
> 
> It would use them if the WiFi part was not on a discoverable bus.

This is a can of worms that I do not wish to open right now.

However the TL;DR is:

 MFD is currently only *meant* for non-discoverable platform devices.

> > Suggest you use drivers/power or similar to handle shared power
> > sequencing requirements.
> 
> What about drivers/soc/qcom? Or drivers/misc?

These are 2 other subsystems, just like MFD, which are commonly used
as dumping grounds for code which doesn't fit anywhere else.  However,
I implore you to please try to find a suitable subsystem for this to
fit into first.  If this driver only deals with power management,
place it is a power related subsystem *before* considering drivers/soc
or drivers/misc.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
