Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF22A4661
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgKCN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:28:52 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:62865 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbgKCN2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:28:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604410128; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vVJTPplaY0wXJNHuBj77wp200J5QpT3xiiwhgZtAyEg=;
 b=CTa+hhZ2XxoZdZn9IB75mam75cY4mFsi03uPtdRvyrKPeCnw1b1Un3wKicqI3V9EZbb0BhQ1
 7ykC99YnMEPeQGIx/ow+fv7xflDz5nwDYhqQozLwHC+J7V4ODwu8NVzi1G7zI54gtTvJcwVY
 6uRZHRqyxR22jw2pxkVoGsOPjPI=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fa15af350440018cb17b218 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 13:28:19
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86DA2C43442; Tue,  3 Nov 2020 02:51:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D464C433B1;
        Tue,  3 Nov 2020 02:51:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 02 Nov 2020 18:51:25 -0800
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: mm/memblock: export memblock_{start/end}_of_DRAM
In-Reply-To: <20201030083842.GA4319@kernel.org>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
 <20201030083842.GA4319@kernel.org>
Message-ID: <ad242b868a291223218a33c05d6729fd@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-30 01:38, Mike Rapoport wrote:
> On Thu, Oct 29, 2020 at 02:29:27PM -0700, Sudarshan Rajagopalan wrote:
>> Hello all,
>> 
>> We have a usecase where a module driver adds certain memory blocks 
>> using
>> add_memory_driver_managed(), so that it can perform memory hotplug
>> operations on these blocks. In general, these memory blocks aren’t 
>> something
>> that gets physically added later, but is part of actual RAM that 
>> system
>> booted up with. Meaning – we set the ‘mem=’ cmdline parameter to limit 
>> the
>> memory and later add the remaining ones using add_memory*() variants.
>> 
>> The basic idea is to have driver have ownership and manage certain 
>> memory
>> blocks for hotplug operations.
>> 
>> For the driver be able to know how much memory was limited and how 
>> much
>> actually present, we take the delta of ‘bootmem physical end address’ 
>> and
>> ‘memblock_end_of_DRAM’. The 'bootmem physical end address' is obtained 
>> by
>> scanning the reg values in ‘memory’ DT node and determining the max
>> {addr,size}. Since our driver is getting modularized, we won’t have 
>> access
>> to memblock_end_of_DRAM (i.e. end address of all memory blocks after 
>> ‘mem=’
>> is applied).
>> 
>> So checking if memblock_{start/end}_of_DRAM() symbols can be exported? 
>> Also,
>> this information can be obtained by userspace by doing ‘cat 
>> /proc/iomem’ and
>> greping for ‘System RAM’. So wondering if userspace can have access to 
>> such
>> info, can we allow kernel module drivers have access by exporting
>> memblock_{start/end}_of_DRAM().
> 
> These functions cannot be exported not because we want to hide this
> information from the modules but because it is unsafe to use them.
> On most architecturs these functions are __init so they are discarded
> after boot anyway. Beisdes, the memory configuration known to memblock
> might be not accurate in many cases as David explained in his reply.
> 

I don't see how information contained in memblock_{start/end}_of_DRAM() 
is considered hidden if the information can be obtained using 'cat 
/proc/iomem'. The memory resource manager adds these blocks either in 
"System RAM", "reserved", "Kernel data/code" etc. Inspecting this, one 
could determine whats the start and end of memblocks.

I agree on the part that its __init annotated and could be removed after 
boot. This is something that the driver can be vary of too.

>> Or are there any other ways where a module driver can get the end 
>> address of
>> system memory block?
> 
> What do you mean by "system memory block"? There could be a lot of
> interpretations if you take into account memory hotplug, "mem=" option,
> reserved and firmware memory.

I meant the physical end address of memblock. The equivalent of 
memblock_end_of_DRAM.

> 
> I'd suggest you to describe the entire use case in more detail. Having
> the complete picture would help finding a proper solution.

The usecase in general is have a way to add/remove and online/offline 
certain memory blocks which are part of boot. We do this by limiting the 
memory using "mem=" and latter add the remaining blocks using 
add_memory_driver_mamanaged().

> 
>> Sudarshan
>> 
> 
> --
> Sincerely yours,
> Mike.


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
