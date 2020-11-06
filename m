Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE92A9718
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgKFNk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgKFNkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:40:55 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036B620735;
        Fri,  6 Nov 2020 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604670054;
        bh=YwRjRr5lQ3DrZpfxUlBZhH48YgZI3xA4YO4Sg1E415c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4qmm7sLeUGaNiAgiy4WPChA/ZU3+M1x3a9Wu04rQnc0fOQy+x24c4KFbTl5jQjZH
         jLDCXPJRBCUS3kcG6Xv4dp7+ED8YWGb1Crx6Px1WDHHk0INGxdE4xfTy6VJfm3BQmi
         nnkpgO+znrw8YXgpe+OO//E9kgNlyWPAlQAUNgVI=
Date:   Fri, 6 Nov 2020 14:41:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     peter.chen@nxp.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        colin.king@canonical.com, rogerq@ti.com, kurahul@cadence.com,
        nsekhar@ti.com
Subject: Re: [PATCH v2 00/10] Introduced new Cadence USBSSP DRD Driver.
Message-ID: <20201106134136.GA3316286@kroah.com>
References: <20201106114300.1245-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106114300.1245-1-pawell@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:42:50PM +0100, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> 
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
> The current driver has been validated with FPGA burned. We have support
> for PCIe bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliance with XHCI
> specification, so it works with standard XHCI Linux driver.
> 
> The device side of USBSS DRD controller is compliant with XHCI.
> The architecture for device side is almost the same as for host side,
> and most of the XHCI specification can be used to understand how
> this controller operates.
> 
> This controller and driver support Full Speed, Hight Speed, Supper Speed
> and Supper Speed Plus USB protocol.
> 
> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
> The last letter of this acronym means PLUS. The formal name of controller
> is USBSSP but it's to generic so I've decided to use CDNSP.
> 
> The patch 1: adds support for DRD CDNSP.
> The patch 2: separates common code that can be reusable by cdnsp driver.
> The patch 3: moves reusable code to separate module.
> The patch 4: changes prefixes in reusable code from cdns3 to common cdns.
> The patch 5: adopts gadget_dev pointer in cdns structure to make possible 
>              use it in both drivers.
> The patches 6-8: add the main part of driver and has been intentionally
>              split into 3 part. In my opinion such division should not
>              affect understanding and reviewing the driver, and cause that
>              main patch (7/8) is little smaller. Patch 6 introduces main
>              header file for driver, 7 is the main part that implements all
>              functionality of driver and 8 introduces tracepoints.
> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
> 
> Changlog from v1:
> - updated common code to latest cdns3 driver
> - moved cdnsp driver files to cdns3 as sugested by Peter Chan
> - removed duplicate code from cdnsp_ep0_set_config function
> - added cdns3 prefixes to file related with USBSS driver
> - updated MAINTAINERS file
> - fixed issue with U1
> - fixed issue with L1
> - some less improtant changes sugested by Chunfeng Yun

After a quick review, I don't see anything wrong with this series, nice
work.

It does feel odd you need to split things into a "common" and then 2
other modules, but I guess it makes sense.  Worst case, over time, you
merge them back together after everyone just ends up enabling both of
them :)

Felipe, want me to take these directly, or should they go through your
tree after you review them?  I never remember with this driver whose it
goes through.

thanks,

greg k-h
