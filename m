Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA41819CD5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 01:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgDBXOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 19:14:51 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41550 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731783AbgDBXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:14:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TuS6Uln_1585869285;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TuS6Uln_1585869285)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Apr 2020 07:14:48 +0800
Subject: Re: [PATCH] mm: thp: don't need drain lru cache when splitting and
 mlocking THP
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200402230411.7ckwkmd6wwtqfkm2@ca-dmjordan1.us.oracle.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6cca9634-02c6-03fc-eeb2-9a4d54441ee1@linux.alibaba.com>
Date:   Thu, 2 Apr 2020 16:14:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200402230411.7ckwkmd6wwtqfkm2@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 4:04 PM, Daniel Jordan wrote:
> On Sat, Mar 28, 2020 at 03:29:40AM +0800, Yang Shi wrote:
>> Since the commit 8f182270dfec ("mm/swap.c: flush lru pvecs on compound
>> page arrival") THP would not stay in pagevec anymore.  So the
>> optimization made by commit d965432234db ("thp: increase
>> split_huge_page() success rate") doesn't make sense anymore, which tries
>> to unpin munlocked THPs from pagevec by draining pagevec.
>>
>> And draining lru cache before isolating THP in mlock path is unnecessary
>> either.
> Can we get some of that nice history in this part too?
>
> Draining lru cache before isolating THP in mlock path is also unnecessary.
> b676b293fb48 ("mm, thp: fix mapped pages avoiding unevictable list on mlock")
> added it and 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge
> pages") accidentally carried it over after the above optimization went in.

Thanks for finding out this, I didn't dig that far. Will add it into v2.

>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Since we don't mlock pte-mapped THP, it seems these huge pages wouldn't ever be
> in the pagevecs if I'm understanding it all.

Yes, it is correct.

>
> Saves lines and some amount of overhead and lru contention, so looks good.
>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thanks.

