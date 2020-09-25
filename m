Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC797278358
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgIYIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:55:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:32826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYIzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:55:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C234ACB5;
        Fri, 25 Sep 2020 08:55:40 +0000 (UTC)
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Joonsoo Kim <js1304@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
 <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz>
 <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
 <20200827133523.GC3090@techsingularity.net>
 <CAAmzW4PTgbVzf1dkvnzpHpYYTbLyeNM=OzywUBvkFw9rUhtR4w@mail.gmail.com>
 <CAAmzW4NabiAc+Nh=jtg9fUZTodQHHjf=mFTn=w32AJ43L9o2Aw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d587d057-75f1-288e-49d2-0c6ea387d414@suse.cz>
Date:   Fri, 25 Sep 2020 10:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4NabiAc+Nh=jtg9fUZTodQHHjf=mFTn=w32AJ43L9o2Aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 6:59 AM, Joonsoo Kim wrote:
> 2020년 8월 28일 (금) 오전 8:54, Joonsoo Kim <js1304@gmail.com>님이 작성:
> 
> Hello, Andrew and Vlastimil.
> 
> It's better to fix this possible bug introduced in v5.9-rc1 before
> v5.9 is released.
> Which approach do you prefer?
> If it is determined, I will immediately send a patch as you suggested.

Hmm both Mel and I preferred the bypass approach and nobody else weighted in, so
if you don't mind, you can use my suggestion. Hmm maybe alloc_flags & ALLOC_CMA
check should precede migratetype check in the if () to optimize for userspace
allocations?

Thanks,
Vlastimil

> Thanks.
> 

