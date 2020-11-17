Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312722B5D22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgKQKpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:45:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:56968 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgKQKpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:45:00 -0500
IronPort-SDR: kOUplXjEiNT1Jc58FA3kGDeQHwO6lWYxXWCuq1Jm3//j2USjZhl4vWE8DxFmTrny9D+OpzW5o9
 pzjXsBivGmSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="158675620"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="158675620"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 02:44:59 -0800
IronPort-SDR: BkR2siWURY65xCTjf4Cd5Gn9T2sTDZAE4g/2Io86QZNoq9mOL7818gUAEIDSV/aGpYM2XtlVdN
 FkEQOc9lCykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430442448"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 02:44:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 12:44:56 +0200
Date:   Tue, 17 Nov 2020 12:44:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 2/8] platform/chrome: cros_ec_typec: Correct the
 Thunderbolt rounded/non-rounded cable support
Message-ID: <20201117104456.GB3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-3-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-3-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:24:57PM -0800, Utkarsh Patel wrote:
> Thunderbolt rounded/non-rounded cable support is two bits value. Correcting
> it as per the Thunderbolt 3 cable discover mode VDO changes done in the
> Thunderbolt 3 alternate mode header.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --
> Changes in v2:
> - Removed the fixes tag as there is no functional implication.
> --
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 31be31161350..8111ed1fc574 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -438,8 +438,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
>  		data.cable_mode |= TBT_CABLE_LINK_TRAINING;
>  
> -	if (pd_ctrl->cable_gen)
> -		data.cable_mode |= TBT_CABLE_ROUNDED;
> +	data.cable_mode |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
>  
>  	/* Enter Mode VDO */
>  	data.enter_vdo = TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
> -- 
> 2.17.1

thanks,

-- 
heikki
