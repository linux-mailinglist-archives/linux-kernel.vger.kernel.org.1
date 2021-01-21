Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610C82FF47C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbhAUTag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbhAUTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:30:26 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE56C06174A;
        Thu, 21 Jan 2021 11:29:45 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 63so2765166oty.0;
        Thu, 21 Jan 2021 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=73Y0t5hPGjjpPYhjQyYWX8rpxWuyxwzbV2Lo/FDBge4=;
        b=EehH8SpP28aEsQDI8w25/2iIu+hQJOIqwvPjIEaMpRPhkwf97oFXgKybCLPLqKXmr5
         BpWBsV0CVBgQOQ+v9WQ6NE6uDG1m6aWTBfQzThHe9g7me/jrwWFbjwg0XGkgrxnXmWKp
         aggZOqck2l1OyM5Sow8r1UrpO3xOnYWYbu5IVY83LjnAFEBP01BHfiKIavBhScQNOifw
         Zwxbh35KjiUI5v/IGS/Lus0jw8IfsEi2nm3Ct9QLtk8fHbI6W0wwpAvoATgoU3EQvoDN
         0s/VnC3MnaMmZhgPCNzHgMGWMnx6M/FMcqqG1Uk7bUEEFO77WTf83mdszvhyxyHJY9ue
         UuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=73Y0t5hPGjjpPYhjQyYWX8rpxWuyxwzbV2Lo/FDBge4=;
        b=tta60oj5AejdkhHmRVL099k84/PvLAG4FTIkviEw3tCO0vQKdIdVJUaWFyK4rwbBge
         rzolQabYEzElZjytRcpSxwrHrXVnWz3S7Nu3IUYJCmGiSYK+4CNf2X0pWypVUPDwFIw0
         JNaH91vCbkhe/afkPGDIE+GXbYWw9FL67xlA0HVcqp8ByYP8AIz4ydPPUbKRtPgAsa92
         EuB8o0nrfB0PRkxoKwCcZUW8tgkfAMg13fU4D4T2x2UHWGZjWsXjXiSHP+Me3aWRRVf/
         Eex9B+K8uAnxBB7gySFDin4rZ1pkbIpBndaDxMI/L+JLN8AL3E40E7djhXZ8s91lIh0E
         mHQw==
X-Gm-Message-State: AOAM531OacipsLFQiWvYYfTicQLV4qQ7hsF1RGBrN6QnAcEmHbEAnUpr
        w/5ZzNrb/Jh4piEfbZrgz67rUIuyoDg=
X-Google-Smtp-Source: ABdhPJw/j9/9fPly2TroN61wFsJPBNljJix91bPE7Mj+BKuLcQtWh2c9jOt1YUovPQSM3mRYg5aw9Q==
X-Received: by 2002:a05:6830:1254:: with SMTP id s20mr520006otp.155.1611257384847;
        Thu, 21 Jan 2021 11:29:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h11sm1180923ooj.36.2021.01.21.11.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 11:29:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Jan 2021 11:29:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     YANG LI <abaci-bugfix@linux.alibaba.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: abx500: style: Simplify bool comparison
Message-ID: <20210121192942.GA31224@roeck-us.net>
References: <1610358729-86795-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610358729-86795-1-git-send-email-abaci-bugfix@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:52:09PM +0800, YANG LI wrote:
> Fix the following coccicheck warning:
> ./drivers/hwmon/abx500.c:84:8-26: WARNING: Comparison to bool
> 
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>

This driver will be removed in v5.11.

Guenter

> ---
>  drivers/hwmon/abx500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
> index 4b96488..3879b13 100644
> --- a/drivers/hwmon/abx500.c
> +++ b/drivers/hwmon/abx500.c
> @@ -81,7 +81,7 @@ static void gpadc_monitor(struct work_struct *work)
>  
>  		if (data->min[i] != 0) {
>  			if (temp < data->min[i]) {
> -				if (data->min_alarm[i] == false) {
> +				if (!data->min_alarm[i]) {
>  					data->min_alarm[i] = true;
>  					updated_min_alarm = true;
>  				}
