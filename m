Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B526B823
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIPAg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:36:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:58943 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgIONY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:24:59 -0400
IronPort-SDR: +GP10s1nqvmRHkLPvpFfojJDFCICASCtxyx9KzkncrgXDGwQlPKkC1H3RGjaaRBSPadP/AcMFP
 TzC/F9NXhciw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="159301984"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="159301984"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:23:52 -0700
IronPort-SDR: p576YaDPTEkIONnXRQvNV5bD7KIIi9w8jyN2kfHe8J7ysqAN2At9lvoUun6WQRAPyp+5Jn/4UU
 V9qtYEwtX6Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="409200332"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 06:23:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 16:23:49 +0300
Date:   Tue, 15 Sep 2020 16:23:49 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/14] usb: typec: tcpci: Implement callbacks for FRS
Message-ID: <20200915132349.GI1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-11-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-11-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:23PM -0700, Badhri Jagan Sridharan wrote:
> Implement tcpc.enable_frs to enable TCPC to receive
> Fast role swap signal.
> 
> Additionally set the sink disconnect threshold to 4v
> to prevent disconnect during Fast Role swap.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

One nitpick below. Otherwise, FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 17 +++++++++++++++++
>  drivers/usb/typec/tcpm/tcpci.h |  8 ++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index d6a6fac82d48..f9f0af64da5f 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -268,6 +268,22 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>  }
>  
> +static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> +	int ret;
> +
> +	/* To prevent disconnect during FRS, set disconnect threshold to 3.5V */
> +	ret = tcpci_write16(tcpci, TCPC_VBUS_SINK_DISCONNECT_THRESH, enable ? 0 : 0x8c);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_FAST_ROLE_SWAP_EN, enable ?
> +				 TCPC_FAST_ROLE_SWAP_EN : 0);

	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_FAST_ROLE_SWAP_EN,
                                 enable ? TCPC_FAST_ROLE_SWAP_EN : 0);

> +
> +	return ret;
> +}
> +
>  static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -611,6 +627,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.set_roles = tcpci_set_roles;
>  	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
>  	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
> +	tcpci->tcpc.enable_frs = tcpci_enable_frs;
>  
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 82f021a82456..5ef07a56d67a 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -16,6 +16,7 @@
>  #define TCPC_PD_INT_REV			0xa
>  
>  #define TCPC_ALERT			0x10
> +#define TCPC_ALERT_EXTND		BIT(14)
>  #define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
>  #define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
>  #define TCPC_ALERT_RX_BUF_OVF		BIT(10)
> @@ -37,6 +38,9 @@
>  #define TCPC_EXTENDED_STATUS_MASK		0x16
>  #define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
>  
> +#define TCPC_ALERT_EXTENDED_MASK	0x17
> +#define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
> +
>  #define TCPC_CONFIG_STD_OUTPUT		0x18
>  
>  #define TCPC_TCPC_CTRL			0x19
> @@ -63,6 +67,7 @@
>  
>  #define TCPC_POWER_CTRL			0x1c
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
> +#define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
>  
>  #define TCPC_CC_STATUS			0x1d
>  #define TCPC_CC_STATUS_TOGGLING		BIT(5)
> @@ -74,11 +79,14 @@
>  
>  #define TCPC_POWER_STATUS		0x1e
>  #define TCPC_POWER_STATUS_UNINIT	BIT(6)
> +#define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
>  #define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
>  #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
>  
>  #define TCPC_FAULT_STATUS		0x1f
>  
> +#define TCPC_ALERT_EXTENDED		0x21
> +
>  #define TCPC_COMMAND			0x23
>  #define TCPC_CMD_WAKE_I2C		0x11
>  #define TCPC_CMD_DISABLE_VBUS_DETECT	0x22
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

thanks,

-- 
heikki
