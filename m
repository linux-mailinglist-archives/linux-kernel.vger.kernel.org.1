Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7AF1ADE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgDQNhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 09:37:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35160 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgDQNhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:37:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HDb07F061259;
        Fri, 17 Apr 2020 08:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587130620;
        bh=+yGkFSBqbs/Dzofc27vQ+cRl3OuDPjmKpun94oFaQPI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ucz4ZGg66mCcDyFpJ2sXzffoH16dhZuwtWm9QieXAcNLWkY5kdutvS9ztSHU/189Z
         xr5O3oXLxegu3RUd/LU6eDf/HpEvGyIJ0f9YbXSjKYXVWHr9zNEqtINHabTEqFzj2O
         Sff5ibwzLxdaYjzD3j+aBmCOGAhHWgr8owDrAbTM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HDb0kB115890
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 08:37:00 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 08:37:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 08:37:00 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HDb0Rr026659;
        Fri, 17 Apr 2020 08:37:00 -0500
Subject: Re: [PATCH v2 1/7] remoteproc: Fix IDR initialisation in
 rproc_alloc()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <elder@linaro.org>, <Markus.Elfring@web.de>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-2-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <672eb741-35d9-4aa2-1615-70c60ee85d1b@ti.com>
Date:   Fri, 17 Apr 2020 08:37:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204858.2448-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/20 3:48 PM, Mathieu Poirier wrote:
> From: Alex Elder <elder@linaro.org>
> 
> If ida_simple_get() returns an error when called in rproc_alloc(),
> put_device() is called to clean things up.  By this time the rproc
> device type has been assigned, with rproc_type_release() as the
> release function.
> 
> The first thing rproc_type_release() does is call:
>      idr_destroy(&rproc->notifyids);
> 
> But at the time the ida_simple_get() call is made, the notifyids
> field in the remoteproc structure has not been initialized.
> 
> I'm not actually sure this case causes an observable problem, but
> it's incorrect.  Fix this by initializing the notifyids field before
> calling ida_simple_get() in rproc_alloc().
> 
> Fixes: b5ab5e24e960 ("remoteproc: maintain a generic child device for each rproc")
> Signed-off-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suman Anna <s-anna@ti.com>

Thanks Alex. I had exactly this particular comment on Mathieu's sync 
patch series [1].

regards
Suman

[1] https://patchwork.kernel.org/comment/23254901/

> ---
>   drivers/remoteproc/remoteproc_core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e12a54e67588..80056513ae71 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2053,6 +2053,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>   	rproc->dev.type = &rproc_type;
>   	rproc->dev.class = &rproc_class;
>   	rproc->dev.driver_data = rproc;
> +	idr_init(&rproc->notifyids);
>   
>   	/* Assign a unique device index and name */
>   	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
> @@ -2078,8 +2079,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>   
>   	mutex_init(&rproc->lock);
>   
> -	idr_init(&rproc->notifyids);
> -
>   	INIT_LIST_HEAD(&rproc->carveouts);
>   	INIT_LIST_HEAD(&rproc->mappings);
>   	INIT_LIST_HEAD(&rproc->traces);
> 

