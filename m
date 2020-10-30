Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743762A0675
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgJ3NcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:32:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:4377 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgJ3NcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:32:23 -0400
IronPort-SDR: K6tZbNIs+fCVStvvgyMOLtRrHAZlcsE+EywWBEzpsxddoFSedvn99SYV9OUQ7xra1+/9IWZSqT
 HBGunDFsHL7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156379571"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="156379571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:32:12 -0700
IronPort-SDR: 4OqqWplgEE4x0HlPKf7B/eyge0FOASE5Ri8pNaKGNrh1SxJFBFMo1pfZpDg/047edN3sanSgfU
 FAm3papgjIPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="425345747"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2020 06:32:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Oct 2020 15:32:08 +0200
Date:   Fri, 30 Oct 2020 15:32:08 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, dzigterman@chromium.org,
        alevkoy@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 7/7] platform/chrome: cros_ec_typec: Register partner
 altmodes
Message-ID: <20201030133208.GF2333887@kuha.fi.intel.com>
References: <20201029222738.482366-1-pmalani@chromium.org>
 <20201029222738.482366-8-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029222738.482366-8-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:27:42PM -0700, Prashant Malani wrote:
> Use the discovery data from the Chrome EC to register parter altmodes
> with the Type C Connector Class framework. Also introduce a node
> struct to keep track of the list of registered alt modes.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - Changed list traversal during alt mode unregistering to use
>   list_for_each_entry_safe() base on review comment.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 77 +++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index f14550dac614..ce031a10eb1b 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> @@ -31,6 +32,12 @@ enum {
>  	CROS_EC_ALTMODE_MAX,
>  };
>  
> +/* Container for altmode pointer nodes. */
> +struct cros_typec_altmode_node {
> +	struct typec_altmode *amode;
> +	struct list_head list;
> +};
> +
>  /* Per port data. */
>  struct cros_typec_port {
>  	struct typec_port *port;
> @@ -53,6 +60,7 @@ struct cros_typec_port {
>  	/* Flag indicating that PD discovery data parsing is completed. */
>  	bool disc_done;
>  	struct ec_response_typec_discovery *sop_disc;
> +	struct list_head partner_mode_list;
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -172,11 +180,25 @@ static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
>  	return ret;
>  }
>  
> +static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct cros_typec_altmode_node *node, *tmp;
> +
> +	list_for_each_entry_safe(node, tmp, &port->partner_mode_list, list) {
> +		list_del(&node->list);
> +		typec_unregister_altmode(node->amode);
> +		devm_kfree(typec->dev, node);
> +	}
> +}
> +
>  static void cros_typec_remove_partner(struct cros_typec_data *typec,
>  				     int port_num)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  
> +	cros_typec_unregister_altmodes(typec, port_num);
> +
>  	port->state.alt = NULL;
>  	port->state.mode = TYPEC_STATE_USB;
>  	port->state.data = NULL;
> @@ -306,6 +328,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  			ret = -ENOMEM;
>  			goto unregister_ports;
>  		}
> +
> +		INIT_LIST_HEAD(&cros_port->partner_mode_list);
>  	}
>  
>  	return 0;
> @@ -590,6 +614,49 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
>  				     sizeof(req), resp, sizeof(*resp));
>  }
>  
> +static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
> +	struct cros_typec_altmode_node *node;
> +	struct typec_altmode_desc desc;
> +	struct typec_altmode *amode;
> +	int ret = 0;
> +	int i, j;
> +
> +	for (i = 0; i < sop_disc->svid_count; i++) {
> +		for (j = 0; j < sop_disc->svids[i].mode_count; j++) {
> +			memset(&desc, 0, sizeof(desc));
> +			desc.svid = sop_disc->svids[i].svid;
> +			desc.mode = j;
> +			desc.vdo = sop_disc->svids[i].mode_vdo[j];
> +
> +			amode = typec_partner_register_altmode(port->partner, &desc);
> +			if (IS_ERR(amode)) {
> +				ret = PTR_ERR(amode);
> +				goto err_cleanup;
> +			}
> +
> +			/* If no memory is available we should unregister and exit. */
> +			node = devm_kzalloc(typec->dev, sizeof(*node), GFP_KERNEL);
> +			if (!node) {
> +				ret = -ENOMEM;
> +				typec_unregister_altmode(amode);
> +				goto err_cleanup;
> +			}
> +
> +			node->amode = amode;
> +			list_add_tail(&node->list, &port->partner_mode_list);
> +		}
> +	}
> +
> +	return 0;
> +
> +err_cleanup:
> +	cros_typec_unregister_altmodes(typec, port_num);
> +	return ret;
> +}
> +
>  static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
> @@ -630,6 +697,16 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
>  		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
>  
>  	ret = typec_partner_set_identity(port->partner);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Failed to update partner PD identity, port: %d\n", port_num);
> +		goto disc_exit;
> +	}
> +
> +	ret = cros_typec_register_altmodes(typec, port_num);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Failed to register partner altmodes, port: %d\n", port_num);
> +		goto disc_exit;
> +	}
>  
>  disc_exit:
>  	return ret;
> -- 
> 2.29.1.341.ge80a0c044ae-goog

thanks,

-- 
heikki
