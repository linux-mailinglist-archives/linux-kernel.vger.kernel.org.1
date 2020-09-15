Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F4326B816
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIPAgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:36:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:42986 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgION1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:27:18 -0400
IronPort-SDR: VCvbYezxSr6U7uUPgBYbMM/QcGWpcKRz1PLvy6NElDVpDCMnx7VMUyTQeLOea7tqLmzAd65xCI
 y6cOv+6bOTWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="160186331"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="160186331"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:26:01 -0700
IronPort-SDR: X/LAgiXrHQkEEyDEpen6n/OPzoT4qPjXcZp29hFeNe3FOcq5vSx25iJXDd90z6KIRlkmJTAJeW
 zWzTkBG/X7SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="409200767"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 06:25:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 16:25:57 +0300
Date:   Tue, 15 Sep 2020 16:25:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/14] usb: typec: tcpci_maxim: Add support for Sink
 FRS
Message-ID: <20200915132557.GJ1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-12-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-12-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:24PM -0700, Badhri Jagan Sridharan wrote:
> Upon receiving ALERT_EXTENDED.TCPC_SINK_FAST_ROLE_SWAP signal
> tcpm to start Sink fast role swap signal.
> 
> Inform when TCPM is sourcing vbus.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 50 +++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index b61f290a8f96..6ba808ad901a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -106,13 +106,22 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
>  		return;
>  	}
>  
> +	ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED, 0xff);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Unable to clear TCPC_ALERT_EXTENDED ret:%d\n", ret);
> +		return;
> +	}
> +
>  	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
>  		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
> -		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS;
> +		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
> +		/* Enable Extended alert for detecting Fast Role Swap Signal */
> +		TCPC_ALERT_EXTND;
>  
>  	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
>  	if (ret < 0) {
> -		dev_err(chip->dev, "Error writing to TCPC_ALERT_MASK ret:%d\n", ret);
> +		dev_err(chip->dev,
> +			"Error enabling TCPC_ALERT: TCPC_ALERT_MASK write failed ret:%d\n", ret);
>  		return;
>  	}
>  
> @@ -122,6 +131,10 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
>  		dev_err(chip->dev, "Error writing to TCPC_POWER_CTRL ret:%d\n", ret);
>  		return;
>  	}
> +
> +	ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED_MASK, TCPC_SINK_FAST_ROLE_SWAP);
> +	if (ret < 0)
> +		return;
>  }
>  
>  static void process_rx(struct max_tcpci_chip *chip, u16 status)
> @@ -225,10 +238,23 @@ static void process_power_status(struct max_tcpci_chip *chip)
>  	if (ret < 0)
>  		return;
>  
> -	if (pwr_status == 0xff)
> +	if (pwr_status == 0xff) {
>  		max_tcpci_init_regs(chip);
> -	else
> +	} else if (pwr_status & TCPC_POWER_STATUS_SOURCING_VBUS) {
> +		tcpm_sourcing_vbus(chip->port);
> +		/*
> +		 * Alawys re-enable boost here.
> +		 * In normal case, when say an headset is attached, TCPM would
> +		 * have instructed to TCPC to enable boost, so the call is a
> +		 * no-op.
> +		 * But for Fast Role Swap case, Boost turns on autonomously without
> +		 * AP intervention, but, needs AP to enable source mode explicitly
> +		 * for AP to regain control.
> +		 */
> +		max_tcpci_set_vbus(chip->tcpci, &chip->data, true, false);
> +	} else {
>  		tcpm_vbus_change(chip->port);
> +	}
>  }
>  
>  static void process_tx(struct max_tcpci_chip *chip, u16 status)
> @@ -249,6 +275,7 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  {
>  	u16 mask;
>  	int ret;
> +	u8 reg_status;
>  
>  	/*
>  	 * Clear alert status for everything except RX_STATUS, which shouldn't
> @@ -274,6 +301,21 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  		}
>  	}
>  
> +	if (status & TCPC_ALERT_EXTND) {
> +		ret = max_tcpci_read8(chip, TCPC_ALERT_EXTENDED, &reg_status);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED, reg_status);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (reg_status & TCPC_SINK_FAST_ROLE_SWAP) {
> +			dev_info(chip->dev, "FRS Signal");
> +			tcpm_sink_frs(chip->port);
> +		}
> +	}
> +
>  	if (status & TCPC_ALERT_RX_STATUS)
>  		process_rx(chip, status);
>  
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

-- 
heikki
