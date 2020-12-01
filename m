Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB32CA390
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390786AbgLANRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:17:30 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:49477 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbgLANR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:17:29 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 0DF4B1E0A2B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:16:48 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id k5WRkmadjdCH5k5WRkquK4; Tue, 01 Dec 2020 06:16:48 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=MYVCRa3f c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=t-lpimFPybC9bo6FsFIA:9 a=CjuIK1q_8ugA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nLqBq10+fOR+OKny22HWzAhVOxxT+jc5tuAvYk0u7qc=; b=31hx/YBpE/apnzWtMG6wL+f0dk
        T1A+wHRWQI0LnZGVK+cWltF4K/RkknsYUb5cQiMNQ+ldpZAGmlvSrspBeH2xGSjI66Em8t3sZHmj0
        OmTd+yuV9LfQcv4Cfmk1cayJZrEbqGVuNFGTxFaBiwe66i6VNvfSj3JdPyBm5rnt7TxZuhmp+O67b
        pcRvi6BHoPKAEhqLCtJLmA59+pW3zZecsJaifq595/5uNxA0Ap9zw3+DgZbXog3coF2zN/we2FLkv
        /aNPxEU9umT3fLTK/L3W5LLiBxKtkd/DhQ/axPHLBwUHurZoVF6z6B3EtUQh0QyeyNJAfAo+/dPu2
        AdIgjxgg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59908 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kk5WR-0007TB-3O; Tue, 01 Dec 2020 13:16:47 +0000
Date:   Tue, 1 Dec 2020 05:16:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] usb: typec: tcpci_maxim: Enable VSAFE0V signalling
Message-ID: <20201201131646.GC232197@roeck-us.net>
References: <20201201013246.32034-1-badhri@google.com>
 <20201201013246.32034-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201013246.32034-3-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kk5WR-0007TB-3O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:59908
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 20
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:32:46PM -0800, Badhri Jagan Sridharan wrote:
> Unmask EXTENDED_STATUS_MASK.vSafe0V, ALERT.Extended_Status
> and set vbus_vsafe0v to enable VSAFE0V signalling.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index c1797239bf08..1aabe6abd819 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -112,11 +112,18 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
>  		return;
>  	}
>  
> +	/* Enable VSAFE0V detection */
> +	ret = max_tcpci_write8(chip, TCPC_EXTENDED_STATUS_MASK, TCPC_EXTENDED_STATUS_VSAFE0V);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Unable to unmask TCPC_EXTENDED_STATUS_VSAFE0V ret:%d\n", ret);
> +		return;
> +	}
> +
>  	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
>  		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
>  		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
>  		/* Enable Extended alert for detecting Fast Role Swap Signal */
> -		TCPC_ALERT_EXTND;
> +		TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS;
>  
>  	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
>  	if (ret < 0) {
> @@ -315,6 +322,12 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  		}
>  	}
>  
> +	if (status & TCPC_ALERT_EXTENDED_STATUS) {
> +		ret = max_tcpci_read8(chip, TCPC_EXTENDED_STATUS, (u8 *)&reg_status);
> +		if (ret >= 0 && (reg_status & TCPC_EXTENDED_STATUS_VSAFE0V))
> +			tcpm_vbus_change(chip->port);
> +	}
> +
>  	if (status & TCPC_ALERT_RX_STATUS)
>  		process_rx(chip, status);
>  
> @@ -442,6 +455,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->data.init = tcpci_init;
>  	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
>  	chip->data.auto_discharge_disconnect = true;
> +	chip->data.vbus_vsafe0v = 1;

Why not use true/false ?

>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
