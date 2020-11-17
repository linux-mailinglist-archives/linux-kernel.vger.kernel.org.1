Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2A2B5F05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKQMVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:21:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:5164 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgKQMVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:21:40 -0500
IronPort-SDR: Sl9ijPSEbNwnULNOKmhviTZ6rH5hr/wa4ZF0yxShKntL+Gq6k+3mndD5BNcoqH76XFyObsb763
 x1imdg1BVvnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="188967990"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="188967990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 04:21:40 -0800
IronPort-SDR: N37MpWcFs4jQosLgJFR7LuYond0jFmr3/dy8avuqv++cBXS3uA/MnnCaXE4lRziVClT/9/0gdS
 5+lwjJ/93TLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430461169"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 04:21:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:21:37 +0200
Date:   Tue, 17 Nov 2020 14:21:37 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 7/8] usb: typec: intel_pmc_mux: Configure active cable
 properties for USB4
Message-ID: <20201117122137.GG3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-8-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-8-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:25:02PM -0800, Utkarsh Patel wrote:
> Value received as a part of Thunderbolt 3 cable discover mode VDO needs
> to be configured in the USB4 mode for the Thunderbolt rounded support and
> active cable plug link training.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> 
> --
> Changes in v2:
> - No change.
> --
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index aa3211f1c4c3..61feb358aad3 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -295,6 +295,7 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
>  {
>  	struct enter_usb_data *data = state->data;
>  	struct altmode_req req = { };
> +	u8 cable_rounded;
>  	u8 cable_speed;
>  
>  	if (IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
> @@ -308,9 +309,6 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
>  	/* USB4 Mode */
>  	req.mode_data = PMC_USB_ALTMODE_FORCE_LSR;
>  
> -	if (data->active_link_training)
> -		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
> -
>  	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
>  	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
>  
> @@ -322,6 +320,20 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
>  		fallthrough;
>  	default:
>  		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
> +
> +		if (data->tbt_cable_vdo) {
> +			/* Active Thunderbolt 3 cable */
> +			if (data->tbt_cable_vdo & TBT_CABLE_LINK_TRAINING)
> +				req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
> +
> +			cable_rounded =
> +				TBT_CABLE_ROUNDED_SUPPORT(data->tbt_cable_vdo);

No need for the newline:

			cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->tbt_cable_vdo);

> +			req.mode_data |= PMC_USB_ALTMODE_TBT_GEN(cable_rounded);
> +		} else {
> +			/* Active USB4 cable */
> +			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK |
> +				PMC_USB_ALTMODE_TBT_GEN(1);
> +		}
>  		break;
>  	}

thanks,

-- 
heikki
