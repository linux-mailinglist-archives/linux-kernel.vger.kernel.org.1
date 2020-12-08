Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2B02D27E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgLHJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:40:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:5141 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgLHJkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:40:20 -0500
IronPort-SDR: MN5Z6TeplJhskw44HRxOCjBXpmgAMk7mQQyYwvPSOZ1YuZxNB2m6v7PCNiAIawaB1nopT6AYdf
 PEFaAPzKGdHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173974783"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="173974783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 01:38:44 -0800
IronPort-SDR: DstkOSJ9V+YZ75HUEGl4+M/zYZfi1LZN4DdG8PKi1d6yrhEJkugptWPNcOyiooU70P9xUHg8Pc
 BpXZVSHoLzzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437320615"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Dec 2020 01:38:41 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Dec 2020 11:38:41 +0200
Date:   Tue, 8 Dec 2020 11:38:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Use correct response message
 bits
Message-ID: <20201208093841.GE680328@kuha.fi.intel.com>
References: <20201203220813.16281-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203220813.16281-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:08:13PM -0800, Utkarsh Patel wrote:
> When Intel PMC Mux agent driver receives the response message from PMC, it
> checks for the same response bits for all the mux states.
> Corrected it by checking correct response message bits, Bit 8 & 9 for the
> SAFE Mode and Alternate Modes and Bit 16 & 17 for the Connect and
> Disconnect Modes.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index aa3211f1c4c3..e58ae8a7fefb 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -176,6 +176,7 @@ static int hsl_orientation(struct pmc_usb_port *port)
>  static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
>  {
>  	u8 response[4];
> +	u8 status_res;
>  	int ret;
>  
>  	/*
> @@ -189,9 +190,13 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
>  	if (ret)
>  		return ret;
>  
> -	if (response[2] & PMC_USB_RESP_STATUS_FAILURE) {
> -		if (response[2] & PMC_USB_RESP_STATUS_FATAL)
> +	status_res = (msg[0] & 0xf) < PMC_USB_SAFE_MODE ?
> +		     response[2] : response[1];
> +
> +	if (status_res & PMC_USB_RESP_STATUS_FAILURE) {
> +		if (status_res & PMC_USB_RESP_STATUS_FATAL)
>  			return -EIO;
> +
>  		return -EBUSY;
>  	}
>  
> -- 
> 2.17.1

thanks,

-- 
heikki
