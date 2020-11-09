Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4764F2AB3AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgKIJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:34:12 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC4CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 01:34:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id C282723EEDC;
        Mon,  9 Nov 2020 10:34:10 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.94
X-Spam-Level: 
X-Spam-Status: No, score=-2.94 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.040, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m8iLppu4mIMG; Mon,  9 Nov 2020 10:34:09 +0100 (CET)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 378B923F3C7;
        Mon,  9 Nov 2020 10:34:09 +0100 (CET)
Date:   Mon, 9 Nov 2020 10:34:01 +0100
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: fix use after free in lcd2s_i2c_remove()
Message-ID: <20201109093401.oufzm5z3kcckloks@lem-wkst-02.lemonage>
References: <20201106192415.GA2696904@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106192415.GA2696904@mwanda>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:24:15PM +0300, Dan Carpenter wrote:
> The kfree() needs to be moved down a line to prevent a use after free.
> 
> Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/auxdisplay/lcd2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
> index cfa5f86deeef..3eb7f04db6cb 100644
> --- a/drivers/auxdisplay/lcd2s.c
> +++ b/drivers/auxdisplay/lcd2s.c
> @@ -348,8 +348,8 @@ static int lcd2s_i2c_remove(struct i2c_client *i2c)
>  {
>  	struct lcd2s_data *lcd2s = i2c_get_clientdata(i2c);
>  
> -	kfree(lcd2s->charlcd);
>  	charlcd_unregister(lcd2s->charlcd);
> +	kfree(lcd2s->charlcd);
>  	return 0;
>  }

Reviewed-by: Lars Pöschel <poeschel@lemonage.de>

Thanks,
Lars
