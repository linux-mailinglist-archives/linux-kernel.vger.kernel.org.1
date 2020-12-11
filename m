Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBAE2D72A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437321AbgLKJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:09:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:51339 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437181AbgLKJJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:09:00 -0500
IronPort-SDR: baVjBVjxQNU1PIPXnMBNqX5T3t4wFsWmfUc+gFA0IW2W8hM6gih2A/WozncznzLSIqoQ8wSlPQ
 Cpz63QYxtBDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="259118787"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="259118787"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 01:07:14 -0800
IronPort-SDR: wlouibNHW3+Of0jRa8i2kIbqHU1E4EEsEoyDMr3CJZ9+PmPljnWtHK90is7VdRORYZHK9nwbb4
 qcvvc7DveReA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="440791163"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Dec 2020 01:07:12 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 11 Dec 2020 11:07:11 +0200
Date:   Fri, 11 Dec 2020 11:07:11 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: tcpm: convert comma to semicolon
Message-ID: <20201211090711.GH1594451@kuha.fi.intel.com>
References: <20201211085553.2982-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211085553.2982-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:55:53PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a6fae1f86505..4451507d600c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5024,14 +5024,14 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
>  	snprintf(psy_name, psy_name_len, "%s%s", tcpm_psy_name_prefix,
>  		 port_dev_name);
>  	port->psy_desc.name = psy_name;
> -	port->psy_desc.type = POWER_SUPPLY_TYPE_USB,
> +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
>  	port->psy_desc.usb_types = tcpm_psy_usb_types;
>  	port->psy_desc.num_usb_types = ARRAY_SIZE(tcpm_psy_usb_types);
> -	port->psy_desc.properties = tcpm_psy_props,
> -	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
> -	port->psy_desc.get_property = tcpm_psy_get_prop,
> -	port->psy_desc.set_property = tcpm_psy_set_prop,
> -	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
> +	port->psy_desc.properties = tcpm_psy_props;
> +	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props);
> +	port->psy_desc.get_property = tcpm_psy_get_prop;
> +	port->psy_desc.set_property = tcpm_psy_set_prop;
> +	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable;
>  
>  	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
>  
> -- 
> 2.22.0

thanks,

-- 
heikki
