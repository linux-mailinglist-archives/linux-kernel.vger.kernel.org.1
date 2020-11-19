Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE52B90B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKSLLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:11:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:40924 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgKSLLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:11:39 -0500
IronPort-SDR: ujy6K6kMFFzbAptR53cy0pmCUUjYsjlW41GwnuxgBLVd8kNsPebWcmdpyJh9W7gxqL8IkIDPJc
 8vydSL9SpaXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="150540880"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="150540880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:11:39 -0800
IronPort-SDR: tas3pm4x9Zgkn7cH9XmrFkOx5z4pNye55fCTSH2uYnxcmn/jKBGWUT9lF4RfwwOBJSfZxUQ81/
 9ldsKwei4cvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="431193767"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2020 03:11:36 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Nov 2020 13:11:36 +0200
Date:   Thu, 19 Nov 2020 13:11:36 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@google.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] usb: typec: Add product_type sysfs attribute
 file for partners and cables
Message-ID: <20201119111136.GB3774817@kuha.fi.intel.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
 <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
 <20201118174821.GA1966168@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118174821.GA1966168@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On Wed, Nov 18, 2020 at 09:48:21AM -0800, Benson Leung wrote:
> > +What:		/sys/class/typec/<port>-partner/product_type
> > +Date:		December 2020
> > +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > +Description:	USB Power Delivery Specification defines a set of product types
> > +		for the partner devices. This file will show the product type of
> > +		the partner if it is known. Dual-role capable partners will have
> > +		both UFP and DFP product types defined, but only one that
> > +		matches the current role will be active at the time. If the
> > +		product type of the partner is not visible to the device driver,
> > +		this file will not exist.
> > +
> > +		When the partner product type is detected, or changed with role
> > +		swap, uvevent is also raised that contains PRODUCT_TYPE=<product
> > +		type> (for example PRODUCT_TYPE=hub).
> > +
> > +		Valid values:
> > +
> > +		UFP / device role
> > +		========================  ==========================
> > +		undefined		  -
> > +		hub			  PDUSB Hub
> > +		peripheral		  PDUSB Peripheral
> > +		psd			  Power Bank
> > +		ama			  Alternate Mode Adapter
> > +		vpd			  VCONN Powered USB Device
> 
> I have it on good authority that "vpd" is incorrectly categorized here,
> and for future proofing, we'd better not introduce vpd as a product
> type for UFP...
> 
> A vpd is actually more closely related to a "cable" than it is a "UFP."
> A closer reading of the USB Type-C and USB PD specs will reveal that
> VPDs can only ever appear as SOP' and not as SOP, so having its type
> appear under UFP is a mistake.
> 
> In other words, the USB PD V3.0 R2.0 spec is wrong. A change has been
> working its way through the spec committee to fix this, but it is not yet
> published.
> 
> In order to reduce the amount of churn, I would recommend not
> including vpd as a possible type until a new version of the spec (or the ECN)
> is published.

Thanks for the heads-up. I'll leave the vpd out then.

cheers,

-- 
heikki
