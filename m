Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1422F1B54
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbhAKQqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:46:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731405AbhAKQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610383497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfWDa25Akh5OH/pweDQ3fJnM+dfnZCEUX8OjvCsiZ/E=;
        b=ShQGl5jodYGJeRsMs7ebxBQtCyErrTMUCbHIePw/N6xnEkQ7HtL4D/iSaC03mdzD9HARx1
        PGpFyFy8QX5RO82u19BtUFhNu2nl10fqIGPUaDi7BYxnbQNXxdf3RRNq+eP6YaZdgbyA0X
        wYVkUYqn3xKwuX59cjWxkyDL09aSAWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ULda1Ar_Pm688wQ0kVuMcw-1; Mon, 11 Jan 2021 11:44:55 -0500
X-MC-Unique: ULda1Ar_Pm688wQ0kVuMcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7C711823E41;
        Mon, 11 Jan 2021 16:44:53 +0000 (UTC)
Received: from [10.36.115.103] (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 815EC60C6E;
        Mon, 11 Jan 2021 16:44:51 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: Remove duplicated VM_BUG_ON_PAGE
 !PageLocked
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210109081420.46030-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c51ae9e1-2e15-cfa7-43b2-a558867573cf@redhat.com>
Date:   Mon, 11 Jan 2021 17:44:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210109081420.46030-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.21 09:14, Miaohe Lin wrote:
> The VM_BUG_ON_PAGE(!PageLocked(page), page) is also done in PageMovable.
> Remove this explicitly one.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/compaction.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 02af220fb992..6d316eb99913 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -137,7 +137,6 @@ EXPORT_SYMBOL(__SetPageMovable);
>  
>  void __ClearPageMovable(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	VM_BUG_ON_PAGE(!PageMovable(page), page);
>  	/*
>  	 * Clear registered address_space val with keeping PAGE_MAPPING_MOVABLE
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

