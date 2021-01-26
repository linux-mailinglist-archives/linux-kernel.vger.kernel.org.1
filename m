Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78B3041AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391225AbhAZPJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406140AbhAZPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:08:20 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB4C061A31;
        Tue, 26 Jan 2021 07:07:40 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id f6so16453289ots.9;
        Tue, 26 Jan 2021 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xaixGsbOlWA/hWWYWWxU+LoZCPaGFGa8xnYG6ukohI=;
        b=Npe5iE/KHsFkCbwC6+Iy+64lXhKAG4wo1b02sEIPntr9jY6NhMpO++YFQadMiPB+EE
         MrcxO2oa1iCKiA8Uws6w/p1WfX/imtpNGZCmnoJZe6UYykQoXyR1WU01kOWNhKXTSkO3
         wlzBb0OdlqSpx5mlvqlnPvJkKBtpLQJd4PhcuPxCFspSQwNYqKMiB+D1wtGMxti6oh+h
         ddHhdICTZYgOWH1Z4EIo8xoRZdRGkJYM7wo/4ND4JvbBKvwwj5nw35YH19Zgula0Gj+p
         G4ezEXJUvVsWhvwhI/5ufSBOZtST0nSjf+uJvU8luNrYdcni9ffZd1CulO6JZhoRJKGA
         ELTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8xaixGsbOlWA/hWWYWWxU+LoZCPaGFGa8xnYG6ukohI=;
        b=V8UdKKKZSHuW4dRQjjdUA0cO3OJMf29zen5SJKmwqeTOTG7F7lXBEcQIhmcRJKvNeZ
         aZeXqqysK7dsPff8HliqLtosK+TJ+wHVJ68P7lQwLNYOwHe4NWpJjb/8AVzS7bDIj9O9
         A49mTidorCjcdXMWEZ4C3Z1R4JnfF6OgH6XaT43SaGQxVmNkcVsjZLrb32Gw1ynGdgNM
         lXaftMxM5hAMFxXxQZwavYVLSI6HerupY8lgCqs4h9eV9jOrhtafULtUbFAk7MEmKy9Z
         HOy6FR5c2SeiAHmviWozXufViTX/NkyZITJoqD50LYP03lgeDwAU9EXx4M2xGNtUhV0j
         xn8A==
X-Gm-Message-State: AOAM533nmRPpR/El+pEWWMII5BT6DdFsTi5XI4FK0Iique5bu7g+Gd1H
        Sy2ASm8zJxrJZNXRWl4+qKB4aluuc+Q=
X-Google-Smtp-Source: ABdhPJxCJDKq/BkbLfoTBC99XGBmnpbYIbi7H4f8rNXqvt6adMdwwAtsenBQqhJ20YgnCcZy7tw6aQ==
X-Received: by 2002:a9d:1d64:: with SMTP id m91mr4199234otm.290.1611673659421;
        Tue, 26 Jan 2021 07:07:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10sm2100958otm.22.2021.01.26.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 07:07:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/3] usb: typec: Determine common SVDM Versions
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        hdegoede@redhat.com, badhri@google.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210126084544.682641-1-kyletso@google.com>
 <20210126084544.682641-2-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <18a45657-b893-11ca-630c-8683b52d3ed5@roeck-us.net>
Date:   Tue, 26 Jan 2021 07:07:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126084544.682641-2-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 12:45 AM, Kyle Tso wrote:
> PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
>   6.4.4.2.3 Structured VDM Version
>   "The Structured VDM Version field of the Discover Identity Command
>   sent and received during VDM discovery Shall be used to determine the
>   lowest common Structured VDM Version supported by the Port Partners or
>   Cable Plug and Shall continue to operate using this Specification
>   Revision until they are Detached."
> 
> Also clear the fields newly defined in SVDM version 2.0 for
> compatibilities. And fix some ID Header fields changed in the Spec.
> 

Couple of concerns:
- svdm_ver is kept in three different data structures. I'd like to understand
  why there isn't a single version associated with the port.
- Version comparisons are against SVDM_MAX_VER, not against svdm_ver.
  That makes me slightly uncomfortable. Is there a reason for doing that
  (other than "it should not matter") ?

Thanks,
Guenter

> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  drivers/usb/typec/altmodes/displayport.c |  6 +++-
>  drivers/usb/typec/class.c                |  8 ++---
>  drivers/usb/typec/tcpm/tcpm.c            | 44 +++++++++++++++++++-----
>  drivers/usb/typec/ucsi/displayport.c     | 12 +++++--
>  include/linux/usb/pd_vdo.h               | 40 +++++++++++++++------
>  5 files changed, 83 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index e62e5e3da01e..baf289acf707 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -15,7 +15,7 @@
>  #include <linux/usb/typec_dp.h>
>  #include "displayport.h"
>  
> -#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, cmd) | \
> +#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, (_dp)->svdm_ver, cmd) | \
>  					 VDO_OPOS(USB_TYPEC_DP_MODE))
>  
>  enum {
> @@ -57,6 +57,7 @@ struct dp_altmode {
>  	struct typec_displayport_data data;
>  
>  	enum dp_state state;
> +	u32 svdm_ver;
>  
>  	struct mutex lock; /* device lock */
>  	struct work_struct work;
> @@ -266,6 +267,8 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>  	case CMDT_RSP_ACK:
>  		switch (cmd) {
>  		case CMD_ENTER_MODE:
> +			if (PD_VDO_SVDM_VER(hdr) < SVDM_MAX_VER)
> +				dp->svdm_ver = PD_VDO_SVDM_VER(hdr);
>  			dp->state = DP_STATE_UPDATE;
>  			break;
>  		case CMD_EXIT_MODE:
> @@ -536,6 +539,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	mutex_init(&dp->lock);
>  	dp->port = port;
>  	dp->alt = alt;
> +	dp->svdm_ver = SVDM_MAX_VER;
>  
>  	alt->desc = "DisplayPort";
>  	alt->ops = &dp_altmode_ops;
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 8f77669f9cf4..862afb377752 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -86,7 +86,7 @@ static const char * const typec_accessory_modes[] = {
>  
>  /* Product types defined in USB PD Specification R3.0 V2.0 */
>  static const char * const product_type_ufp[8] = {
> -	[IDH_PTYPE_UNDEF]		= "undefined",
> +	[IDH_PTYPE_NOT_UFP]		= "not_ufp",
>  	[IDH_PTYPE_HUB]			= "hub",
>  	[IDH_PTYPE_PERIPH]		= "peripheral",
>  	[IDH_PTYPE_PSD]			= "psd",
> @@ -94,17 +94,17 @@ static const char * const product_type_ufp[8] = {
>  };
>  
>  static const char * const product_type_dfp[8] = {
> -	[IDH_PTYPE_DFP_UNDEF]		= "undefined",
> +	[IDH_PTYPE_NOT_DFP]		= "not_dfp",
>  	[IDH_PTYPE_DFP_HUB]		= "hub",
>  	[IDH_PTYPE_DFP_HOST]		= "host",
>  	[IDH_PTYPE_DFP_PB]		= "power_brick",
> -	[IDH_PTYPE_DFP_AMC]		= "amc",
>  };
>  
>  static const char * const product_type_cable[8] = {
> -	[IDH_PTYPE_UNDEF]		= "undefined",
> +	[IDH_PTYPE_NOT_CABLE]		= "not_cable",
>  	[IDH_PTYPE_PCABLE]		= "passive",
>  	[IDH_PTYPE_ACABLE]		= "active",
> +	[IDH_PTYPE_VPD]			= "vpd",
>  };
>  
>  static struct usb_pd_identity *get_pd_identity(struct device *dev)
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..c14cf7842520 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -408,6 +408,7 @@ struct tcpm_port {
>  	u8 vdo_count;
>  	/* VDO to retry if UFP responder replied busy */
>  	u32 vdo_retry;
> +	unsigned int svdm_version;
>  
>  	/* PPS */
>  	struct pd_pps_data pps_data;
> @@ -1500,10 +1501,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			if (PD_VDO_VID(p[0]) != USB_SID_PD)
>  				break;
>  
> +			if (PD_VDO_SVDM_VER(p[0]) <= SVDM_MAX_VER)
> +				port->svdm_version = PD_VDO_SVDM_VER(p[0]);
>  			/* 6.4.4.3.1: Only respond as UFP (device) */
>  			if (port->data_role == TYPEC_DEVICE &&
>  			    port->nr_snk_vdo) {
> -				for (i = 0; i <  port->nr_snk_vdo; i++)
> +				/*
> +				 * Product Type DFP and Connector Type are not defined in SVDM
> +				 * version 1.0 and shall be set to zero.
> +				 */
> +				if (port->svdm_version < SVDM_V20)
> +					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
> +						      & ~IDH_CONN_MASK;
> +				else
> +					response[1] = port->snk_vdo[0];
> +				for (i = 1; i <  port->nr_snk_vdo; i++)
>  					response[i + 1] = port->snk_vdo[i];
>  				rlen = port->nr_snk_vdo + 1;
>  			}
> @@ -1532,6 +1544,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			response[0] = p[0] | VDO_CMDT(CMDT_RSP_BUSY);
>  			rlen = 1;
>  		}
> +		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +			      (VDO_SVDM_VERS(port->svdm_version));
>  		break;
>  	case CMDT_RSP_ACK:
>  		/* silently drop message if we are not connected */
> @@ -1542,19 +1556,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  
>  		switch (cmd) {
>  		case CMD_DISCOVER_IDENT:
> +			if (PD_VDO_SVDM_VER(p[0]) <= SVDM_MAX_VER)
> +				port->svdm_version = PD_VDO_SVDM_VER(p[0]);
>  			/* 6.4.4.3.1 */
>  			svdm_consume_identity(port, p, cnt);
> -			response[0] = VDO(USB_SID_PD, 1, CMD_DISCOVER_SVID);
> +			response[0] = VDO(USB_SID_PD, 1, port->svdm_version, CMD_DISCOVER_SVID);
>  			rlen = 1;
>  			break;
>  		case CMD_DISCOVER_SVID:
>  			/* 6.4.4.3.2 */
>  			if (svdm_consume_svids(port, p, cnt)) {
> -				response[0] = VDO(USB_SID_PD, 1,
> +				response[0] = VDO(USB_SID_PD, 1, port->svdm_version,
>  						  CMD_DISCOVER_SVID);
>  				rlen = 1;
>  			} else if (modep->nsvids && supports_modal(port)) {
> -				response[0] = VDO(modep->svids[0], 1,
> +				response[0] = VDO(modep->svids[0], 1, port->svdm_version,
>  						  CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			}
> @@ -1565,7 +1581,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			modep->svid_index++;
>  			if (modep->svid_index < modep->nsvids) {
>  				u16 svid = modep->svids[modep->svid_index];
> -				response[0] = VDO(svid, 1, CMD_DISCOVER_MODES);
> +				response[0] = VDO(svid, 1, port->svdm_version,
> +						  CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			} else {
>  				tcpm_register_partner_altmodes(port);
> @@ -1592,6 +1609,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			/* Unrecognized SVDM */
>  			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
>  			rlen = 1;
> +			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +				      (VDO_SVDM_VERS(port->svdm_version));
>  			break;
>  		}
>  		break;
> @@ -1611,6 +1630,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			/* Unrecognized SVDM */
>  			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
>  			rlen = 1;
> +			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +				      (VDO_SVDM_VERS(port->svdm_version));
>  			break;
>  		}
>  		port->vdm_sm_running = false;
> @@ -1618,6 +1639,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  	default:
>  		response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
>  		rlen = 1;
> +		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +			      (VDO_SVDM_VERS(port->svdm_version));
>  		port->vdm_sm_running = false;
>  		break;
>  	}
> @@ -1695,7 +1718,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			break;
>  		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
>  			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
> -				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
> +				response[0] = VDO(adev->svid, 1, port->svdm_version, CMD_EXIT_MODE);
>  				response[0] |= VDO_OPOS(adev->mode);
>  				rlen = 1;
>  			}
> @@ -1729,7 +1752,8 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
>  
>  	/* set VDM header with VID & CMD */
>  	header = VDO(vid, ((vid & USB_SID_PD) == USB_SID_PD) ?
> -			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), cmd);
> +			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION),
> +			port->svdm_version, cmd);
>  	tcpm_queue_vdm(port, header, data, count);
>  }
>  
> @@ -2024,7 +2048,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  	u32 header;
>  
> -	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
> +	header = VDO(altmode->svid, vdo ? 2 : 1, port->svdm_version, CMD_ENTER_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
> @@ -2036,7 +2060,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  	u32 header;
>  
> -	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
> +	header = VDO(altmode->svid, 1, port->svdm_version, CMD_EXIT_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
> @@ -3716,6 +3740,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
>  		port->caps_count = 0;
>  		port->negotiated_rev = PD_MAX_REV;
> +		port->svdm_version = SVDM_MAX_VER;
>  		port->message_id = 0;
>  		port->rx_msgid = -1;
>  		port->explicit_contract = false;
> @@ -3938,6 +3963,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		typec_set_pwr_opmode(port->typec_port, opmode);
>  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
>  		port->negotiated_rev = PD_MAX_REV;
> +		port->svdm_version = SVDM_MAX_VER;
>  		port->message_id = 0;
>  		port->rx_msgid = -1;
>  		port->explicit_contract = false;
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index 261131c9e37c..421ad3e0d976 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -28,6 +28,7 @@ struct ucsi_dp {
>  	u32 header;
>  	u32 *vdo_data;
>  	u8 vdo_size;
> +	u32 svdm_ver;
>  };
>  
>  /*
> @@ -83,7 +84,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  	 * mode, and letting the alt mode driver continue.
>  	 */
>  
> -	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_ENTER_MODE);
> +	dp->header = VDO(USB_TYPEC_DP_SID, 1, dp->svdm_ver, CMD_ENTER_MODE);
>  	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
>  
> @@ -120,7 +121,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_EXIT_MODE);
> +	dp->header = VDO(USB_TYPEC_DP_SID, 1, dp->svdm_ver, CMD_EXIT_MODE);
>  	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
>  
> @@ -200,7 +201,11 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
>  
>  	switch (cmd_type) {
>  	case CMDT_INIT:
> -		dp->header = VDO(USB_TYPEC_DP_SID, 1, cmd);
> +		if (PD_VDO_SVDM_VER(header) != dp->svdm_ver &&
> +		    PD_VDO_SVDM_VER(header) < SVDM_MAX_VER)
> +			dp->svdm_ver = PD_VDO_SVDM_VER(header);
> +
> +		dp->header = VDO(USB_TYPEC_DP_SID, 1, dp->svdm_ver, cmd);
>  		dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  
>  		switch (cmd) {
> @@ -310,6 +315,7 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
>  	dp->offset = offset;
>  	dp->con = con;
>  	dp->alt = alt;
> +	dp->svdm_ver = SVDM_MAX_VER;
>  
>  	alt->ops = &ucsi_displayport_ops;
>  	typec_altmode_set_drvdata(alt, dp);
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index 8c08eeb9a74b..5283a08527ce 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -16,27 +16,33 @@
>  #define VDO_MAX_OBJECTS		6
>  #define VDO_MAX_SIZE		(VDO_MAX_OBJECTS + 1)
>  
> +#define SVDM_V10		0
> +#define SVDM_V20		1
> +#define SVDM_MAX_VER		SVDM_V20
> +
>  /*
>   * VDM header
>   * ----------
>   * <31:16>  :: SVID
>   * <15>     :: VDM type ( 1b == structured, 0b == unstructured )
> - * <14:13>  :: Structured VDM version (can only be 00 == 1.0 currently)
> + * <14:13>  :: Structured VDM version
>   * <12:11>  :: reserved
>   * <10:8>   :: object position (1-7 valid ... used for enter/exit mode only)
>   * <7:6>    :: command type (SVDM only?)
>   * <5>      :: reserved (SVDM), command type (UVDM)
>   * <4:0>    :: command
>   */
> -#define VDO(vid, type, custom)				\
> +#define VDO(vid, type, ver, custom)				\
>  	(((vid) << 16) |				\
>  	 ((type) << 15) |				\
> +	 ((ver) << 13) |				\
>  	 ((custom) & 0x7FFF))
>  
>  #define VDO_SVDM_TYPE		(1 << 15)
>  #define VDO_SVDM_VERS(x)	((x) << 13)
>  #define VDO_OPOS(x)		((x) << 8)
>  #define VDO_CMDT(x)		((x) << 6)
> +#define VDO_SVDM_VERS_MASK	VDO_SVDM_VERS(0x3)
>  #define VDO_OPOS_MASK		VDO_OPOS(0x7)
>  #define VDO_CMDT_MASK		VDO_CMDT(0x3)
>  
> @@ -74,6 +80,7 @@
>  
>  #define PD_VDO_VID(vdo)		((vdo) >> 16)
>  #define PD_VDO_SVDM(vdo)	(((vdo) >> 15) & 1)
> +#define PD_VDO_SVDM_VER(vdo)	(((vdo) >> 13) & 0x3)
>  #define PD_VDO_OPOS(vdo)	(((vdo) >> 8) & 0x7)
>  #define PD_VDO_CMD(vdo)		((vdo) & 0x1f)
>  #define PD_VDO_CMDT(vdo)	(((vdo) >> 6) & 0x3)
> @@ -103,34 +110,46 @@
>   * --------------------
>   * <31>     :: data capable as a USB host
>   * <30>     :: data capable as a USB device
> - * <29:27>  :: product type (UFP / Cable)
> + * <29:27>  :: product type (UFP / Cable / VPD)
>   * <26>     :: modal operation supported (1b == yes)
> - * <25:16>  :: product type (DFP)
> + * <25:23>  :: product type (DFP) (SVDM version 2.0+ only; set to zero in version 1.0)
> + * <22:21>  :: connector type (SVDM version 2.0+ only; set to zero in version 1.0)
> + * <20:16>  :: Reserved, Shall be set to zero
>   * <15:0>   :: USB-IF assigned VID for this cable vendor
>   */
> -#define IDH_PTYPE_UNDEF		0
> +/* SOP Product Type (UFP) */
> +#define IDH_PTYPE_NOT_UFP	0
>  #define IDH_PTYPE_HUB		1
>  #define IDH_PTYPE_PERIPH	2
>  #define IDH_PTYPE_PSD		3
>  #define IDH_PTYPE_AMA		5
>  
> +/* SOP' Product Type (Cable Plug / VPD) */
> +#define IDH_PTYPE_NOT_CABLE	0
>  #define IDH_PTYPE_PCABLE	3
>  #define IDH_PTYPE_ACABLE	4
> +#define IDH_PTYPE_VPD		6
>  
> -#define IDH_PTYPE_DFP_UNDEF	0
> +/* SOP Product Type (DFP) */
> +#define IDH_PTYPE_NOT_DFP	0
>  #define IDH_PTYPE_DFP_HUB	1
>  #define IDH_PTYPE_DFP_HOST	2
>  #define IDH_PTYPE_DFP_PB	3
> -#define IDH_PTYPE_DFP_AMC	4
>  
> -#define VDO_IDH(usbh, usbd, ptype, is_modal, vid)		\
> -	((usbh) << 31 | (usbd) << 30 | ((ptype) & 0x7) << 27	\
> -	 | (is_modal) << 26 | ((vid) & 0xffff))
> +/* ID Header Mask */
> +#define IDH_DFP_MASK		GENMASK(25, 23)
> +#define IDH_CONN_MASK		GENMASK(22, 21)
> +
> +#define VDO_IDH(usbh, usbd, ufp_cable, is_modal, dfp, conn, vid)		\
> +	((usbh) << 31 | (usbd) << 30 | ((ufp_cable) & 0x7) << 27		\
> +	 | (is_modal) << 26 | ((dfp) & 0x7) << 23 | ((conn) & 0x3) << 21	\
> +	 | ((vid) & 0xffff))
>  
>  #define PD_IDH_PTYPE(vdo)	(((vdo) >> 27) & 0x7)
>  #define PD_IDH_VID(vdo)		((vdo) & 0xffff)
>  #define PD_IDH_MODAL_SUPP(vdo)	((vdo) & (1 << 26))
>  #define PD_IDH_DFP_PTYPE(vdo)	(((vdo) >> 23) & 0x7)
> +#define PD_IDH_CONN_TYPE(vdo)	(((vdo) >> 21) & 0x3)
>  
>  /*
>   * Cert Stat VDO
> @@ -138,6 +157,7 @@
>   * <31:0>  : USB-IF assigned XID for this cable
>   */
>  #define PD_CSTAT_XID(vdo)	(vdo)
> +#define VDO_CERT(xid)		((xid) & 0xffffffff)
>  
>  /*
>   * Product VDO
> 

