Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A232F9950
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbhARFeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbhARFeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610947964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDPCAVJcJa7C+5eBbyflXnWUh5KwAB1+USyHP1tOpTI=;
        b=NM1gofHb9d1d08doebk6/ufcwzz/m8hCBTwPv2xbyypFH50+NHB3LMxsrPpj+2LN47irvb
        GjPg0Q5GThvCFX8bX1Y/mjcQCF3AOCFDH6J3zGtwjDHHz57uXJ+SAQBvio1eblby8+umPc
        nWqjHs2NOGJhKtZ0VDcD9yS8+u6U0Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-9KjLBBToNRGaLv5l7aAqmQ-1; Mon, 18 Jan 2021 00:32:39 -0500
X-MC-Unique: 9KjLBBToNRGaLv5l7aAqmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6CC7107ACF9;
        Mon, 18 Jan 2021 05:32:38 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D16B71CA0;
        Mon, 18 Jan 2021 05:32:32 +0000 (UTC)
Subject: Re: [PATCH V2] mlx5: vdpa: fix possible uninitialized var
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
References: <20210114070904.9981-1-jasowang@redhat.com>
 <20210117052810-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9184ab89-2d64-7f5f-6e16-2f572cc192bc@redhat.com>
Date:   Mon, 18 Jan 2021 13:32:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210117052810-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/17 下午6:30, Michael S. Tsirkin wrote:
> On Thu, Jan 14, 2021 at 03:09:04PM +0800, Jason Wang wrote:
>> When compiling with -Werror=maybe-uninitialized, gcc may complains the
>> possible uninitialized umem. Since the callers won't pass value other
>> than 1 to 3, making 3 as default to fix the compiler warning.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Of course if it's actually something else this is not DTRT ...


It breaks some donw stream build (which mandates 
-Werror=maybe-uninitialized)


> As long as we worry about this warning, let's have defence in depth:
>    	case 3:
>    		umem = &mvq->umem3;
>    		break;
>   +	default:
>   +		umem = NULL;
>   +              BUG();
>   +		break;


Checkpatch doesn't like this:

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code 
rather than BUG() or BUG_ON()
#20: FILE: drivers/vdpa/mlx5/net/mlx5_vnet.c:695:
+        BUG();

But if you stick, I can go this way.

Thanks


>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index f1d54814db97..07ccc61cd6f6 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -703,7 +703,7 @@ static void umem_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
>>   	case 2:
>>   		umem = &mvq->umem2;
>>   		break;
>> -	case 3:
>> +	default:
>>   		umem = &mvq->umem3;
>>   		break;
>>   	}
>> -- 
>> 2.25.1

