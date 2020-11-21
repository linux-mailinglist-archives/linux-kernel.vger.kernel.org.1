Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329102BC197
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgKUSu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:50:29 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:54695 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbgKUSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:50:29 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 0ADE1215C67
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 11:50:28 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id gXxrkBWJOh41lgXxrkFuUH; Sat, 21 Nov 2020 11:50:28 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=FoUrAVjq c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=iH7RfIX4AAAA:20
 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8 a=8y_7F0WFO_vNhfgCrDoA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=AjGcO6oz07-iQ99wixmX:22
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CO3ZopLurYfZ1yt43p5M9cveWYTt3s3J5YWhtvV2Bno=; b=q1i2JhEV44laI+W5Pque6fhyXe
        c/xFxb+fjL0cpHFVRYnOEZVSHSxao/rSInqJOEVXKqvajFvfwwOrzBg1eE7vDMT+y3XoIXTm/6x7Q
        vqpfFAEpB/j1lZh5Trzk57IZP8jSpyFpJnimctiO/eZqjte+UjXSnB6ACaAj1SJ7Wcch+VYTsy4Qg
        41efHNdSH1GJUprQRhyzYA6GI4BgtuZ9IezCwDVJWdjsCjSjuAbl4gz3EkRf4yhu3IKAOuWUAKbQg
        8kbLo0NvgQO6z36Pp3ox/IPEgZgRc1SrlhZQjF9D5NpbdevtFhveg2PrQFw75s9ECyzimlgCUgiWh
        ygvVPMQQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40994 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgXxr-003Cdf-1e; Sat, 21 Nov 2020 18:50:27 +0000
Date:   Sat, 21 Nov 2020 10:50:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 087/141] hwmon: (max6621) Fix fall-through warnings for
 Clang
Message-ID: <20201121185026.GC114144@roeck-us.net>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <e59b39ab11a5d8c2a2ec86c15eabc00b5a056c15.1605896060.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e59b39ab11a5d8c2a2ec86c15eabc00b5a056c15.1605896060.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgXxr-003Cdf-1e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:40994
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 67
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:36:09PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/max6621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
> index 367855d5edae..7821132e17fa 100644
> --- a/drivers/hwmon/max6621.c
> +++ b/drivers/hwmon/max6621.c
> @@ -156,7 +156,7 @@ max6621_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
>  		default:
>  			break;
>  		}
> -
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.27.0
> 
