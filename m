Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AE22AB267
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgKIIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:30:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:61824 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgKIIab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:30:31 -0500
IronPort-SDR: 1tp1W1FqZI0CnPT3osPzUAerJifEmoUCHdZEs2rDBEwsc8CCvGZX6BRpZ6KUFvXsK4mTQunr7L
 lmtVmIgCywGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="169920490"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="169920490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:30:30 -0800
IronPort-SDR: 0dlkP3SoKPUbSCXLDxZaWAkT515nHxmpaMd1Pxk2rXfZBKMHN7TGKZ5EuxVifEgq7ksf30Bx/S
 BOftvLbXLlWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="427920429"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Nov 2020 00:30:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Nov 2020 10:30:27 +0200
Date:   Mon, 9 Nov 2020 10:30:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 5/6] usb: pd: Add captive Type C cable type
Message-ID: <20201109083027.GG4062920@kuha.fi.intel.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
 <20201106184104.939284-6-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-6-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:41:08AM -0800, Prashant Malani wrote:
> The USB Power Delivery Specification R3.0 adds a captive cable type
> to the "USB Type-C plug to USB Type-C/Captive" field (Bits 19-18,
> Passive/Active Cable VDO, Table 6-38 & 6-39).
> 
> Add the corresponding definition to the Cable VDO header. Also add a
> helper macro to get the Type C cable connector type, when provided
> the cable VDO.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - No changes.
> 
>  include/linux/usb/pd_vdo.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index 68bdc4e2f5a9..8c5cb5830754 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -177,7 +177,7 @@
>   * <31:28> :: Cable HW version
>   * <27:24> :: Cable FW version
>   * <23:20> :: Reserved, Shall be set to zero
> - * <19:18> :: type-C to Type-A/B/C (00b == A, 01 == B, 10 == C)
> + * <19:18> :: type-C to Type-A/B/C/Captive (00b == A, 01 == B, 10 == C, 11 == Captive)
>   * <17>    :: Type-C to Plug/Receptacle (0b == plug, 1b == receptacle)
>   * <16:13> :: cable latency (0001 == <10ns(~1m length))
>   * <12:11> :: cable termination type (11b == both ends active VCONN req)
> @@ -193,6 +193,7 @@
>  #define CABLE_ATYPE		0
>  #define CABLE_BTYPE		1
>  #define CABLE_CTYPE		2
> +#define CABLE_CAPTIVE		3
>  #define CABLE_PLUG		0
>  #define CABLE_RECEPTACLE	1
>  #define CABLE_CURR_1A5		0
> @@ -208,6 +209,7 @@
>  	 | (tx1d) << 10 | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7	\
>  	 | ((cur) & 0x3) << 5 | (vps) << 4 | (sopp) << 3		\
>  	 | ((usbss) & 0x7))
> +#define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
>  
>  /*
>   * AMA VDO
> -- 
> 2.29.1.341.ge80a0c044ae-goog

thanks,

-- 
heikki
