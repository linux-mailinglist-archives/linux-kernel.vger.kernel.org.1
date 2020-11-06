Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE82A94B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgKFKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:51:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:10300 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgKFKvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:51:07 -0500
IronPort-SDR: YUjDNC0w3gjAySdPJymae9k9l3/r4WoXp+m0fr5e06kxnlarm9NoQRwVbg6shm/fkhTsDmnqHE
 tJsY5W1x3dmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="187453480"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="187453480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 02:51:06 -0800
IronPort-SDR: lbbOiRuTeTRiQEc0yZcK//hJeV3DoVV7R2H31sSVvQu8ZS+wTeIh6mmzXWdSz7kpfYAPimOYxt
 RSPvH84npPlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="427289318"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2020 02:51:02 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 06 Nov 2020 12:51:01 +0200
Date:   Fri, 6 Nov 2020 12:51:01 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v4 3/5] usb: typec: stusb160x: fix power-opmode property
 with typec-power-opmode
Message-ID: <20201106105101.GB4062920@kuha.fi.intel.com>
References: <20201106091854.14958-1-amelie.delaunay@st.com>
 <20201106091854.14958-4-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106091854.14958-4-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:18:52AM +0100, Amelie Delaunay wrote:
> Device tree property is named typec-power-opmode, not power-opmode.
> 
> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/stusb160x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
> index 2a618f02f4f1..d21750bbbb44 100644
> --- a/drivers/usb/typec/stusb160x.c
> +++ b/drivers/usb/typec/stusb160x.c
> @@ -562,7 +562,7 @@ static int stusb160x_get_fw_caps(struct stusb160x *chip,
>  	 * Supported power operation mode can be configured through device tree
>  	 * else it is read from chip registers in stusb160x_get_caps.
>  	 */
> -	ret = fwnode_property_read_string(fwnode, "power-opmode", &cap_str);
> +	ret = fwnode_property_read_string(fwnode, "typec-power-opmode", &cap_str);
>  	if (!ret) {
>  		ret = typec_find_pwr_opmode(cap_str);
>  		/* Power delivery not yet supported */
> -- 
> 2.17.1

thanks,

-- 
heikki
