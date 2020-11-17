Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216932B5D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgKQKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:46:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:17496 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgKQKq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:46:28 -0500
IronPort-SDR: ghOcfc5U7fBJyukk0Kpib9ubC/5WysrVAAIEb5WZbjPtXPcUwojCAr8fJyJQ+5pgILmJqvMBTa
 RLzax1JLzj1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="171071425"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="171071425"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 02:46:28 -0800
IronPort-SDR: vg1S/+UpEUuY29x434YdrxTuq09PU96DCAJLLwq2K/+OHgzegTDSyf9PK+mBS+brPgkmNN5/H7
 iGq4TFNPufJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430442715"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 02:46:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 12:46:24 +0200
Date:   Tue, 17 Nov 2020 12:46:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, enric.balletbo@collabora.com,
        rajmohan.mani@intel.com, azhar.shaikh@intel.com
Subject: Re: [PATCH v2 4/8] usb: typec: Remove one bit support for the
 Thunderbolt rounded/non-rounded cable
Message-ID: <20201117104624.GD3437448@kuha.fi.intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-5-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113202503.6559-5-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:24:59PM -0800, Utkarsh Patel wrote:
> Two bits support for the Thunderbolt rounded/non-rounded cable has been
> added to the header file.
> Hence, removing unused TBT_CABLE_ROUNDED definition from the header file.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> --
> changes in v2:
> - Removed the fixes tag as there is no functional implication.
> --
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
> -- 
> 2.17.1

thanks,

-- 
heikki
