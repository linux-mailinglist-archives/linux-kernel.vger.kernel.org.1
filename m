Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9ED2B6D14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgKQSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbgKQSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:19:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A3C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:19:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t21so10256926pgl.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PCgrY2aBpRPAX/roDvuGOrFaxtGkBJ2lTrHl8BUGv4A=;
        b=GAneKGoG2Io10/3LWlTWJUCwy28HHQcLayHqSU9hLDc4DmunSEd5mdQZMrKPmkQ9K3
         VQsDq1foqZki5dv3xhpVdzzZEAZ+hPj4RYmNZ6zQ8bzjpp7X1LE+wzEe2kFcpktoCsQI
         53QgOCJl6z5jYVsbLhNgHSsp0X1hj/8D2RGQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCgrY2aBpRPAX/roDvuGOrFaxtGkBJ2lTrHl8BUGv4A=;
        b=kF0f0TEPYZO7sjV5iKCsydTEpiYhAVDjzuEIIOqVrZUh5EuT7ZkEM0qzKFTcRQYR6m
         xNQwpY/MfkpiOeuI93X1Gxlvd5Y5n8pHAoQmt1UZIm2o64m5j6FWVspMk+VXni8pO2qp
         jCUsTPaZROszzZ0t+5sB7z6wmOR7xRL0Lu+G4kBVVe59Z6t7K3tzH1kzcMlwb4ur1LF5
         TmbIWYaYdPYgGC3u7A1dNm4vBixGngUm34KJm1IYRxKo4qxSyo6XM/A43wNnQACfZDaK
         zr51Hf1/14dsnZEO4/Vza/Fq+hyhHTsXF9Lfi8fePozeiesJQi+PM9bGt9TIvLUzYSfh
         uypg==
X-Gm-Message-State: AOAM532gO9wNgl8fJw61h/Yj3iqKtm0YJRGd62/NDGykbdCW6/svxZ93
        ulkODVcS1CFE8Fz5Q9sNwyX2vw==
X-Google-Smtp-Source: ABdhPJwlUD+zvvpBBQFbbbouktVbBndX2gMv7jTi96odnE9w+zMsgJQ5w5FlffK5mrpjCmRFe8rYQg==
X-Received: by 2002:a63:7b55:: with SMTP id k21mr4516899pgn.256.1605637160286;
        Tue, 17 Nov 2020 10:19:20 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id l133sm22320736pfd.112.2020.11.17.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 10:19:19 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:19:18 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 6/8] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Message-ID: <20201117181918.GB1819103@google.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-7-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-7-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Fri, Nov 13, 2020 at 12:25:01PM -0800, Utkarsh Patel wrote:
> Configure Thunderbolt3/USB4 cable generation value by filing Thunderbolt 3
> cable discover mode VDO to support rounded and non-rounded Thunderbolt3/
> USB4 cables.
> While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> cable plug link training value.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
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

Is it safe to be making this assumption unconditionally? It might work for
Intel Mux agent but is it guaranteed to be safe for any other future
mux implementation? In other words, what if a "true" USB4 cable is
connected which doesn't have the Thunderbolt SVID alt mode?

(Pre-fetching some alternatives in case the answer is no)

You might want to check with the Cros EC team if you can repurpose a bit of
the "reserved" field for specifying whether the cable is TBT or not.

Either that or see if there is a way to determine from the pd_ctrl->cable_speed
whether the cable is actually TBT or not.

Failing all the above, perhaps you'll have to wait for the PD discovery stuff
to make it's way through review and use that (note that there may be
timing issues between the Mux update event and PD discovery complete
event reaching the port driver).

Best regards,

-Prashant
