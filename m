Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A812A1514
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 11:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJaKF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 06:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgJaKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 06:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604138755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnjgLhuePwx0jJk40v4DM0roK18yccWOA7FCi5j5z9Y=;
        b=iZG/IQqvAIeTynrfHEqfXq3l7rCu0bZ6GWMyJpBdMHNpRpIe1/we5Qnp6LeDy+Y3NajmQo
        QB76syleFRzAuyxlGU9KoymzhorgMxKmy7zsyOiS04ULlrjehI0263JU9XJOoSiCH1OVEZ
        zeNKRcapIiL1XN4Nz4OcT661sAcrYBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-z9cKa54QMqiCjDV5EtZyuQ-1; Sat, 31 Oct 2020 06:05:51 -0400
X-MC-Unique: z9cKa54QMqiCjDV5EtZyuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 270381074641;
        Sat, 31 Oct 2020 10:05:49 +0000 (UTC)
Received: from [10.36.112.45] (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4786760C05;
        Sat, 31 Oct 2020 10:05:46 +0000 (UTC)
Subject: Re: mm/memblock: export memblock_{start/end}_of_DRAM
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Pratik Patel <pratikp@codeaurora.org>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
 <20201030083842.GA4319@kernel.org> <20201031091846.GA30512@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <db82e52c-0159-777d-8fa9-7b5cf93eca7f@redhat.com>
Date:   Sat, 31 Oct 2020 11:05:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201031091846.GA30512@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.20 10:18, Christoph Hellwig wrote:
> On Fri, Oct 30, 2020 at 10:38:42AM +0200, Mike Rapoport wrote:
>>   
>> What do you mean by "system memory block"? There could be a lot of
>> interpretations if you take into account memory hotplug, "mem=" option,
>> reserved and firmware memory.
>>
>> I'd suggest you to describe the entire use case in more detail. Having
>> the complete picture would help finding a proper solution.
> 
> I think we need the code for the driver trying to do this as an RFC
> submission.  Everything else is rather pointless.

Sharing RFCs is most probably not what people want when developing 
advanced hypervisor features :)

@Sudarshan, I recommend looking at the slides of the KVM Forum talk from 
yesterday

https://kvmforum2020.sched.com/event/eE40/towards-an-alternative-memory-architecture-joao-martins-oracle?iframe=no

It contains a nice summary of the state of art, and how "mem=", devdax, 
and dax_hmat can be used to tackle the issue in a hypervisor.

-- 
Thanks,

David / dhildenb

