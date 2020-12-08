Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B122D2793
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgLHJ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:27:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:22380 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbgLHJ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:27:32 -0500
IronPort-SDR: 2Ce3xE8ruysJjLGKYm7XlhckYtq5R2i1KiolO1S8O8/qxuT+VIYHit3WXXVWneU/G/9D3tq4gs
 jolr9K6IW9DA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="161625615"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="161625615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 01:25:43 -0800
IronPort-SDR: 7B44dhAzRjY1LEV4hGnbT/PcR1Z2CKscqFwEnf8rug21OU1ffQZiRPyjQP4U50HBvnqksH7XnB
 KEP+FKEGkljg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437316400"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Dec 2020 01:25:41 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Dec 2020 11:25:40 +0200
Date:   Tue, 8 Dec 2020 11:25:40 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: tcpci: Add support to report vSafe0V
Message-ID: <20201208092540.GB680328@kuha.fi.intel.com>
References: <20201202040840.663578-1-badhri@google.com>
 <20201202040840.663578-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202040840.663578-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:08:39PM -0800, Badhri Jagan Sridharan wrote:
> This change adds vbus_vsafe0v which when set, makes TCPM
> query for VSAFE0V by assigning the tcpc.is_vbus_vsafe0v callback.
> Also enables ALERT.ExtendedStatus which is triggered when
> status of EXTENDED_STATUS.vSafe0V changes.
> EXTENDED_STATUS.vSafe0V is set when vbus is at vSafe0V and
> cleared otherwise.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Removed logic for checking TCPC_POWER_STATUS_MASK reg
>   read in the irq handler. Sending that as a separate patch.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 39 +++++++++++++++++++++++++++++-----
>  drivers/usb/typec/tcpm/tcpci.h |  6 ++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 12d983a75510..f938d9876ce9 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -402,6 +402,19 @@ static int tcpci_get_vbus(struct tcpc_dev *tcpc)
>  	return !!(reg & TCPC_POWER_STATUS_VBUS_PRES);
>  }
>  
> +static bool tcpci_is_vbus_vsafe0v(struct tcpc_dev *tcpc)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &reg);
> +	if (ret < 0)
> +		return false;
> +
> +	return !!(reg & TCPC_EXTENDED_STATUS_VSAFE0V);
> +}
> +
>  static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -554,12 +567,22 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;
>  	if (tcpci->controls_vbus)
>  		reg |= TCPC_ALERT_POWER_STATUS;
> +	/* Enable VSAFE0V status interrupt when detecting VSAFE0V is supported */
> +	if (tcpci->data->vbus_vsafe0v) {
> +		reg |= TCPC_ALERT_EXTENDED_STATUS;
> +		ret = regmap_write(tcpci->regmap, TCPC_EXTENDED_STATUS_MASK,
> +				   TCPC_EXTENDED_STATUS_VSAFE0V);
> +		if (ret < 0)
> +			return ret;
> +	}
>  	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
>  }
>  
>  irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  {
>  	u16 status;
> +	int ret;
> +	unsigned int raw;
>  
>  	tcpci_read16(tcpci, TCPC_ALERT, &status);
>  
> @@ -575,15 +598,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  		tcpm_cc_change(tcpci->port);
>  
>  	if (status & TCPC_ALERT_POWER_STATUS) {
> -		unsigned int reg;
> -
> -		regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &reg);
> -
> +		regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &raw);
>  		/*
>  		 * If power status mask has been reset, then the TCPC
>  		 * has reset.
>  		 */
> -		if (reg == 0xff)
> +		if (raw == 0xff)
>  			tcpm_tcpc_reset(tcpci->port);
>  		else
>  			tcpm_vbus_change(tcpci->port);
> @@ -622,6 +642,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  		tcpm_pd_receive(tcpci->port, &msg);
>  	}
>  
> +	if (status & TCPC_ALERT_EXTENDED_STATUS) {
> +		ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &raw);
> +		if (!ret && (raw & TCPC_EXTENDED_STATUS_VSAFE0V))
> +			tcpm_vbus_change(tcpci->port);
> +	}
> +
>  	if (status & TCPC_ALERT_RX_HARD_RST)
>  		tcpm_pd_hard_reset(tcpci->port);
>  
> @@ -699,6 +725,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  			tcpci_set_auto_vbus_discharge_threshold;
>  	}
>  
> +	if (tcpci->data->vbus_vsafe0v)
> +		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
> +
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
>  		return ERR_PTR(err);
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 3fe313655f0c..116a69c85e38 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -49,6 +49,9 @@
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
>  #define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
>  
> +#define TCPC_EXTENDED_STATUS		0x20
> +#define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
> +
>  #define TCPC_ROLE_CTRL			0x1a
>  #define TCPC_ROLE_CTRL_DRP		BIT(6)
>  #define TCPC_ROLE_CTRL_RP_VAL_SHIFT	4
> @@ -155,11 +158,14 @@ struct tcpci;
>   *		is sourcing vbus.
>   * @auto_discharge_disconnect:
>   *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
> + * @vbus_vsafe0v:
> + *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
>   */
>  struct tcpci_data {
>  	struct regmap *regmap;
>  	unsigned char TX_BUF_BYTE_x_hidden:1;
>  	unsigned char auto_discharge_disconnect:1;
> +	unsigned char vbus_vsafe0v:1;
>  
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> -- 
> 2.29.2.576.ga3fc446d84-goog

-- 
heikki
