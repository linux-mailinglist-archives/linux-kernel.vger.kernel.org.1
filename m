Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07D12854A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgJFWek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:34:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:34200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbgJFWek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:34:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB32BAC5F;
        Tue,  6 Oct 2020 22:34:38 +0000 (UTC)
Subject: Re: [PATCH 6/9] mm, page_alloc: cache pageset high and batch in
 struct zone
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-7-vbabka@suse.cz>
 <20201005132830.GB4555@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <017450b3-21b1-a6a0-adea-b0b4fa1870d3@suse.cz>
Date:   Wed, 7 Oct 2020 00:34:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005132830.GB4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 3:28 PM, Michal Hocko wrote:
> On Tue 22-09-20 16:37:09, Vlastimil Babka wrote:
>> All per-cpu pagesets for a zone use the same high and batch values, that are
>> duplicated there just for performance (locality) reasons. This patch adds the
>> same variables also to struct zone as a shared copy.
>> 
>> This will be useful later for making possible to disable pcplists temporarily
>> by setting high value to 0, while remembering the values for restoring them
>> later. But we can also immediately benefit from not updating pagesets of all
>> possible cpus in case the newly recalculated values (after sysctl change or
>> memory online/offline) are actually unchanged from the previous ones.
> 
> Advantage of this patch is not really clear from it in isolation. Maybe
> merge it with the patch which uses the duplicated state.

I'm not sure that would help its reviewability? As the patch that uses it is the 
last, largest one. And there is already a small advantage right away as 
changelog explains.
