Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3362A9029
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgKFHUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:20:13 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71421208FE;
        Fri,  6 Nov 2020 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604647213;
        bh=oiuaCuXvu3qqgBIhoDXutO+WSl9oQyHg8DPg/SV087A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oskLS4mXxC0RDgG0I5FjO85p80ZgUZ0104BLORszrRsPkyXTFbXfPtFkVV6Q3WogZ
         n0gnUGzwZkHpBQi4pm56evnqzsFrDrVv8Sl8tRzi4FA8NNGDSmdr0rPofShS6xUaF0
         KjcSF0SAixPF59HJ+J1K0Y7coyUpqlAw50jmIRs0=
Date:   Fri, 6 Nov 2020 08:20:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        dzigterman@chromium.org, alevkoy@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_typec: Store cable plug type
Message-ID: <20201106072059.GA2614221@kroah.com>
References: <20201106012758.525472-1-pmalani@chromium.org>
 <20201106012758.525472-7-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106012758.525472-7-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 05:28:03PM -0800, Prashant Malani wrote:
> Use the PD VDO Type C cable plug type macro to retrieve and store the
> cable plug type in the cable descriptor.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Where are the first 5 patches in this series?


> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 5e7f0b4ebbec..0a2a8b0f8115 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -709,6 +709,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  		.port = port_num,
>  		.partner_type = TYPEC_PARTNER_SOP_PRIME,
>  	};
> +	uint32_t cable_plug_type;

u32 please, this isn't userspace code :)

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

So you save it but what happens with the value?

confused,

greg k-h
