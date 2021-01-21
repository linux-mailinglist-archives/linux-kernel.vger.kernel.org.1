Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860102FE551
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbhAUIq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:46:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:61123 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbhAUInI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:43:08 -0500
IronPort-SDR: PH7tY5MGtT+/bpBgnEK0jt7pe9wDTs7vohCGEe0QOQfsM6LZWwb0PrKJnfB3cl5SPZuyJh0AS4
 9erqihw3MDDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175730692"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="175730692"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 00:41:06 -0800
IronPort-SDR: EjN2w9lJttDmgldVAUHsaRA0bbtmhH4KCXrw/unabc737CbM83ZNZduc2D0Juq4ZoFJ8gDS6r2
 tXOrn7DZNqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="467386860"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Jan 2021 00:41:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Jan 2021 10:41:02 +0200
Date:   Thu, 21 Jan 2021 10:41:01 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Create legacy PDOs for PD2 connection
Message-ID: <20210121084101.GC423216@kuha.fi.intel.com>
References: <20210115163311.391332-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115163311.391332-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

On Sat, Jan 16, 2021 at 12:33:11AM +0800, Kyle Tso wrote:
> If the port partner is PD2, the PDOs of the local port should follow the
> format defined in PD2 Spec. Dynamically modify the pre-defined PD3 PDOs
> and transform them into PD2 format before sending them to the PD2 port
> partner.

I guess it's not possible for the system to supply separate static
PDOs for each PD revision?

> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 62 +++++++++++++++++++++++++++++------
>  include/linux/usb/pd.h        |  1 +
>  2 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 22a85b396f69..1220ab1ed47d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -911,13 +911,47 @@ static int tcpm_set_pwr_role(struct tcpm_port *port, enum typec_role role)
>  	return 0;
>  }
>  
> +/*
> + * Transform the PDO to be compliant to PD rev2.0.
> + * Return 0 if the PDO type is not defined in PD rev2.0.
> + * Otherwise, return the converted PDO.
> + */
> +static u32 tcpm_forge_legacy_pdo(struct tcpm_port *port, u32 pdo, enum typec_role role)
> +{
> +	switch (pdo_type(pdo)) {
> +	case PDO_TYPE_FIXED:
> +		if (role == TYPEC_SINK)
> +			return pdo & ~PDO_FIXED_FRS_CURR_MASK;
> +		else
> +			return pdo & ~PDO_FIXED_UNCHUNK_EXT;
> +	case PDO_TYPE_VAR:
> +	case PDO_TYPE_BATT:
> +		return pdo;
> +	case PDO_TYPE_APDO:
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>  {
>  	struct pd_message msg;
> -	int i;
> +	u32 pdo;
> +	unsigned int i, nr_pdo = 0;

Side note. I think this driver uses the "reverse christmas tree"
style with the variables.

>  	memset(&msg, 0, sizeof(msg));
> -	if (!port->nr_src_pdo) {
> +
> +	for (i = 0; i < port->nr_src_pdo; i++) {
> +		if (port->negotiated_rev >= PD_REV30) {
> +			msg.payload[nr_pdo++] =	cpu_to_le32(port->src_pdo[i]);
> +		} else {
> +			pdo = tcpm_forge_legacy_pdo(port, port->src_pdo[i], TYPEC_SOURCE);
> +			if (pdo)
> +				msg.payload[nr_pdo++] = cpu_to_le32(pdo);
> +		}
> +	}

Why not just generate the PD_REV20 PDOs during probe time and then
just use the ones that fit the negotiated_rev here?

> +
> +	if (!nr_pdo) {
>  		/* No source capabilities defined, sink only */
>  		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>  					  port->pwr_role,
> @@ -930,10 +964,8 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>  					  port->data_role,
>  					  port->negotiated_rev,
>  					  port->message_id,
> -					  port->nr_src_pdo);
> +					  nr_pdo);
>  	}
> -	for (i = 0; i < port->nr_src_pdo; i++)
> -		msg.payload[i] = cpu_to_le32(port->src_pdo[i]);
>  
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
> @@ -941,10 +973,22 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>  static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  {
>  	struct pd_message msg;
> -	int i;
> +	u32 pdo;
> +	unsigned int i, nr_pdo = 0;
>  
>  	memset(&msg, 0, sizeof(msg));
> -	if (!port->nr_snk_pdo) {
> +
> +	for (i = 0; i < port->nr_snk_pdo; i++) {
> +		if (port->negotiated_rev >= PD_REV30) {
> +			msg.payload[nr_pdo++] =	cpu_to_le32(port->snk_pdo[i]);
> +		} else {
> +			pdo = tcpm_forge_legacy_pdo(port, port->snk_pdo[i], TYPEC_SINK);
> +			if (pdo)
> +				msg.payload[nr_pdo++] = cpu_to_le32(pdo);
> +		}
> +	}

ditto.

> +	if (!nr_pdo) {
>  		/* No sink capabilities defined, source only */
>  		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>  					  port->pwr_role,
> @@ -957,10 +1001,8 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  					  port->data_role,
>  					  port->negotiated_rev,
>  					  port->message_id,
> -					  port->nr_snk_pdo);
> +					  nr_pdo);
>  	}
> -	for (i = 0; i < port->nr_snk_pdo; i++)
> -		msg.payload[i] = cpu_to_le32(port->snk_pdo[i]);
>  
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index bb9a782e1411..88f64bce5dea 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -225,6 +225,7 @@ enum pd_pdo_type {
>  #define PDO_FIXED_EXTPOWER		BIT(27) /* Externally powered */
>  #define PDO_FIXED_USB_COMM		BIT(26) /* USB communications capable */
>  #define PDO_FIXED_DATA_SWAP		BIT(25) /* Data role swap supported */
> +#define PDO_FIXED_UNCHUNK_EXT		BIT(24) /* Unchunked Extended Message supported (Source) */
>  #define PDO_FIXED_FRS_CURR_MASK		(BIT(24) | BIT(23)) /* FR_Swap Current (Sink) */
>  #define PDO_FIXED_FRS_CURR_SHIFT	23
>  #define PDO_FIXED_VOLT_SHIFT		10	/* 50mV units */

thanks,

-- 
heikki
