Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A82C8234
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgK3Kb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:31:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:65474 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbgK3Kb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:31:26 -0500
IronPort-SDR: BmijwczFEG6FHDCbzUyRMVm1xv7cYwqN489RMcfJREzMqqwSeY0DJNH89Qrk/fqMEMzSX9L24D
 BDAEBA3wZk0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="169115392"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="169115392"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 02:29:45 -0800
IronPort-SDR: 37FsGUTQabxcZUL4YZTH2m4XDp0v0jJAcchF26J13qHZmx1wQfe8dUcWvMuivFgKgT9339Y2m4
 VATR/zyIs5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="434266167"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Nov 2020 02:29:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 30 Nov 2020 12:29:42 +0200
Date:   Mon, 30 Nov 2020 12:29:42 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: tps6598x: Export some power supply
 properties
Message-ID: <20201130102942.GB2911464@kuha.fi.intel.com>
References: <cover.1606481420.git.agx@sigxcpu.org>
 <91c27b323786445f6b33c6a7e89e93755d05e3a2.1606481420.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91c27b323786445f6b33c6a7e89e93755d05e3a2.1606481420.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 01:53:29PM +0100, Guido Günther wrote:
> This allows downstream supplies and userspace to detect
> whether external power is supplied.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig    |   1 +
>  drivers/usb/typec/tps6598x.c | 105 +++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 772b07e9f188..365f905a8e49 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -64,6 +64,7 @@ config TYPEC_HD3SS3220
>  config TYPEC_TPS6598X
>  	tristate "TI TPS6598x USB Power Delivery controller driver"
>  	depends on I2C
> +	select POWER_SUPPLY
>  	select REGMAP_I2C
>  	select USB_ROLE_SWITCH
>  	help
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index 3db33bb622c3..8163306f849e 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -9,6 +9,7 @@
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> +#include <linux/power_supply.h>
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
>  #include <linux/usb/typec.h>
> @@ -55,6 +56,7 @@ enum {
>  };
>  
>  /* TPS_REG_POWER_STATUS bits */
> +#define TPS_POWER_STATUS_CONNECTION	BIT(0)
>  #define TPS_POWER_STATUS_SOURCESINK	BIT(1)
>  #define TPS_POWER_STATUS_PWROPMODE(p)	(((p) & GENMASK(3, 2)) >> 2)
>  
> @@ -96,8 +98,25 @@ struct tps6598x {
>  	struct typec_partner *partner;
>  	struct usb_pd_identity partner_identity;
>  	struct usb_role_switch *role_sw;
> +	struct typec_capability typec_cap;
> +
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +	enum power_supply_usb_type usb_type;
> +};
> +
> +static enum power_supply_property tps6598x_psy_props[] = {
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_ONLINE,
>  };
>  
> +static enum power_supply_usb_type tps6598x_psy_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_C,
> +	POWER_SUPPLY_USB_TYPE_PD,
> +};
> +
> +static const char *tps6598x_psy_name_prefix = "tps6598x-source-psy-";
> +
>  /*
>   * Max data bytes for Data1, Data2, and other registers. See ch 1.3.2:
>   * https://www.ti.com/lit/ug/slvuan1a/slvuan1a.pdf
> @@ -248,6 +267,8 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  	if (desc.identity)
>  		typec_partner_set_identity(tps->partner);
>  
> +	power_supply_changed(tps->psy);
> +
>  	return 0;
>  }
>  
> @@ -260,6 +281,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
>  	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
>  	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), false);
> +	power_supply_changed(tps->psy);
>  }
>  
>  static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> @@ -467,6 +489,85 @@ static const struct regmap_config tps6598x_regmap_config = {
>  	.max_register = 0x7F,
>  };
>  
> +static int tps6598x_psy_get_online(struct tps6598x *tps,
> +				   union power_supply_propval *val)
> +{
> +	int ret;
> +	u16 pwr_status;
> +
> +	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(pwr_status & TPS_POWER_STATUS_CONNECTION) ||
> +	    !(pwr_status & TPS_POWER_STATUS_SOURCESINK)) {
> +		val->intval = 0;
> +	} else {
> +		val->intval = 1;
> +	}
> +	return 0;
> +}
> +
> +static int tps6598x_psy_get_prop(struct power_supply *psy,
> +				 enum power_supply_property psp,
> +				 union power_supply_propval *val)
> +{
> +	struct tps6598x *tps = power_supply_get_drvdata(psy);
> +	u16 pwr_status;
> +	int ret = 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> +		if (ret < 0)
> +			return ret;
> +		if (TPS_POWER_STATUS_PWROPMODE(pwr_status) == TYPEC_PWR_MODE_PD)
> +			val->intval = POWER_SUPPLY_USB_TYPE_PD;
> +		else
> +			val->intval = POWER_SUPPLY_USB_TYPE_C;
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = tps6598x_psy_get_online(tps, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int devm_tps6598_psy_register(struct tps6598x *tps)
> +{
> +	struct power_supply_config psy_cfg = {};
> +	const char *port_dev_name = dev_name(tps->dev);
> +	size_t psy_name_len = strlen(tps6598x_psy_name_prefix) +
> +				     strlen(port_dev_name) + 1;
> +	char *psy_name;
> +
> +	psy_cfg.drv_data = tps;
> +	psy_cfg.fwnode = dev_fwnode(tps->dev);
> +	psy_name = devm_kzalloc(tps->dev, psy_name_len, GFP_KERNEL);
> +	if (!psy_name)
> +		return -ENOMEM;
> +
> +	snprintf(psy_name, psy_name_len, "%s%s", tps6598x_psy_name_prefix,
> +		 port_dev_name);
> +	tps->psy_desc.name = psy_name;
> +	tps->psy_desc.type = POWER_SUPPLY_TYPE_USB;
> +	tps->psy_desc.usb_types = tps6598x_psy_usb_types;
> +	tps->psy_desc.num_usb_types = ARRAY_SIZE(tps6598x_psy_usb_types);
> +	tps->psy_desc.properties = tps6598x_psy_props;
> +	tps->psy_desc.num_properties = ARRAY_SIZE(tps6598x_psy_props);
> +	tps->psy_desc.get_property = tps6598x_psy_get_prop;
> +
> +	tps->usb_type = POWER_SUPPLY_USB_TYPE_C;
> +
> +	tps->psy = devm_power_supply_register(tps->dev, &tps->psy_desc,
> +					       &psy_cfg);
> +	return PTR_ERR_OR_ZERO(tps->psy);
> +}
> +
>  static int tps6598x_probe(struct i2c_client *client)
>  {
>  	struct typec_capability typec_cap = { };
> @@ -560,6 +661,10 @@ static int tps6598x_probe(struct i2c_client *client)
>  		goto err_role_put;
>  	}
>  
> +	ret = devm_tps6598_psy_register(tps);
> +	if (ret)
> +		return ret;
> +
>  	tps->port = typec_register_port(&client->dev, &typec_cap);
>  	if (IS_ERR(tps->port)) {
>  		ret = PTR_ERR(tps->port);
> -- 
> 2.29.2

thanks,

-- 
heikki
