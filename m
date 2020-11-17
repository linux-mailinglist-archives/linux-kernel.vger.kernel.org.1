Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD62B5EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgKQMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:09:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:35508 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKQMJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:09:57 -0500
IronPort-SDR: xtxZrDzIH4pKUnRVWUDQIYNOEpgNjBXO6+tsX1PtNqC29fTfXkLYpBQfffqgRw+Q8zGtiEUEqB
 PxItTiW1LrVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="171011629"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="171011629"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 04:09:56 -0800
IronPort-SDR: 6zU5qG2I4Kp6HIQDmtkOp7foVGq8DLZXaUq3cKtauuAubFVlTfh/9o07sAPidfHaUaD5vnudEf
 bDmB7a0iYDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430458516"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 04:09:53 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:09:52 +0200
Date:   Tue, 17 Nov 2020 14:09:52 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 5/8] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Message-ID: <20201117120952.GE3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-6-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-6-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:25:00PM -0800, Utkarsh Patel wrote:
> USB4 also uses same cable properties as Thunderbolt 3 so use Thunderbolt 3
> cable discover mode VDO to fill details such as active cable plug link
> training and cable rounded support.

I'm sorry, but I think that has to be explained better. We only need
the Thunderbolt 3 properties when we create the USB4 connection with
Thunderbolt 3 cables. With USB4 cables that information is simply not
available. Claiming that USB4 uses the same properties in general is
not true.

> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> --
> Changes in v2:
> - No change.
> --
> ---
>  include/linux/usb/typec.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 6be558045942..d91e09d9d91c 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -75,6 +75,7 @@ enum typec_orientation {
>  /*
>   * struct enter_usb_data - Enter_USB Message details
>   * @eudo: Enter_USB Data Object
> + * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
>   * @active_link_training: Active Cable Plug Link Training
>   *
>   * @active_link_training is a flag that should be set with uni-directional SBRX

Please also explain the same here with a short comment. So basically,
if the USB4 connection is created using TBT3 cable, then we need to
supply also the TBT3 Cable VDO as part of this data. But if USB4
cable is used, then that member should not be filled at all.

> @@ -83,6 +84,7 @@ enum typec_orientation {
>   */
>  struct enter_usb_data {
>  	u32			eudo;
> +	u32			tbt_cable_vdo;
>  	unsigned char		active_link_training:1;
>  };

thanks,

-- 
heikki
