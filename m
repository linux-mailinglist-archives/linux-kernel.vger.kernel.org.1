Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7F2B6E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKQTJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKQTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:09:53 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:09:52 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q5so17923121pfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EKEIxK+pD4jeTEalscTFltmZD0LJMW1oTR1V1Ai92rk=;
        b=XaxS8MGD3YWh+KA6GrLINPqaVS8l4Dy/xN7Knq4xTYyGShmNF9bPMr7JvepWoCvT3v
         dPZ4y/WpjoFN/EjBXCzIzDYBpWSkxs41P9fYu8dXRWDx3SxCrBIZymXzRu9v2w9SQT9b
         WiVDuxx0wsC7NUAB/l+ysH2/J5/eWh/rDHFQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKEIxK+pD4jeTEalscTFltmZD0LJMW1oTR1V1Ai92rk=;
        b=faAYIW0kKFrJ8sY1mLJevJGlV9YBt5qpV57VzBHqcha8sTjOJOKl3IliZffumDn2VR
         EWEOp1usJ4al0ZzTUOCWdgVKm2uq67+17PZfEFI3V5aq56CYDQelqvJHNpqpiJou/80O
         dbgrK2EDhgzwK0qlw4u0UBqPG5RvxJ5z1XlcsmvF5jMMgoI3JmKO5yJghhz3JgC4I83p
         X4TldaKl3Rh/aBN4opjF6N7Juvw6kmnRyA0lGjsSJY3TuvEb6FiFjL5DnTmEI/Va+1Ri
         0FK+EhGq/20LoFo+igG40wMqcyNUVOn4TXvNz7GQamUXhlGnpmhIlBcxiX99bybfhIeF
         71kw==
X-Gm-Message-State: AOAM531NyhGm1Y4jRuTbdacDBjpN6B9axaGkLAhe0RbEbBoC3GbISip+
        gzXkDbbaEL5s/LDEbi7OCtFIg7oRC5aVfw==
X-Google-Smtp-Source: ABdhPJzgOnXDshYEhvVE5GgtnQqo/HSrJGcZyPdSpGVJt8byRY+zTZ9oBt0Q6fqJboCozKHJ3lIdoQ==
X-Received: by 2002:a62:256:0:b029:18c:6905:d18d with SMTP id 83-20020a6202560000b029018c6905d18dmr835157pfc.67.1605640192219;
        Tue, 17 Nov 2020 11:09:52 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a3sm3434038pgq.53.2020.11.17.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:09:51 -0800 (PST)
Date:   Tue, 17 Nov 2020 11:09:50 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com
Cc:     Keith Short <keithshort@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Tolerate unrecognized
 mux flags
Message-ID: <20201117190950.GC1819103@google.com>
References: <20201106020305.767202-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106020305.767202-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including Heikki, who I forgot to add in the original patch email.

On Thu, Nov 05, 2020 at 06:03:05PM -0800, Prashant Malani wrote:
> On occasion, the Chrome Embedded Controller (EC) can send a mux
> configuration which doesn't map to a particular data mode. For instance,
> dedicated Type C chargers, when connected, may cause only
> USB_PD_MUX_POLARITY_INVERTED to be set. This is a valid flag combination
> and should not lead to a driver abort.
> 
> Modify the mux configuration handling to not return an error when an
> unrecognized mux flag combination is encountered. Concordantly, make the
> ensuing print a debug level print so as to not pollute the kernel logs.
> 
> Cc: Keith Short <keithshort@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index ce031a10eb1b..5b8db02ab84a 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -537,10 +537,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  		port->state.mode = TYPEC_STATE_USB;
>  		ret = typec_mux_set(port->mux, &port->state);
>  	} else {
> -		dev_info(typec->dev,
> -			 "Unsupported mode requested, mux flags: %x\n",
> -			 mux_flags);
> -		ret = -ENOTSUPP;
> +		dev_dbg(typec->dev,
> +			"Unrecognized mode requested, mux flags: %x\n",
> +			mux_flags);
>  	}
>  
>  	return ret;
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
