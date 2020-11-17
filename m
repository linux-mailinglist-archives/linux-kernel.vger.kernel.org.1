Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79852B5D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgKQKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKQKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:49:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE13C0613CF;
        Tue, 17 Nov 2020 02:49:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 25D9D1F44341
Subject: Re: [PATCH v2 6/8] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-7-utkarsh.h.patel@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8654d16e-7f9e-7dda-41b7-bf2996f82136@collabora.com>
Date:   Tue, 17 Nov 2020 11:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113202503.6559-7-utkarsh.h.patel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/20 21:25, Utkarsh Patel wrote:
> Configure Thunderbolt3/USB4 cable generation value by filing Thunderbolt 3
> cable discover mode VDO to support rounded and non-rounded Thunderbolt3/
> USB4 cables.
> While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> cable plug link training value.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> 
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
> 
