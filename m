Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0A274EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIWB5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:57:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36618 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgIWB5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:57:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U9oxugE_1600826244;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9oxugE_1600826244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Sep 2020 09:57:28 +0800
Subject: Re: [PATCH v18 22/32] mm/vmscan: use relock for move_pages_to_lru
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-23-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2009212240370.6434@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <45164ea9-d4bb-4c31-6d8d-9c6342e5ea50@linux.alibaba.com>
Date:   Wed, 23 Sep 2020 09:55:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009212240370.6434@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2020/9/22 ����1:44, Hugh Dickins д��:
> On Mon, 24 Aug 2020, Alex Shi wrote:
> 
>> From: Hugh Dickins <hughd@google.com>
>>
>> Use the relock function to replace relocking action. And try to save few
>> lock times.
>>
>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> NAK. Who wrote this rubbish? Oh, did I? Maybe something you extracted
> from my tarball. No, we don't need any of this now, as explained when
> going through 20/32.
> 

removed in lruv19.5

Thanks!
