Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942B12B5D38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgKQKtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:49:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgKQKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:49:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1F4621F44341
Subject: Re: [PATCH v2 2/8] platform/chrome: cros_ec_typec: Correct the
 Thunderbolt rounded/non-rounded cable support
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-3-utkarsh.h.patel@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5c919cea-3773-2782-2855-904e131fe057@collabora.com>
Date:   Tue, 17 Nov 2020 11:49:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113202503.6559-3-utkarsh.h.patel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/20 21:24, Utkarsh Patel wrote:
> Thunderbolt rounded/non-rounded cable support is two bits value. Correcting
> it as per the Thunderbolt 3 cable discover mode VDO changes done in the
> Thunderbolt 3 alternate mode header.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

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
> 
