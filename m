Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2F2C537E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbgKZMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:01:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:8361 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgKZMBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:01:50 -0500
IronPort-SDR: nHst40LdHtTDjx2kw1g7MVGPFn7T4UsFLXgeO/SOLvmyaeL94gCOGOwDPrG5hyeRJWpmpIRAyB
 Q3y2bVGsG46g==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="171496594"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="171496594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 04:01:49 -0800
IronPort-SDR: onU1zK9uk/17th74qPRWMeNHmF6PoQ5yThUTzQk+kdcUaPc4sxhuW0UNqhJ0NNLFFm4Xaqgydf
 gYNpA1gYOKdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="433255153"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 26 Nov 2020 04:01:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Nov 2020 14:01:46 +0200
Date:   Thu, 26 Nov 2020 14:01:46 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Stay in
 SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS till Rp is seen
Message-ID: <20201126120146.GN1008337@kuha.fi.intel.com>
References: <20201125014804.1596719-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125014804.1596719-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 05:48:04PM -0800, Badhri Jagan Sridharan wrote:
> TD.4.7.3. Try SNK DRP Connect Try.SRC DRP fails. The compliance
> tester mimics being a Try.SRC USB-C port.
> The failure is due to TCPM exiting SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS
> when VBUS is not present eventhough when SNK.Rp is seen. Exit to
> SRC_TRYWAIT from SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS only when SNK.Rp
> is not seen for PD_T_TRY_CC_DEBOUNCE.
> 
> >From the spec:
> The port shall then transition to Attached.SNK when the SNK.Rp state
> is detected on exactly one of the CC1 or CC2 pins for at least
> tTryCCDebounce and VBUS is detected. Alternatively, the port shall
> transition to TryWait.SRC if SNK.Rp state is not detected for
> tTryCCDebounce.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 18 +++++++++++++-----
>  include/linux/usb/pd.h        |  1 +
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4aac0efdb720..b2cffa00d737 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3124,15 +3124,13 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_TRY_WAIT_DEBOUNCE:
>  		tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS,
> -			       PD_T_PD_DEBOUNCE);
> +			       PD_T_TRY_CC_DEBOUNCE);
>  		break;
>  	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
> -		if (port->vbus_present && tcpm_port_is_sink(port)) {
> +		if (port->vbus_present && tcpm_port_is_sink(port))
>  			tcpm_set_state(port, SNK_ATTACHED, 0);
> -		} else {
> -			tcpm_set_state(port, SRC_TRYWAIT, 0);
> +		else
>  			port->max_wait = 0;
> -		}
>  		break;
>  	case SRC_TRYWAIT:
>  		tcpm_set_cc(port, tcpm_rp_cc(port));
> @@ -4053,6 +4051,12 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
>  		if (!tcpm_port_is_sink(port))
>  			tcpm_set_state(port, SNK_TRYWAIT_DEBOUNCE, 0);
>  		break;
> +	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
> +		if (!tcpm_port_is_sink(port))
> +			tcpm_set_state(port, SRC_TRYWAIT, PD_T_TRY_CC_DEBOUNCE);
> +		else
> +			tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS, 0);
> +		break;
>  	case SNK_TRYWAIT:
>  		/* Do nothing, waiting for tCCDebounce */
>  		break;
> @@ -4139,6 +4143,10 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
>  	case SNK_TRYWAIT_DEBOUNCE:
>  		/* Do nothing, waiting for Rp */
>  		break;
> +	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
> +		if (port->vbus_present && tcpm_port_is_sink(port))
> +			tcpm_set_state(port, SNK_ATTACHED, 0);
> +		break;
>  	case SRC_TRY_WAIT:
>  	case SRC_TRY_DEBOUNCE:
>  		/* Do nothing, waiting for sink detection */
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 3a805e2ecbc9..63a66dd5d832 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -484,6 +484,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  
>  #define PD_T_CC_DEBOUNCE	200	/* 100 - 200 ms */
>  #define PD_T_PD_DEBOUNCE	20	/* 10 - 20 ms */
> +#define PD_T_TRY_CC_DEBOUNCE	15	/* 10 - 20 ms */
>  
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
> -- 
> 2.29.2.454.gaff20da3a2-goog

thanks,

-- 
heikki
