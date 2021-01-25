Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB95304A24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbhAZFOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:14:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:24544 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbhAYJlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:41:01 -0500
IronPort-SDR: O1OlXT3GB1RrNMskYylZhQYus9H/fUavgr7q+X/7Q7IXvIJiw+EeZzsT2O8waly2uDXG1WwcHD
 Uzt6o+5GCF7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="243773211"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="243773211"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 01:34:02 -0800
IronPort-SDR: SNoZNL8KIhrD+eKpTytEij+R3D6xneGtryZekQJenjgTIeNUcFirYAzs3Ie6Y4yG+SZSjnI/I3
 kny4lbqgi5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="471993591"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2021 01:33:59 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 25 Jan 2021 11:33:59 +0200
Date:   Mon, 25 Jan 2021 11:33:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     angkery <angkery@163.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH v3 2/2] usb: typec: tcpci_maxim: add terminating newlines
 to logging
Message-ID: <20210125093359.GC1720720@kuha.fi.intel.com>
References: <20210124143947.1688-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124143947.1688-1-angkery@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 10:39:47PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> Add terminating '\n' to the formats where missed.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3:Modify it again and submit it separately from patch 1.
> 
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 7f54f51a..5d7463c 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -158,7 +158,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  	 */
>  	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, 2);
>  	if (ret < 0) {
> -		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d", ret);
> +		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d\n", ret);
>  		return;
>  	}
>  
> @@ -167,13 +167,13 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  
>  	if (count == 0 || frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP) {
>  		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
> -		dev_err(chip->dev, "%s", count ==  0 ? "error: count is 0" :
> +		dev_err(chip->dev, "%s\n", count ==  0 ? "error: count is 0" :
>  			"error frame_type is not SOP");
>  		return;
>  	}
>  
>  	if (count > sizeof(struct pd_message) || count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
> -		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d", count);
> +		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d\n", count);
>  		return;
>  	}
>  
> @@ -184,7 +184,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  	count += 1;
>  	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, count);
>  	if (ret < 0) {
> -		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d", ret);
> +		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d\n", ret);
>  		return;
>  	}
>  
> @@ -317,7 +317,7 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  			return ret;
>  
>  		if (reg_status & TCPC_SINK_FAST_ROLE_SWAP) {
> -			dev_info(chip->dev, "FRS Signal");
> +			dev_info(chip->dev, "FRS Signal\n");
>  			tcpm_sink_frs(chip->port);
>  		}
>  	}
> @@ -460,7 +460,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
>  	if (IS_ERR(chip->tcpci)) {
> -		dev_err(&client->dev, "TCPCI port registration failed");
> +		dev_err(&client->dev, "TCPCI port registration failed\n");
>  		return PTR_ERR(chip->tcpci);
>  	}
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
> -- 
> 1.9.1

thanks,

-- 
heikki
