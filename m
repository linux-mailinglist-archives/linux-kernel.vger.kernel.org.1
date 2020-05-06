Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204C01C6FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 14:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgEFMHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 08:07:37 -0400
Received: from foss.arm.com ([217.140.110.172]:35076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgEFMHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:07:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291481FB;
        Wed,  6 May 2020 05:07:36 -0700 (PDT)
Received: from [10.57.31.214] (unknown [10.57.31.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA1EF3F71F;
        Wed,  6 May 2020 05:07:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] Documentation/vmcoreinfo: Add documentation for
 'KERNELPACMASK'
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <1587968702-19996-2-git-send-email-amit.kachhap@arm.com>
 <20200504173440.GE1833@willie-the-truck>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <c5b441e9-8dd4-d2e7-20bb-b934b68dad9a@arm.com>
Date:   Wed, 6 May 2020 17:37:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200504173440.GE1833@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/4/20 11:04 PM, Will Deacon wrote:
> On Mon, Apr 27, 2020 at 11:55:02AM +0530, Amit Daniel Kachhap wrote:
>> Add documentation for KERNELPACMASK variable being added to the vmcoreinfo.
>>
>> It indicates the PAC bits mask information of signed kernel pointers if
>> Armv8.3-A Pointer Authentication feature is present.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>>   Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> index 007a6b8..5cc3ee6 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -393,6 +393,12 @@ KERNELOFFSET
>>   The kernel randomization offset. Used to compute the page offset. If
>>   KASLR is disabled, this value is zero.
>>   
>> +KERNELPACMASK
>> +-------------
>> +
>> +Indicates the PAC bits mask information if Pointer Authentication is
>> +enabled and address authentication feature is present.
> 
> This is a bit cryptic. How about:
> 
>    The mask to extract the Pointer Authentication Code from a kernel virtual
>    address.

Ok sure. I will update like this in the v3 version.

Cheers,
Amit Daniel
> 
> Will
> 
