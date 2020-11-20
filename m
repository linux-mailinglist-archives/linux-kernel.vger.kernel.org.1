Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2930E2BA445
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKTIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:05:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:2079 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgKTIF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:05:26 -0500
IronPort-SDR: ZsxY5ISn67CybMpPmNk8nbNFe+f1bC8qzAcJMjiirgxoq7JVNhGs8F6zsIDIE7IK3NJSj6Vil8
 g7c7NBl/vyaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="151281798"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="151281798"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 00:05:20 -0800
IronPort-SDR: jA6jC7mvEXMDRVXWA7dkEP+5iTF7xiZoEJ0f2tq7GNfuYsasYtyui4ugVYffAFxuifEc+/8N/H
 g+zRUMJVygTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="431499744"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2020 00:05:16 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 20 Nov 2020 10:05:14 +0200
Date:   Fri, 20 Nov 2020 10:05:14 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v3 1/4] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Message-ID: <20201120080514.GC4120550@kuha.fi.intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-2-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119063211.2264-2-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:32:08PM -0800, Utkarsh Patel wrote:
> When Thunderbolt 3 cable is being used to create USB4 connection, use
> Thunderbolt 3 discover mode VDO to fill details such as active cable plug
> link training and cable rounded support.
> With USB4 cables, these VDO members need not be filled.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> 
> --
> Changes in v3:
> - Changed the commit mesage to reflect why TBT3 VDO is being used.
> - Added more details in the header file about the usage of TBT3 VDO.
> 
> Changes in v2:
> - No change.
> --
> ---
>  include/linux/usb/typec.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 6be558045942..25731ed863fa 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -75,6 +75,10 @@ enum typec_orientation {
>  /*
>   * struct enter_usb_data - Enter_USB Message details
>   * @eudo: Enter_USB Data Object
> + * @tbt_cable_vdo: TBT3 Cable Discover Mode Response

This is fine..

> + * @tbt_cable_vdo needs to be filled with details of active cable plug link
> + * training and cable rounded support when thunderbolt 3 cable is being used to
> + * create USB4 connection. Do not fill this in case of USB4 cable.

But this is not. The description of the member tells what the member
contains, but it does not make sense to explain also how to use the
member in the same place. Instead you should explain how to use the
member in the description of the structure. So..

>   * @active_link_training: Active Cable Plug Link Training
>   *
>   * @active_link_training is a flag that should be set with uni-directional SBRX

Put it here. That will make this much more readable.


thanks,

-- 
heikki
