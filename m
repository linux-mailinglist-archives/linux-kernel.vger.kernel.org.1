Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C599C2F2670
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbhALCza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728044AbhALCza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610420043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBNIZoVEFYnZolBPXDxQvsKxura8sTWXxEYo+kfOlYs=;
        b=cFXmGcYHNd0t2am0TZqWM+DQwdlLteKst4A3LNRpecda3PWWh+faEsix2j/a8Y2Xg1P9Hn
        OZZl/r+JaB4TXZSuAtx/cPZ4eg9rr2annuqcgr9pPXlAPCiUhWb9pKP0e6bUvULIdbAh1u
        nY2vaaqHzHIPsX/8sIpR2XUpRLy09C8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-NeFrT79jM9uRKsLdnRlk2A-1; Mon, 11 Jan 2021 21:54:02 -0500
X-MC-Unique: NeFrT79jM9uRKsLdnRlk2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DAF0107ACF8;
        Tue, 12 Jan 2021 02:54:01 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3E094F3C6;
        Tue, 12 Jan 2021 02:53:56 +0000 (UTC)
Subject: Re: [PATCH] mlx5: vdpa: fix possible uninitialized var
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210108082443.5609-1-jasowang@redhat.com>
 <20210110063955.GA115874@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ae775c12-65d1-6623-be54-8d9e9be08fd0@redhat.com>
Date:   Tue, 12 Jan 2021 10:53:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210110063955.GA115874@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/10 下午2:39, Eli Cohen wrote:
> On Fri, Jan 08, 2021 at 04:24:43PM +0800, Jason Wang wrote:
>> Upstream: posted
>>
>> When compiling with -Werror=maybe-uninitialized, gcc may complains the
>> possible uninitialized umem. Fix that.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index f1d54814db97..a6ad83d8d8e2 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -706,6 +706,9 @@ static void umem_destroy(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
>>   	case 3:
>>   		umem = &mvq->umem3;
>>   		break;
>> +	default:
>> +		WARN(1, "unsupported umem num %d\n", num);
>> +		return;
>>   	}
>>   
>>   	MLX5_SET(destroy_umem_in, in, opcode, MLX5_CMD_OP_DESTROY_UMEM);
> Since the "default" case will never be executed, maybe it's better to
> just change "case 3:" to "default:" and avoid the WARN().


Fine with me. Will do that in V3.

Thanks


>
>> -- 
>> 2.25.1
>>

