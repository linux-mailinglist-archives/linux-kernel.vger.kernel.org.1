Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353DF2C2847
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgKXNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:39:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbgKXNjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:39:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58507AD1E;
        Tue, 24 Nov 2020 13:39:43 +0000 (UTC)
To:     Charan Teja Kalla <charante@codeaurora.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
References: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
 <20201123141354.GQ27488@dhcp22.suse.cz>
 <bfa430f6-a6a6-8b08-2776-cb62197619c0@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: memory_hotplug: put migration failure information
 under DEBUG_VM
Message-ID: <775a56a9-b301-31bb-cd6d-8b82b1dd4d65@suse.cz>
Date:   Tue, 24 Nov 2020 14:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <bfa430f6-a6a6-8b08-2776-cb62197619c0@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 4:10 PM, Charan Teja Kalla wrote:
> 
> Thanks Michal!
> On 11/23/2020 7:43 PM, Michal Hocko wrote:
>> On Mon 23-11-20 19:33:16, Charan Teja Reddy wrote:
>>> When the pages are failed to get isolate or migrate, the page owner
>>> information along with page info is dumped. If there are continuous
>>> failures in migration(say page is pinned) or isolation, the log buffer
>>> is simply getting flooded with the page owner information. As most of
>>> the times page info is sufficient to know the causes for failures of
>>> migration or isolation, place the page owner information under DEBUG_VM.
>> 
>> I do not see why this path is any different from others that call
>> dump_page. Page owner can add a very valuable information to debug
>> the underlying reasons for failures here. It is an opt-in debugging
>> feature which needs to be enabled explicitly. So I would argue users
>> are ready to accept a lot of data in the kernel log.
> 
> Just thinking how frequently failures can happen in those paths. In the
> memory hotplug path, we can flood the page owner logs just by making one
> page pinned. Say If it is anonymous page, the page owner information

So you say it's flooded when page_owner info is included, but not 
flooded when only the rest of __dump_page() is printed? (which is also 
not just one or two lines). That has to be very specific rate of failures.
Anyway I don't like the solution with arbitrary config option. To 
prevent flooding we generally have ratelimiting, how about that?

Also agreed with Michal that page_owner is explicitly enabled debugging 
option and if you use it in production, that's rather surprising to me, 
and possibly more rare than DEBUG_VM, which IIRC Fedora kernels use.
