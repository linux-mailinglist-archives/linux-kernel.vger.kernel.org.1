Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB72F5C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbhANIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:20:19 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:35989 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbhANIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610612243;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=fEEp0Noi7jJWrCuf7sZQZHb+rVCjvIPHa+3gQdjlcmY=;
        b=GMf35K9dvlnfUsmw8xfeU6TEOgtXv/3Ewb/cqui18sywyEbfFDOtSCetP1XVuzOw/O
        2YVQ/MQhMRsJVvCuIr5lh2BiTwyGrK/6O514rWSm/Jdtc3NVUs4BtxwEO3Btx+vtVqAh
        7mZAuMBVJBoPzL0UeC6SeJqFflAc3rCfFaiy0qtOoX8/EeISrWuZoW6slyr8ki9nF2tt
        R+/e8+pg1LpfJNoCb05zGKS2VX7Kwab95yzaZV8uMh26wlR5nxcPH3wn9N1B0sMOeLKU
        FppVs8ihFc+XsyqkCVuFVWqbVFjI0sqcT2bBSqYIB+dtAa0uj/Sou98X5yjus9M8oMrc
        F74A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j5IczAa4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x0E8HGhGG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 14 Jan 2021 09:17:16 +0100 (CET)
Date:   Thu, 14 Jan 2021 09:17:08 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Peter Chen <hzpeterchen@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: Infinite recursion in device_reorder_to_tail() due to circular
 device links
Message-ID: <X//+BBbv454RuYqm@gerhold.net>
References: <X/ycQpu7NIGI969v@gerhold.net>
 <CAJZ5v0gAsZ45O8mv-gz0UvbyxnKA6fQBYvambBYEH6OSk3-m3g@mail.gmail.com>
 <CAJZ5v0h8bNp-=1zVfY5gZ1ezr8JRV4L8cEV45e+0f-aRSJnb1A@mail.gmail.com>
 <X/7XCzdDG7kbiNfM@gerhold.net>
 <20210114005454.GA14220@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114005454.GA14220@b29397-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Jan 14, 2021 at 08:54:54AM +0800, Peter Chen wrote:
> On 21-01-13 12:18:35, Stephan Gerhold wrote:
> > 
> > Also, on a completely different note I looked again at the chipidea USB
> > driver that produces this situation. To request the PHY (which ends up
> > in the circular device link) it does:
> > 
> > 	/* Look for a generic PHY first */
> > 	ci->phy = devm_phy_get(dev->parent, "usb-phy");
> > 
> > To me it doesn't really seem great to use the devm_* helpers on the
> > parent device either, so I will check if I can refactor this somehow.
> > Perhaps this situation can be prevented entirely.
> > 
> 
> You could try to get the PHY at parent driver
> (drivers/usb/chipidea/ci_hdrc_msm.c) to see the difference.
> 

Unfortunately, I don't think this works in my case because I have an
ULPI PHY. It's not available until ret = ci_ulpi_init(ci); is called
from the ci_hdrc.0 platform device.

I tried the following diff yesterday. It prevents the circular device
link, therefore also the crash and even devm_* on the parent device:

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index aa40e510b806..79f556d0c93e 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -847,6 +847,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
+	device_set_of_node_from_dev(&pdev->dev, dev);
+	pdev->driver_override = kstrdup("ci_hdrc", GFP_KERNEL);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)
@@ -1027,7 +1029,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		ci->usb_phy = ci->platdata->usb_phy;
 	} else {
 		/* Look for a generic PHY first */
-		ci->phy = devm_phy_get(dev->parent, "usb-phy");
+		ci->phy = devm_phy_get(dev, "usb-phy");
 
 		if (PTR_ERR(ci->phy) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;

Basically my idea was to share the of_node with the ci_hdrc.0 platform
device, so that it can request the PHY itself instead of going through
the parent.

It seems to work fine but I had to add pdev->driver_override to prevent
the ci_hdrc.0 device from probing using ci_hdrc_msm (since it considers
the "compatible" value on the of_node otherwise).

This is a bit weird (I think driver_override is mainly intended to be
written through sysfs, not from kernel code directly).
That is why I did not post this as a proper patch yet...

Thanks,
Stephan
