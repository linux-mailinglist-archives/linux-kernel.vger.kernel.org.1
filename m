Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF52AECD7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgKKJLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbgKKJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605085874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlZinN9OnNylR1xrMcRKZCPumUU6I2AoyvcUIe4LUBE=;
        b=INDM4VtQmTfOGmq7ZVNe3uChCPE4tDD1BNuO77rwK0jHf3/AbbftZgL76jXT+tCr06KFGi
        K0pRIuX3qMa90uVaTCHBYlhFk2G+WkTdr1SLsRe5xmkG4ZDtqG01uXcnnhRjRh0NDfjEzi
        CXjuLAOQeX83gt2ztzm/0oVrB/UEi7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-xjpSYL_VPgureiI2gCU0VA-1; Wed, 11 Nov 2020 04:11:09 -0500
X-MC-Unique: xjpSYL_VPgureiI2gCU0VA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C766D5F9DB;
        Wed, 11 Nov 2020 09:11:07 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2078D1A925;
        Wed, 11 Nov 2020 09:11:04 +0000 (UTC)
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        gshan@redhat.com, Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>
References: <20201014081857.3288-1-ardb@kernel.org>
 <160503561804.1015659.16599672230432576934.b4-ty@arm.com>
 <a330440d-803b-5aa2-0092-a18317819850@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <39a6c4a9-bdad-c565-03a0-b60b9811d234@redhat.com>
Date:   Wed, 11 Nov 2020 10:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a330440d-803b-5aa2-0092-a18317819850@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.20 04:48, Anshuman Khandual wrote:
> 
> 
> On 11/11/20 12:44 AM, Catalin Marinas wrote:
>> On Wed, 14 Oct 2020 10:18:57 +0200, Ard Biesheuvel wrote:
>>> As a hardening measure, we currently randomize the placement of
>>> physical memory inside the linear region when KASLR is in effect.
>>> Since the random offset at which to place the available physical
>>> memory inside the linear region is chosen early at boot, it is
>>> based on the memblock description of memory, which does not cover
>>> hotplug memory. The consequence of this is that the randomization
>>> offset may be chosen such that any hotplugged memory located above
>>> memblock_end_of_DRAM() that appears later is pushed off the end of
>>> the linear region, where it cannot be accessed.
>>>
>>> [...]
>>
>> Applied to arm64 (for-next/mem-hotplug), thanks!
>>
>> [1/1] arm64: mm: account for hotplug memory when randomizing the linear region
>>        https://git.kernel.org/arm64/c/97d6786e0669
>>
> 
> Hello Catalin,
> 
> Got delayed and never made here in time, sorry about that. Nonetheless,
> I have got something working with respect to the generic mechanism that
> David Hildenbrand had asked for earlier.
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> I am wondering if we could instead consider merging the above patch with
> a small change that Ard had pointed out earlier [1], I will send out a
> revision if required.
> 
> I am asking this because the patch in question is a memory hotplug fix
> and should be back ported to other stable releases. Implementing that
> via the new proposed generic framework might make it difficult for a
> possible arm64 specific backport. We could then add the new generic
> framework and move this fix to an arch callback. Let me know if this
> would be an feasible option. Thank you.

Sure, if it's a fix that is intended to be backported as well, then 
let's move forward with the simple fix and do a proper cleanup on top 
later. Thanks!


-- 
Thanks,

David / dhildenb

