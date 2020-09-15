Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46926A513
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIOMZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:25:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:62526 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIOMXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:23:17 -0400
IronPort-SDR: 0fsGWdXU14E2BBg0UIQN1SVId8ioVDpkfMb/K0e5cn5i1tYetVBwfUjzjX3vlWRUXFQ7NAmHcv
 bxbHz4Qc9R6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="158529775"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="158529775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 05:22:29 -0700
IronPort-SDR: lllJ+U7BvN7HK17zY5ZgCIq5m7dcbjLrPdM879jpytu1cU47fSZ9f8M/rKyFCJAuRvaCRZ+F7d
 qSTQbdqP+vWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="409184911"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 05:22:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 15:22:25 +0300
Date:   Tue, 15 Sep 2020 15:22:25 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/14] usb: typec: tcpci: Add set_vbus tcpci callback
Message-ID: <20200915122225.GF1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-6-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-6-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:18PM -0700, Badhri Jagan Sridharan wrote:
> set_vbus callback allows TCPC which are TCPCI based, however,
> does not support turning on sink and source mode through
> Command.SinkVbus and Command.SourceVbusDefaultVoltage.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
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

Can it return positive value? What does positive value mean?

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
> 2.28.0.402.g5ffc5be6b7-goog

-- 
heikki
