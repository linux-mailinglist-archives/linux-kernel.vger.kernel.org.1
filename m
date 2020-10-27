Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7218A29A76C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895445AbgJ0JKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409057AbgJ0JKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603789848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7NxN+I+syqbzG1V104q5VuskMuq+vggAGJ9GCoeDg8=;
        b=VaVEfgDKhR14GvzIEZx7HxBU2aMfbvxJP9T2WTc1Ra0mobSMyettvm/5Cb/9uZ7z0ZVDWp
        Dh4ezpk75RJYVa6ZpK/rp9mfEmDpvpXFdBluQPhc/L+2LlqcHywbNRmop10pPb3fvyC81o
        jW+pIRqYf290Zv+/bKqB+97gxmmT2y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-oTfVcj5LM9aJ9bkOmwGX8g-1; Tue, 27 Oct 2020 05:10:44 -0400
X-MC-Unique: oTfVcj5LM9aJ9bkOmwGX8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB9D71009E2D;
        Tue, 27 Oct 2020 09:10:42 +0000 (UTC)
Received: from [10.36.113.185] (ovpn-113-185.ams2.redhat.com [10.36.113.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3140460FC2;
        Tue, 27 Oct 2020 09:10:41 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm, page_alloc: reduce static keys in prep_new_page()
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-4-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <93ab79df-cf8c-294b-3ed1-8a563e4a452b@redhat.com>
Date:   Tue, 27 Oct 2020 10:10:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201026173358.14704-4-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.20 18:33, Vlastimil Babka wrote:
> prep_new_page() will always zero a new page (regardless of __GFP_ZERO) when
> init_on_alloc is enabled, but will also always skip zeroing if the page was
> already zeroed on free by init_on_free or page poisoning.
> 
> The latter check implemented by free_pages_prezeroed() can involve two
> different static keys. As prep_new_page() is really a hot path, let's introduce
> a single static key free_pages_not_prezeroed for this purpose and initialize it
> in init_mem_debugging().

Is this actually observable in practice? This smells like 
micro-optimization to me.

Also, I thought the whole reason for static keys is to have basically no 
overhead at runtime, so I wonder if replacing two static key checks by a 
single one actually makes *some* difference.

-- 
Thanks,

David / dhildenb

