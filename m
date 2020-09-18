Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E428F26FC96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIRMeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:34:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:56032 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRMeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:34:04 -0400
IronPort-SDR: leF+e+i9Iso3kYeUOGC7dRRYQWdNrjhEPIW01MN3fqX46zGtEnWdekst/XS6sRq7nH/pGHk67Q
 f44tkgEHiHcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244758922"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="244758922"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 05:34:03 -0700
IronPort-SDR: S0yg/TuIDIF6r4mvqLSzU5qT1nfDKkW7waMzNkjy2llapPkPKMG9wCajtmUs8oGsVs4VDcnf8P
 ee5y2/9BUyJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="410277755"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 Sep 2020 05:34:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 18 Sep 2020 15:33:59 +0300
Date:   Fri, 18 Sep 2020 15:33:59 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/11] usb: typec: tcpci: Add set_vbus tcpci callback
Message-ID: <20200918123359.GC1630537@kuha.fi.intel.com>
References: <20200917101856.3156869-1-badhri@google.com>
 <20200917101856.3156869-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917101856.3156869-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:18:47AM -0700, Badhri Jagan Sridharan wrote:
> set_vbus callback allows TCPC which are TCPCI based, however,
> does not support turning on sink and source mode through
> Command.SinkVbus and Command.SourceVbusDefaultVoltage.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Rebase on usb-next
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 7 +++++++
>  drivers/usb/typec/tcpm/tcpci.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index b960fe5a0f28..d6a6fac82d48 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -328,6 +328,13 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>  	int ret;
>  
> +	if (tcpci->data->set_vbus) {
> +		ret = tcpci->data->set_vbus(tcpci, tcpci->data, source, sink);
> +		/* Bypass when ret > 0 */
> +		if (ret != 0)
> +			return ret < 0 ? ret : 0;
> +	}
> +
>  	/* Disable both source and sink first before enabling anything */
>  
>  	if (!source) {
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 04c49a0b0368..4d441bdf24d5 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -144,6 +144,7 @@ struct tcpci_data {
>  			 bool enable);
>  	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
>  				  enum typec_cc_status cc);
> +	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
>  };
>  
>  struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> -- 
> 2.28.0.618.gf4bc123cb7-goog

thanks,

-- 
heikki
