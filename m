Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A02AD60D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgKJMT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:19:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:12263 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgKJMTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:19:55 -0500
IronPort-SDR: 8IW9OWS6vx+rQTFsh4EpOOsiU2FK9Pir4imp571RCQ5q9QpxuBNDqKKB67wqDuRgVwXzJ1sj/I
 OSQQHtklCOGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167379239"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="167379239"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 04:19:54 -0800
IronPort-SDR: 9HC/KvfaMqULvjcJVZk0lttrcpRdKZvI+HFWBhtLtZa7/M3pvXiiG7hJKl4Eto7O9QGV3gfKRZ
 HXrpbDamlcpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="428348645"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2020 04:19:52 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Nov 2020 14:19:51 +0200
Date:   Tue, 10 Nov 2020 14:19:51 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH 4/8] usb: typec: Remove one bit support for the
 Thunderbolt rounded/non-rounded cable
Message-ID: <20201110121951.GM1224435@kuha.fi.intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
 <20201110003716.5164-5-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110003716.5164-5-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 04:37:12PM -0800, Utkarsh Patel wrote:
> Two bits support for the Thunderbolt rounded/non-rounded cable has been
> added to the header file.
> Hence, removing unused TBT_CABLE_ROUNDED definition from the header file.
> 
> Fixes: ca469c292edc ("usb: typec: Add definitions for Thunderbolt 3 Alternate Mode")

And again?

> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
>  include/linux/usb/typec_tbt.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index aad648d14bb3..63dd44b72e0c 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -39,7 +39,6 @@ struct typec_thunderbolt_data {
>  #define   TBT_CABLE_USB3_GEN1		1
>  #define   TBT_CABLE_USB3_PASSIVE	2
>  #define   TBT_CABLE_10_AND_20GBPS	3
> -#define TBT_CABLE_ROUNDED		BIT(19)
>  #define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
>  					(((_vdo_) & GENMASK(20, 19)) >> 19)
>  #define   TBT_GEN3_NON_ROUNDED                 0

thanks,

-- 
heikki
