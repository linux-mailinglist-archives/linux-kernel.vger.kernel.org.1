Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B600F2BC196
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgKUSuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:50:13 -0500
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:48802 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727155AbgKUSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:50:12 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id 3E24C14049B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 11:50:12 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id gXxbkR88GwNNlgXxckefle; Sat, 21 Nov 2020 11:50:12 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=BoezP7f5 c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=iH7RfIX4AAAA:20
 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8 a=C2tvwzfEKYeKYKrD1t0A:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=AjGcO6oz07-iQ99wixmX:22
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8b9vr57xzkf1VDiWMstyj8UQWq9B2jqEErH6/3baziY=; b=Y/HNNQ55DkowKcg9mRP964rJLn
        R31Nkc9jjVHkphn7fZKVmVEgWnO+WVREtoZLerrqsD43hvYRoIoI7lgARFK/xdWv1TYfq9AmD6lns
        ghbkldxj4bKTZZXMnQhNjE78ih6jNunK9TU+VsQDvM/PV6pQVj4TrG+wwn0sWefHAoePyfrw1YGzj
        Qhmd0dMWr2eIzsmzS8gmUPwpJGDwmjs7y6lKY/EatyKQp2OGwOpsW6PE/Zj4NrSyr0dKhGa3pICBq
        hOoPnJXLtzU+hFR8uAu7Pn/x9HFD5Nek+a98wOlZCmWexT52p27s2Ku4ANN/roaYiMUucylFOrtq3
        V1kjmVpQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40992 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgXxb-003CZP-AS; Sat, 21 Nov 2020 18:50:11 +0000
Date:   Sat, 21 Nov 2020 10:50:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 086/141] hwmon: (corsair-cpro) Fix fall-through warnings
 for Clang
Message-ID: <20201121185010.GB114144@roeck-us.net>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <be5c59f9bc4bac8c968bbd7443d08eaaf8a28ef8.1605896060.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be5c59f9bc4bac8c968bbd7443d08eaaf8a28ef8.1605896060.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgXxb-003CZP-AS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:40992
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 61
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:36:04PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/corsair-cpro.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 591929ec217a..fa6aa4fc8b52 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -310,6 +310,7 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 
