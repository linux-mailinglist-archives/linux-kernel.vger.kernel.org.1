Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254D630235F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbhAYJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:49:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:24038 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbhAYJgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:36:14 -0500
IronPort-SDR: Dn95e+Aoqt+2rOkCCMsRPXYcm5NRPagHtgpvX+E8hpNJd+e6viPw9snJSJ/TYEFISlOmsXRSnm
 IvnDaqKnBdBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="243773061"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="243773061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 01:33:07 -0800
IronPort-SDR: RxOm6rrh1dDY3i+iQcTZxCM31BRr2g7l8RmphZurkcw7VIoiXSQHW/iHKoaOZoY1JJga1/IB+z
 rWb5F7YleaNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="471993329"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2021 01:33:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 25 Jan 2021 11:33:02 +0200
Date:   Mon, 25 Jan 2021 11:33:02 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     angkery <angkery@163.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH v3 1/2] usb: typec: tcpci_maxim: remove redundant
 assignment
Message-ID: <20210125093302.GB1720720@kuha.fi.intel.com>
References: <20210124143853.1630-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124143853.1630-1-angkery@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 10:38:53PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> PTR_ERR(chip->tcpci) has been used as a return value,
> it is not necessary to assign it to ret, so remove it.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3:remove the newline modification.
> 
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 3192663..7f54f51a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -461,7 +461,6 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
>  	if (IS_ERR(chip->tcpci)) {
>  		dev_err(&client->dev, "TCPCI port registration failed");
> -		ret = PTR_ERR(chip->tcpci);
>  		return PTR_ERR(chip->tcpci);
>  	}
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
> -- 
> 1.9.1

thanks,

-- 
heikki
