Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A62B7D80
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgKRMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgKRMQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:16:03 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1332E22202;
        Wed, 18 Nov 2020 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605701762;
        bh=q4cShSMUKnBa8V7sPSLhSXgfGhvt30XaVlBSN4Pgj7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwZs5/qv5ROkdk3mFD1pQbT/R1eA/2pHHO4pEwDoS/JzYI8LmA8TweSs8TeDB0sqD
         V4FVQg40NHdtlL8ZCFMGv5JB5xAB4USMyEIZIJl6VxgqFZca8nSZfzaMex4PrgfUbL
         mmx3oC0feeCxaQ5Eq5mAVfQ2KFgrIJn8ha+hbNww=
Date:   Wed, 18 Nov 2020 13:16:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 00/11] chrome/platform: cros_ec_typec: Register
 cables, partner altmodes and plug altmodes
Message-ID: <X7UQsaoNfziThXQs@kroah.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
 <X7UMvw7wnMapkAk8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7UMvw7wnMapkAk8@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:59:59PM +0100, Greg KH wrote:
> On Mon, Nov 16, 2020 at 12:11:36PM -0800, Prashant Malani wrote:
> > This patch series adds support for the following bits of functionality,
> > parsing USB Type C Power Delivery information from the Chrome Embedded Controller
> > and using the Type C connector class:
> > - Register cable objects (including plug type).
> > - Register "number of altmodes" attribute for partners.
> > - Register altmodes and "number of altmodes" attribute for cable plugs.
> > 
> > The functionality was earlier part of multiple series ([1], [2], [3]), but
> > I've combined it into 1 series and re-ordered the patches to hopefully make
> > it easier to peruse. I've maintained the patch Acked-by/Reviewed-by tags where
> > they were received.
> > 
> > Patches 1/11, 2/11, 3/11 introduce the changes needed in the USB subsystem (PD VDO
> > header update, sysfs attribute additions) and hence the first three patches
> > can go through Greg's tree.
> 
> I've taken the first 2 patches in my usb tree now, waiting for Heikki's
> response on patch 3 before I touch that.

Ok, now taken patch 3 too.

I can take the rest in my usb-next tree if the platform people don't
object as well, but would need an ack for that.

thanks,

greg k-h
