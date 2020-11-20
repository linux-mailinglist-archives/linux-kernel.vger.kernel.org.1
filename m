Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2E2BAB74
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgKTNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:42:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:55569 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgKTNmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:42:06 -0500
IronPort-SDR: MVuHTBlluN1E4/K8/genGK9vS3tP+eZJNXFC+PJfiu944e5Xz+MWz2uC/WbLzmf8M/KqrolLCg
 bQ0D89BgMQ/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171639683"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="171639683"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 05:42:05 -0800
IronPort-SDR: BWt1lre77QLy4QmAVtAza0La1Ggg+04hXV7L4akabWHbbdWFDTAQwOt+QQcnL7vwC/D9+ZSK+Z
 V3QSjiEPQrGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="431569463"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2020 05:41:59 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 20 Nov 2020 15:41:58 +0200
Date:   Fri, 20 Nov 2020 15:41:58 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com
Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Message-ID: <20201120134158.GF4120550@kuha.fi.intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-3-utkarsh.h.patel@intel.com>
 <20201119080906.GE3652649@google.com>
 <20201120112218.GE4120550@kuha.fi.intel.com>
 <20201120120700.GD4160865@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120120700.GD4160865@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On Fri, Nov 20, 2020 at 04:07:00AM -0800, Prashant Malani wrote:
> On Fri, Nov 20, 2020 at 01:22:18PM +0200, Heikki Krogerus wrote:
> > IMO safer bet for now would be to just claim that the cable is always
> > TBT3 cable until we have access to information that can really tell us
> > is the cable USB4 or TBT3.
> 
> Which brings us back to v1 of the patch :S
> 
> That still leaves my underlying concern that we'll be telling the Mux
> implementation that a TBT3 cable is connected when in fact it's a USB4
> active cable.

No matter what we do with these values, it does not change the fact
that we do not know is the cable USB4 or TBT3 at the moment. What ever
we do, we are guessing things.

Can you please explain your concern again? What can happen if we use
USB4 cable but claim that it is TBT3 to the mux?

> How about we don't set the TBT_MODE bit at all ?

Let's not come up with values that are not defined in the spec for
this field (or any other). Even though it is unlikely, we can not rule
out the possibility that one day value of 0x0000 is defined for that
field.

I'm strongly against this kind of "modifications". It would mean that
the member tbt_cable_vdo does not actually contain TBT3 Cable VDO, but
instead it has to be considered as driver or subsystem specific data.

> IMO it's equally bad as setting it always, but with the additional
> advantage:
> 
> - USB4 active cable case : you are covered (since if we unilaterally set
> TBT_MODE then the Active USB4 cable case never gets executed in
> pmc_usb_mux_usb4() in drivers/usb/typec/mux/intel_pmc_mux.c Patch 3/4)
> 
> - Bidirectional LSRX non-rounded TBT: Still supported since
>   the code path in the Intel Mux agent is the same.

This case will not work. The tbt_cable_vdo member is now 0, which to
the mux driver means that the cable is USB4 cable (and that is what it
really must mean to the mux driver - any mux driver). The mux driver
will therefore enable unidirectional SBU communication even though it
is actually bidirectional, and also rounded data rates even though the
cable supports only non-rounded data rates.

> I understand neither of the options are ideal, but WDYT?

I may be missing something, but I'm still going to say that let's just
claim that the cable is always TBT3 for now in this driver. That is
the only safe bet that we have.


thanks,

-- 
heikki
