Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DCC2D59C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgLJLxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:53:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:22889 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733226AbgLJLwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:52:50 -0500
IronPort-SDR: CSV6180jtXNBb7ErOeeEu1lhyWLVpubKc8t4y3CFzyS3jJXSV2eg9amV8LjlyJ2nx0shJQ07qu
 BD92wE+v5vig==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="171673554"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="171673554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 03:51:03 -0800
IronPort-SDR: smss9TRyqk9rjDlWysbLjoMmrQKSkN4VY+r8UN7BPyuDObyS1jTYeBPN0+//UmVM1yuRVN33zu
 dojUiUx3Pb1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="438306781"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Dec 2020 03:51:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Dec 2020 13:50:59 +0200
Date:   Thu, 10 Dec 2020 13:50:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v4 1/1] usb: typec: intel_pmc_mux: Configure cable
 generation value for USB4
Message-ID: <20201210115059.GB1594451@kuha.fi.intel.com>
References: <20201209042408.23079-1-utkarsh.h.patel@intel.com>
 <20201209042408.23079-2-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201209042408.23079-2-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 08:24:08PM -0800, Utkarsh Patel wrote:
> USB4 specification chapter 3 indicates that cable data rates have to be
> rounded for USB4 device to operate as USB4.
> With that configure cable generation value to use rounded data rates for
> USB4.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v4:
> - Removed usage of tbt_mode_vdo since data rates should always be rounded
>   in the case of USB4.
> - Updated commit message to reflect the change.
> 
> Changes in v3:
> - Moved TBT_CABLE_ROUNDED_SUPPORT assignment to the same line.
> 
> Changes in v2:
> - No change.
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index e58ae8a7fefb..cf37a59ce130 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -327,6 +327,11 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
>  		fallthrough;
>  	default:
>  		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
> +
> +		/* Configure data rate to rounded in the case of Active TBT3
> +		 * and USB4 cables.
> +		 */
> +		req.mode_data |= PMC_USB_ALTMODE_TBT_GEN(1);
>  		break;
>  	}
>  
> -- 
> 2.17.1

-- 
heikki
