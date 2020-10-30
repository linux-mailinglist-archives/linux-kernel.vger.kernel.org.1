Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296232A0477
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgJ3Lja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726095AbgJ3Lja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604057969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8q8fsEl6aD3OUT59S4M1cT9k1uGFu1YWNQAqZku11GA=;
        b=Vp9KS6V/oNEJt4ZCkeTREcOdL5Z+pMKYV5fapp3N7Rd48tEeCxLPAVQ7np17IQQZgZweXn
        HmI3E4lu09oRYiNXHxGw/utP90WJWqQyunPyl2R8cziQYAAf3wcXrx/vp1WIAplt9UEQDz
        nQfTGcx5M0+hJzeYYXr5RyPpsY95xyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-An6ty-GhPqyi6UaSVuzpcw-1; Fri, 30 Oct 2020 07:39:25 -0400
X-MC-Unique: An6ty-GhPqyi6UaSVuzpcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0D3C803651;
        Fri, 30 Oct 2020 11:39:23 +0000 (UTC)
Received: from [10.36.112.97] (ovpn-112-97.ams2.redhat.com [10.36.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CED1F6198B;
        Fri, 30 Oct 2020 11:39:22 +0000 (UTC)
Subject: Re: [PATCH -next] mm, page_alloc: Fix old-style function definition
To:     Zou Wei <zou_wei@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1603870368-104763-1-git-send-email-zou_wei@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <79d7b9ee-6e0a-182c-bb44-d00382c2d5d0@redhat.com>
Date:   Fri, 30 Oct 2020 12:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1603870368-104763-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.20 08:32, Zou Wei wrote:
> Fix warning:
> 
> mm/page_alloc.c:763:6: warning: old-style function definition [-Wold-style-definition]
>   void init_mem_debugging()
>        ^~~~~~~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f80dc59..470b18d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -760,7 +760,7 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>    * order of appearance. So we need to first gather the full picture of what was
>    * enabled, and then make decisions.
>    */
> -void init_mem_debugging()
> +void init_mem_debugging(void)
>   {
>   	if (_init_on_alloc_enabled_early) {
>   		if (page_poisoning_enabled()) {
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

