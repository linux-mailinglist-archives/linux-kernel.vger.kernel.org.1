Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79502A949E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKFKql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFKql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:46:41 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D844E206FA;
        Fri,  6 Nov 2020 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604659599;
        bh=tahmYF1Nfurdnp3mCBUJ0EVpaeoL8OPekPU5wmxuvzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6gsHh5mYniFvIDSCrjKOwicyBqCj3D4XuGTVvH7F3KnFBbE3jS1vxb5ONSZvY+f1
         xvFom1RGaPnVr5qWWGKHOg4tqxqex1d3DNYIlb+aZCOOdU/sVgPFI5iU/U3oY7kP9b
         hiB802vTvNuZsEsvGa3Jrket+5qbA/Q6NlD42oxg=
Date:   Fri, 6 Nov 2020 11:47:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <20201106104725.GC2785199@kroah.com>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028091043.GC1947336@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:10:43AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Oct 09, 2020 at 04:40:45PM +0200, Benjamin Berg wrote:
> > From: Benjamin Berg <bberg@redhat.com>
> > 
> > Hi all,
> > 
> > so, I kept running in an issue where the UCSI port information was saying
> > that power was being delivered (online: 1), while no cable was attached.
> > 
> > The core of the problem is that there are scenarios where UCSI change
> > notifications are lost. This happens because querying the changes that
> > happened is done using the GET_CONNECTOR_STATUS command while clearing the
> > bitfield happens from the separate ACK command. Any change in between will
> > be lost.
> > 
> > Note that the problem may be almost invisible in the UI as e.g. GNOME will
> > still show the battery as discharging. But some policies like automatic
> > suspend may be applied incorrectly.
> > 
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > Benjamin Berg (2):
> >   usb: typec: ucsi: acpi: Always decode connector change information
> >   usb: typec: ucsi: Work around PPM losing change information
> 
> Do these need to be backported to stable kernel releases?  If so, how
> far back?

Due to the lack of response, I guess they don't need to go to any stable
kernel, so will queue them up for 5.11-rc1.

thanks,

greg k-h
