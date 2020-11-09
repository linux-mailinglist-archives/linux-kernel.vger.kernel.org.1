Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF432AB259
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgKIIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:23:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:10319 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgKIIXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:23:41 -0500
IronPort-SDR: i2gNkEQZ3Z9jNurPbptlINuVMPIWdp9Wg9TptUFSYu4apDSYIjKiDZsV9E79FEHP9z6wABQihB
 +iD77LDF0tlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="167180951"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="167180951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:23:41 -0800
IronPort-SDR: PFHlEoqILWV/jurf/JXQKqEo60ThfjoeB8A+0wszARgLUHvR7IO62QRhOjs7DKk28uPnULbQxm
 9qUJt9DUg5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="427917970"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Nov 2020 00:23:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Nov 2020 10:23:37 +0200
Date:   Mon, 9 Nov 2020 10:23:37 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 3/6] platform/chrome: cros_ec_typec: Rename discovery
 struct
Message-ID: <20201109082337.GE4062920@kuha.fi.intel.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
 <20201106184104.939284-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-4-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:41:04AM -0800, Prashant Malani wrote:
> Rename the sop_disc data struct which is used to store PD discovery data
> to the more generic name of disc_data. It can then be re-used to store
> and process cable discovery data.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index f6d3c37c2c27..3c8ff07c8803 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -59,7 +59,7 @@ struct cros_typec_port {
>  
>  	/* Flag indicating that PD partner discovery data parsing is completed. */
>  	bool sop_disc_done;
> -	struct ec_response_typec_discovery *sop_disc;
> +	struct ec_response_typec_discovery *disc_data;
>  	struct list_head partner_mode_list;
>  };
>  
> @@ -323,8 +323,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  
>  		cros_typec_register_port_altmodes(typec, port_num);
>  
> -		cros_port->sop_disc = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
> -		if (!cros_port->sop_disc) {
> +		cros_port->disc_data = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
> +		if (!cros_port->disc_data) {
>  			ret = -ENOMEM;
>  			goto unregister_ports;
>  		}
> @@ -617,7 +617,7 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
>  static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
> -	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
> +	struct ec_response_typec_discovery *sop_disc = port->disc_data;
>  	struct cros_typec_altmode_node *node;
>  	struct typec_altmode_desc desc;
>  	struct typec_altmode *amode;
> @@ -682,7 +682,7 @@ static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
>  static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
> -	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
> +	struct ec_response_typec_discovery *sop_disc = port->disc_data;
>  	struct ec_params_typec_discovery req = {
>  		.port = port_num,
>  		.partner_type = TYPEC_PARTNER_SOP,
> -- 
> 2.29.1.341.ge80a0c044ae-goog

thanks,

-- 
heikki
