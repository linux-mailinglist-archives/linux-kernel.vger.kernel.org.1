Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555A2B909A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgKSLFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:05:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:19168 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSLFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:05:10 -0500
IronPort-SDR: OHvjf+HkuhwiA/cLeDBPRwnQgeyNzNrxLzNAuEHog4Ue3teL7cos6X7HnhmsNSQ9bfZR8DMLea
 lP/cHkXbpb7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159043364"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="159043364"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:05:09 -0800
IronPort-SDR: 8U+MHKbLCabV6ZlOoD80RU5+uJfFmBy34CAjWTVQxN2vZA9AVlTnJhji1C1G97jTSmzJ2G0jTF
 488Lq3YP8Rvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="431191813"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2020 03:05:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Nov 2020 13:05:06 +0200
Date:   Thu, 19 Nov 2020 13:05:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] usb: typec: Add product_type sysfs attribute
 file for partners and cables
Message-ID: <20201119110506.GA3774817@kuha.fi.intel.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
 <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
 <20201118185350.GB3652649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118185350.GB3652649@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:53:50AM -0800, Prashant Malani wrote:
> > +What:		/sys/class/typec/<port>-cable/product_type
> > +Date:		December 2020
> > +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > +Description:	USB Power Delivery Specification defines a set of product types
> > +		for the cables. This file will show the product type of the
> > +		cable if it is known. If the product type of the cable is not
> > +		visible to the device driver, this file will not exist.
> > +
> > +		When the cable product type is detected, uvevent is also raised
> > +		with PRODUCT_TYPE showing the product type of the cable.
> > +
> > +		Valid values:
> > +
> > +		========================  ==========================
> > +		undefined		  -
> > +		active			  Active Cable
> > +		passive			  Passive Cable
> > +		========================  ==========================
> 
> There exists a /sys/class/typec/<port>-cable/type attribute (connected
> to the "active" field in struct typec_cable [1]), which is supposed
> to be populated by the Type C port driver. Won't the newly introduced
> attribute duplicate the same information as "type"?

True. So we don't need add this for the cable separately. I'll just
modify the code so that it considers also the response to Discover
Identity command if we have access to it.

Would it be OK if we name the file "type" instead of "product_type"
also with the partners?

thanks,

-- 
heikki
