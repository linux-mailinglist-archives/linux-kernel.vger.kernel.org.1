Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161642FB24C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbhASHCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbhASGzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:55:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 22:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xT1tYpudDlazNJPJKolNWPqeNHhb50HWMulfMYYqrPE=; b=mNCbksAUU5L9gZDfdp+KiOGCLm
        dW4IPRz5jJJTx1UmUoFK238jERdr8au9KK0VsH9LUFDZkSmxQDv7PwZeWvLrz9XjX7gmPLx/IB/pX
        tkeY733aow0Yh5gp1aQNvfuKZ7K3wfrr5ESxq4IV52FCBTyeQCLuE/KqG88phkY7B2L5VTbcuOeVP
        bVJ1R2zQXPRjsOKdrUh8gCe5s80ScvSgLQH3awRLBH5+Xq62VIwBJ8f79+fq3vfNcmSz2Gh2qCAXM
        dXDE1td3Q3Lr6zcqvlocchltr4SgS26hY/vPE6VlXxS1ZDyv1fzjLCPwzR6ke9Cl2MID+pbJfsrJk
        3+Shx06A==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1kuw-0007Pn-Md; Tue, 19 Jan 2021 06:55:07 +0000
Subject: Re: [PATCH v5 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>, minchan@kernel.org,
        glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org, Vineet Gupta <vgupta@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
 <2f12a84c-132b-7141-a89e-9e19de0e4b90@infradead.org>
 <678c5d5f-3cd4-74ad-aebc-51cbc4c9ee4b@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <647943d6-9a8c-e5f7-a608-0892edfed2ff@infradead.org>
Date:   Mon, 18 Jan 2021 22:54:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <678c5d5f-3cd4-74ad-aebc-51cbc4c9ee4b@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 10:52 PM, Vijayanand Jitta wrote:
> 
> 
> On 1/19/2021 4:23 AM, Randy Dunlap wrote:
>> On 1/18/21 1:56 AM, vjitta@codeaurora.org wrote:
>>> From: Yogesh Lal <ylal@codeaurora.org>
>>>
>>> Use CONFIG_STACK_HASH_ORDER to configure STACK_HASH_SIZE.
>>>
>>> Aim is to have configurable value for  STACK_HASH_SIZE,
>>> so depend on use case one can configure it.
>>>
>>> One example is of Page Owner, default value of
>>> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
>>> Making it configurable and use lower value helps to enable features like
>>> CONFIG_PAGE_OWNER without any significant overhead.
>>>
>>> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
>>> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
>>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> Hi,
>>
>> Did you see
>> https://lore.kernel.org/lkml/202101050729.cwTd47Yw-lkp@intel.com/
>>
>> It seems that arch/arc/ does not have:
>>    arc-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>>    (.text+0x6): undefined reference to `__irqentry_text_start'
>>>> arc-elf-ld: (.text+0x6): undefined reference to `__irqentry_text_start'
>>>> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
>>>> arc-elf-ld: (.text+0x26): undefined reference to `__irqentry_text_end'
>>>> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
>>>> arc-elf-ld: (.text+0x34): undefined reference to `__softirqentry_text_start'
>>>> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'
>>>> arc-elf-ld: (.text+0x3c): undefined reference to `__softirqentry_text_end'
>>
>>
>>
>>
> 
> The above issue seems to be because of a different patch.
> This one
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=505a0ef15f96c6c43ec719c9fc1833d98957bb39
> 
> I didn't really get why you referred that here.

Yes, I noticed that later. Sorry about that.

Maybe Alexander P. can look into it...

thanks.
-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
