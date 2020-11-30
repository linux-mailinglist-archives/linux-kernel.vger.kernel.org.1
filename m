Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6702C8226
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgK3K3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:29:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:65308 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3K3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:29:07 -0500
IronPort-SDR: cobIHU4vc2p4vUxO9kJHXpN8+RRm93K3RrTZJcELUB7EBUkguieVZyk8TfpPKRCrKTi4gzVHD3
 tXJYYF4+VfdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="169115203"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="169115203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 02:27:23 -0800
IronPort-SDR: Iz/v3e4lXOxK9+EmEse+lSEBEb+5XRXys6LHr3SGqXBwoLbSgzQU1m8WdNFOfJxK+9lG0NzU/+
 95IMzxuBEbBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="434265806"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Nov 2020 02:27:20 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 30 Nov 2020 12:27:20 +0200
Date:   Mon, 30 Nov 2020 12:27:20 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usb: typc: tps6598x: Select USB_ROLE_SWITCH and
 REGMAP_I2C
Message-ID: <20201130102720.GA2911464@kuha.fi.intel.com>
References: <cover.1606481420.git.agx@sigxcpu.org>
 <84257ebf9a8d6412a53cb1e87cbd426621fedb1f.1606481420.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84257ebf9a8d6412a53cb1e87cbd426621fedb1f.1606481420.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 01:53:28PM +0100, Guido Günther wrote:
> This is more in line with what tcpm does and will be needed
> to avoid recursive dependency like
> 
>  > drivers/power/supply/Kconfig:2:error: recursive dependency detected!
>    drivers/power/supply/Kconfig:2: symbol POWER_SUPPLY is selected by TYPEC_TPS6598X
>    drivers/usb/typec/Kconfig:64: symbol TYPEC_TPS6598X depends on REGMAP_I2C
>    drivers/base/regmap/Kconfig:19: symbol REGMAP_I2C is selected by CHARGER_ADP5061
>    drivers/power/supply/Kconfig:93: symbol CHARGER_ADP5061 depends on POWER_SUPPLY
>    For a resolution refer to Documentation/kbuild/kconfig-language.rst
>    subsection "Kconfig recursive dependency limitations"
> 
> when selecting POWER_SUPPLY.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 6c5908a37ee8..772b07e9f188 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -64,8 +64,8 @@ config TYPEC_HD3SS3220
>  config TYPEC_TPS6598X
>  	tristate "TI TPS6598x USB Power Delivery controller driver"
>  	depends on I2C
> -	depends on REGMAP_I2C
> -	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> +	select REGMAP_I2C
> +	select USB_ROLE_SWITCH
>  	help
>  	  Say Y or M here if your system has TI TPS65982 or TPS65983 USB Power
>  	  Delivery controller.
> -- 
> 2.29.2

thanks,

-- 
heikki
