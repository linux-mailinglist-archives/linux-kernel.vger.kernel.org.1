Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F19B26A4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIOMRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:17:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:46049 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIOMQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:16:28 -0400
IronPort-SDR: U+DEJS9vnOaw3pGqqeBlAldGIfYDNaZEGr6O3KdJZYp2YiIf4h6MvH8bzRTbBCO3S4FV7xKCaF
 h/Kw8NokypaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156636516"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="156636516"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 05:16:18 -0700
IronPort-SDR: zHcTlE409gQ8N5SSotwtoKhpNs93GndkkJ7e1WDuvrjKIKX3TlNReDnWOh5z4E1dXzLnnJOZ9d
 g1WMyy/wQzNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="409183643"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 05:16:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 15:16:15 +0300
Date:   Tue, 15 Sep 2020 15:16:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/14] usb: typec: tcpci: Add a getter method to
 retrieve tcpm_port reference
Message-ID: <20200915121615.GE1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-5-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-5-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:17PM -0700, Badhri Jagan Sridharan wrote:
> Allow chip level drivers to retrieve reference to tcpm_port.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

I'm still wondering if this is the right way. Ideally the glue drivers
should not need to deal with the tcpm_port at all directly, only with
the tcpci handle they have. But FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Change since v1:
> - Changing patch version to v6 to fix version number confusion.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 6 ++++++
>  drivers/usb/typec/tcpm/tcpci.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 7d9491ba62fb..b960fe5a0f28 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -38,6 +38,12 @@ struct tcpci_chip {
>  	struct tcpci_data data;
>  };
>  
> +struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci)
> +{
> +	return tcpci->port;
> +}
> +EXPORT_SYMBOL_GPL(tcpci_get_tcpm_port);
> +
>  static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
>  {
>  	return container_of(tcpc, struct tcpci, tcpc);
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index cf9d8b63adcb..04c49a0b0368 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -150,4 +150,6 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
>  void tcpci_unregister_port(struct tcpci *tcpci);
>  irqreturn_t tcpci_irq(struct tcpci *tcpci);
>  
> +struct tcpm_port;
> +struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
>  #endif /* __LINUX_USB_TCPCI_H */
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

-- 
heikki
