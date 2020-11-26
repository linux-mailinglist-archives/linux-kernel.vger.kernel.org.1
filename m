Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5EE2C537D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbgKZMBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:01:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:44239 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgKZMBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:01:24 -0500
IronPort-SDR: 2H70VseyICZNM2nFQwcVjYEh15Taj27QURe3s2hY1ORsrtu8f/h4TaQK2ktEUVTWwbIUMTT8W2
 kZco7JK3YnHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="151532993"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="151532993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 04:01:23 -0800
IronPort-SDR: rb+wS5te4rO8LEkXQ5Q2kU0hUkk1MierNidsemk/DaW+mO+qro5YGsgALGAthhVH9BIrVgTFbX
 fxNC5X8zylNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="433255018"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 26 Nov 2020 04:01:20 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Nov 2020 14:01:20 +0200
Date:   Thu, 26 Nov 2020 14:01:20 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Disregard vbus off while in
 PR_SWAP_SNK_SRC_SOURCE_ON
Message-ID: <20201126120120.GM1008337@kuha.fi.intel.com>
References: <20201125020703.1604979-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125020703.1604979-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 06:07:03PM -0800, Badhri Jagan Sridharan wrote:
> During PR_SWAP sequence, when TCPM is waiting in PR_SWAP_SNK_SRC_SOURCE_ON
> for the vbus source to ramp up, TCPM would prematurely exit
> PR_SWAP_SNK_SRC_SOURCE_ON and transition to SNK_UNATTACHED state when a
> vbus off notification is received. This should not be the case as vbus
> can still be off while in PR_SWAP_SNK_SRC_SOURCE_ON and the vbus source
> has PD_T_NEWSRC to ramp up.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4aac0efdb720..277b9d4d9c84 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4218,6 +4218,14 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  		/* Do nothing, expected */
>  		break;
>  
> +	case PR_SWAP_SNK_SRC_SOURCE_ON:
> +		/*
> +		 * Do nothing when vbus off notification is received.
> +		 * TCPM can wait for PD_T_NEWSRC in PR_SWAP_SNK_SRC_SOURCE_ON
> +		 * for the vbus source to ramp up.
> +		 */
> +		break;
> +
>  	case PORT_RESET_WAIT_OFF:
>  		tcpm_set_state(port, tcpm_default_state(port), 0);
>  		break;
> -- 
> 2.29.2.454.gaff20da3a2-goog

thanks,

-- 
heikki
