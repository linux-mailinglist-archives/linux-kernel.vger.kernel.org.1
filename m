Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1426BAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgIPDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgIPDk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600227622;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sa18Wy+AFGfNEzK/QEu3XYN/v5F2MKLXPBV9X785ZOo=;
        b=R5Qd5YkVWsz4nEF6pq2WaTLDtqC+R8w6c5qWCYgk0fO8ANgk+pIWQBJeLr27+mbxbpwgS/
        aYFf+NhHvGPTEMM5O0sV1kTir7ZLhO68oYcYL8+SiH2liBjI8U+prqMz4qaHgBxDkwVx8x
        pRfGqXVkYyH3ymnrBtLKelTC3GeW+bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-xHzbVAyzPC693VGLrZM1aA-1; Tue, 15 Sep 2020 23:40:21 -0400
X-MC-Unique: xHzbVAyzPC693VGLrZM1aA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCD61800D4A;
        Wed, 16 Sep 2020 03:40:19 +0000 (UTC)
Received: from [10.64.54.108] (vpn2-54-108.bne.redhat.com [10.64.54.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 930AC702E7;
        Wed, 16 Sep 2020 03:40:18 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH -next] firmware: arm_sdei: simplify the return expression
 of sdei_device_freeze()
To:     Liu Shixin <liushixin2@huawei.com>,
        James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200915032625.1772413-1-liushixin2@huawei.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <9fdd9c4d-d957-e7d5-818d-cc9247be9dfd@redhat.com>
Date:   Wed, 16 Sep 2020 13:40:16 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200915032625.1772413-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/20 1:26 PM, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---

Reviewed-by: Gavin Shan <gshan@redhat.com>

>   drivers/firmware/arm_sdei.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index b4b9ce97f415..5b4c8c51cb20 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -798,16 +798,10 @@ static int sdei_device_resume(struct device *dev)
>    */
>   static int sdei_device_freeze(struct device *dev)
>   {
> -	int err;
> -
>   	/* unregister private events */
>   	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
>   
> -	err = sdei_unregister_shared();
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return sdei_unregister_shared();
>   }
>   
>   static int sdei_device_thaw(struct device *dev)
> 

