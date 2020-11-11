Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6E2AEF08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKKKzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgKKKzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:55:37 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3292067D;
        Wed, 11 Nov 2020 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605092137;
        bh=GodoxXRF2t+6JT7hRI+txJdHXviHQTs0JxH5PSbAj+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toDLooxMUGSJSCWRPvdwJ3Znuh2nNtDIqIYTJFzR7wgsG3G6KIe57BIbKgNNa+Y64
         GfgTktIfuVRC3xO1hTVMEYnU4mlDfY2XIY2jUMzp9NpxSuyZUak3H28IL6YAznGU4D
         v5GkrxY6fH4sAUtrw92FqDBQec3i3oXytKjBzp0c=
Date:   Wed, 11 Nov 2020 11:56:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Set partner
 num_altmodes
Message-ID: <X6vDZXI3Cp1pqRUr@kroah.com>
References: <20201110061535.2163599-1-pmalani@chromium.org>
 <20201110061535.2163599-2-pmalani@chromium.org>
 <20201110105015.GF1224435@kuha.fi.intel.com>
 <ba6c1415-457b-1e8d-b604-fad603fe9be6@collabora.com>
 <20201111102846.GP1224435@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111102846.GP1224435@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 12:28:46PM +0200, Heikki Krogerus wrote:
> On Tue, Nov 10, 2020 at 05:01:04PM +0100, Enric Balletbo i Serra wrote:
> > Hi,
> > 
> > On 10/11/20 11:50, Heikki Krogerus wrote:
> > > On Mon, Nov 09, 2020 at 10:15:36PM -0800, Prashant Malani wrote:
> > >> Set the number of altmodes available for a registered partner using the
> > >> Type C connector class framework routine.
> > >>
> > >> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > 
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > 
> > Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > Heikki, would you like to take these two through your tree? It'd help if you can
> > create an inmutable branch so I can pick other cros_ec_typec patches on top of it.
> 
> I'm sorry, but I don't actually maintain a tree for the USB Type-C
> stuff.
> 
> Greg, I'm sorry to bother you with this, but can you provide the
> immutable branch for Enric?

My usb tree branches are always immutable :)

> Maybe I should set up a tree for the USB Type-C stuff?

Or I can just take all of these patches as they depend on USB stuff more
than any other specific platform driver changes, right?

thanks,

greg k-h
