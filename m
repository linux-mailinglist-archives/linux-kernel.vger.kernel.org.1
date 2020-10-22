Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1C295ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898642AbgJVMnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:50686 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505168AbgJVMnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:16 -0400
IronPort-SDR: dBV59pkk61YVJ3y97vqIqLpxmYmtooHRVUpyQumrf1P+/4bVF1de16lHs/KGgTcev7SGM+oDxu
 wKRCNnE5sX9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="167615571"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="167615571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 05:43:12 -0700
IronPort-SDR: HBghbPpVJubVf1gjnx8GQuAv69Q98ioZov+K7O0q3NvV33slZ9hU/m9z0b/1MnZXsRTmMi8TWQ
 KTZh6/twUyZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="423109076"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 22 Oct 2020 05:43:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 22 Oct 2020 15:42:48 +0300
Date:   Thu, 22 Oct 2020 15:42:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201022124248.GQ1667571@kuha.fi.intel.com>
References: <20201022061554.3418060-1-pmalani@chromium.org>
 <20201022065719.GA1440360@kroah.com>
 <CACeCKacvhtSfQ=hGYHi3AdrTT+XY2RpKmPHuYWoxNVmRWMeBBA@mail.gmail.com>
 <20201022071753.GA1470296@kroah.com>
 <CACeCKafjm-T5WnQNRbpKm3OwxqYH+_MxLMg60-=RrpJFBzcKyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKafjm-T5WnQNRbpKm3OwxqYH+_MxLMg60-=RrpJFBzcKyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:25:07AM -0700, Prashant Malani wrote:
> Hi Greg,
> 
> On Thu, Oct 22, 2020 at 12:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > > > > +What:                /sys/class/typec/<port>-partner/identity/product_type_vdo
> > > > > +Date:                October 2020
> > > > > +Contact:     Prashant Malani <pmalani@chromium.org>
> > > > > +Description:
> > > > > +             Product Type VDOs part of Discover Identity command result. 3 values
> > > > > +             are displayed (for the 3 possible Product Type VDOs), one per line.
> > > >
> > > > sysfs is "one value per file", not "one value per line".  This is not
> > > > ok.
> > >
> > > I see. Would listing these out as three separate vdos (i.e vdo0, vdo1,
> > > vdo2) be better?
> >
> > Given that your current implementation is not acceptable, something has
> > to change :)
> 
> Got it. I'd like to see if Heikki has any suggestions on naming these
> entries better.

Why not have product type specific attribute files?

So if the partner is UFP, then we expose ufp1 and ufp2 files that
return the UFP1 and UFP2 VDO values and hide the other files:

        % ls /sys/class/typec/port0-partner/identity/
        id_header cert_stat product ufp1 ufp2

If the partner is DFP, then you expose the dfp file and hide
everything else:

        % ls /sys/class/typec/port0-partner/identity/
        id_header cert_stat product dfp

And so on.

thanks,

-- 
heikki
