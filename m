Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E72B5F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgKQMpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:45:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:1159 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKQMpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:45:15 -0500
IronPort-SDR: 4+2BqcwkUBwZer24G03E/XY1D8mu6UHbMSPqdTdEhV3DSqt5iFtf+Yo0w9TVvNQ3KJqn/Ksjux
 016Jr/8Z7DOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="158690181"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="158690181"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 04:45:14 -0800
IronPort-SDR: CWh7jgNj/QKRbB51DDHqaVhuH+1ZYb4GB01V6RyBrdqVqoA3CnDT2wBgRF84toMHKkdiv2gBDw
 uyEftAor/Sjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430468045"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 04:45:11 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:45:10 +0200
Date:   Tue, 17 Nov 2020 14:45:10 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 10/11] platform/chrome: cros_ec_typec: Register SOP'
 cable plug
Message-ID: <20201117124510.GJ3437448@kuha.fi.intel.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
 <20201116201150.2919178-11-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116201150.2919178-11-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:11:56PM -0800, Prashant Malani wrote:
> In order to register cable alternate modes, we need to first register a
> plug object. Use the Type C connector class framework to register a SOP'
> plug for this purpose.
> 
> Since a cable and plug go hand in hand, we can handle the registration
> and removal together.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Re-arranged patch order and combined it with related series of
>   patches.
> 
> No version v2.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 35 ++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index ad5e37bfd45d..d2e154ae2362 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -45,6 +45,8 @@ struct cros_typec_port {
>  	struct typec_capability caps;
>  	struct typec_partner *partner;
>  	struct typec_cable *cable;
> +	/* SOP' plug. */
> +	struct typec_plug *plug;
>  	/* Port partner PD identity info. */
>  	struct usb_pd_identity p_identity;
>  	/* Port cable PD identity info. */
> @@ -222,6 +224,8 @@ static void cros_typec_remove_cable(struct cros_typec_data *typec,
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  
> +	typec_unregister_plug(port->plug);
> +	port->plug = NULL;
>  	typec_unregister_cable(port->cable);
>  	port->cable = NULL;
>  	memset(&port->c_identity, 0, sizeof(port->c_identity));
> @@ -712,7 +716,8 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct ec_response_typec_discovery *disc = port->disc_data;
> -	struct typec_cable_desc desc = {};
> +	struct typec_cable_desc c_desc = {};
> +	struct typec_plug_desc p_desc;
>  	struct ec_params_typec_discovery req = {
>  		.port = port_num,
>  		.partner_type = TYPEC_PARTNER_SOP_PRIME,
> @@ -735,32 +740,44 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  		cable_plug_type = VDO_TYPEC_CABLE_TYPE(port->c_identity.vdo[0]);
>  		switch (cable_plug_type) {
>  		case CABLE_ATYPE:
> -			desc.type = USB_PLUG_TYPE_A;
> +			c_desc.type = USB_PLUG_TYPE_A;
>  			break;
>  		case CABLE_BTYPE:
> -			desc.type = USB_PLUG_TYPE_B;
> +			c_desc.type = USB_PLUG_TYPE_B;
>  			break;
>  		case CABLE_CTYPE:
> -			desc.type = USB_PLUG_TYPE_C;
> +			c_desc.type = USB_PLUG_TYPE_C;
>  			break;
>  		case CABLE_CAPTIVE:
> -			desc.type = USB_PLUG_CAPTIVE;
> +			c_desc.type = USB_PLUG_CAPTIVE;
>  			break;
>  		default:
> -			desc.type = USB_PLUG_NONE;
> +			c_desc.type = USB_PLUG_NONE;
>  		}
> -		desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
> +		c_desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
>  	}
>  
> -	desc.identity = &port->c_identity;
> +	c_desc.identity = &port->c_identity;
>  
> -	port->cable = typec_register_cable(port->port, &desc);
> +	port->cable = typec_register_cable(port->port, &c_desc);
>  	if (IS_ERR(port->cable)) {
>  		ret = PTR_ERR(port->cable);
>  		port->cable = NULL;
> +		goto sop_prime_disc_exit;
> +	}
> +
> +	p_desc.index = TYPEC_PLUG_SOP_P;
> +	port->plug = typec_register_plug(port->cable, &p_desc);
> +	if (IS_ERR(port->plug)) {
> +		ret = PTR_ERR(port->plug);
> +		port->plug = NULL;
> +		goto sop_prime_disc_exit;
>  	}
>  
> +	return 0;
> +
>  sop_prime_disc_exit:
> +	cros_typec_remove_cable(typec, port_num);
>  	return ret;
>  }
>  
> -- 
> 2.29.2.299.gdc1121823c-goog

-- 
heikki
