Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE912A31AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKBRfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727227AbgKBRfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604338518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSe5mZ8XO1w2rEfMWtfgOM0vprGVIF0or7um/1zv7Ts=;
        b=iG24LG5aEeh1OhmTnr06Lvb4s2bktRpGlyzbDi3/DH8S1B85oVbCN2XxYFiPBeydrhssZn
        c+98qcbuK9pQIIk82HlJVXUNSFKKs2P9NGshU9uppi5GT6brpAdx7vnxeLV5rSdU5/hvhP
        35S4AjNIMH3k8CiJck0ja3miWHfIrkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Y1uEIelZOPSzB_adJbCRcA-1; Mon, 02 Nov 2020 12:35:14 -0500
X-MC-Unique: Y1uEIelZOPSzB_adJbCRcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 927A857204;
        Mon,  2 Nov 2020 17:35:11 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1B9A1002C18;
        Mon,  2 Nov 2020 17:35:08 +0000 (UTC)
Subject: Re: [PATCH 0/2] Increasing CMA Utilization with a GFP Flag
To:     Matthew Wilcox <willy@infradead.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1604282969.git.cgoldswo@codeaurora.org>
 <20201102144449.GM27442@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3675d394-371c-cff6-ca3e-2e11d0e80642@redhat.com>
Date:   Mon, 2 Nov 2020 18:35:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201102144449.GM27442@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.20 15:44, Matthew Wilcox wrote:
> On Mon, Nov 02, 2020 at 06:39:20AM -0800, Chris Goldsworthy wrote:
>> The current approach to increasing CMA utilization introduced in
>> commit 16867664936e ("mm,page_alloc,cma: conditionally prefer cma
>> pageblocks for movable allocations") increases CMA utilization by
>> redirecting MIGRATE_MOVABLE allocations to a CMA region, when
>> greater than half of the free pages in a given zone are CMA pages.
>> The issue in this approach is that allocations with type
>> MIGRATE_MOVABLE can still succumb to pinning. To get around
>> this, one approach is to re-direct allocations to the CMA areas, that
>> are known not to be victims of pinning.
>>
>> To this end, this series brings in __GFP_CMA, which we mark with
>> allocations that we know are safe to be redirected to a CMA area.
> 
> This feels backwards to me.  What you're essentially saying is "Some
> allocations marked with GFP_MOVABLE turn out not to be movable, so we're
> going to add another GFP_REALLY_MOVABLE flag" instead of tracking down
> which GFP_MOVABLE allocations aren't really movable.

Right, this just sounds wrong. We have the exact same issues with 
long-term pinnings on ZONE_MOVABLE. We have known issues with short-term 
pinnings and movable allocations (e.g., when a process dies) that should 
be tackled instead.

This is just trying to work around the original issue.

Nacked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

