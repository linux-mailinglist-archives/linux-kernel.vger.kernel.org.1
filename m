Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47E2B5D24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgKQKpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:45:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:58424 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbgKQKpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:45:23 -0500
IronPort-SDR: QSffe0h8IelXmqzPvmdRokqTOTmxuDU6Yt/Ku1EqgnHX8ZuX8O+pKdlQuNE4ig3vEgXdT93BnN
 oSjpn4ZfMp+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="157930492"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="157930492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 02:45:22 -0800
IronPort-SDR: A/JFUTFVn8/iwJSyihdWVGnCL7/nj79Aa7u+cc++Ids9X6k6GM0kHIiV9+5GcEyUyJksM39rNj
 UQYxKbBgzJGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430442530"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 02:45:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 12:45:18 +0200
Date:   Tue, 17 Nov 2020 12:45:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 3/8] usb: typec: intel_pmc_mux: Configure Thunderbolt
 cable generation bits
Message-ID: <20201117104518.GC3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-4-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-4-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:24:58PM -0800, Utkarsh Patel wrote:
> Thunderbolt cable generation bits received as a part of Thunderbolt 3 cable
> discover mode VDO needs to be configured for Thunderbolt rounded and
> non-rounded cable support in the Thunderbolt alternate mode.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --
> Changes in v2:
> - No change.
> --
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index d7f63b74c6b1..aa3211f1c4c3 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -256,6 +256,7 @@ static int
>  pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
>  {
>  	struct typec_thunderbolt_data *data = state->data;
> +	u8 cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->cable_mode);
>  	u8 cable_speed = TBT_CABLE_SPEED(data->cable_mode);
>  	struct altmode_req req = { };
>  
> @@ -284,6 +285,8 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
>  
>  	req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
>  
> +	req.mode_data |= PMC_USB_ALTMODE_TBT_GEN(cable_rounded);
> +
>  	return pmc_usb_command(port, (void *)&req, sizeof(req));
>  }
>  
> -- 
> 2.17.1

-- 
heikki
