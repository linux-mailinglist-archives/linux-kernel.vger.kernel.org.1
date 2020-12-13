Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A652D8ADE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 02:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgLMBhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 20:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgLMBhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 20:37:34 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440DC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 17:36:54 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j12so12170897ota.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 17:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f6QnnODpwjvVs0TG6bz0vqKvu0blPYOpBmRNhM9K0/c=;
        b=r5CSyrDFc5uz6hPmhtd3vWLfdIlDAwaEjPdE+45+uAnlChA5fFhZ2m+FPkGh8LG32+
         5aWK027RYSSVmz489LInPnqZTll5VQgHY6TWmLf+EHrpYXXo4AIXsqX81Ah/m7D6YDtw
         l1r9Ijsxk+vq8J1nlGhH9LlBiWrV+Yg0VZBbZhRNJE+K44HPKvaoCNfYX2V3mzF2w+aT
         jXk/QrieZe/x8R2X+OnhUFvYBbkTz/RIUvxj3y4dAa5wavetjYf40w7TyfhefJ0nlviE
         I4LG1mrBp/l0oHbTZeJzRu2pC7kObskuGdG2/CbucUzdEU88rnWOWprWKfbLgbiIIZjs
         3MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f6QnnODpwjvVs0TG6bz0vqKvu0blPYOpBmRNhM9K0/c=;
        b=tz3ygs2ZiRMdFQfWJfl8Ip6pwPa5QAxzNnkgTCgNloWN+cKh6ZJLF3WvUq9RuldZ6A
         2lFdoobex/YmbuIwxLBap6XjZl6RWeX4tV6WC5m+JX+dgPLke241wfy4HnX1r9NksEm8
         0EIgUQjr/snvv3W5v3Kcfoy9S7E1BrleAnEp/J0Q1shwJpoF0tDsAur64FiZlzhiwrBx
         tzuAHXn3Kw4Nh4l6DI+zyRu6rTai/bSFBc52o6q0M0CIslL+ZHlzeyo4kx3HaMPIW2dl
         YOP1+yaRB43ZZHm5w9ZtFljwZpbs7QkKKY+myGu/xONMmtgYe+XDu+KDa4362degyv7I
         Hejg==
X-Gm-Message-State: AOAM531/NSg5aIcy+bbeJTYYenbEMCniEabL5ZjISeO6Y2FZcEyBpX7Q
        WKGjUktU+pXHZW43gkNvtSk=
X-Google-Smtp-Source: ABdhPJzRtDobhAWfTmB6InWZqe7gF0fXbTzmP6lXFCxDTVuq6XJeEwPpiqVFGt2Efo7P3CDR+c7oxQ==
X-Received: by 2002:a9d:7f15:: with SMTP id j21mr15228929otq.76.1607823413633;
        Sat, 12 Dec 2020 17:36:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14sm2948337oot.5.2020.12.12.17.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Dec 2020 17:36:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 12 Dec 2020 17:36:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] driver core: platform: don't oops in
 platform_shutdown() on unbound devices
Message-ID: <20201213013651.GA59715@roeck-us.net>
References: <20201212235533.247537-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212235533.247537-1-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 02:55:33AM +0300, Dmitry Baryshkov wrote:
> On shutdown the driver core calls the bus' shutdown callback also for
> unbound devices. A driver's shutdown callback however is only called for
> devices bound to this driver. Commit 9c30921fe799 ("driver core:
> platform: use bus_type functions") changed the platform bus from driver
> callbacks to bus callbacks, so the shutdown function must be prepared to
> be called without a driver. Add the corresponding check in the shutdown
> function.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/base/platform.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 0358dc3ea3ad..e9477e0bbca5 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1351,9 +1351,13 @@ static int platform_remove(struct device *_dev)
>  
>  static void platform_shutdown(struct device *_dev)
>  {
> -	struct platform_driver *drv = to_platform_driver(_dev->driver);
>  	struct platform_device *dev = to_platform_device(_dev);
> +	struct platform_driver *drv;
> +
> +	if (!_dev->driver)
> +		return;
>  
> +	drv = to_platform_driver(_dev->driver);
>  	if (drv->shutdown)
>  		drv->shutdown(dev);
>  }
> -- 
> 2.29.2
> 
