Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2C2D4684
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgLIQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:15:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:42263 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbgLIQPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:15:45 -0500
IronPort-SDR: qhAQ9V4Boh4uBpx0YNL/irxMbiGn8GKEFJ9ANBaBOI06RE4kF08V9z8M5jo0gmtm1+egbUz3b2
 35PQETpUp93g==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="192405890"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="192405890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 08:13:59 -0800
IronPort-SDR: nDfX4tYjT8ZYFGG8XF2PmutHkMhsyiA+r1JGwdPpFqhYyDcKiGLPDtuMLvOl0vVQSBK0L05XKQ
 uGzn7QomKmbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="437847788"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Dec 2020 08:13:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Dec 2020 18:13:56 +0200
Date:   Wed, 9 Dec 2020 18:13:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Add bus type for plug alt modes
Message-ID: <20201209161356.GI680328@kuha.fi.intel.com>
References: <20201203030846.51669-1-pmalani@chromium.org>
 <20201208093734.GD680328@kuha.fi.intel.com>
 <CACeCKaehg=HTuQNLtQaJZWvTnOFYM9b1BWfM+WX_ebiZ-_i8JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaehg=HTuQNLtQaJZWvTnOFYM9b1BWfM+WX_ebiZ-_i8JQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:45:19PM -0800, Prashant Malani wrote:
> Hi Heikki,
> 
> Thanks a lot for looking at the patch.
> 
> On Tue, Dec 8, 2020 at 1:37 AM Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 07:08:47PM -0800, Prashant Malani wrote:
> > > Add the Type C bus for plug alternate modes which are being
> > > registered via the Type C connector class. This ensures that udev events
> > > get generated when plug alternate modes are registered (and not just for
> > > partner/port alternate modes), even though the Type C bus doesn't link
> > > plug alternate mode devices to alternate mode drivers.
> >
> > I still don't understand how is the uevent related to the bus? If you
> > check the device_add() function, on line 2917, kobject_uevent() is
> > called unconditionally. The device does not need a bus for that event
> > to be generated.
> 
> My initial thought process was to see what is the difference in the adev device
> initialization between partner altmode and plug altmode (the only difference I saw in
> typec_register_altmode() was regarding the bus field).
> 
> Yes, kobject_uevent() is called unconditionally, but it's return value isn't checked,
> so we don't know if it succeeded or not.
> 
> In the case of cable plug altmode, I see it fail with the following error[1]:
> 
> [  114.431409] kobject: 'port1-plug0.0' (000000004ad42956): kobject_uevent_env: filter function caused the event to drop!
> 
> I think the filter function which is called is this one: drivers/base/core.c: dev_uevent_filter() [2]
> 
> static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
> {
> 	struct kobj_type *ktype = get_ktype(kobj);
> 
> 	if (ktype == &device_ktype) {
> 		struct device *dev = kobj_to_dev(kobj);
> 		if (dev->bus)
> 			return 1;
> 		if (dev->class)
> 			return 1;
> 	}
> 	return 0;
> }
> 
> So, both the "if (dev->bus)" and "if (dev->class)" checks are failing here. In the case of partner alt modes, bus is set by the class.c code
> so this check likely returns 1 in that case.

OK. I understand the issue now. So I would say that the proper
solution to this problem is to link the alt modes with the class
instead of the bus. That is much smaller change IMO.


thanks,

-- 
heikki
