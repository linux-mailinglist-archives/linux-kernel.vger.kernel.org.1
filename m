Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C9A2B5EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgKQMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:11:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:4366 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKQMLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:11:03 -0500
IronPort-SDR: h8Fp81H8lsv9RKkM8MkJsKx4Fukj0XKWe17p9goJc2A0rvk+BQ5Nq85b9cpY8jOESyL/CLhPzI
 Ap84GPx6TIkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="188966521"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="188966521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 04:11:03 -0800
IronPort-SDR: VWOLiyCAE5HtdFruh/KAFYL27GmWPJmuTXb6+Igzyx0J4mZ/4RsuhGk6yj6zqaJHF4ad0WNHOf
 OEBdWOx0zhYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430458762"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 04:11:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:10:59 +0200
Date:   Tue, 17 Nov 2020 14:10:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 6/8] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Message-ID: <20201117121059.GF3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-7-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-7-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:25:01PM -0800, Utkarsh Patel wrote:
> Configure Thunderbolt3/USB4 cable generation value by filing Thunderbolt 3
> cable discover mode VDO to support rounded and non-rounded Thunderbolt3/
> USB4 cables.
> While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> cable plug link training value.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --
> Changes in v2:
> - No change.
> --
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 8111ed1fc574..b7416e82c3b3 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
>  	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
>  		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
>  
> -	data.active_link_training = !!(pd_ctrl->control_flags &
> -				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> +	/*
> +	 * This driver does not have access to the identity information or
> +	 * capabilities of the cable, so we don't know is it a real USB4 or
> +	 * TBT3 cable. Therefore pretending that it's always TBT3 cable by
> +	 * filling the TBT3 Cable VDO.
> +	 */
> +	data.tbt_cable_vdo = TBT_MODE;
> +
> +	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> +		data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> +
> +	data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
>  
>  	port->state.alt = NULL;
>  	port->state.data = &data;
> -- 
> 2.17.1

-- 
heikki
