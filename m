Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE1290049
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405245AbgJPI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404372AbgJPI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602838665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yajcjuZ6uO56PGYXi5xPi6C1F2lWsOwbXSJhWt9V0A8=;
        b=QXUy5gijWNFu/5BFZTfaFV4aNXoGe0IcuL2ZdnDJrM5QpAiH5yMsF/dJVNqc8FB7cawNRU
        13EviqpajAGRbJpo8GSg5CvoNXppHf/yDUOMtg6nxBrx0+s4SDgA0LcBKHzkUm1K9uBOCs
        qdcVquQmv+JWSfxTQPBcbXv3mCzxwcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-FPbhpK8fPrK86akRRhCSSQ-1; Fri, 16 Oct 2020 04:57:42 -0400
X-MC-Unique: FPbhpK8fPrK86akRRhCSSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13CCA835B73;
        Fri, 16 Oct 2020 08:57:41 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B32276649;
        Fri, 16 Oct 2020 08:57:36 +0000 (UTC)
Subject: Re: [PATCH v1 13/29] virtio-mem: factor out handling of fake-offline
 pages in memory notifier
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-14-david@redhat.com>
 <20201016071502.GM86495@L-31X9LVDL-1304.local>
 <20201016080046.GA43862@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <17ca9bd8-bdc6-541c-b8f9-4076cb9a7322@redhat.com>
Date:   Fri, 16 Oct 2020 10:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016080046.GA43862@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do we adjust the count twice?
>>
> 
> Ah, I got the reason why we need to adjust count for *unplugged* sub-blocks.

Exactly.

> 
>>> -		for (i = 0; i < nr_pages; i++) {
>>> -			page = pfn_to_page(pfn + i);
>>> -			if (WARN_ON(!page_ref_dec_and_test(page)))
> 
> Another question is when we grab a refcount for the unpluged pages? The one
> you mentioned in virtio_mem_set_fake_offline().

Yeah, that was confusing on my side. I actually meant
virtio_mem_fake_offline() - patch #12.

We have a reference on unplugged (fake offline) blocks via

1. memmap initialization, if never online via generic_online_page()

So if we keep pages fake offline when onlining memory, they

a) Have a refcount of 1
b) Have *not* increased the managed page count

2. alloc_contig_range(), if fake offlined. After we fake-offlined pages
(e.g., patch #12), such pages

a) Have a refcount of 1
b) Have *not* increased the managed page count (because we manually
decreased it)


-- 
Thanks,

David / dhildenb

