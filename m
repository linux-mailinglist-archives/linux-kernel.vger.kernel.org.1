Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9882B8CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKSIJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgKSIJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:09:09 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04060C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:09:09 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y22so2521892plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9YeX71DgvayKaBn55/9EguYcKXPkstIm7k9o5hsUwd4=;
        b=g+ix/XqX7fwT7g0wx9jHzdNVXBba7Yu/WJLfwnSiMAdEPtKmmo/hM2oxQqWdpVCuJc
         1KKLUOoRuaP/w+gSYU2/zRs79JTHFJoYO8dp/VJf++5VYfEWVv0zVrHk9Hwy/4KMy6Pt
         MWnZi7QlYNMj2wK1pSc9AhtHWr8D+xWicSX8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YeX71DgvayKaBn55/9EguYcKXPkstIm7k9o5hsUwd4=;
        b=O7bJd6tiQiGm1WStpUclEYC73sQ9s6R0mtXzXo1JUDBB9ElWkHUcmARzTPEMgGZf2Z
         pMNdulgjlR5peAIiv1VmfFQUAfW28uAEJEMiDGC2LmrsTNBdd+9lDTQKKciNc7+nhnrb
         S5nznDf3o9ZwQDV/P52aLBUUsP+4rjivqYyHxi3d6121dg05DLnBD/CeAPxifLF/SSvG
         6mqiX2hEnSEVDwTvTo/zYP7MqGtMDCeNAqqgCvvZrs9AdYuDzgxaWosvcbZJdQEAQFzX
         EnRwZ3KXUzcGq6AuAdsFb9bCVhORbtw+xPboXrWnkdy2r+1HCwSsPrrdaj4IQMblRvs/
         yNcg==
X-Gm-Message-State: AOAM533NgjeeFB960Zdx75zgRk1wZmtfK0qZcXSDYlP7bhN/NR5URzbv
        ZZA4Dh+mB+HF/q5sRzzXMu9qIQ==
X-Google-Smtp-Source: ABdhPJyjgjvgkqU/XXSkUf6OeAkjb64BJmpaJrHCk6LYUKDVS3qmAt7paEzL1YBGyoPtbY4Zb+syyw==
X-Received: by 2002:a17:902:a415:b029:d8:f55b:5e9b with SMTP id p21-20020a170902a415b02900d8f55b5e9bmr7492889plq.6.1605773348474;
        Thu, 19 Nov 2020 00:09:08 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a123sm29092392pfd.218.2020.11.19.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 00:09:08 -0800 (PST)
Date:   Thu, 19 Nov 2020 00:09:06 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Message-ID: <20201119080906.GE3652649@google.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-3-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119063211.2264-3-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Wed, Nov 18, 2020 at 10:32:09PM -0800, Utkarsh Patel wrote:
> Configure Thunderbolt 3 cable generation value by filling Thunderbolt 3
> cable discover mode VDO to support rounded Thunderbolt 3 cables.
> While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> cable plug link training value.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> 
> --
> Changes in v3:
> - Added a check for cable's TBT support before filling TBT3 discover mode
>   VDO.
> 
> Changes in v2:
> - No change.
> --
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 8111ed1fc574..68b17ee1d1ae 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
>  	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
>  		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
>  
> -	data.active_link_training = !!(pd_ctrl->control_flags &
> -				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> +	/*
> +	 * Filling TBT3 Cable VDO when TBT3 cable is being used to establish
> +	 * USB4 connection.
> +	 */
> +	if (pd_ctrl->cable_gen) {
> +		data.tbt_cable_vdo = TBT_MODE;
> +
> +		if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> +			data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> +
> +		data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
> +	}

I think the following would decouple Rounded Support and Active Cable Link
Training?:

	struct typec_thunderbolt_data data = {};
...
	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
		data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;

	data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);

	if (data.tbt_cable_vdo)
		data.tbt_cable_vdo |= TBT_MODE;


Best regards,

-Prashant
