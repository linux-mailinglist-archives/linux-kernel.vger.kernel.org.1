Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270E02D72A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437383AbgLKJKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:10:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:22818 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437380AbgLKJJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:09:36 -0500
IronPort-SDR: II/BeZN6xv/vABlwIfBEvFAuGfnmt1GpfwQ8BhcL7TJb4wJFvpSH5f7UZI6n9saam5zPXQ29Ac
 HxbFdblwJ8Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="238506406"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="238506406"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 01:07:49 -0800
IronPort-SDR: l527EIwNxdBh3kL0K6XFwTD0QsiMPp59nJVNTDaqJc8QUz8KqhkaLFgSqxd534FWTUn6srN4dl
 BwkD5i+ST+Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="440791417"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Dec 2020 01:07:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 11 Dec 2020 11:07:46 +0200
Date:   Fri, 11 Dec 2020 11:07:46 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH -next] usb: ucsi: convert comma to semicolon
Message-ID: <20201211090746.GI1594451@kuha.fi.intel.com>
References: <20201211085510.2928-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211085510.2928-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:55:10PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/psy.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 571a51e16234..56bf56517f75 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -220,11 +220,11 @@ int ucsi_register_port_psy(struct ucsi_connector *con)
>  		return -ENOMEM;
>  
>  	con->psy_desc.name = psy_name;
> -	con->psy_desc.type = POWER_SUPPLY_TYPE_USB,
> +	con->psy_desc.type = POWER_SUPPLY_TYPE_USB;
>  	con->psy_desc.usb_types = ucsi_psy_usb_types;
>  	con->psy_desc.num_usb_types = ARRAY_SIZE(ucsi_psy_usb_types);
> -	con->psy_desc.properties = ucsi_psy_props,
> -	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props),
> +	con->psy_desc.properties = ucsi_psy_props;
> +	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props);
>  	con->psy_desc.get_property = ucsi_psy_get_prop;
>  
>  	con->psy = power_supply_register(dev, &con->psy_desc, &psy_cfg);
> -- 
> 2.22.0

thanks,

-- 
heikki
