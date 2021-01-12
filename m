Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82792F2EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbhALMGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:06:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbhALMGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:06:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D1A722EBE;
        Tue, 12 Jan 2021 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610453135;
        bh=mI4rHP50fccUJxrpr2+kl7js5/5KSgQaYpoCvv6emKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9KJlctw3nuOjkz173EVSFcwQ0JCUfMFRGFgvkz8/WyLYbZjhkf4OXEdPq+tfarXX
         efZOL9fJskx6qhpaKEmABB/6GDjewT9C2hjU/e9VPJTdiziNJscR4FzFeK98zgRGoj
         yNBPIFAVTCPJ/8kFc8WkYkpcPj7nDAoYEHgsjvzI=
Date:   Tue, 12 Jan 2021 13:06:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
Message-ID: <X/2Q1BAg3mF3YmqL@kroah.com>
References: <20210105163927.1376770-1-kyletso@google.com>
 <X/2N1LAgNRCSkWrw@kroah.com>
 <bfb36421-ec4a-9ea6-585c-798f626e069b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb36421-ec4a-9ea6-585c-798f626e069b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:57:28PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 1/12/21 12:53 PM, Greg KH wrote:
> > On Wed, Jan 06, 2021 at 12:39:24AM +0800, Kyle Tso wrote:
> >> This series include previous patch "[v4] AMS and Collision Avoidance"
> >> https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
> >> and two more patches "Protocol Error handling" and "Respond Wait if...".
> >>
> >> The patch "AMS and Collision Avoidance" in [v5] is the same as the one
> >> in [v4] (only rebased to ToT).
> >>
> >> The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
> >> wrong handling.
> >>
> >> The patch "Respond Wait if..." is to fix a conflict when 
> >> DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.
> >>
> >> Kyle Tso (3):
> >>   usb: typec: tcpm: AMS and Collision Avoidance
> >>   usb: typec: tcpm: Protocol Error handling
> >>   usb: typec: tcpm: Respond Wait if VDM state machine is running
> >>
> >>  drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
> >>  include/linux/usb/pd.h        |   2 +
> >>  include/linux/usb/tcpm.h      |   4 +
> >>  3 files changed, 792 insertions(+), 139 deletions(-)
> > 
> > Heikki, any thoughts about this series?
> 
> Note I plan to test this series on a device with a fusb302 Type-C
> controller, where it broke role-swappings in a previous version of
> this series. This is supposed to be fixed now but I would like to
> confirm this.
> 
> I've had this on my todo list for a while now. I've
> now put this in my calendar as a task for tomorrow. So please wait
> till you hear back from me (hopefully with a Tested-by) with
> merging this, thanks.

No worries, just wanted to make sure it didn't fall through the cracks.

thanks for testing!

greg k-h
