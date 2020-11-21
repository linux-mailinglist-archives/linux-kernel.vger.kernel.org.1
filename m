Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1272A2BC0BF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 18:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgKUQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 11:59:11 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:34081 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbgKUQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 11:59:10 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id C310640098
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 09:59:05 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id gWE5kQjAGwNNlgWE5keHWe; Sat, 21 Nov 2020 09:59:05 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=BoezP7f5 c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=7CQSdrXTAAAA:8 a=2M5tUyfAVdibolAbR3cA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=AjGcO6oz07-iQ99wixmX:22
 a=nlm17XC03S6CtCLSeiRr:22 a=a-qgeE7W1pNrGK8U0ZQC:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2vcIO4pCUjm64D/qilEE5CXFzPfD8btnRxk3dxvAE4o=; b=r28lvndeQOQuEL2MB/HRk6Gzqb
        UeifVyeOYK5hQQvF/rYzNwV+DGDJ9/Ww8q6L5EthecJRUq6NrKbJfd/2m2Vx6wVChYKHBYBGRlxZx
        NJhykulrKthvigzlrqtOtWwTVXjCSVxDVAR5PHknNNRuzsP0ls/8vwZhHPVr0ZJSCN2J0h/cRQje/
        UINtlqfn7t4CJBg2y9vpnmeLdoLBspI8wuq4IxpwhrskkZj77NMyWOCZ1yvdSCriePtbkrWzNRg8h
        bSRSRP3wnmkcWMo8Cri4ER+LG3pHKubEMMum2q+i1pMyNgSxR+JwBfdUnXosCQ8ildxyC7oaeSwCQ
        /l3PhI5w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40692 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgWE4-002Xca-I4; Sat, 21 Nov 2020 16:59:04 +0000
Date:   Sat, 21 Nov 2020 08:59:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 3/6] hwmon: scmi: update hwmon internal scale data type
Message-ID: <20201121165903.GA111877@roeck-us.net>
References: <20201119174906.43862-1-cristian.marussi@arm.com>
 <20201119174906.43862-4-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119174906.43862-4-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgWE4-002Xca-I4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:40692
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org:  HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 05:49:03PM +0000, Cristian Marussi wrote:
> Use an int to calculate scale values inside scmi_hwmon_scale() to match
> the updated scale data type in struct scmi_sensor_info.
> 
> Cc: linux-hwmon@vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

[ Assuming this will be pushed togesther with the other patches in the series ]

Guenter

> ---
>  drivers/hwmon/scmi-hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 09ce30cba54b..17d064e58938 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -30,7 +30,7 @@ static inline u64 __pow10(u8 x)
>  
>  static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
>  {
> -	s8 scale = sensor->scale;
> +	int scale = sensor->scale;
>  	u64 f;
>  
>  	switch (sensor->type) {
> -- 
> 2.17.1
> 
