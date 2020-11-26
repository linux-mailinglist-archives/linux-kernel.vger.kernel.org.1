Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A532C5CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405303AbgKZTrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:47:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:54380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZTrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:47:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E852BACEB;
        Thu, 26 Nov 2020 19:47:19 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm,thp,shmem: make khugepaged obey tmpfs mount flags
To:     Rik van Riel <riel@surriel.com>, hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
References: <20201124194925.623931-1-riel@surriel.com>
 <20201124194925.623931-4-riel@surriel.com>
 <eda496c8-e248-c8fe-e7bd-f7e71d20e499@suse.cz>
 <8f2428a049f2c29f092782699bcb3af76bf72b6a.camel@surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc08c0b4-84b3-5aa0-4c96-03f3767eec56@suse.cz>
Date:   Thu, 26 Nov 2020 20:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8f2428a049f2c29f092782699bcb3af76bf72b6a.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/20 7:14 PM, Rik van Riel wrote:
> On Thu, 2020-11-26 at 18:18 +0100, Vlastimil Babka wrote:
>> On 11/24/20 8:49 PM, Rik van Riel wrote:
>>> Currently if thp enabled=[madvise], mounting a tmpfs filesystem
>>> with huge=always and mmapping files from that tmpfs does not
>>> result in khugepaged collapsing those mappings, despite the
>>> mount flag indicating that it should.
>>>
>>> Fix that by breaking up the blocks of tests in hugepage_vma_check
>>> a little bit, and testing things in the correct order.
>>>
>>> Signed-off-by: Rik van Riel <riel@surriel.com>
>>> Fixes: c2231020ea7b ("mm: thp: register mm for khugepaged when
>>> merging vma for shmem")
>>
>> Looks ok. But, it we have sysfs thp enabled=never, and shmem mount
>> explicitly 
>> thp enabled, then shmem mount overrides the global sysfs setting and
>> thp's will 
>> be allocated there, right? However, khugepaged_enabled() will be
>> false and thus 
>> khugepaged won't run at all? So a similar situation than what you're
>> fixing here.
> 
> Indeed, that is somewhat similar. Whether or not shmem
> allocations attempt huge pages is controlled by both
> the file /sys/kernel/mm/transparent_hugepage/shmem_enabled

Ah right, there's also that sysfs file.

> and mount options.
> 
> This patch makes khugepaged treat the mount options
> and/or
> sysfs flag as enabling collapsing of huge pages in case
> enabled = [always] for regular THPs.
> 
> Should I send another patch on top
> of this that causes
> khugepaged to be enabled when regular THPs are disabled,
> but shmem THPs are enabled in any way?

I think it would make sense. Although it might involve counting
thp-enabled shmem mounts and only run khugepaged when there are >0 of them.
