Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748F72A7E9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgKEMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:32:39 -0500
Received: from mout01.posteo.de ([185.67.36.65]:42867 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKEMcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:32:39 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7926F160060
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1604579556; bh=eD5YzhzoFulXg23Qhdnp1Y9wMmabAYRLiaaKokM1eJQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ligZR8BOrxnkL/247mgI0w7bb6GxmPAIYe6jQIzkr4cMvkEsVhFNmj8jFs4+Pke6Z
         NV9AcEY9codhgqsGtWiu8bPBdKOMbXx9/WnAgajDTABnsP132e2PCM2wVC8cwDT69V
         w9ebRGDL0O4zwDI9ZRQoGcl+zcfiqTBizBeTqKs2dKAt65iCB4Pgl9kisSiSewJWlF
         BN8SDBtemb7dGSCXS2Ji9u4BpdZxUN6opFjHNtvSn2uG7Rifig5L8gcXKT86hk0v7w
         rLiZe2KXdcux7JMLayeKYEE9YCS3ml0y0Lck23Aoymq+39GbvR26lqYvBYDFQoKUZ4
         0ozV+2+JiElxA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CRjb73RM3z6tmM;
        Thu,  5 Nov 2020 13:32:35 +0100 (CET)
Date:   Thu, 5 Nov 2020 13:32:33 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: corsair-psu: fix unintentional sign
 extension issue
Message-ID: <20201105133233.10edda5b@monster.powergraphx.local>
In-Reply-To: <20201105115019.41735-1-colin.king@canonical.com>
References: <20201105115019.41735-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Nov 2020 11:50:19 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The shifting of the u8 integer data[3] by 24 bits to the left will
> be promoted to a 32 bit signed int and then sign-extended to a
> long. In the event that the top bit of data[3] is set then all
> then all the upper 32 bits of a 64 bit long end up as also being
> set because of the sign-extension. Fix this by casting data[3] to
> a long before the shift.
> 
> Addresses-Coverity: ("Unintended sign extension")
> Fixes: ce15cd2cee8b ("hwmon: add Corsair PSU HID controller driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hwmon/corsair-psu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index e92d0376e7ac..5d19a888231a 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -241,7 +241,7 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8
> rail, l
>  	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest
> psu
>  	 * supported (HX1200i)
>  	 */
> -	tmp = (data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
> +	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
>  	switch (cmd) {
>  	case PSU_CMD_IN_VOLTS:
>  	case PSU_CMD_IN_AMPS:

Yeah, this could happen if the uptime value in the micro-controller gets bigger
than 68 years (in seconds), and it is the only value which actually uses more
than 2 bytes for the representation. So what about architectures which are 32 bit
wide and where a long has 32 bits? I guess this simple cast is not enough.

greetings,
Wilken
