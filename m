Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39CE25C6C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgICQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 12:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgICQ1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:27:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F09520758;
        Thu,  3 Sep 2020 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599150452;
        bh=n18zFWphDNg2aRYfjtmiYIaEOax/Mxu+pvAzXVc1jPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6fIweep7s/hPm6QbZue1G+dM/GxD8ySstK8ScMaQN2tkcSPOzFlfnBbScumPtVP/
         z9iyOs2c9RSZYZ1vKazCyXX7ARd6iiKO0mdPOMJRM28z44nUr+Ce6vYXlvE9SbEXK1
         a8f72H6oG9i2T2BhEjbE8l1LriBXT3GagkDDhnFg=
Date:   Thu, 3 Sep 2020 18:27:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] Platform integrity information in sysfs
Message-ID: <20200903162756.GB406278@kroah.com>
References: <20200903161804.403299-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903161804.403299-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:18:04PM -0300, Daniel Gutson wrote:
> This patch exports information about the platform integrity
> firmware configuration in the sysfs filesystem.
> In this initial patch, I include some configuration attributes
> for the system SPI chip.
> 
> This initial version exports the BIOS Write Enable (bioswe),
> BIOS Lock Enable (ble), and the SMM BIOS Write Protect (SMM_BWP)
> fields of the BIOS Control register. The idea is to keep adding more
> flags, not only from the BC but also from other registers in following
> versions.
> 
> The goal is that the attributes are avilable to fwupd when SecureBoot
> is turned on.
> 
> The patch provides a new misc driver, as proposed in the previous patch,
> that provides a registration function for HW Driver devices to register
> class_attributes.
> In this case, the intel SPI flash chip (intel-spi) registers three
> class_attributes corresponding to the fields mentioned above.
> 
> This version of the patch provides a new API supporting regular
> device attributes rather than custom attributes, and also avoids
> a race condition when exporting the driver sysfs dir and the
> attributes files inside it.
> Also, this patch renames 'platform lockdown' by 'platform integrity'.
> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---

Always version your patches, there's no way this is "v1", right?

greg k-h
