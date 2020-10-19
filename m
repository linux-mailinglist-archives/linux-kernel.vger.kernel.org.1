Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20866292895
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgJSNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:50:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:16870 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgJSNuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:50:16 -0400
IronPort-SDR: zROtJJ/qlHkLW+zbpT8SPUYgCMBYGM9NUL1MG51/B78xQzHGueQpeItNy9CubQzwpuylyk/ByP
 TZx5TG+06vUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="154820950"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="154820950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 06:50:15 -0700
IronPort-SDR: +pykw250Fmb+Dshcu2KrEc924MczhvYpVBiKHpy/hpTZKJrn9+57nDSjxRW0A/Hg+iWit9nTr5
 gaWpYacS+kLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="422186200"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2020 06:50:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Oct 2020 16:50:10 +0300
Date:   Mon, 19 Oct 2020 16:50:10 +0300
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
Subject: Re: [PATCH v10 15/15] usb: typec: tcpci_maxim: Enable auto discharge
 disconnect
Message-ID: <20201019135010.GI1667571@kuha.fi.intel.com>
References: <20201008061556.1402293-1-badhri@google.com>
 <20201008061556.1402293-16-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008061556.1402293-16-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:15:56PM -0700, Badhri Jagan Sridharan wrote:
> Enable auto discharge disconnect for Maxim TCPC.
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
> - Heikki's suggestion:
> Moved the actual write of TCPC_VBUS_SINK_DISCONNECT_THRES
> register to tcpci code.
> 
> Changes since v8:
> - Moved the logic to program the default values of
>   TCPC_VBUS_SINK_DISCONNECT_THRESH into the tcpci code.
> 
> Changes since v9:
> - none.
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 43dcad95e897..55dea33387ec 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -441,6 +441,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->data.TX_BUF_BYTE_x_hidden = true;
>  	chip->data.init = tcpci_init;
>  	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
> +	chip->data.auto_discharge_disconnect = true;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.28.0.806.g8561365e88-goog

-- 
heikki
