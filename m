Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE986291767
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgJRMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 08:37:37 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48886 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgJRMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 08:37:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UCMVb5V_1603024653;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCMVb5V_1603024653)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Oct 2020 20:37:34 +0800
Date:   Sun, 18 Oct 2020 20:37:33 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 13/29] virtio-mem: factor out handling of fake-offline
 pages in memory notifier
Message-ID: <20201018123733.GC50506@L-31X9LVDL-1304>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-14-david@redhat.com>
 <20201016071502.GM86495@L-31X9LVDL-1304.local>
 <20201016080046.GA43862@L-31X9LVDL-1304.local>
 <17ca9bd8-bdc6-541c-b8f9-4076cb9a7322@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ca9bd8-bdc6-541c-b8f9-4076cb9a7322@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 10:57:35AM +0200, David Hildenbrand wrote:
>>> Do we adjust the count twice?
>>>
>> 
>> Ah, I got the reason why we need to adjust count for *unplugged* sub-blocks.
>
>Exactly.
>
>> 
>>>> -		for (i = 0; i < nr_pages; i++) {
>>>> -			page = pfn_to_page(pfn + i);
>>>> -			if (WARN_ON(!page_ref_dec_and_test(page)))
>> 
>> Another question is when we grab a refcount for the unpluged pages? The one
>> you mentioned in virtio_mem_set_fake_offline().
>
>Yeah, that was confusing on my side. I actually meant
>virtio_mem_fake_offline() - patch #12.
>
>We have a reference on unplugged (fake offline) blocks via
>
>1. memmap initialization, if never online via generic_online_page()
>
>So if we keep pages fake offline when onlining memory, they
>
>a) Have a refcount of 1
>b) Have *not* increased the managed page count
>
>2. alloc_contig_range(), if fake offlined. After we fake-offlined pages
>(e.g., patch #12), such pages
>
>a) Have a refcount of 1
>b) Have *not* increased the managed page count (because we manually
>decreased it)
>

Yep, I got the reason now.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
