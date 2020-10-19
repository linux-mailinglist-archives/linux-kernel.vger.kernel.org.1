Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88229285D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgJSNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:40:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:62031 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgJSNky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:40:54 -0400
IronPort-SDR: hJMWP7h+0WeN5xHhFDbgksCPiD3gno/dFhH/K3kKUQGYzHjGZAyMknIVnZhJB1b6/IWnMyN/9w
 a60qZU2HVKoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="153968907"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="153968907"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 06:40:52 -0700
IronPort-SDR: HwdKJjM+FFjAHLcoyEnAhnOdI6GWkqpEcAkzCZQfuGNHPF6bGWigCKH5j0AqE5nYJoF6Z2EsM4
 b6RPQ2V1qEAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="422183357"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2020 06:40:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Oct 2020 16:40:48 +0300
Date:   Mon, 19 Oct 2020 16:40:48 +0300
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
Subject: Re: [PATCH v10 09/15] usb: typec: tcpm: frs sourcing vbus callback
Message-ID: <20201019134048.GD1667571@kuha.fi.intel.com>
References: <20201008061556.1402293-1-badhri@google.com>
 <20201008061556.1402293-10-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008061556.1402293-10-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:15:50PM -0700, Badhri Jagan Sridharan wrote:
> During FRS hardware autonomously starts to source vbus. Provide
> callback to perform chip specific operations.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Introduced in v9. No chages since then.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
>  include/linux/usb/tcpm.h      | 4 ++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 55535c4f66bf..02b7f623f584 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4090,7 +4090,16 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
>  	case SRC_TRY_DEBOUNCE:
>  		/* Do nothing, waiting for sink detection */
>  		break;
> +	case FR_SWAP_SEND:
> +	case FR_SWAP_SEND_TIMEOUT:
> +	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
> +	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
> +		if (port->tcpc->frs_sourcing_vbus)
> +			port->tcpc->frs_sourcing_vbus(port->tcpc);
> +		break;
>  	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
> +		if (port->tcpc->frs_sourcing_vbus)
> +			port->tcpc->frs_sourcing_vbus(port->tcpc);
>  		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
>  		break;
>  
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 09762d26fa0c..7303f518ba49 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -83,6 +83,9 @@ enum tcpm_transmit_type {
>   *		Optional; Called to enable/disable PD 3.0 fast role swap.
>   *		Enabling frs is accessory dependent as not all PD3.0
>   *		accessories support fast role swap.
> + * @frs_sourcing_vbus:
> + *		Optional; Called to notify that vbus is now being sourced.
> + *		Low level drivers can perform chip specific operations, if any.
>   */
>  struct tcpc_dev {
>  	struct fwnode_handle *fwnode;
> @@ -109,6 +112,7 @@ struct tcpc_dev {
>  			   const struct pd_message *msg);
>  	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
>  	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
> +	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
>  };
>  
>  struct tcpm_port;
> -- 
> 2.28.0.806.g8561365e88-goog

thanks,

-- 
heikki
