Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683FE2AD608
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgKJMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:18:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:17087 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgKJMS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:18:59 -0500
IronPort-SDR: JAFMt5qzjAOV63RxTlQX5KRhVZsohx/BgqjirFtaAFrc59YF23ETWV9y7nPeAOl/tJfh1D782J
 9deW64f2G1YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149811710"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="149811710"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 04:18:59 -0800
IronPort-SDR: aJJZ6EHpkk+5H7rRmxBdiFExHuOxWNKFlsASCSD9FoDwnHTjlTahuTyNALmSXvvmeoL/G7PzSp
 Zu+06B6kRpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="428348430"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2020 04:18:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Nov 2020 14:18:55 +0200
Date:   Tue, 10 Nov 2020 14:18:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH 2/8] platform/chrome: cros_ec_typec: Correct the
 Thunderbolt rounded/non-rounded cable support
Message-ID: <20201110121855.GL1224435@kuha.fi.intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
 <20201110003716.5164-3-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110003716.5164-3-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 04:37:10PM -0800, Utkarsh Patel wrote:
> Thunderbolt rounded/non-rounded cable support is two bits value. Correcting
> it as per the Thunderbolt 3 cable discover mode VDO changes done in the
> Thunderbolt 3 alternate mode header.
> 
> Fixes: 5b30bd35aab4 ("platform/chrome: cros_ec_typec: Add TBT compat support")

Again the fix tag?

> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
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
