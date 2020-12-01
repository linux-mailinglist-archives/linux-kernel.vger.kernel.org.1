Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0C2C9FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgLAKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:33:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:40453 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgLAKdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:33:47 -0500
IronPort-SDR: svWi1n0YeJw8g9xW6g561C0tDdaYtVMR2ygNYjD547UnwkbYX2YXMQ/kBQ1iAnr02rUEXZLKSS
 nSbQcHHYn4kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172963547"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="172963547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 02:32:01 -0800
IronPort-SDR: T/rXxtx3qMZyzxQo9aQcTNzrrtAyXDYW+T1LjXV+lwq9+eLxagowcqUzXTMazJ5AIVVtOCOI9R
 +0gBCU4Zreqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="434617560"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 01 Dec 2020 02:31:58 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 01 Dec 2020 12:31:57 +0200
Date:   Tue, 1 Dec 2020 12:31:57 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] usb: typec: tcpm: Pass down negotiated rev to
 update retry count
Message-ID: <20201201103157.GA3191259@kuha.fi.intel.com>
References: <20201201042237.414235-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201042237.414235-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:22:34PM -0800, Badhri Jagan Sridharan wrote:
> nRetryCount was updated from 3 to 2 between PD2.0 and PD3.0 spec.
> nRetryCount in "Table 6-34 Counter parameters" of the PD 2.0
> spec is set to 3, whereas, nRetryCount in "Table 6-59 Counter
> parameters" is set to 2.
> 
> Pass down negotiated rev in pd_transmit so that low level chip
> drivers can update the retry count accordingly before attempting
> packet transmission.
> 
> This helps in passing "TEST.PD.PORT.ALL.02" of the
> "Power Delivery Merged" test suite which was initially failing
> with "The UUT did not retransmit the message nReryCount times"
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  include/linux/usb/tcpm.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bbc1f10af49..c73bc3a8356a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -667,7 +667,7 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
>  		tcpm_log(port, "PD TX, type: %#x", type);
>  
>  	reinit_completion(&port->tx_complete);
> -	ret = port->tcpc->pd_transmit(port->tcpc, type, msg);
> +	ret = port->tcpc->pd_transmit(port->tcpc, type, msg, port->negotiated_rev);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index e68aaa12886f..efaedd7e8a18 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -121,7 +121,7 @@ struct tcpc_dev {
>  			      enum typec_cc_status cc);
>  	int (*try_role)(struct tcpc_dev *dev, int role);
>  	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
> -			   const struct pd_message *msg);
> +			   const struct pd_message *msg, unsigned int negotiated_rev);
>  	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
>  	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
>  	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);

I think this will break bisectability. You need to change the users of
that at in the same commit.

thanks,

-- 
heikki
