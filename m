Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7398F292864
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgJSNli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:41:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:27697 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgJSNli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:41:38 -0400
IronPort-SDR: Q5iSzDY53nNwGE4xyQCLQSxpQPh7MH2YIcHbeABbgraRBQfq6cuOjA7eUjNcClY2H3EGQJw5uP
 LxOJadBOhcow==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="146890174"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="146890174"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 06:41:37 -0700
IronPort-SDR: tE7NqGOjh23Ez0tt0O8aR0eBLBovkxERKJjkwDV6kW8YynteJUhL7az+0YS7ab+6m7ZNZlV0To
 1cYBHzx1KTzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="422183600"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2020 06:41:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Oct 2020 16:41:33 +0300
Date:   Mon, 19 Oct 2020 16:41:33 +0300
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
Subject: Re: [PATCH v10 10/15] usb: typec: tcpci: frs sourcing vbus callback
Message-ID: <20201019134133.GE1667571@kuha.fi.intel.com>
References: <20201008061556.1402293-1-badhri@google.com>
 <20201008061556.1402293-11-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008061556.1402293-11-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:15:51PM -0700, Badhri Jagan Sridharan wrote:
> During FRS hardware autonomously starts to source vbus. Provide
> callback to perform chip specific operations.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v9 is the first version of this patch in the series. Added to fix
> occasional bug of vbus turning back on when disconnecting the FRS accessory
> after disconnect. No changes since v9.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
>  drivers/usb/typec/tcpm/tcpci.h | 4 ++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f9f0af64da5f..f91688e43991 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -284,6 +284,14 @@ static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
>  	return ret;
>  }
>  
> +static void tcpci_frs_sourcing_vbus(struct tcpc_dev *dev)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> +
> +	if (tcpci->data->frs_sourcing_vbus)
> +		tcpci->data->frs_sourcing_vbus(tcpci, tcpci->data);
> +}
> +
>  static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -628,6 +636,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
>  	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
>  	tcpci->tcpc.enable_frs = tcpci_enable_frs;
> +	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
>  
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 5ef07a56d67a..b418fe11b527 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -143,6 +143,9 @@
>  /*
>   * @TX_BUF_BYTE_x_hidden
>   *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
> + * @frs_sourcing_vbus:
> + *		Optional; Callback to perform chip specific operations when FRS
> + *		is sourcing vbus.
>   */
>  struct tcpci;
>  struct tcpci_data {
> @@ -154,6 +157,7 @@ struct tcpci_data {
>  	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
>  				  enum typec_cc_status cc);
>  	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
> +	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
>  };
>  
>  struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> -- 
> 2.28.0.806.g8561365e88-goog

thanks,

-- 
heikki
