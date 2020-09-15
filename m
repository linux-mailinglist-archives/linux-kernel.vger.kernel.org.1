Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49FA26A263
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgIOJjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:39:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36830 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgIOJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:39:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so2226625ljm.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gsQS95Uk+X6C1ro4IWpVaBNknqSF3qG+Ftqq7mGtuJM=;
        b=LdOK0FXiKcgOY5Y2YL19E0tIR6Ql1ZIVcv1oHhdUnvKHw1eSeefKN7Ll8SGRbbJ7fv
         sgO9BKldcSwcxwNavCdMzvUkf0o9CgFZuQzYlXAGlAVVhoYKTcXA23N18VOjkXk3Zf3Q
         Vx31VcJLa4SbXWBssnP87qp0guVulgwrzP/kL1Dn8gscjHXPz+NL40QbQTBk3cREaNNr
         sk1aB2wXedE6ZJ8t8e7l5W+QFFyJTst+D+i1vH+rXsdf5EaGA5tjlFtLGAp/VRcVquc6
         tRpRomWlqo5kt39vTUG+flzEcHsHrfXtLVZYDiShs+KskjKzPLB3gyyxl2SvuZu6a+1W
         WMaQ==
X-Gm-Message-State: AOAM533vtm0v7p2d/cHtUsq34/AxA5pnLnXmp0RG33T0MKPdow2Vyaxr
        9Za4/X758EQ8b7EXdBy8M4cVcLdkU2M=
X-Google-Smtp-Source: ABdhPJxT4U446B9RyHHoxlY0C1zVy/91BYU/0K3ze2/e5l+769DK9WnAtaylL3grijOpOooNXJi5Rw==
X-Received: by 2002:a05:651c:1073:: with SMTP id y19mr6961972ljm.57.1600162771665;
        Tue, 15 Sep 2020 02:39:31 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 80sm4228874lff.61.2020.09.15.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 02:39:30 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kI7Qv-00058k-Pa; Tue, 15 Sep 2020 11:39:29 +0200
Date:   Tue, 15 Sep 2020 11:39:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: greybus: simplify the return expression
 of gb_svc_add()
Message-ID: <20200915093929.GM24441@localhost>
References: <20200915032630.1772621-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915032630.1772621-1-liushixin2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:26:30AM +0800, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/greybus/svc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
> index ce7740ef449b..dca251172cd2 100644
> --- a/drivers/greybus/svc.c
> +++ b/drivers/greybus/svc.c
> @@ -1345,18 +1345,12 @@ struct gb_svc *gb_svc_create(struct gb_host_device *hd)
>  
>  int gb_svc_add(struct gb_svc *svc)
>  {
> -	int ret;
> -
>  	/*
>  	 * The SVC protocol is currently driven by the SVC, so the SVC device
>  	 * is added from the connection request handler when enough
>  	 * information has been received.
>  	 */
> -	ret = gb_connection_enable(svc->connection);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return gb_connection_enable(svc->connection);

There no need for this change. This code was written with an explicit
success path on purpose.

Also, this driver doesn't live in staging anymore as your patch prefix
suggests.

>  }
>  
>  static void gb_svc_remove_modules(struct gb_svc *svc)

Johan
