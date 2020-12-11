Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCD2D7217
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437118AbgLKIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:45:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:62644 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437082AbgLKIpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:45:06 -0500
IronPort-SDR: M9mKBsFJojaXv7/dWkFtmzzmzGG3Sp3sEO2+W3RSmv702udVQR8tzVy9ak++Qsxd+4XRkVKiYX
 kJgCZYLjc5GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="161451223"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="161451223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 00:43:15 -0800
IronPort-SDR: NZWOoAWh8L8FANn9o6CzLYmtpSgJl5ks86uX4joqPN/B3wgis9y1xmOkqUfdNrMq7Pb07kH/I4
 P3eS6x9mn4gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="440617236"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Dec 2020 00:43:13 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 11 Dec 2020 10:43:12 +0200
Date:   Fri, 11 Dec 2020 10:43:12 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Update vbus_vsafe0v on init
Message-ID: <20201211084312.GG1594451@kuha.fi.intel.com>
References: <20201211071911.2205197-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211071911.2205197-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:19:11PM -0800, Badhri Jagan Sridharan wrote:
> During init, vbus_vsafe0v does not get updated till the first
> connect as a sink. This causes TCPM to be stuck in SRC_ATTACH_WAIT
> state while booting with a sink (For instance: a headset) connected.
> 
> [    1.429168] Start toggling
> [    1.439907] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [    1.445242] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [   53.358528] CC1: 0 -> 0, CC2: 0 -> 2 [state TOGGLING, polarity 0, connected]
> [   53.358564] state change TOGGLING -> SRC_ATTACH_WAIT [rev1 NONE_AMS]
> 
> Fix this by updating vbus_vsafe0v based on vbus_present status
> on boot.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

One nitpick bellow, but it's so minor that you can ignore it if you
like. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index cedc6cf82d61..58a6302c549f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4794,6 +4794,24 @@ static void tcpm_init(struct tcpm_port *port)
>  	if (port->vbus_present)
>  		port->vbus_never_low = true;
>  
> +	/*
> +	 * 1. When vbus_present is true, voltage on VBUS is already at VSAFE5V.
> +	 * So implicitly vbus_vsafe0v = false.
> +	 *
> +	 * 2. When vbus_present is false and TCPC does NOT support querying
> +	 * vsafe0v status, then, it's best to assume vbus is at VSAFE0V i.e.
> +	 * vbus_vsafe0v is true.
> +	 *
> +	 * 3. When vbus_present is false and TCPC does support querying vsafe0v,
> +	 * then, query tcpc for vsafe0v status.
> +	 */
> +	if (port->vbus_present)
> +		port->vbus_vsafe0v = false;
> +	else if (!port->tcpc->is_vbus_vsafe0v)
> +		port->vbus_vsafe0v = true;
> +	else
> +		port->vbus_vsafe0v = port->tcpc->is_vbus_vsafe0v(port->tcpc);

Couldn't that be the other way around?

        ...
	else if (port->tcpc->is_vbus_vsafe0v)
		port->vbus_vsafe0v = port->tcpc->is_vbus_vsafe0v(port->tcpc);
	else
		port->vbus_vsafe0v = true;
        ...

>  	tcpm_set_state(port, tcpm_default_state(port), 0);
>  
>  	if (port->tcpc->get_cc(port->tcpc, &cc1, &cc2) == 0)
> -- 
> 2.29.2.576.ga3fc446d84-goog

thanks,

-- 
heikki
