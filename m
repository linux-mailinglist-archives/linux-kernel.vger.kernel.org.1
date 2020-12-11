Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB202D783C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406204AbgLKOuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:50:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:33051 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394973AbgLKOuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:50:22 -0500
IronPort-SDR: gYubNMEdbaRQ/tjpL+XKHpViixGj97qppBsGzuN6eP/PiT+BoMQQzebAML2ezybcTjSXg5hnaG
 FICYQuDvIZGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="174552381"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="174552381"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 06:48:35 -0800
IronPort-SDR: kF44CLvInam9OUaqikp9p6kTmX/p8WfrnkSqsX+BOQGBuTTL0poIKuAyEH/dz85NhS6d7lIjy2
 pYQu6J05xRwA==
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="441224857"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 06:48:34 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1knjjk-00Dg9a-5E; Fri, 11 Dec 2020 16:49:36 +0200
Date:   Fri, 11 Dec 2020 16:49:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] usb: dwc3: drd: Avoid error when extcon is missing
Message-ID: <20201211144936.GT4077@smile.fi.intel.com>
References: <20201211142421.15389-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211142421.15389-1-semen.protsenko@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:24:21PM +0200, Sam Protsenko wrote:
> If "port" node is missing in PHY controller node, dwc3_get_extcon()
> isn't able to find extcon device. This is perfectly fine in case when
> "usb-role-switch" or OTG is used, but next misleading error message is
> printed in that case, from of_graph_get_remote_node():
> 
>     OF: graph: no port node found in /phy@1234abcd
> 
> Avoid printing that message by checking if port node exists in PHY node
> before calling of_graph_get_remote_node().

So, this has to be v2...
Anyway, see below.

...

>  static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>  {
>  	struct device *dev = dwc->dev;
> -	struct device_node *np_phy, *np_conn;
> -	struct extcon_dev *edev;
> +	struct device_node *np_phy;
> +	struct extcon_dev *edev = NULL;
>  	const char *name;
>  
>  	if (device_property_read_bool(dev, "extcon"))
> @@ -462,15 +462,22 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>  		return edev;
>  	}
>  
> +	/*
> +	 * Try to get extcon device from USB PHY controller's "port" node.
> +	 * Check if it has the "port" node first, to avoid printing the error
> +	 * message from underlying code, as it's a valid case: extcon device
> +	 * (and "port" node) may be missing in case of "usb-role-switch" or OTG
> +	 * mode.
> +	 */
>  	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> -	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +	if (of_graph_is_present(np_phy)) {
> +		struct device_node *np_conn;
>  
> -	if (np_conn)
> -		edev = extcon_find_edev_by_node(np_conn);
> -	else
> -		edev = NULL;
> -
> -	of_node_put(np_conn);
> +		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +		if (np_conn)
> +			edev = extcon_find_edev_by_node(np_conn);
> +		of_node_put(np_conn);
> +	}
>  	of_node_put(np_phy);
>  
>  	return edev;


Why not do it slightly different, i.e.

-	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+	if (of_graph_is_present(np_phy))
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+	else
+		np_conn = NULL;

?

-- 
With Best Regards,
Andy Shevchenko


