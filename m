Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA22D5281
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgLJEEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:04:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731933AbgLJEEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607572999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ep/ZiwecWipeqk42V6c9PjyxWhVrZXaXr/UgV2fCnYY=;
        b=jUrAtZ1CPjriXmQQqEYE0LTNunMmk/UqBewk/0DPiiQYOJrNalv1kM0qiyo2gj0bd0fSie
        2pm5WgO/Tpq+2WkuZoLK6oAvTYUGRHI/BxkU0ZBbdg7FqEBIVUiwv5QNERA5F+12iOIff3
        5N/kIA/wMUx36u2D52rhU5cht7balcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-3ir88J8zN1aW0_fCiv20MQ-1; Wed, 09 Dec 2020 23:03:15 -0500
X-MC-Unique: 3ir88J8zN1aW0_fCiv20MQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18F32107ACF6;
        Thu, 10 Dec 2020 04:03:14 +0000 (UTC)
Received: from [10.72.13.187] (ovpn-13-187.pek2.redhat.com [10.72.13.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C52E75D6A1;
        Thu, 10 Dec 2020 04:03:04 +0000 (UTC)
Subject: Re: [PATCH v3 05/19] vdpa_sim: remove the limit of IOTLB entries
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-6-sgarzare@redhat.com>
 <d7b00b70-9785-db1f-1e42-7b9172b7ad90@redhat.com>
 <20201209105829.6l6ie7xqp2eycds6@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0333484d-7fa1-fc88-7e22-14492e994b72@redhat.com>
Date:   Thu, 10 Dec 2020 12:03:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209105829.6l6ie7xqp2eycds6@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/9 下午6:58, Stefano Garzarella wrote:
> On Mon, Dec 07, 2020 at 12:00:07PM +0800, Jason Wang wrote:
>>
>> On 2020/12/4 上午1:04, Stefano Garzarella wrote:
>>> The simulated devices can support multiple queues, so this limit
>>> should be defined according to the number of queues supported by
>>> the device.
>>>
>>> Since we are in a simulator, let's simply remove that limit.
>>>
>>> Suggested-by: Jason Wang <jasowang@redhat.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>>
>> Rethink about this, since simulator can be used by VM, so the 
>> allocation is actually guest trigger-able when vIOMMU is enabled.
>>
>> This means we need a limit somehow, (e.g I remember swiotlb is about 
>> 64MB by default). Or having a module parameter for this.
>>
>> Btw, have you met any issue when using 2048, I guess it can happen 
>> when we run several processes in parallel?
>>
>
> No, I didn't try with the limit.
> This came from the reviews to Max's patches.
>
> Anyway I can add a module parameter to control that limit, do you 
> think is better to set a limit per queue (the parameter per number of 
> queues), or just a value for the entire device?


Per-device should be ok.

Thanks


>
> Thanks,
> Stefano
>

