Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C52B1DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKMPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:01:04 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:56484 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgKMPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:01:03 -0500
X-Greylist: delayed 1295 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2020 10:01:02 EST
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 98E0E175E74
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:39:23 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id daEVkSmoOeMJHdaEVkc7xq; Fri, 13 Nov 2020 07:39:23 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Lve8NEVc c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=uChsZFC9AAAA:8
 a=Yh6QIf3qdrE7sFbyTP4A:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=ULtXvzFHYWHLyBAuiDia:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BY78yr0Ocioiva88DRMAPlOkXCVeBnu536+stK2YWsw=; b=E+be1NRoQOBKsggx1pC23FllMg
        WwUMXeHOrZI08PqNbZuUAPGDLSGOd1PfBjBTyrLF2WMCfGP8PZZ2g1djgZwygYjrk8EpVeGXH9Lbc
        8DzbFqXbqOsQOD2qmhJRJzO7TcbgkjhTdv8nmkL6H0TExr6Zxy17u3grrk4lZuo3RcqbgdidueFpE
        ZMVHMIFgWPKZ2Vfvi3WkidZCeK5tFwA3SMblLEDwgVbJJJ0MAm+W98bQi2BSLCuKeSAvo+RacSmiA
        m+9lAdU27Rrt4dnpAs0mnl0ca8A9wYcSxd4uqPXU+9muE/VcW9BOGOosR1dcM95A2VdK/IkR/51c9
        lq0w6z+A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52254 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kdaEU-002XNs-Mq; Fri, 13 Nov 2020 14:39:22 +0000
Date:   Fri, 13 Nov 2020 06:39:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: fix corsair-psu fan rpm calculation
Message-ID: <20201113143921.GA26336@roeck-us.net>
References: <20201113121954.GA8488@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113121954.GA8488@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kdaEU-002XNs-Mq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:52254
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 01:19:54PM +0100, Wilken Gottwalt wrote:
> The correct fan rpm value is also a LINEAR11 value but without a factor.
> Verified by using the fan test button on the psu to let the fan spin up
> to maximum for some seconds.
> 
> Fixes: 933222c98445 ("hwmon: (corsair-psu) fix unintentional sign extension issue")
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/corsair-psu.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 5d19a888231a..99494056f4bd 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -252,12 +252,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF) * 1000;
>  		break;
>  	case PSU_CMD_FAN:
> -		/*
> -		 * this value is best guess, so the calculated value could be wrong, it is hard
> -		 * to ge the fan to spin in these semi-passive power supplies, which need a
> -		 * quite high load to do so
> -		 */
> -		*val = ((tmp & 0xFF) << 8) + ((tmp >> 8) & 0xFF);
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF);
>  		break;
>  	case PSU_CMD_RAIL_WATTS:
>  	case PSU_CMD_TOTAL_WATTS:
