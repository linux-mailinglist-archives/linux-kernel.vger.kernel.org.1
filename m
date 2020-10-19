Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C32292892
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgJSNt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:49:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:23529 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgJSNtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:49:55 -0400
IronPort-SDR: ZLEOHwu6K66p1uEnBqauJNIJais7yl3YRSmFZGiQVdm5ewxUvChPO19H8gpURJ7igDqItmoabw
 EKhe2EgDbw6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167143746"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="167143746"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 06:49:54 -0700
IronPort-SDR: pul1hPuGtmMevZseQSxSffHhQwTo1Aa79jH3ozRgKJbeoX+ZDkrmTwvCYnjeOO2yxYIxSSCHpn
 E4BXkjv9+tpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="422186089"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2020 06:49:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Oct 2020 16:49:48 +0300
Date:   Mon, 19 Oct 2020 16:49:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v10 14/15] usb: typec: tcpci: Implement Auto discharge
 disconnect callbacks
Message-ID: <20201019134948.GH1667571@kuha.fi.intel.com>
References: <20201008061556.1402293-1-badhri@google.com>
 <20201008061556.1402293-15-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008061556.1402293-15-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:15:55PM -0700, Badhri Jagan Sridharan wrote:
> vImplement callbacks for enabling/disabling
> POWER_CONTROL.AutoDischargeDisconnect.
> 
> Programs VBUS_SINK_DISCONNECT_THRESHOLD based on the
> voltage requested as sink, mode of operation.
> 
> The programmed threshold is based on vSinkDisconnect and
> vSinkDisconnectPD values.
> 
> Add auto_discharge_disconnect to tdata to allow TCPC chip
> level drivers enable AutoDischargeDisconnect.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Rebase on usb-next.
> 
> Changes since v7:
> Heikki's suggestion:
> - Moved the actual write to TCPC_VBUS_SINK_DISCONNECT_THRESH
> as it's common to all chip drivers.
> - Renaming the tcpci_data callback as
> get_auto_vbus_discharge_threshold
> 
> Changes since v8:
> - Removed get_auto_vbus_discharge_threshold callback and moved the logic
>   to program the default threshold for TCPC_VBUS_SINK_DISCONNECT_THRESH
>   into the TCPCI code.
> 
> Changes since v9:
> - none
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 63 +++++++++++++++++++++++++++++++++-
>  drivers/usb/typec/tcpm/tcpci.h | 14 ++++++--
>  2 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f91688e43991..12d983a75510 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -18,7 +18,10 @@
>  
>  #include "tcpci.h"
>  
> -#define PD_RETRY_COUNT 3
> +#define	PD_RETRY_COUNT				3
> +#define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
> +#define	AUTO_DISCHARGE_PD_HEADROOM_MV		850
> +#define	AUTO_DISCHARGE_PPS_HEADROOM_MV		1250
>  
>  struct tcpci {
>  	struct device *dev;
> @@ -268,6 +271,58 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>  }
>  
> +static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> +	int ret;
> +
> +	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
> +				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
> +	return ret;
> +}
> +
> +static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
> +						   bool pps_active, u32 requested_vbus_voltage_mv)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> +	unsigned int pwr_ctrl, threshold = 0;
> +	int ret;
> +
> +	/*
> +	 * Indicates that vbus is going to go away due PR_SWAP, hard reset etc.
> +	 * Do not discharge vbus here.
> +	 */
> +	if (requested_vbus_voltage_mv == 0)
> +		goto write_thresh;
> +
> +	ret = regmap_read(tcpci->regmap, TCPC_POWER_CTRL, &pwr_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (pwr_ctrl & TCPC_FAST_ROLE_SWAP_EN) {
> +		/* To prevent disconnect when the source is fast role swap is capable. */
> +		threshold = AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
> +	} else if (mode == TYPEC_PWR_MODE_PD) {
> +		if (pps_active)
> +			threshold = (95 * requested_vbus_voltage_mv / 100) -
> +				AUTO_DISCHARGE_PD_HEADROOM_MV;
> +		else
> +			threshold = (95 * requested_vbus_voltage_mv / 100) -
> +				AUTO_DISCHARGE_PPS_HEADROOM_MV;
> +	} else {
> +		/* 3.5V for non-pd sink */
> +		threshold = AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
> +	}
> +
> +	threshold = threshold / TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV;
> +
> +	if (threshold > TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX)
> +		return -EINVAL;
> +
> +write_thresh:
> +	return tcpci_write16(tcpci, TCPC_VBUS_SINK_DISCONNECT_THRESH, threshold);
> +}
> +
>  static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> @@ -638,6 +693,12 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.enable_frs = tcpci_enable_frs;
>  	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
>  
> +	if (tcpci->data->auto_discharge_disconnect) {
> +		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
> +		tcpci->tcpc.set_auto_vbus_discharge_threshold =
> +			tcpci_set_auto_vbus_discharge_threshold;
> +	}
> +
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
>  		return ERR_PTR(err);
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index b418fe11b527..3fe313655f0c 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -8,6 +8,8 @@
>  #ifndef __LINUX_USB_TCPCI_H
>  #define __LINUX_USB_TCPCI_H
>  
> +#include <linux/usb/typec.h>
> +
>  #define TCPC_VENDOR_ID			0x0
>  #define TCPC_PRODUCT_ID			0x2
>  #define TCPC_BCD_DEV			0x4
> @@ -67,6 +69,7 @@
>  
>  #define TCPC_POWER_CTRL			0x1c
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
> +#define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
>  #define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
>  
>  #define TCPC_CC_STATUS			0x1d
> @@ -133,6 +136,8 @@
>  
>  #define TCPC_VBUS_VOLTAGE			0x70
>  #define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
> +#define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV	25
> +#define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	0x3ff
>  #define TCPC_VBUS_STOP_DISCHARGE_THRESH		0x74
>  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
>  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
> @@ -140,17 +145,22 @@
>  /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
>  #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
>  
> +struct tcpci;
> +
>  /*
> - * @TX_BUF_BYTE_x_hidden
> + * @TX_BUF_BYTE_x_hidden:
>   *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
>   * @frs_sourcing_vbus:
>   *		Optional; Callback to perform chip specific operations when FRS
>   *		is sourcing vbus.
> + * @auto_discharge_disconnect:
> + *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
>   */
> -struct tcpci;
>  struct tcpci_data {
>  	struct regmap *regmap;
>  	unsigned char TX_BUF_BYTE_x_hidden:1;
> +	unsigned char auto_discharge_disconnect:1;
> +
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>  			 bool enable);
> -- 
> 2.28.0.806.g8561365e88-goog

-- 
heikki
