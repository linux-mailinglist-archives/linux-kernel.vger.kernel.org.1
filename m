Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88D82C8FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbgK3VH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:07:27 -0500
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:38143 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387637AbgK3VH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:07:26 -0500
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id C6727140443
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:06:45 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id jqNhklc8ZDlydjqNhkZN9d; Mon, 30 Nov 2020 14:06:45 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=CakmGojl c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=j6-uj1VeAAAA:8
 a=2fiukrtPANBYyaf-bDIA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=l1090BQ9NeRrzJSN_Wma:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dclgXg6ZgH4oh82WYmITYR+5dyJVxhh5pV1w6M4cw+8=; b=srcN40G7AIBOx5Sx4X5lU7pwhF
        aAgI8O2vCig1EZWFOfED2RJzFRgOi/DOqE+akWyiRxe3V/eSL/ecSUTP+1QDQeZD73WTqJKhaO9LQ
        JWHTQsXj00XtoHJS9i1puWQOVc4kNmcdx8unNqWmP6l0SOI1pvhpT+rVsa2+FDxmQ2sWBQsj5H2lZ
        Qrp3tSR+lzzWnxAI3zmUJAmrn95qI/WrZmC6bDfnRH1aKfIGKLW54KfanAKne2+6l1kwv6kSCLZNY
        s2K8tQrC3jrhuxK7uogPG0QLizG5gUk7xPh515ZApp9zaTQt3F6VLaT7KhyvXYM3KCrgTvqC0Yl4d
        IQ9Odnuw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56610 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kjqNg-001HBw-R6; Mon, 30 Nov 2020 21:06:44 +0000
Date:   Mon, 30 Nov 2020 13:06:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Jamison <joejamison717@gmail.com>
Cc:     rydberg@bitmath.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        joe@smaklab.com
Subject: Re: [PATCH] hwmon: (applesmc) Add DMI product matches for
 Intel-based Xserves (non-RackMac*)
Message-ID: <20201130210644.GA41165@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kjqNg-001HBw-R6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:56610
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 15
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 10:54:03AM -0600, Joe Jamison wrote:
> This patch adds the DMI Product ID for Intel-based Xserve machines.
> They use the same SMC accessible from the same data ports.
> 
> The 'Xserve' product ID only resolves to SMC-containing
> Intel-based Xserves, as the PowerPC machines are identified
> by the 'RackMac' identifier.
> 
> Tested on: Xserve3,1
> 
> Tested-by: Joe Jamison <joe@smaklab.com> # Xserve3,1
> Signed-off-by: Joe Jamison <joe@smaklab.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/applesmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 79b498f816fe..89207af81c48 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -1299,6 +1299,10 @@ static const struct dmi_system_id applesmc_whitelist[] __initconst = {
>  	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
>  	  DMI_MATCH(DMI_PRODUCT_NAME, "iMac") },
>  	},
> +	{ applesmc_dmi_match, "Apple Xserve", {
> +	  DMI_MATCH(DMI_BOARD_VENDOR, "Apple"),
> +	  DMI_MATCH(DMI_PRODUCT_NAME, "Xserve") },
> +	},
>  	{ .ident = NULL }
>  };
>  
> -- 
> 2.20.1
> 
