Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D825A2AB26A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgKIIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:31:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:44652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgKIIb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:31:26 -0500
IronPort-SDR: /Z/NA4/eALiKwDmdyuK909SYkDzy0bx40ABQD4lke4mhPSj1H3eVp3X+i1irpV26GCoQrTrvQQ
 8J+KEaJaBeIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="149618669"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="149618669"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:31:26 -0800
IronPort-SDR: AKQ/kboLMEHgt3q1Q/RSpYI4QgU5etzJBCq6HUSEl9NN7uV9BQq7ZK/CR6uwVjO+QGfl1Pl55o
 5BPbaDXxwlYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="427920663"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Nov 2020 00:31:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Nov 2020 10:31:22 +0200
Date:   Mon, 9 Nov 2020 10:31:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 6/6] platform/chrome: cros_ec_typec: Store cable plug
 type
Message-ID: <20201109083122.GH4062920@kuha.fi.intel.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
 <20201106184104.939284-7-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-7-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:41:10AM -0800, Prashant Malani wrote:
> Use the PD VDO Type C cable plug type macro to retrieve and store the
> cable plug type in the cable descriptor.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - Changed local variable from uint32_to u32.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 5e7f0b4ebbec..cf609aa10567 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -709,6 +709,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  		.port = port_num,
>  		.partner_type = TYPEC_PARTNER_SOP_PRIME,
>  	};
> +	u32 cable_plug_type;
>  	int ret = 0;
>  
>  	memset(disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
> @@ -722,8 +723,26 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  	/* Parse the PD identity data, even if only 0s were returned. */
>  	cros_typec_parse_pd_identity(&port->c_identity, disc);
>  
> -	if (disc->identity_count != 0)
> +	if (disc->identity_count != 0) {
> +		cable_plug_type = VDO_TYPEC_CABLE_TYPE(port->c_identity.vdo[0]);
> +		switch (cable_plug_type) {
> +		case CABLE_ATYPE:
> +			desc.type = USB_PLUG_TYPE_A;
> +			break;
> +		case CABLE_BTYPE:
> +			desc.type = USB_PLUG_TYPE_B;
> +			break;
> +		case CABLE_CTYPE:
> +			desc.type = USB_PLUG_TYPE_C;
> +			break;
> +		case CABLE_CAPTIVE:
> +			desc.type = USB_PLUG_CAPTIVE;
> +			break;
> +		default:
> +			desc.type = USB_PLUG_NONE;
> +		}
>  		desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
> +	}
>  
>  	desc.identity = &port->c_identity;
>  
> -- 
> 2.29.1.341.ge80a0c044ae-goog

thanks,

-- 
heikki
