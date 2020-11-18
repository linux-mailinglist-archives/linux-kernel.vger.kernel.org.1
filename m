Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C82B7D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgKRMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:04:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:4837 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgKRMEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:04:14 -0500
IronPort-SDR: 7qNHeMshNgNIIpvmIBt8u2WjJMBBIsvfIFjwwKUrAEac0gA3oLAxTdcQiEZzb68bwx3J47RoEn
 Fa3jszg790PQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255815670"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255815670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 04:04:13 -0800
IronPort-SDR: Mbimcke64Rmpf1jMY/9ir/N/g3HWTelPECz5ErmG1nkn4XxAhWyzPvYkG9QfaGhYsL/jKAQYaL
 eTDJ15wmQ79A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430813669"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 Nov 2020 04:04:11 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 18 Nov 2020 14:04:08 +0200
Date:   Wed, 18 Nov 2020 14:04:08 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com
Subject: Re: [PATCH v3 03/11] usb: typec: Add plug num_altmodes sysfs attr
Message-ID: <20201118120408.GL3437448@kuha.fi.intel.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
 <20201116201150.2919178-4-pmalani@chromium.org>
 <20201117124143.GI3437448@kuha.fi.intel.com>
 <20201117174016.GA1819103@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117174016.GA1819103@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:40:16AM -0800, Prashant Malani wrote:
> Hi Heikki,
> 
> On Tue, Nov 17, 2020 at 02:41:43PM +0200, Heikki Krogerus wrote:
> > On Mon, Nov 16, 2020 at 12:11:42PM -0800, Prashant Malani wrote:
> > > Add a field to the typec_plug struct to record the number of available
> > > altmodes as well as the corresponding sysfs attribute to expose this to
> > > userspace.
> > > 
> > > This allows userspace to determine whether there are any
> > > remaining alternate modes left to be registered by the kernel driver. It
> > > can begin executing any policy state machine after all available
> > > alternate modes have been registered with the connector class framework.
> > > 
> > > This value is set to "-1" initially, signifying that a valid number of
> > > alternate modes haven't been set for the plug. The sysfs file remains
> > > hidden as long as the attribute value is -1.
> > 
> > Why couldn't we just keep it hidden for as long as the number of
> > alt modes is 0? If you already explained that, then I apologise, I've
> > forgotten.
> > 
> 
> No worries :)
> 
> Succinctly, because 0 is a valid value for "number of altmodes
> supported".
> 
> If we keep the attribute hidden for 0, then there won't
> be a way for userspace to determine that PD discovery is done and we
> don't expect any more cable plug altmodes to be registered by the kernel
> Type C port driver (it can determine this by comparing
> "number_of_altmodes" against the actual number of alt modes registered
> by the Type C port driver).
> 
> If we keep "number_of_altmodes" hidden even for 0, the userspace cannot
> differentiate between "this cable doesn't support any altmodes" and
> "it does altmodes, but the PD stack hasn't completed PD Discovery
> including DiscoverIdentity yet".
> 
> For reference, here is the initial patch and mini-discussion around it
> back in July for port-partner altmodes [1] (I've followed a similar
> logic here).
> 
> Hope this helps the rationale a bit more.

Got it. Thanks for the explanation (again :-).

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Best regards,
> 
> -Prashant
> 
> [1]:
> https://lore.kernel.org/linux-usb/20200701082230.GF856968@kuha.fi.intel.com/

thanks,

-- 
heikki
