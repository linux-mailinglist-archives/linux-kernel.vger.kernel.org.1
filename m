Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4D2B6692
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgKQOFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:05:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:11775 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbgKQNJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:09:24 -0500
IronPort-SDR: QjZtaSjAzXBWFOue01xqhX1qe39LFQdPAbfZxJB8TwsuEBuyHvtJpt58+JBSsmpAMFuJ7ka74+
 HB9MBtLc0AwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="170136085"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="170136085"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 05:09:24 -0800
IronPort-SDR: HqGvF/+6FXV4wA+Mwg2sT/ar+Ezg4LsbCnlpgtiW7e1iuf4KOesQvwoOHmRepcAVlktM4tT9Cw
 Qsy0vdrfJ/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430472543"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 05:09:21 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 15:09:20 +0200
Date:   Tue, 17 Nov 2020 15:09:20 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 11/11] platform/chrome: cros_ec_typec: Register plug
 altmodes
Message-ID: <20201117130920.GK3437448@kuha.fi.intel.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
 <20201116201150.2919178-12-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116201150.2919178-12-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:11:58PM -0800, Prashant Malani wrote:
> Modify the altmode registration (and unregistration) code so that it
> can be used by both partners and plugs.
> 
> Then, add code to register plug altmodes using the newly parameterized
> function. Also set the number of alternate modes for the plug using the
> associated Type C connector class function
> typec_plug_set_num_altmodes().
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Re-arranged patch order and combined it with related series of
>   patches.
> 
> No version v2.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 50 ++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index d2e154ae2362..65c5d0090ccd 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -67,6 +67,7 @@ struct cros_typec_port {
>  	bool sop_prime_disc_done;
>  	struct ec_response_typec_discovery *disc_data;
>  	struct list_head partner_mode_list;
> +	struct list_head plug_mode_list;
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -186,12 +187,15 @@ static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
>  	return ret;
>  }
>  
> -static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num)
> +static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num,
> +					   bool is_partner)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct cros_typec_altmode_node *node, *tmp;
> +	struct list_head *head;
>  
> -	list_for_each_entry_safe(node, tmp, &port->partner_mode_list, list) {
> +	head = is_partner ? &port->partner_mode_list : &port->plug_mode_list;
> +	list_for_each_entry_safe(node, tmp, head, list) {
>  		list_del(&node->list);
>  		typec_unregister_altmode(node->amode);
>  		devm_kfree(typec->dev, node);
> @@ -203,7 +207,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  
> -	cros_typec_unregister_altmodes(typec, port_num);
> +	cros_typec_unregister_altmodes(typec, port_num, true);
>  
>  	port->state.alt = NULL;
>  	port->state.mode = TYPEC_STATE_USB;
> @@ -224,6 +228,8 @@ static void cros_typec_remove_cable(struct cros_typec_data *typec,
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  
> +	cros_typec_unregister_altmodes(typec, port_num, false);
> +
>  	typec_unregister_plug(port->plug);
>  	port->plug = NULL;
>  	typec_unregister_cable(port->cable);
> @@ -352,6 +358,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  		}
>  
>  		INIT_LIST_HEAD(&cros_port->partner_mode_list);
> +		INIT_LIST_HEAD(&cros_port->plug_mode_list);
>  	}
>  
>  	return 0;
> @@ -639,7 +646,11 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
>  				     sizeof(req), resp, sizeof(*resp));
>  }
>  
> -static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num)
> +/*
> + * Helper function to register partner/plug altmodes.
> + */
> +static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num,
> +					bool is_partner)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct ec_response_typec_discovery *sop_disc = port->disc_data;
> @@ -657,7 +668,11 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>  			desc.mode = j;
>  			desc.vdo = sop_disc->svids[i].mode_vdo[j];
>  
> -			amode = typec_partner_register_altmode(port->partner, &desc);
> +			if (is_partner)
> +				amode = typec_partner_register_altmode(port->partner, &desc);
> +			else
> +				amode = typec_plug_register_altmode(port->plug, &desc);
> +
>  			if (IS_ERR(amode)) {
>  				ret = PTR_ERR(amode);
>  				goto err_cleanup;
> @@ -672,21 +687,30 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>  			}
>  
>  			node->amode = amode;
> -			list_add_tail(&node->list, &port->partner_mode_list);
> +
> +			if (is_partner)
> +				list_add_tail(&node->list, &port->partner_mode_list);
> +			else
> +				list_add_tail(&node->list, &port->plug_mode_list);
>  			num_altmodes++;
>  		}
>  	}
>  
> -	ret = typec_partner_set_num_altmodes(port->partner, num_altmodes);
> +	if (is_partner)
> +		ret = typec_partner_set_num_altmodes(port->partner, num_altmodes);
> +	else
> +		ret = typec_plug_set_num_altmodes(port->plug, num_altmodes);
> +
>  	if (ret < 0) {
> -		dev_err(typec->dev, "Unable to set partner num_altmodes for port: %d\n", port_num);
> +		dev_err(typec->dev, "Unable to set %s num_altmodes for port: %d\n",
> +			is_partner ? "partner" : "plug", port_num);
>  		goto err_cleanup;
>  	}
>  
>  	return 0;
>  
>  err_cleanup:
> -	cros_typec_unregister_altmodes(typec, port_num);
> +	cros_typec_unregister_altmodes(typec, port_num, is_partner);
>  	return ret;
>  }
>  
> @@ -774,6 +798,12 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
>  		goto sop_prime_disc_exit;
>  	}
>  
> +	ret = cros_typec_register_altmodes(typec, port_num, false);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Failed to register plug altmodes, port: %d\n", port_num);
> +		goto sop_prime_disc_exit;
> +	}
> +
>  	return 0;
>  
>  sop_prime_disc_exit:
> @@ -815,7 +845,7 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
>  		goto disc_exit;
>  	}
>  
> -	ret = cros_typec_register_altmodes(typec, port_num);
> +	ret = cros_typec_register_altmodes(typec, port_num, true);
>  	if (ret < 0) {
>  		dev_err(typec->dev, "Failed to register partner altmodes, port: %d\n", port_num);
>  		goto disc_exit;
> -- 
> 2.29.2.299.gdc1121823c-goog

thanks,

-- 
heikki
