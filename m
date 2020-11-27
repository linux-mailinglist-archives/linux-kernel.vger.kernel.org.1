Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF72C68DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgK0Pkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:40:36 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:56120 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730324AbgK0Pkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:40:36 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 4BE801AB105
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:40:35 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id ifrOkytFfi1lMifrPkxY5K; Fri, 27 Nov 2020 08:40:35 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=dd3w5Tfe c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10
 a=evQFzbml-YQA:10 a=BTeA3XvPAAAA:8 a=YPWOSqNe3Y0DLtFEYbAA:9 a=CjuIK1q_8ugA:10
 a=tafbbOV3vt1XuEhzTjGK:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2pBYS0YD09ZNwP3MsMG1NDl3sTm6BHmwAJZST+7OreY=; b=mU1NS5xbIQgt7NWROsUxDeh636
        7T7Peb3cxkzSYOBke/uczLqX44EvTKAXiRBDIJ0Zg+s9/ABG2g7SuWi25roGuW5Fsh/5j6Jd95dlz
        Pnugl1PUaROLki/091SjC25z7BdbhQUgcBcQ6MMc4B0KIHYbdE9i+3+UGBZqjcZi1/dckpEo8GOpH
        MAd2qrEUwP4c3i30bBm+LDzZCBX8KBh9BfWgwF5kWIhauesmDuvtaquxy+cMq5PrwULH0e/I3K6hG
        hZv60x+8deyA5qAK2cEMYm0ilwdsglBmvMHQ8gV9g7yX8mjcM01u9cNexZ2mlWSZObxcFUW6xmkEx
        Kua1sBWQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43368 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kifrO-002bDh-Dy; Fri, 27 Nov 2020 15:40:34 +0000
Date:   Fri, 27 Nov 2020 07:40:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (abx500): Switch to using the new API
 kobj_to_dev()
Message-ID: <20201127154033.GA9268@roeck-us.net>
References: <1606357280-51921-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606357280-51921-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kifrO-002bDh-Dy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:43368
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:21:20AM +0800, Tian Tao wrote:
> fixed the following coccicheck:
> drivers/hwmon/abx500.c:266:60-61: WARNING opportunity for kobj_to_dev().
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/abx500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
> index 50e67cd..4b96488 100644
> --- a/drivers/hwmon/abx500.c
> +++ b/drivers/hwmon/abx500.c
> @@ -263,7 +263,7 @@ static ssize_t max_alarm_show(struct device *dev,
>  static umode_t abx500_attrs_visible(struct kobject *kobj,
>  				   struct attribute *attr, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct abx500_temp *data = dev_get_drvdata(dev);
>  
>  	if (data->ops.is_visible)
