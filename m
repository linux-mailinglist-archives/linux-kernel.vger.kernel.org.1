Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282502D2800
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgLHJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:43:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:49287 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgLHJnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:43:25 -0500
IronPort-SDR: QEvepFzE65JO+njNslgNHbO+bAX21UjN9RuxhBzlMYM0hODTtspCWEEWL67VQ+cYXo9vs4eW+r
 4zP9z/J8cdxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="258570644"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="258570644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 01:41:40 -0800
IronPort-SDR: lphYxfNFm97c5yzRygv9/53SK56PjpPxm+/DnB/JV+EIhDyXVumECsDgQq5efEsU6vKblus7xv
 Rx1DGfH/DGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437322162"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Dec 2020 01:41:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Dec 2020 11:41:36 +0200
Date:   Tue, 8 Dec 2020 11:41:36 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Clear send_discover in
 tcpm_check_send_discover
Message-ID: <20201208094136.GH680328@kuha.fi.intel.com>
References: <20201203031908.1491542-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203031908.1491542-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:19:08PM -0800, Badhri Jagan Sridharan wrote:
> tcpm_check_send_discover does not clear the send_discover flag
> when any of the following conditions are not met.
> 1. data_role is TYPEC_HOST
> 2. link is pd_capable
> 
> Discovery indentity would anyways not be attempted during
> the current session anymore when the above conditions are not
> met. Hence clear the send_discover flag here to prevent
> tcpm_enable_frs_work from rescheduling indefinetly.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bbc1f10af49..012135ade7b1 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3035,10 +3035,9 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
>  static void tcpm_check_send_discover(struct tcpm_port *port)
>  {
>  	if (port->data_role == TYPEC_HOST && port->send_discover &&
> -	    port->pd_capable) {
> +	    port->pd_capable)
>  		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
> -		port->send_discover = false;
> -	}
> +	port->send_discover = false;
>  }
>  
>  static void tcpm_swap_complete(struct tcpm_port *port, int result)
> -- 
> 2.29.2.576.ga3fc446d84-goog

-- 
heikki
