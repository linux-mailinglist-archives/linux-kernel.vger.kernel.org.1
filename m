Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1722A0660
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgJ3NZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:25:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:27523 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3NZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:25:09 -0400
IronPort-SDR: dMh+tfTkyEn8vJOTu0DuuFjBlZIG4AEUXWpvKdbk/J8TSxd2i/fSCpj/Rbd5K6EWv/eS1/3IIo
 QQJdzjlaElug==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="148459395"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="148459395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:25:08 -0700
IronPort-SDR: t3UcWjQfaGU4zZsAWFqdjNBHPA/JgDSVEapjeDVUDSZJGvXQNhEGhtY6X4/1aIbIWAW26XiBII
 jF9YYx3uwGPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="425344266"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2020 06:25:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Oct 2020 15:25:05 +0200
Date:   Fri, 30 Oct 2020 15:25:05 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 6/7] platform/chrome: cros_ec_typec: Parse partner PD ID
 VDOs
Message-ID: <20201030132505.GC2333887@kuha.fi.intel.com>
References: <20201021205317.708008-1-pmalani@chromium.org>
 <20201021205317.708008-7-pmalani@chromium.org>
 <20201028131633.GA2026875@kuha.fi.intel.com>
 <20201028201135.GA3913249@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028201135.GA3913249@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:11:35PM -0700, Prashant Malani wrote:
> Hi Heikki,
> 
> Thanks a lot for reviewing the patch!
> 
> On Wed, Oct 28, 2020 at 03:16:33PM +0200, Heikki Krogerus wrote:
> > > +
> > > +	/* Copy the remaining identity VDOs till a maximum of 6. */
> > > +	for (i = 3; i < sop_disc->identity_count && i < VDO_MAX_OBJECTS; i++)
> > > +		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
> > 
> > Why do you need to put the product type VDOs in reverse order?
> 
> The Chrome EC returns all the Identity VDOs as an array of 6 VDOs (the
> discovery_vdo[] array). The first three entries are assigned to the
> pd_identity.{id_header,cert_stat,product} members.
> 
> This for loop assigns the next three discovery_vdo entries (i.e indices
> 3-5) to pd_identity.vdo[0-2] respectively.
> 
> The "i-3" is because discovery_vdo[3] corresponds to pd_identity.vdo[0]
> and so on.
> 
> Does that help to clarify the for loop?

Yes. Thanks.

Br,

-- 
heikki
