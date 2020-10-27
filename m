Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D429A73C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895280AbgJ0JDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408143AbgJ0JDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603789422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLp0SICM2nVdk9br36TAZIwlI3d3VRJtmlACPi0OKps=;
        b=NhkMr4W9xwqricLS3nssGdQjNePnzoBDRc8VhgpbstrmJ6Il1AHtgeOpBoPMyhEI+uDPIx
        9JLLYIiQFlxFMxO/J7GxzoGT9S1sndvtgdcq1JhVAocu6kZ2x8Fg44SkKMP9daGFqWgY1b
        fBcMgsxecc89+DBO2hh4yszmi8SJikY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-goJxFZZANjuGc-pKuwiwLw-1; Tue, 27 Oct 2020 05:03:38 -0400
X-MC-Unique: goJxFZZANjuGc-pKuwiwLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3E1100854A;
        Tue, 27 Oct 2020 09:03:36 +0000 (UTC)
Received: from [10.36.113.185] (ovpn-113-185.ams2.redhat.com [10.36.113.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12B7F55772;
        Tue, 27 Oct 2020 09:03:34 +0000 (UTC)
Subject: Re: [PATCH 1/3] mm, page_alloc: do not rely on the order of
 page_poison and init_on_alloc/free parameters
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-2-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3784dac7-49cb-006b-7b9d-1244d5c59935@redhat.com>
Date:   Tue, 27 Oct 2020 10:03:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201026173358.14704-2-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.20 18:33, Vlastimil Babka wrote:
> Enabling page_poison=1 together with init_on_alloc=1 or init_on_free=1 produces
> a warning in dmesg that page_poison takes precendence. However, as these
> warnings are printed in early_param handlers for init_on_alloc/free, they are
> not printed if page_poison is enabled later on the command line (handlers are
> called in the order of their parameters), or when init_on_alloc/free is always
> enabled by the respective config option - before the page_poison early param
> handler is called, it is not considered to be enabled. This is inconsistent.
> 
> We can remove the dependency on order by making the init_on_* parameters only
> set a boolean variable, and postponing the evaluation after all early params
> have been processed. Introduce a new init_mem_debugging() function for that,
> and move the related debug_pagealloc processing there as well.

init_mem_debugging() is somewhat sub-optimal - init_on_alloc=1 or 
init_on_free=1 are rather security hardening mechanisms.

... I wondered if this could be the place to initialize any kind of mm 
parameters in the future. Like init_mem_params() or so.

> 
> As a result init_mem_debugging() knows always accurately if init_on_* and/or
> page_poison options were enabled. Thus we can also optimize want_init_on_alloc()
> and want_init_on_free(). We don't need to check page_poisoning_enabled() there,
> we can instead not enable the init_on_* tracepoint at all, if page poisoning is
> enabled. This results in a simpler and more effective code.

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

