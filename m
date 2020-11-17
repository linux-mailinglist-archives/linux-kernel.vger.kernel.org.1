Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10DA2B5F06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgKQMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:22:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:3862 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgKQMWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:22:18 -0500
IronPort-SDR: GmFaV83VZ23ZQr+ZPloQ7LPmkfQZwf23lv2Hc1U8tcsOkwCF9B7CCIwvnEskL9qmJlH6XCgzmB
 /8vMBTUO3ecQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="150181253"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="150181253"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 04:22:17 -0800
IronPort-SDR: miAZPVwrpHpJscqHx2/kEHFdPtyMZnWKDxLFg5/ByrctyXOMEaoQFxsagjY/Kjp4W6luey785H
 PYJIUTMKB4SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430461244"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 04:22:15 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:22:14 +0200
Date:   Tue, 17 Nov 2020 14:22:14 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 8/8] usb: typec: Remove active_link_training variable
 from Enter_USB message
Message-ID: <20201117122214.GH3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-9-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-9-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:25:03PM -0800, Utkarsh Patel wrote:
> Thunderbolt 3 cable discover mode VDO support has been added as part of
> Enter_USB message to fill details of active cable plug link training.
> Hence, removing unused variable active_link_training from Enter_USB
> message data structure.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --
> Changes in v2:
> - No change.
> --
> ---
>  include/linux/usb/typec.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index d91e09d9d91c..4a9608a15ac1 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -76,16 +76,10 @@ enum typec_orientation {
>   * struct enter_usb_data - Enter_USB Message details
>   * @eudo: Enter_USB Data Object
>   * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
> - * @active_link_training: Active Cable Plug Link Training
> - *
> - * @active_link_training is a flag that should be set with uni-directional SBRX
> - * communication, and left 0 with passive cables and with bi-directional SBRX
> - * communication.
>   */
>  struct enter_usb_data {
>  	u32			eudo;
>  	u32			tbt_cable_vdo;
> -	unsigned char		active_link_training:1;
>  };
>  
>  /*
> -- 
> 2.17.1

thanks,

-- 
heikki
