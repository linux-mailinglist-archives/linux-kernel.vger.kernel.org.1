Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04E02A2820
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgKBKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbgKBKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604312498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Lf6wlb3PZFzHMyIied7N5VXmSAujDTv239rqbCDPtM=;
        b=FiI3wsgMBJCmUGmmp/tZiPlhYiRbb6cR9d8X/QBiBfU1lM2gQIAKMMDXOQf0S30FG1rEfL
        XhgibQjADI2di1gMDza3AreR85RbKvs778OdoOPgNTjRT7XY5fvrAtsF1aHwWKYuWVsu6f
        CsdpQbrpztrOlwxFhZOzHBd4KvNY8Co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-LdZU5nPQNruc30dhsHe5tg-1; Mon, 02 Nov 2020 05:21:36 -0500
X-MC-Unique: LdZU5nPQNruc30dhsHe5tg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A9458030DC;
        Mon,  2 Nov 2020 10:21:35 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96BCB6EF79;
        Mon,  2 Nov 2020 10:21:33 +0000 (UTC)
Subject: Re: [PATCH] mm/zswap: Fix passing zero to 'PTR_ERR' warning
To:     YueHaibing <yuehaibing@huawei.com>, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201031055615.28080-1-yuehaibing@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6926f3a4-05df-70a6-7a56-4405e10cb9f3@redhat.com>
Date:   Mon, 2 Nov 2020 11:21:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201031055615.28080-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.20 06:56, YueHaibing wrote:
> Fix smatch warning:
> 
> mm/zswap.c:425 zswap_cpu_comp_prepare() warn: passing zero to 'PTR_ERR'
> 
> crypto_alloc_comp() never return NULL, use IS_ERR
> instead of IS_ERR_OR_NULL to fix this.
> 
> Fixes: f1c54846ee45 ("zswap: dynamic pool creation")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   mm/zswap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 1eced701b3bd..55a2f72557a8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -421,7 +421,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>   		return 0;
>   
>   	tfm = crypto_alloc_comp(pool->tfm_name, 0, 0);
> -	if (IS_ERR_OR_NULL(tfm)) {
> +	if (IS_ERR(tfm)) {
>   		pr_err("could not alloc crypto comp %s : %ld\n",
>   		       pool->tfm_name, PTR_ERR(tfm));
>   		return -ENOMEM;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

