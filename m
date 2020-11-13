Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5D2B1CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKMONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:13:00 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD10F22226;
        Fri, 13 Nov 2020 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605276779;
        bh=g3VM31K0NG7LqAnSgaUP3p+CmZcx4hSzlN+h8qaOZiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YN+ptGH7IxVgi1456cLOmm3Cig2q7+yNMAp2Ak5zw9ELgFooqFbJBP3hCmV4+eO8i
         kICE6+iu4iK6Ksl7SRJfjbmOgm73B5MOGqRsIN27mye7qevW1KstHT4wjbkqsm0Wb0
         dNxTH44ZUnhHMAlni7w+Hen1nPOmcL1MljNIQen4=
Date:   Fri, 13 Nov 2020 15:13:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 0/3] platform/chrome: cros_ec_typec: Add plug and plug
 altmodes
Message-ID: <X66Uo83dTGS2dMcx@kroah.com>
References: <20201112012329.1364975-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112012329.1364975-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:23:25PM -0800, Prashant Malani wrote:
> This patch series add plug registration support to the cros-ec-typec
> driver. It also adds support for registering alternate modes for the
> registered plug. These features utilize the API provided by the Type C
> connector class framework.
> 
> The first patch adds support to the connector class framework for the
> number_of_alternate_modes attribute (along with the relevant ABI
> documentation).
> 
> The next two patches add plug registration, and then altmode
> registration for the plugs. The latter of these two patches utilizes the
> new function for plug number_of_alternate_modes introduced in the first patch.
> 
> This series is based on top of the following branch and other patch
> series (applied in the order specified):
> - Branch: chrome-platform for-next [1], which is currently set to the
>   "Linux 5.10-rc1" tag.
> - cros-ec-typec: Patch series to register PD identity information + partner altmodes[2]
> - cros-ec-typec: Patch series to register cable[3]
> - cros-ec-typec: Patch series to add partner number_of_altmodes[4]
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=for-next
> [2]: https://lore.kernel.org/lkml/20201029222738.482366-1-pmalani@chromium.org/
> [3]: https://lore.kernel.org/lkml/20201106184104.939284-1-pmalani@chromium.org/
> [4]: https://lore.kernel.org/lkml/20201110061535.2163599-1-pmalani@chromium.org/

Ok, I'm confused.  This is not the first submission of this series, as
you sent out a v2 a few days before this one.

And am I supposed to suck in the chrome-platform branch into the
usb-next tree?

What should I do here, ignore these?  Merge them?

I see the USB change lost the reviewer's ack as well, why?

I'm going to delete all of these patches from my review queue now and
wait for a resend with some clarity as to what I should do with it :)

thanks,

greg k-h
