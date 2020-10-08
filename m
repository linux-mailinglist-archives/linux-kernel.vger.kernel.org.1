Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908DC28749D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgJHM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:56:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbgJHM4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:56:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB678B00A;
        Thu,  8 Oct 2020 12:56:13 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] mm, page_alloc: remove setup_pageset()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-4-vbabka@suse.cz>
 <20201008122309.GB4967@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a6d39f3b-3dea-3b97-018a-a53f07155d39@suse.cz>
Date:   Thu, 8 Oct 2020 14:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008122309.GB4967@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 2:23 PM, Michal Hocko wrote:
> On Thu 08-10-20 13:41:57, Vlastimil Babka wrote:
>> We initialize boot-time pagesets with setup_pageset(), which sets high and
>> batch values that effectively disable pcplists.
>> 
>> We can remove this wrapper if we just set these values for all pagesets in
>> pageset_init(). Non-boot pagesets then subsequently update them to the proper
>> values.
>> 
>> No functional change.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> Btw. where do we initialize pcp->count? I thought that pcp allocator
> zeroes out the allocated memory but alloc_percpu is GFP_KERNEL like.

pageset_init() does:
memset(p, 0, sizeof(*p))

