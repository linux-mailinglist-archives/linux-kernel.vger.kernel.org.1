Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1859A2A0664
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgJ3N1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:27:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:6321 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgJ3N1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:27:00 -0400
IronPort-SDR: KOaE4zNRPzH3ePzMvkbq72dsnuHqH8+hm/1VqtBZOt/DXRgQe86S8ppXlW2JPB5mwjBH5luV6Q
 AAb8B1FCRTgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="147889745"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="147889745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:26:10 -0700
IronPort-SDR: YV4wtnH3IbPh9jWJxKOoi2HaVoQvD2DRl2ZQ7xMBjrzlRSS29MaPLlNoVKeXW4U+RJngJoRIqD
 wRuU8KGsnIew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="425344461"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2020 06:26:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Oct 2020 15:26:06 +0200
Date:   Fri, 30 Oct 2020 15:26:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 1/1] usb: typec: add missing MODULE_DEVICE_TABLE() to
 stusb160x
Message-ID: <20201030132606.GD2333887@kuha.fi.intel.com>
References: <20201028151703.31195-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028151703.31195-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:17:03PM +0100, Amelie Delaunay wrote:
> When stusb160x driver is built as a module, no modalias information is
> available, and it prevents the module to be loaded by udev.
> Add MODULE_DEVICE_TABLE() to fix this issue.
> 
> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/stusb160x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
> index da7f1957bcb3..42076697e26c 100644
> --- a/drivers/usb/typec/stusb160x.c
> +++ b/drivers/usb/typec/stusb160x.c
> @@ -633,6 +633,7 @@ static const struct of_device_id stusb160x_of_match[] = {
>  	{ .compatible = "st,stusb1600", .data = &stusb1600_regmap_config},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, stusb160x_of_match);
>  
>  static int stusb160x_probe(struct i2c_client *client)
>  {
> -- 
> 2.17.1

-- 
heikki
