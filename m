Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532A82DC45F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLPQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgLPQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:36:28 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3B0C061794;
        Wed, 16 Dec 2020 08:35:48 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 11so23519767oty.9;
        Wed, 16 Dec 2020 08:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cYvBBPpoOjACqprIaSxF5NE7DTcYLIMW9b2II2n+bAk=;
        b=ZzCmS9jg6L7FUJJcTC2ClOEmxbAu1LuetdlQDMnoczcMMk7ssuFQ3tnEuCFOLQG2pN
         /BWTfstggZArspNsxnxMJ5FcRBDDbpWMHi7vZhxnb+5AGkj9QUITch8FqfGsXp3/aLih
         Sx+hXmJMc3+0PmGwG0sjnsGyXW793OP2A87HW98pjhdYHhET4z78eiNizSWXyY+SfqRo
         o9Qh/oR0OXumPnxmasAq8aFgLV1JnJg9nVbthU9XdfixnSUvsN9vsZwm3JBIylMulbbt
         MPv/GxvCOqPe+2I741rUZgkVJ34le7vWIW3RXZpIfcxN7JTgjM9ejbtkx0F6iVPidrUb
         hslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cYvBBPpoOjACqprIaSxF5NE7DTcYLIMW9b2II2n+bAk=;
        b=jNDJuAy2vxN9GpS51Eg2EPV6RtBQfSUA0+H65AqbT9Vvx9aAzDQTalcDZA0+0KbWYa
         2HQIf9FBR7GnyyDqWiZwraCIWN4hRkEasYOAO03Bowv/b/JH70vGju86WhmohoWclrSP
         ZXVBmwDNAfWaGjOlRrUxKuKcM4tfx2zaeopbzXei2nkmh+beJbNrcMkgrJGIoPudYBFB
         KthfEMULANKd8LpJuZQFsUCVs12ngjS1Z5E9RjvPLUgkXJr+3Y5YLx7qpsculFYswdIm
         PFnWp/CsDXOsj90OQq/U0KguLWg90nasQ1u1bHP4YuSXClpxBUKZlnaQKD9wBvveMhGn
         qCRQ==
X-Gm-Message-State: AOAM531EQ1IzNApXSxU+2VYoWnULT3n7yW3r7ojSsOnbgm0TkukNCG6L
        BIyf6Ap5zLzyOY0sxLHI8Zbl/WBdQEo=
X-Google-Smtp-Source: ABdhPJxYVd1B4dJst6PJ9uExZL2pk6dNG04Arz9Ma4h89+TbArsvy7e9yZRkPTDxeIQXWkfQnGkY0A==
X-Received: by 2002:a05:6830:16d9:: with SMTP id l25mr23907415otr.314.1608136547630;
        Wed, 16 Dec 2020 08:35:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w131sm499021oif.8.2020.12.16.08.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Dec 2020 08:35:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Dec 2020 08:35:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     trix@redhat.com
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: remove h from printk format specifier
Message-ID: <20201216163546.GA59836@roeck-us.net>
References: <20201215183237.2071770-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215183237.2071770-1-trix@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:32:37AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> See Documentation/core-api/printk-formats.rst.
> h should no longer be used in the format specifier for printk.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied. For subsequent patches, please include the affected driver
in the patch subject.

Thanks,
Guenter

> ---
>  drivers/hwmon/smsc47m1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> index b637836b58a1..37531b5c8254 100644
> --- a/drivers/hwmon/smsc47m1.c
> +++ b/drivers/hwmon/smsc47m1.c
> @@ -682,7 +682,7 @@ static int __init smsc47m1_handle_resources(unsigned short address,
>  			/* Request the resources */
>  			if (!devm_request_region(dev, start, len, DRVNAME)) {
>  				dev_err(dev,
> -					"Region 0x%hx-0x%hx already in use!\n",
> +					"Region 0x%x-0x%x already in use!\n",
>  					start, start + len);
>  				return -EBUSY;
>  			}
