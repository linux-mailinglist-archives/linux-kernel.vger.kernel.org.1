Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183F52AD5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgKJMSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:18:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:53167 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgKJMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:18:31 -0500
IronPort-SDR: q9Gda4OQFT4H/hlBbhhj1MBBunEUQg1yIow8v4APrQ1+uDSLxXBKS1AB4yY8XH+VGCVP2pht5x
 UCG30/LFhqVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="157742773"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="157742773"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 04:18:27 -0800
IronPort-SDR: CTAlIZNRW0SkuVPtJQ8YVdiyHTAe1vk9SZZ1Kn1Ez683qqd87t3VSFJzooqijxKpOhp6uYyHGH
 7LSkgRPDu+UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="428348328"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2020 04:18:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Nov 2020 14:18:24 +0200
Date:   Tue, 10 Nov 2020 14:18:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH 1/8] usb: typec: Correct the bit values for the
 Thunderbolt rounded/non-rounded cable support
Message-ID: <20201110121824.GK1224435@kuha.fi.intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
 <20201110003716.5164-2-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110003716.5164-2-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 04:37:09PM -0800, Utkarsh Patel wrote:
> Rounded and non-rounded Thunderbolt cables are represented by two bits as
> per USB Type-C Connector specification v2.0 section F.2.6.
> Corrected that in the Thunderbolt 3 cable discover mode VDO.
> 
> Fixes: ca469c292edc ("usb: typec: Add definitions for Thunderbolt 3 Alternate Mode")

Hold on... Why is this tagged as a fix? What is it fixing?

Why do we even need this change? The field may have two bits, but
only one is used: "10b...11b = Reserved".

> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
>  include/linux/usb/typec_tbt.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index 47c2d501ddce..aad648d14bb3 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -40,11 +40,16 @@ struct typec_thunderbolt_data {
>  #define   TBT_CABLE_USB3_PASSIVE	2
>  #define   TBT_CABLE_10_AND_20GBPS	3
>  #define TBT_CABLE_ROUNDED		BIT(19)
> +#define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
> +					(((_vdo_) & GENMASK(20, 19)) >> 19)
> +#define   TBT_GEN3_NON_ROUNDED                 0
> +#define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
>  #define TBT_CABLE_OPTICAL		BIT(21)
>  #define TBT_CABLE_RETIMER		BIT(22)
>  #define TBT_CABLE_LINK_TRAINING		BIT(23)
>  
>  #define TBT_SET_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
> +#define TBT_SET_CABLE_ROUNDED(_g_)	(((_g_) & GENMASK(1, 0)) << 19)
>  
>  /* TBT3 Device Enter Mode VDO bits */
>  #define TBT_ENTER_MODE_CABLE_SPEED(s)	TBT_SET_CABLE_SPEED(s)

thanks,

-- 
heikki
