Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D142D2797
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgLHJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:28:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:11601 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbgLHJ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:28:18 -0500
IronPort-SDR: jP113QkBnPA0stwIn1xF8LHx5vWxeYgH/OE8lqaHO7fQqbLtytiVm3d7FCTCGDr5ojdz6SidRh
 qcdwhiy5e/uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="171289223"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="171289223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 01:26:26 -0800
IronPort-SDR: zhhVIlCGklv/r/1kXZJIjPwWWQHgD3GUAwUjxitSg6FiPOePtmPR8Ctl+HX7Rzq6ldXdw/Y7u/
 I5O6XFdfvjCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437316612"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Dec 2020 01:26:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Dec 2020 11:26:23 +0200
Date:   Tue, 8 Dec 2020 11:26:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: tcpci_maxim: Enable VSAFE0V signalling
Message-ID: <20201208092623.GC680328@kuha.fi.intel.com>
References: <20201202040840.663578-1-badhri@google.com>
 <20201202040840.663578-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202040840.663578-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:08:40PM -0800, Badhri Jagan Sridharan wrote:
> Unmask EXTENDED_STATUS_MASK.vSafe0V, ALERT.Extended_Status
> and set vbus_vsafe0v to enable VSAFE0V signalling.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Setting auto_discharge_disconnect to true instead of 1 as
>   suggested by Guenter.
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index c1797239bf08..319266329b42 100644
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
> +	chip->data.vbus_vsafe0v = true;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.29.2.576.ga3fc446d84-goog

-- 
heikki
