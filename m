Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7F26A4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIOMOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:14:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:45047 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIOMMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:12:49 -0400
IronPort-SDR: Kw4TQnqxCCgZHVHtW2E4uQsLSvMnrF4S1JAz9bLGwHkAR89NpX+NS9N2Wi7IPKuo6VIlsL7kYk
 jy6Ovfd+awrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146931356"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="146931356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 05:12:19 -0700
IronPort-SDR: yAREuQbk4980ARyBOoiXGAyvrjN8/059oMNvClMF8Qex/WwuehQj0r91EvFoXSIPZaukkz1dEv
 Tmc3FG0uFMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="409182851"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 05:12:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 15:12:16 +0300
Date:   Tue, 15 Sep 2020 15:12:16 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/14] usb: typec: tcpci: update ROLE_CONTROL for DRP
Message-ID: <20200915121216.GD1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-4-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-4-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:16PM -0700, Badhri Jagan Sridharan wrote:
> ROLE_CONTROL register would not have the actual CC terminations
> unless the port does not set ROLE_CONTROL.DRP. For DRP ports,
> CC_STATUS.cc1/cc2 indicates the final terminations applied
> when TCPC enters potential_connect_as_source/_sink.
> For DRP ports, infer port role from CC_STATUS and set corresponding
> CC terminations before setting the orientation.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
>  - Changing patch version to v6 to fix version number confusion.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 37 +++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 7d36d5e2d3f7..7d9491ba62fb 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -191,12 +191,47 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>  	unsigned int reg;
>  	int ret;
> +	enum typec_cc_status cc1, cc2;
>  
> -	/* Keep the disconnect cc line open */
> +	/* Obtain Rp setting from role control */
>  	ret = regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &reg);
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = tcpci_get_cc(tcpc, &cc1, &cc2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * When port has drp toggling enabled, ROLE_CONTROL would only have the initial
> +	 * terminations for the toggling and does not indicate the final cc
> +	 * terminations when ConnectionResult is 0 i.e. drp toggling stops and
> +	 * the connection is resolbed. Infer port role from TCPC_CC_STATUS based on the
> +	 * terminations seen. The port role is then used to set the cc terminations.
> +	 */
> +	if (reg & TCPC_ROLE_CTRL_DRP) {
> +		/* Disable DRP for the OPEN setting to take effect */
> +		reg = reg & ~TCPC_ROLE_CTRL_DRP;
> +
> +		if (polarity == TYPEC_POLARITY_CC2) {
> +			reg &= ~(TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT);
> +			/* Local port is source */
> +			if (cc2 == TYPEC_CC_RD)
> +				/* Role control would have the Rp setting when DRP was enabled */
> +				reg |= TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT;
> +			else
> +				reg |= TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT;
> +		} else {
> +			reg &= ~(TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT);
> +			/* Local port is source */
> +			if (cc1 == TYPEC_CC_RD)
> +				/* Role control would have the Rp setting when DRP was enabled */
> +				reg |= TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT;
> +			else
> +				reg |= TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT;
> +		}
> +	}
> +
>  	if (polarity == TYPEC_POLARITY_CC2)
>  		reg |= TCPC_ROLE_CTRL_CC_OPEN << TCPC_ROLE_CTRL_CC1_SHIFT;
>  	else
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

-- 
heikki
