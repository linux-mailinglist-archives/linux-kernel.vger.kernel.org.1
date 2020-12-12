Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921B62D833E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437624AbgLLAIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:08:30 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2087 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437470AbgLLAH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:07:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd409b60000>; Fri, 11 Dec 2020 16:07:18 -0800
Received: from [10.2.58.108] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 12 Dec
 2020 00:07:09 +0000
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Sasha Levin" <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>, <mike.kravetz@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>
References: <CA+CK2bCc9gk3Yy+ueaZVJs90MFE3fqukLsdb5R2kTUH4tWRbkA@mail.gmail.com>
 <447A41F3-EB94-4DA4-8B98-038B127774A5@redhat.com>
 <CA+CK2bAok_0Q+AovxVYqtsObVbbxr+ZZcTgP76uxEvDy-uJWsQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9c201f8c-6266-ed03-e419-12edd8148fdb@nvidia.com>
Date:   Fri, 11 Dec 2020 16:07:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bAok_0Q+AovxVYqtsObVbbxr+ZZcTgP76uxEvDy-uJWsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607731638; bh=GE26nCzQ9HfpnpJ/4kq8ZcBVZOfOrwVSu+Matl1W4V0=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=hnjxYUKJZY/IWx8fOrko9qKAIHQ0lvPgjIe708zMbhQ6DNTfpnzpmlWTt4TFi+OqI
         /RbazPTJrJQWAAKMicUsQipszn5aj1fjHGUnAvfxMbW4D+7GDZbmvKuV4Q5EV9ne8Z
         krbF7LtVNO9bHbo77xY4AH77SzliappiRIxnAfwp77lpA0axIpo2+8uEYQyatuvCwC
         SAf0PNLh0OHqGujN6DbP1boYVxOKfwNWRBhYHRze9xE5sarVU1w91K/FCOfklEMyYh
         YAklh8SSjyngvzKoyizVo/TD1Jlct4F3UcWXvXSFCJ2Zkai9VEDXpFz9eVEFVzkzIp
         4wjv2KxnqmZcw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 3:00 PM, Pavel Tatashin wrote:
>> I guess revert what we did (unpin) and return an error. The interesting question is what can make migration/isolation fail
> 
> OK. I will make the necessary changes. Let's handle errors properly.
> Whatever the cause for the error, we will know it when it happens, and
> when error is returned. I think I will add a 10-time retry instead of
> the infinite retry that we currently have. The 10-times retry we
> currently have during the hot-remove path.

It occurs to me that maybe the pre-existing infinite loop shouldn't be
there at all? Would it be better to let the callers retry? Obviously that
would be a separate patch and I'm not sure it's safe to make that change,
but the current loop seems buried maybe too far down.

Thoughts, anyone?

thanks,
-- 
John Hubbard
NVIDIA
