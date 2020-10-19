Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2E29287C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgJSNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:45:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:16468 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgJSNpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:45:22 -0400
IronPort-SDR: QxA5siPEOOSpAUm78x2UplnceZzZbRTWnRiOhqVgb7TracLCq2ORJaKdrndzNPd4hZd/dQZyQo
 6oUI2YRxbcQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="154820462"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="154820462"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 06:45:03 -0700
IronPort-SDR: N6/ETYpLoqkD1hFWoKNnpnbVAWaazbj33PbiPrixCj/NXNPo1Xk2oKZyigm6eAbLGLm0yInLam
 Fip6xN61yrAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="422184607"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2020 06:44:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Oct 2020 16:44:58 +0300
Date:   Mon, 19 Oct 2020 16:44:58 +0300
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
Subject: Re: [PATCH v10 11/15] usb: typec: tcpci_max77759: Fix vbus stuck on
 upon diconnecting sink
Message-ID: <20201019134458.GF1667571@kuha.fi.intel.com>
References: <20201008061556.1402293-1-badhri@google.com>
 <20201008061556.1402293-12-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008061556.1402293-12-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:15:52PM -0700, Badhri Jagan Sridharan wrote:
> Occasionally, POWER_STATUS.sourcing_vbus takes a while to clear after
> writing to  MAX_BUCK_BOOST_OP register. This causes vbus to turn back
> on while disconnecting the sink. Overcome this issue by writing into
> MAX_BUCK_BOOST_OP during frs while sourcing vbu, instead of always
> into the register whenever POWER_STATUS.sourcing_vbus is set.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v9 is the first version of this patch. Added to fix
> occasional bug of vbus turning back on when disconnecting the FRS accessory
> after disconnect. No changes since v9.
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 723d7dd38f75..43dcad95e897 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -238,23 +238,22 @@ static void process_power_status(struct max_tcpci_chip *chip)
>  	if (ret < 0)
>  		return;
>  
> -	if (pwr_status == 0xff) {
> +	if (pwr_status == 0xff)
>  		max_tcpci_init_regs(chip);
> -	} else if (pwr_status & TCPC_POWER_STATUS_SOURCING_VBUS) {
> +	else if (pwr_status & TCPC_POWER_STATUS_SOURCING_VBUS)
>  		tcpm_sourcing_vbus(chip->port);
> -		/*
> -		 * Alawys re-enable boost here.
> -		 * In normal case, when say an headset is attached, TCPM would
> -		 * have instructed to TCPC to enable boost, so the call is a
> -		 * no-op.
> -		 * But for Fast Role Swap case, Boost turns on autonomously without
> -		 * AP intervention, but, needs AP to enable source mode explicitly
> -		 * for AP to regain control.
> -		 */
> -		max_tcpci_set_vbus(chip->tcpci, &chip->data, true, false);
> -	} else {
> +	else
>  		tcpm_vbus_change(chip->port);
> -	}
> +}
> +
> +static void max_tcpci_frs_sourcing_vbus(struct tcpci *tcpci, struct tcpci_data *tdata)
> +{
> +	/*
> +	 * For Fast Role Swap case, Boost turns on autonomously without
> +	 * AP intervention, but, needs AP to enable source mode explicitly
> +	 * for AP to regain control.
> +	 */
> +	max_tcpci_set_vbus(tcpci, tdata, true, false);
>  }
>  
>  static void process_tx(struct max_tcpci_chip *chip, u16 status)
> @@ -441,6 +440,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->data.start_drp_toggling = max_tcpci_start_toggling;
>  	chip->data.TX_BUF_BYTE_x_hidden = true;
>  	chip->data.init = tcpci_init;
> +	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.28.0.806.g8561365e88-goog

-- 
heikki
