Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE82AB257
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgKIIWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:22:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:57888 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgKIIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:22:38 -0500
IronPort-SDR: K8HwPpFY2slZIQTrYXAHxJK1zQwl58GuP03Xh2zPyM+skCMwtwWWvMkxHKIKjK6Qe/GrFCOU15
 8z/DgU5QVafQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="233933410"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="233933410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:22:37 -0800
IronPort-SDR: z3bkgQemJx4MA4i/HDhrdxRO5fIGPFEBVSg25otC49bNpsWXeZW/Ra8H2IgXsVPuqh/BVRhmaN
 +liS7AFE8jQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="427917693"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Nov 2020 00:22:34 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Nov 2020 10:22:33 +0200
Date:   Mon, 9 Nov 2020 10:22:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 2/6] platform/chrome: cros_ec_typec: Factor out PD
 identity parsing
Message-ID: <20201109082233.GD4062920@kuha.fi.intel.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
 <20201106184104.939284-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-3-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:41:01AM -0800, Prashant Malani wrote:
> Factor out the PD identity parsing code into a separate function. This
> way it can be re-used for Cable PD identity parsing in future patches.
> 
> No functional changes are introduced by this patch.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 35 ++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 801c3d2c1fbd..f6d3c37c2c27 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -657,6 +657,28 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>  	return ret;
>  }
>  
> +/*
> + * Parse the PD identity data from the EC PD discovery responses and copy that to the supplied
> + * PD identity struct.
> + */
> +static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
> +					 struct ec_response_typec_discovery *disc)
> +{
> +	int i;
> +
> +	/* First, update the PD identity VDOs for the partner. */
> +	if (disc->identity_count > 0)
> +		id->id_header = disc->discovery_vdo[0];
> +	if (disc->identity_count > 1)
> +		id->cert_stat = disc->discovery_vdo[1];
> +	if (disc->identity_count > 2)
> +		id->product = disc->discovery_vdo[2];
> +
> +	/* Copy the remaining identity VDOs till a maximum of 6. */
> +	for (i = 3; i < disc->identity_count && i < VDO_MAX_OBJECTS; i++)
> +		id->vdo[i - 3] = disc->discovery_vdo[i];
> +}
> +
>  static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
> @@ -666,7 +688,6 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
>  		.partner_type = TYPEC_PARTNER_SOP,
>  	};
>  	int ret = 0;
> -	int i;
>  
>  	if (!port->partner) {
>  		dev_err(typec->dev,
> @@ -684,17 +705,7 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
>  		goto disc_exit;
>  	}
>  
> -	/* First, update the PD identity VDOs for the partner. */
> -	if (sop_disc->identity_count > 0)
> -		port->p_identity.id_header = sop_disc->discovery_vdo[0];
> -	if (sop_disc->identity_count > 1)
> -		port->p_identity.cert_stat = sop_disc->discovery_vdo[1];
> -	if (sop_disc->identity_count > 2)
> -		port->p_identity.product = sop_disc->discovery_vdo[2];
> -
> -	/* Copy the remaining identity VDOs till a maximum of 6. */
> -	for (i = 3; i < sop_disc->identity_count && i < VDO_MAX_OBJECTS; i++)
> -		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
> +	cros_typec_parse_pd_identity(&port->p_identity, sop_disc);
>  
>  	ret = typec_partner_set_identity(port->partner);
>  	if (ret < 0) {
> -- 

thanks,

-- 
heikki
