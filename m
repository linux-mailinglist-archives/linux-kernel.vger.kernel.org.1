Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987A128EB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 04:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgJOC1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 22:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbgJOC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 22:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602728866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyAP3Rfg7FJTxqxuK3r1p6Qq+lXnyE1YhC8oWkK3KlY=;
        b=fJvQBsQLC+0gyTMPML38nsUEAZk0wP6GoMqWS6h+d8Bdd1NukMgKxUfJoKZtISH2/p3oby
        nZG3jECmVoTwTJtJZhpt+9QqB0Sk7U2kK5qFb01Gz0tovd79MJD1E8OutGXWgJ2r2h2aMT
        7/gGVEYytk3MF8w4d8v7AFeV4qXio7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-v0H6X6AFNsyEv4BRT9Yh5w-1; Wed, 14 Oct 2020 22:27:44 -0400
X-MC-Unique: v0H6X6AFNsyEv4BRT9Yh5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3739F1007464;
        Thu, 15 Oct 2020 02:27:43 +0000 (UTC)
Received: from x1.home (ovpn-113-35.phx2.redhat.com [10.3.113.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5F8610F3;
        Thu, 15 Oct 2020 02:27:42 +0000 (UTC)
Date:   Wed, 14 Oct 2020 20:27:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org, stuyoder@gmail.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/13] bus/fsl-mc: Extend mc-bus driver
 functionalities in preparation for mc-bus VFIO support
Message-ID: <20201014202742.43b0ff18@x1.home>
In-Reply-To: <20201002140549.GA3492850@kroah.com>
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
        <8b3c1222-5dbd-5c51-ac10-8b1c1a69d2d5@nxp.com>
        <20201002135512.GA3466738@kroah.com>
        <9e5576fb-6e42-4216-286c-7afb7979ed0b@nxp.com>
        <20201002140549.GA3492850@kroah.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 16:05:49 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 02, 2020 at 04:56:52PM +0300, Laurentiu Tudor wrote:
> > Hi Greg,
> > 
> > On 10/2/2020 4:55 PM, Greg KH wrote:  
> > > On Tue, Sep 29, 2020 at 02:06:41PM +0300, Laurentiu Tudor wrote:  
> > >>
> > >>
> > >> On 9/29/2020 11:54 AM, Diana Craciun wrote:  
> > >>> The vfio-mc bus driver needs some additional services to be exported by the
> > >>> mc-bus driver like:
> > >>> - a way to reset the DPRC container
> > >>> - driver_override support
> > >>> - functions to setup/tear down a DPRC
> > >>> - functions for allocating the pool of interrupts. In case of VFIO the
> > >>> interrupts are not configured at probe time, but later by userspace
> > >>> request
> > >>>
> > >>> v4 -> v5
> > >>> - dprc_celanup should not fail
> > >>>
> > >>> v3 -> v4
> > >>> - Rebased on the latest kernel.
> > >>> - Exported a dprc_remove function
> > >>>
> > >>> v2 -> v3
> > >>> - Add a new version for dprc_get_obj_region
> > >>> - Export the cacheability bus specific bits defines
> > >>>
> > >>> v1 -> v2
> > >>> - Remove driver_override propagation through various functions
> > >>> - Cache the DPRC API version
> > >>>
> > >>> The patches are related with "vfio/fsl-mc: VFIO support for FSL-MC
> > >>> devices" patches, but the series were split because they are targeting
> > >>> different subsystems. However, the mc-bus patches may suffer changes
> > >>> when addressing the VFIO review comments.
> > >>>
> > >>> The patches do not address the comment regarding moving driver_override
> > >>> in the core code. I prefer not to tie these patches on that change and
> > >>> address that separately.
> > >>>
> > >>> Bharat Bhushan (3):
> > >>>   bus/fsl-mc: add support for 'driver_override' in the mc-bus
> > >>>   bus/fsl-mc: Add dprc-reset-container support
> > >>>   bus/fsl-mc: Extend ICID size from 16bit to 32bit
> > >>>
> > >>> Diana Craciun (10):
> > >>>   bus/fsl-mc: Do no longer export the total number of irqs outside
> > >>>     dprc_scan_objects
> > >>>   bus/fsl-mc: Add a new parameter to dprc_scan_objects function
> > >>>   bus/fsl-mc: Set the QMAN/BMAN region flags
> > >>>   bus/fsl-mc: Cache the DPRC API version
> > >>>   bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by
> > >>>     multiple entities
> > >>>   bus/fsl-mc: Export a cleanup function for DPRC
> > >>>   bus/fsl-mc: Add a container setup function
> > >>>   bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
> > >>>   bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
> > >>>   bus/fsl-mc: Add a new version for dprc_get_obj_region command
> > >>>
> > >>>  drivers/bus/fsl-mc/dprc-driver.c      | 190 ++++++++++++++++----------
> > >>>  drivers/bus/fsl-mc/dprc.c             | 141 +++++++++++++++----
> > >>>  drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
> > >>>  drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
> > >>>  drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
> > >>>  drivers/bus/fsl-mc/mc-io.c            |   7 +-
> > >>>  include/linux/fsl/mc.h                |  41 +++++-
> > >>>  7 files changed, 359 insertions(+), 127 deletions(-)
> > >>>  
> > >>
> > >> For the series:
> > >> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > >> Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>  
> > > 
> > > Do you want me to take these patches in my tree, or are they going to
> > > Linus some other way?  
> > 
> > I'm prefectly fine with you picking up the patches through your tree.  
> 
> Great, now queued up.

Hi Greg,

Diana has a vfio bus driver for fsl-mc devices queued up in my tree as
well.  After a linux-next build failure due to our branches being
applied in the wrong order, Stephen advised that the proper way to
handle this is to merge a shared branch with this series.  Do you have
a pull request imminent with this series or if not, would you mind
pushing such a branch?  Thanks,

Alex

