Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF52B923C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgKSMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:11:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:33756 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgKSMLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:11:11 -0500
IronPort-SDR: QZm41tzU7URNMdNcWABav2u0+MVIQeJQ2ahkkKRQchTyHkV1wL/fKk0W9xzAQI17fPSLXibmyJ
 8kQom8qdu/dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="189364322"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="189364322"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 04:11:10 -0800
IronPort-SDR: cjQkm8w0TOL1dAn1/1SG2eK5hCK/WpHyzI+ZxaFn1egzYUcFKlpHyueOxbaq9Llsk/bT6tYmfn
 8Vsiyu8KjiqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="431209451"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2020 04:11:08 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Nov 2020 14:11:07 +0200
Date:   Thu, 19 Nov 2020 14:11:07 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201119121107.GD3774817@kuha.fi.intel.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
 <20201118150059.3419-4-heikki.krogerus@linux.intel.com>
 <X7VESebL4CnS45hv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7VESebL4CnS45hv@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:56:57PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 18, 2020 at 06:00:59PM +0300, Heikki Krogerus wrote:
> > From: Prashant Malani <pmalani@chromium.org>
> > 
> > Interim. ABI doc missing.
> > 
> > A PD-capable device can return up to 3 Product Type VDOs as part of its
> > DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
> > 6.4.4.3.1). Add sysfs attribute to expose these to userspace.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > [ heikki: Only one instead of three attribute files ]
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>'
> > ---
> >  drivers/usb/typec/class.c | 41 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 303f054181ff7..5e135678f5952 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -165,15 +165,55 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(product);
> >  
> > +static ssize_t
> > +product_type_vdo_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct usb_pd_identity *id = get_pd_identity(dev);
> > +	size_t len = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < 3; i++) {
> > +		if (!id->vdo[i])
> > +			break;
> > +		len += sysfs_emit(buf, "%08x ", id->vdo[i]);
> > +	}
> > +
> > +	buf[len - 1] = '\n';
> > +
> > +	return len;
> > +}
> 
> I don't understand what you are trying to print out here, documentation
> would be helpful :)
> 
> > +static struct device_attribute dev_attr_product_type_vdo = {
> > +	.attr = {
> > +		.name = "product_type",
> > +		.mode = 0444,
> > +	},
> > +	.show = product_type_vdo_show,
> > +};
> 
> DEVICE_ATTR_RO(product_type_vdo)?
> 
> Why are you calling it "product_type" and not with the "vdo"?
> 
> And you have to name it this, there's always __ATTR_RO(), never put a
> mode in "raw" numbers for a sysfs file if at all possible.

Sorry Greg. This is still work-in-progress.

I didn't use the _vdo ending in the file name because the other files
exposing the other parts (VDOs) of the response to the discover
identity don't have it either.


thanks,

-- 
heikki
