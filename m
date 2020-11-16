Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8F2B54AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgKPXAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:00:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA4C0613CF;
        Mon, 16 Nov 2020 15:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=pkMMx2It+5Pvco6e/Mzh+7cjlpElvgRby/hMw4rxyqs=; b=pSihbiP0NpEOovk4JegF6/FeWU
        XH/+UeM50+Ld8mGi/S0oS6QD2oizuU5SikacL1Pr7lbExrkBag7/nF+/j00HNz0L7rxtUpqHYHF+c
        SPhqS9d3VkJcm46rGTa3XE4AjKMsgiru+TK5a66JhFqK9D7FZqp4bZmwRPw7RfINnnJoIMIRufSlu
        wkhkUohGrkUvQC2La2lXAiyL0rONWV4fze+BaKcLMUZo9of2cH1IvNQUYuAACJpexkgXD0ccYSWvh
        2RZyGqv6K2ZKXZXb3mAKx/+Le4NXuhO3pGuXtcuF+Zgtz88134/+by+UMzUgISNH7ePZSAFfkJ/Eq
        NY+3sZmQ==;
Received: from [2601:1c0:6280:3f0::f32]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kenTh-0004T5-H3; Mon, 16 Nov 2020 23:00:05 +0000
Subject: Re: [PATCH] md: dm-writeback: add __noreturn to BUG-ging function
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
Date:   Mon, 16 Nov 2020 15:00:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/20 11:30 PM, Christian Borntraeger wrote:
> 
> 
> On 13.11.20 23:52, Randy Dunlap wrote:
>> Building on arch/s390/ flags this as an error, so add the
>> __noreturn attribute modifier to prevent the build error.
>>
>> cc1: some warnings being treated as errors
>> ../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
>> ../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]
> 
> ok with me, but I am asking why
> 
> the unreachable macro is not good enough. For x86 it obviously is.
> 
> form arch/s390/include/asm/bug.h
> #define BUG() do {                                      \
>         __EMIT_BUG(0);                                  \
>         unreachable();                                  \
> } while (0)
> 

Hi Christian,

Good question.
I don't see any guidance about when to use one or the other etc.

I see __noreturn being used 109 times and unreachable();
being used 33 times, but only now that I look at them.
That had nothing to do with why I used __noreturn in the patch.

> 
>>
>> Fixes: 48debafe4f2f ("dm: add writecache target")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Mikulas Patocka <mpatocka@redhat.com>
>> Cc: Alasdair Kergon <agk@redhat.com>
>> Cc: Mike Snitzer <snitzer@redhat.com>
>> Cc: dm-devel@redhat.com
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>  drivers/md/dm-writecache.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20201113.orig/drivers/md/dm-writecache.c
>> +++ linux-next-20201113/drivers/md/dm-writecache.c
>> @@ -317,7 +317,7 @@ err1:
>>  	return r;
>>  }
>>  #else
>> -static int persistent_memory_claim(struct dm_writecache *wc)
>> +static int __noreturn persistent_memory_claim(struct dm_writecache *wc)
>>  {
>>  	BUG();
>>  }
>>

thanks.
-- 
~Randy

