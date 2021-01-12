Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4157C2F331A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbhALOmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbhALOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610462470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJLhS6MrRmYcBy2q5fslcQ3ZrLD7BMqvtBIQ18v75Yw=;
        b=dsOKy89M+eeICuN4Eze+O7DH5bF/FxYkat+9UzzpfWViyPgIwx4b9XAuaBd0aK0dFMTcrZ
        LSjBrl2AnKK/km6U1RfMd29kF3tOcsi9aJX28RWcQt3G1rjSyFfuZmIC6R1GmMUL+Jl11V
        CfSMlMj6YgQad36Zn4TK+aKy67o6NgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-b5tYlFyEN-6aTyXFKNVihA-1; Tue, 12 Jan 2021 09:41:06 -0500
X-MC-Unique: b5tYlFyEN-6aTyXFKNVihA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1584B802B46;
        Tue, 12 Jan 2021 14:41:05 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 202AC5B4B6;
        Tue, 12 Jan 2021 14:41:02 +0000 (UTC)
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
 <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
 <20210112112709.GO22493@dhcp22.suse.cz>
 <d00da0ca-8a2b-f144-b455-2887fd269ed7@redhat.com>
 <20210112121643.GP22493@dhcp22.suse.cz>
 <20210112142337.GR22493@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <52ec4899-80df-4cbe-41f1-e0a29e838afa@redhat.com>
Date:   Tue, 12 Jan 2021 15:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210112142337.GR22493@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 15:23, Michal Hocko wrote:
> On Tue 12-01-21 13:16:45, Michal Hocko wrote:
> [...]
>> Well, currently pool pages are not migrateable but you are right that
>> this is likely something that we will need to look into in the future
>> and this optimization would stand in the way.
> 
> After some more thinking I believe I was wrong in my last statement.
> This optimization shouldn't have any effect on pages on the pool as
> those stay at reference count 0 and they cannot be isolated either
> (clear_page_huge_active before it is enqueued).
> 
> That being said, the migration code would still have to learn about
> about this pages but that is out of scope of this discussion.
> 
> Sorry about the confusion from my side.
> 

At this point I am fairly confused what's working at what's not :D

I think this will require more thought, on how to teach
alloc_contig_range() (and eventually in some cases offline_pages()?) to
do the right thing.

-- 
Thanks,

David / dhildenb

