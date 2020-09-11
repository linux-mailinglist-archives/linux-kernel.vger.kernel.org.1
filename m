Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE12667F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgIKR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgIKR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:59:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D0C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:59:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x123so7951857pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TXquo1qLqqSIdjE0lSTLkND6jkViwwDG0wLUjG4hQcI=;
        b=FX539b1S/fSYmDlIVIRft7aJLXtUq/mchMLXO6XDtcqcFWUpD06dPlhj5WeKoihPFO
         P/ZvP3e+T6Qs5KUSWymZ0LXg+uCOpKHhgni1Mgad0dMfin1IJ8wVTdEa4lfm6RnyABt1
         mtL3RPZCZfcX0v19Q/kr+mvgicw6smWJMI4VxjInJvtZjPq5ZBMdpz2v+TsZRfuux2LT
         KzA5PBtqYGfeMtMPyh4HUU0tiiAcJNT9hxifz+Q7CkaltRYlNpbDA0e08Q9ny437lge7
         KCKfWJFsjLvYwJEUrGKxXCWSEABvAKtezmJUlMIwrPCA/NGdh2qrH/CsJysdM7VnZcLx
         SARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXquo1qLqqSIdjE0lSTLkND6jkViwwDG0wLUjG4hQcI=;
        b=qGk3Mkrx5oYPgvovhvztYM4eDn1he0o1vCj2qZYhhLnTLCMUH4wZLIioJq7Kw6uvLi
         aRB7c8ygMdNmE3U3kOQzEFfZ0aA7TfCaVPvQlm8T39I6ZJ9dIO6U+6OkUVrIdT6UEO2U
         gS1JwGvQj5N+qeSE3sox2cytNP7/6QWGpxhQ8Dd23neJV9VrUjPDbBq1K4kjaw/w+Asp
         kQztCVf0Fuc3RxW557ryP+MPqJzgdqObAbRWp95d2uk978iMrDJBPAMTg4FMtZVahxbT
         zn7oj3SvfVg2ovXl3QqzSGNtNULYRt9ZuAh5Qs/qb8hhx7Xcc9JluJzJxTyZ9QFZGjl/
         dDwg==
X-Gm-Message-State: AOAM531dgbwfEFNyS9AqNd+PECbvS/3sG/SNb+3AMN5405wK5peLTyMn
        SYuYyjOkvr9/0SQPvshh09xdvQ==
X-Google-Smtp-Source: ABdhPJzuoVoQsZf/X3umP/oy+to3uZXSK1m/Mwcq0DPLfv9Rz/eL3/ebVAOLbn32TZtgQs8qrHl74A==
X-Received: by 2002:a62:8607:0:b029:13c:1611:6593 with SMTP id x7-20020a6286070000b029013c16116593mr3022517pfd.16.1599847162307;
        Fri, 11 Sep 2020 10:59:22 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id np1sm2430537pjb.2.2020.09.11.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:59:21 -0700 (PDT)
Date:   Fri, 11 Sep 2020 11:59:19 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, Al.Grant@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] coresight: Don't allocate pdata->conns when there is no
 output port
Message-ID: <20200911175919.GC613136@xps15>
References: <1599550288-41724-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599550288-41724-1-git-send-email-liuqi115@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Tue, Sep 08, 2020 at 03:31:28PM +0800, Qi Liu wrote:
> When there is no output port, coresight_alloc_conns() still do the following
> copy connection information to pdata->conns, and this may cause kernel panic.
> Let's fix it.

Function coresight_alloc_conns() doesn't copy connection information.  Moreover
sink devices don't have an output port and this code has been stable for years
now.  As such I am suspecting that something else is going wrong...

Can you give more details about the coresight topology you are working with?  An
output of the kernel panic you are seeing would also be much appreciated.

Thanks,
Mathieu

> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index bfd4423..cdc8824 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -26,12 +26,13 @@
>  static int coresight_alloc_conns(struct device *dev,
>  				 struct coresight_platform_data *pdata)
>  {
> -	if (pdata->nr_outport) {
> -		pdata->conns = devm_kcalloc(dev, pdata->nr_outport,
> -					    sizeof(*pdata->conns), GFP_KERNEL);
> -		if (!pdata->conns)
> -			return -ENOMEM;
> -	}
> +	if (!pdata->nr_outport)
> +		return -ENOMEM;
> +
> +	pdata->conns = devm_kcalloc(dev, pdata->nr_outport,
> +				    sizeof(*pdata->conns), GFP_KERNEL);
> +	if (!pdata->conns)
> +		return -ENOMEM;
> 
>  	return 0;
>  }
> --
> 2.8.1
> 
