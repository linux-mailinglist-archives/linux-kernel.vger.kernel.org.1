Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E67A2AED5C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgKKJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:21:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:44180 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgKKJVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:21:31 -0500
IronPort-SDR: KYZKcO6pmpoYZGaUaDLjBVO71Gimqyk/0MWnR9pDXuh7i0d2mSbeFGbAoptl2ml2iYvRLjGH4x
 ID42EaIlIR2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157129497"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="157129497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:21:24 -0800
IronPort-SDR: pV8MvkyFMwZdIn4NyFLcxNJwScFDgOhxUOJHLLolqmBxb8azAk54Ms1+UlYy0vrp9QQcLJOk+p
 JtRYN7hpaX2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="428688764"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Nov 2020 01:21:21 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 11 Nov 2020 11:21:20 +0200
Date:   Wed, 11 Nov 2020 11:21:20 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201111092120.GO1224435@kuha.fi.intel.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
 <20201110115453.GI1224435@kuha.fi.intel.com>
 <X6qF7hioVJyCm/Ps@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6qF7hioVJyCm/Ps@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Nov 10, 2020 at 01:22:06PM +0100, Greg KH wrote:
> > I've now come to the conclusion that this is not the correct approach.
> > Instead, the whole identity, all six VDOs, should be supplied
> > separately with a "raw" sysfs attribute file after all.
> > 
> > The three attribute files that we already have - so id_header,
> > cert_stat and product - can always supply the actual VDO as is,
> > regardless of the product type, so they are fine. But these new
> > attribute files, product_type_vdoX, would behave differently as they
> > supply different information depending on the product type. That just
> > does not feel right to me.
> > 
> > So lets just add the "raw" sysfs attribute file. We can think about
> > extracting some other details from the product type VDOs once the
> > specification has settled down a bit and we can be quite certain that
> > those details will always be available.
> > 
> > Would this be OK to you? I think we should be able to dump the data to
> > the "raw" sysfs attribute file with something like hex_dump_to_buffer().
> 
> Does this mean that the value of the attributes depends on something
> external to the device?  If so, how is userspace going to know how to
> parse this any differently than the kernel could today?
> 
> And I say this as the maintainer of 'lsusb' which probably should start
> getting support for the typec attributes that are being exposed here :)

OK, this is great! I really want you opinion on this. Let me try to
explain the situation.

So USB Power Delivery specification defines a set of these product
types, as I'm sure you already know. You have your hub, alternate mode
adapter, and so on. Then there are also a couple of cable types.
Originally I though that a product type simply equals a device type
(and that still feels correct to me). Each product type can have its
own "ABI" in form of the attribute files, that really should not be a
problem, right?

The problem with that was that we do not always know the product type.
For example UCSI does not supply the operating system the response to
the Discover Identity request from the partner device that contains
this information. It would mean that depending on your system, we will
claim that, let's say a hub really is a hub, or just some kind of a
default partner device. There was discussion about this back in the
day on this mailing list, and it was considered to be at least a
little bit confusing for the user.

In the end I did not propose the separate device types for each USB PD
product type (yet). Instead we only expose the header part of the
response to the Discover Identity (when we have it) because that part
is the same for all product types. So basically we have just the
"default" partner device type for everything for now.

But since now we clearly need all the identity details, not just the
header, it's good to talk about this again. Maybe even the "raw"
attribute file is not that useful in the end, and we really should
finally introduce the separate device types for each product types?

Or maybe there is a third option that I have not even thought of?

thanks,

-- 
heikki
