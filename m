Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB798259238
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgIAPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 11:06:08 -0400
Received: from foss.arm.com ([217.140.110.172]:43104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgIAPF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:05:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81DDE1045;
        Tue,  1 Sep 2020 08:05:52 -0700 (PDT)
Received: from [10.57.5.66] (unknown [10.57.5.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B77623F71F;
        Tue,  1 Sep 2020 08:05:51 -0700 (PDT)
Subject: Re: [PATCH] perf: correct SNOOPX field offset
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
From:   Al Grant <al.grant@foss.arm.com>
Message-ID: <67062e1a-98b1-1f0d-d405-2c0dc2ce655a@foss.arm.com>
Date:   Tue, 1 Sep 2020 16:05:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20200901150225.GA1424523@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2020 16:02, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 26, 2020 at 03:33:35PM +0100, Al Grant escreveu:
>> On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
>>>> On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
>>>>> perf_event.h has macros that define the field offsets in the
>>>>> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
>>>>> were both 37. These are distinct fields, and the bitfield layout
>>>>> in perf_mem_data_src confirms that SNOOPX should be at offset 38.
>>>>
>>>> Looks good.
>>>>
>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>>>
>>>> Probably should have a Fixes: header
>>>
>>> Please do so, find the patch that introduced the error, add the Fixes
>>> tag, will help me not having to do it myself :-)
>>
>> Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info
>> encodings")
> 
> Ok, I'll add that, thanks.
>  > But you forgot to add your Signed-off-by:, can you please provide it?

Signed-off-by: Al Grant <al.grant@arm.com>

> There was also a minor problem in the patch, there was no separation of
> --- from the patch comment section to the patch itself, I'll fix that as
> well.

Thanks, will remember for next time.

Al
