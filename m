Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B562B5D20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgKQKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:44:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:31045 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgKQKoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:44:02 -0500
IronPort-SDR: JgD6d26JPDza7Kg8RZA7FsHktXi2IimuG/bO6gbEfNEltgu8zhxt/CAZgjxcNqfpEITj6lusY8
 dSrdTqG7ZJTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="232517337"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="232517337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 02:44:01 -0800
IronPort-SDR: 8hXD6uIgIvuWqTKoYWesBFntqqOkH/Slf2sV1inlbGjcL0bOaNCx/1C6bVZClRsoN3pcIHP6jJ
 /kMfHOMSePzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430442271"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 02:43:58 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 12:43:57 +0200
Date:   Tue, 17 Nov 2020 12:43:57 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 1/8] usb: typec: Correct the bit values for the
 Thunderbolt rounded/non-rounded cable support
Message-ID: <20201117104357.GA3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-2-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-2-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:24:56PM -0800, Utkarsh Patel wrote:
> Rounded and non-rounded Thunderbolt cables are represented by two bits as
> per USB Type-C Connector specification v2.0 section F.2.6.
> Corrected that in the Thunderbolt 3 cable discover mode VDO.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --
> Changes in v2:
> - Removed the fixes tag as there is no functional implication.
> --
> ---
>  include/linux/usb/typec_tbt.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index 47c2d501ddce..aad648d14bb3 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -40,11 +40,16 @@ struct typec_thunderbolt_data {
>  #define   TBT_CABLE_USB3_PASSIVE	2
>  #define   TBT_CABLE_10_AND_20GBPS	3
>  #define TBT_CABLE_ROUNDED		BIT(19)
> +#define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
> +					(((_vdo_) & GENMASK(20, 19)) >> 19)
> +#define   TBT_GEN3_NON_ROUNDED                 0
> +#define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
>  #define TBT_CABLE_OPTICAL		BIT(21)
>  #define TBT_CABLE_RETIMER		BIT(22)
>  #define TBT_CABLE_LINK_TRAINING		BIT(23)
>  
>  #define TBT_SET_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
> +#define TBT_SET_CABLE_ROUNDED(_g_)	(((_g_) & GENMASK(1, 0)) << 19)
>  
>  /* TBT3 Device Enter Mode VDO bits */
>  #define TBT_ENTER_MODE_CABLE_SPEED(s)	TBT_SET_CABLE_SPEED(s)

thanks,

-- 
heikki
