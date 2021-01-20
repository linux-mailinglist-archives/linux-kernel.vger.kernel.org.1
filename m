Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53B2FD6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391771AbhATRSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404050AbhATRSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:18:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07C7022CE3;
        Wed, 20 Jan 2021 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611163058;
        bh=9WZ/m19z2HGkINVwNeYp/+wcK7hXnj4kx5NeS4ydpJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAosQ5P65dgOHKIO0YQi5Sj0fPMVYX1loaU/SHZ1bBzto/EbQxH7ttoCeQld4jojx
         6/YFWJLma/2eAPw1Aq2WhdJ/koSKXt+Fya54smDXwV0+VU8PRakWl1//ZmXzGgZqh6
         sINSZtlc9ccu8xdTcFTKpVS6uIiPHUK7T5RbmVyc=
Date:   Wed, 20 Jan 2021 18:17:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] AMS, Collision Avoidance, and Protocol Error
Message-ID: <YAhlrxRdURu0djbf@kroah.com>
References: <20210114145053.1952756-1-kyletso@google.com>
 <2211ad43-b76c-fbe9-2cc8-bb40c4ee4e89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2211ad43-b76c-fbe9-2cc8-bb40c4ee4e89@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:45:02PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 1/14/21 3:50 PM, Kyle Tso wrote:
> > v5 https://lore.kernel.org/r/20210105163927.1376770-1-kyletso@google.com
> > 
> > "usb: typec: tcpm: AMS and Collision Avoidance"
> >  - removed the signed-off
> >  - modified the coding style suggested from Heikki
> >  - added FR_SWAP AMS handling
> > 
> > "usb: typec: tcpm: Protocol Error handling"
> >  - removed the signed-off
> >  - modified the coding style suggested from Heikki
> >  - modified more coding style problems (line wrapping limit)
> > 
> > "usb: typec: tcpm: Respond Wait if VDM state machine is running"
> >  - no change
> 
> I've finally gotten around to testing this. I'm happy to
> report that the power-role swapping regression seen in one
> of the older versions of this patch-set is gone.
> 
> So the entire series is:
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Thanks for testing and the review.

Heikki, any thoughts?

thanks,

greg k-h
