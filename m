Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AA2D71E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391891AbgLKIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:36:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:55312 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405556AbgLKIgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:36:11 -0500
IronPort-SDR: AA4UKQR4QnUrzmfiaJ2I3UI2y7baUlpKBAraTUTYxuVPXVBzaw2CDuIQ9/fUSuGLh10FpQ8Rvs
 b+2hU9FydyVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="171834962"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="171834962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 00:34:25 -0800
IronPort-SDR: MepZUPw4n7yaP6+BJ2h90WShZTk66uXqJXOt4z/KY1pLKtJBzHOqDVUZbkM0tVcr3w/vgILBmc
 xdMwdAgtEm8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="440614654"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Dec 2020 00:34:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 11 Dec 2020 10:34:22 +0200
Date:   Fri, 11 Dec 2020 10:34:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpci: Enable bleed discharge when auto
 discharge is enabled
Message-ID: <20201211083422.GF1594451@kuha.fi.intel.com>
References: <20201211071145.2199997-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211071145.2199997-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:11:45PM -0800, Badhri Jagan Sridharan wrote:
> Auto discharge circuits kick in only when vbus decays and reaches
> VBUS_SINK_DISCONNECT_THRESHOLD threshold. Enable bleed discharge to
> discharge vbus to VBUS_SINK_DISCONNECT_THRESHOLD upon disconnect.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index af5524338a63..f676abab044b 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -725,6 +725,8 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
>  		tcpci->tcpc.set_auto_vbus_discharge_threshold =
>  			tcpci_set_auto_vbus_discharge_threshold;
> +		regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_BLEED_DISCHARGE,
> +				   TCPC_POWER_CTRL_BLEED_DISCHARGE);
>  	}
>  
>  	if (tcpci->data->vbus_vsafe0v)
> -- 
> 2.29.2.576.ga3fc446d84-goog

-- 
heikki
