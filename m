Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71B32B6821
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbgKQO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729733AbgKQO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605625138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUjO6Gi+rUqRafvOaWLAMF3YmRkHsdaCsNnrxjA1lmI=;
        b=Q5HH3gNnB9YpqjFTEVtiQGGaGWjstwhD7IoZ3c2HINJncCEKTmejJS2vuw71stIsfjbgY1
        SKrI6+VH0CauW2KYLQQldGV20+fNR8HOgNZcwvptco+sSCtBI7VbhAWYs71c8JbcGxT+V1
        AdAWBR1zgSBULcBV+H1JPjJd0gRgWVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-CKHrpfupMZW4GVIDn1JBQQ-1; Tue, 17 Nov 2020 09:58:54 -0500
X-MC-Unique: CKHrpfupMZW4GVIDn1JBQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 305BD5F9E6;
        Tue, 17 Nov 2020 14:58:52 +0000 (UTC)
Received: from [10.36.114.99] (ovpn-114-99.ams2.redhat.com [10.36.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 012896EF49;
        Tue, 17 Nov 2020 14:58:49 +0000 (UTC)
Subject: Re: [RFC] depopulate_range_driver_managed() for removing page-table
 mappings for hot-added memory blocks
To:     Christoph Hellwig <hch@infradead.org>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <bb30aa44d367ad217e9c877eba7b0a12@codeaurora.org>
 <20201114102853.GA8618@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f1ff619d-5190-1181-6514-41f0c69ffe54@redhat.com>
Date:   Tue, 17 Nov 2020 15:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201114102853.GA8618@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.20 11:28, Christoph Hellwig wrote:
> On Fri, Nov 13, 2020 at 06:41:22PM -0800, Sudarshan Rajagopalan wrote:
>>
>> Hello,
>>
>> When memory blocks are removed, along with removing the memmap entries,
>> memory resource and memory block devices, the arch specific
>> arch_remove_memory() is called which takes care of tearing down the
>> page-tables.
>>
>> Suppose there???s a usecase where the removed memory blocks will be added
>> back into the system at later point,
> 
> Stop this crap.  If you have a use case post the actual use here,
> including code and specs.  If you don't have that don't waste peoples
> time on your pipe dream.
> 

Adding to that, we (upstream people) are not interested in introducing 
and maintaining kernel interfaces/infrastructure only relevant to 
out-of-tree / proprietary drivers. If you're planning on upstreaming, 
then please share the actual problem you are trying to solve and the 
issues you see with the current interfaces/infrastructure, best along 
with an RFC that shows the bigger picture.

Having that said, what you describe sounds more like a special kind of 
allocation, whereby the linear mapping is removed, similar to [1].

[1] https://lkml.kernel.org/r/20201111145322.15793-1-david@redhat.com


-- 
Thanks,

David / dhildenb

