Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA028F79C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgJOR0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgJOR0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:26:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB1822210;
        Thu, 15 Oct 2020 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602782793;
        bh=3O/eM9/wBpQabvttClKuMGrs50v76YaYlpO9NRumXDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZk+EfB5w2VcyWwWdRH6LPD8cCpS4IphLNnX7Om1oR33bkZPndkUmy9uwyrHk8edM
         a2a/V4+t1Hfaf4s+/TPS7rPR7if7YnoeAWNkJKPHOeWRFOGmbTD/FXruAvsLxHeZcC
         HCW1VYZmmBwCeOA+Sp9PdFSGL9WDhqjivei7Jg2I=
Date:   Thu, 15 Oct 2020 19:27:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org, stuyoder@gmail.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/13] bus/fsl-mc: Extend mc-bus driver
 functionalities in preparation for mc-bus VFIO support
Message-ID: <20201015172706.GA85496@kroah.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
 <8b3c1222-5dbd-5c51-ac10-8b1c1a69d2d5@nxp.com>
 <20201002135512.GA3466738@kroah.com>
 <9e5576fb-6e42-4216-286c-7afb7979ed0b@nxp.com>
 <20201002140549.GA3492850@kroah.com>
 <20201014202742.43b0ff18@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014202742.43b0ff18@x1.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:27:42PM -0600, Alex Williamson wrote:
> On Fri, 2 Oct 2020 16:05:49 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Oct 02, 2020 at 04:56:52PM +0300, Laurentiu Tudor wrote:
> > > Hi Greg,
> > > 
> > > On 10/2/2020 4:55 PM, Greg KH wrote:  
> > > > On Tue, Sep 29, 2020 at 02:06:41PM +0300, Laurentiu Tudor wrote:  
> > > >>
> > > >>
> > > >> On 9/29/2020 11:54 AM, Diana Craciun wrote:  
> > > >>> The vfio-mc bus driver needs some additional services to be exported by the
> > > >>> mc-bus driver like:
> > > >>> - a way to reset the DPRC container
> > > >>> - driver_override support
> > > >>> - functions to setup/tear down a DPRC
> > > >>> - functions for allocating the pool of interrupts. In case of VFIO the
> > > >>> interrupts are not configured at probe time, but later by userspace
> > > >>> request
> > > >>>
> > > >>> v4 -> v5
> > > >>> - dprc_celanup should not fail
> > > >>>
> > > >>> v3 -> v4
> > > >>> - Rebased on the latest kernel.
> > > >>> - Exported a dprc_remove function
> > > >>>
> > > >>> v2 -> v3
> > > >>> - Add a new version for dprc_get_obj_region
> > > >>> - Export the cacheability bus specific bits defines
> > > >>>
> > > >>> v1 -> v2
> > > >>> - Remove driver_override propagation through various functions
> > > >>> - Cache the DPRC API version
> > > >>>
> > > >>> The patches are related with "vfio/fsl-mc: VFIO support for FSL-MC
> > > >>> devices" patches, but the series were split because they are targeting
> > > >>> different subsystems. However, the mc-bus patches may suffer changes
> > > >>> when addressing the VFIO review comments.
> > > >>>
> > > >>> The patches do not address the comment regarding moving driver_override
> > > >>> in the core code. I prefer not to tie these patches on that change and
> > > >>> address that separately.
> > > >>>
> > > >>> Bharat Bhushan (3):
> > > >>>   bus/fsl-mc: add support for 'driver_override' in the mc-bus
> > > >>>   bus/fsl-mc: Add dprc-reset-container support
> > > >>>   bus/fsl-mc: Extend ICID size from 16bit to 32bit
> > > >>>
> > > >>> Diana Craciun (10):
> > > >>>   bus/fsl-mc: Do no longer export the total number of irqs outside
> > > >>>     dprc_scan_objects
> > > >>>   bus/fsl-mc: Add a new parameter to dprc_scan_objects function
> > > >>>   bus/fsl-mc: Set the QMAN/BMAN region flags
> > > >>>   bus/fsl-mc: Cache the DPRC API version
> > > >>>   bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by
> > > >>>     multiple entities
> > > >>>   bus/fsl-mc: Export a cleanup function for DPRC
> > > >>>   bus/fsl-mc: Add a container setup function
> > > >>>   bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
> > > >>>   bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
> > > >>>   bus/fsl-mc: Add a new version for dprc_get_obj_region command
> > > >>>
> > > >>>  drivers/bus/fsl-mc/dprc-driver.c      | 190 ++++++++++++++++----------
> > > >>>  drivers/bus/fsl-mc/dprc.c             | 141 +++++++++++++++----
> > > >>>  drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
> > > >>>  drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
> > > >>>  drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
> > > >>>  drivers/bus/fsl-mc/mc-io.c            |   7 +-
> > > >>>  include/linux/fsl/mc.h                |  41 +++++-
> > > >>>  7 files changed, 359 insertions(+), 127 deletions(-)
> > > >>>  
> > > >>
> > > >> For the series:
> > > >> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > >> Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>  
> > > > 
> > > > Do you want me to take these patches in my tree, or are they going to
> > > > Linus some other way?  
> > > 
> > > I'm prefectly fine with you picking up the patches through your tree.  
> > 
> > Great, now queued up.
> 
> Hi Greg,
> 
> Diana has a vfio bus driver for fsl-mc devices queued up in my tree as
> well.  After a linux-next build failure due to our branches being
> applied in the wrong order, Stephen advised that the proper way to
> handle this is to merge a shared branch with this series.  Do you have
> a pull request imminent with this series or if not, would you mind
> pushing such a branch?  Thanks,

This should all now be in Linus's tree, so I don't think you need any
shared branch anymore :)

thanks,

greg k-h
