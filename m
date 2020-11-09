Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC19D2AB402
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgKIJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:52:08 -0500
Received: from mail.loongson.cn ([114.242.206.163]:50188 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbgKIJwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:52:08 -0500
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3389EalfhdsJAA--.13521S3;
        Mon, 09 Nov 2020 17:51:58 +0800 (CST)
Subject: Re: [PATCH] locking/lock_events: no need to check return value of
 debugfs_create functions
To:     Peter Zijlstra <peterz@infradead.org>
References: <1604740753-17662-1-git-send-email-yangtiezhu@loongson.cn>
 <20201109083251.GA2594@hirez.programming.kicks-ass.net>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ef0058d3-8308-bd9c-7289-e4009fed3b4b@loongson.cn>
Date:   Mon, 9 Nov 2020 17:51:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20201109083251.GA2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx3389EalfhdsJAA--.13521S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4DJFW8XFykXw1DCry7trb_yoW5WFyxpw
        s8Gry3Kr40v3yfWF9I9w1DZryI93yIkrs7CF9rCr1xAwnYvr1ayFykKr4UArySvr1fGryF
        q3W5GF1j9FyjyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUSsjbUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2020 04:32 PM, Peter Zijlstra wrote:
> On Sat, Nov 07, 2020 at 05:19:13PM +0800, Tiezhu Yang wrote:
>> When calling debugfs functions, there is no need to ever check the
>> return value.  The function can work or not, but the code logic should
>> never do something different based on this.
> I strongly disagree and have told this to Greg before. Having half a
> debug interface is weird at best, so upon failure we remove the whole
> thing, which is consistent.

Hi Peter,

Thanks for your reply.

I find the early discussion and see the following opinion by Greg:

https://lore.kernel.org/patchwork/patch/1290162/

[ For debugfs, this isn't an issue, what can a user do with something like
"debugfs isn't working?  What does that mean???"

And if we _really_ want warnings like this, it should go into the
debugfs core, not require this to be done for every debugfs user, right?

debugfs is just there for kernel developers to help debug things, it's
not a dependancy on any userspace functionality, so if it works or not
should not be an issue for any user.

Unless that user is a kernel developer of course :)

thanks,

greg k-h ]

Anyway, if this patch is meaningless after discussion, please ignore it.

Thanks,
Tiezhu

>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   kernel/locking/lock_events.c | 19 ++++---------------
>>   1 file changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
>> index fa2c2f9..bac77a1 100644
>> --- a/kernel/locking/lock_events.c
>> +++ b/kernel/locking/lock_events.c
>> @@ -146,9 +146,6 @@ static int __init init_lockevent_counts(void)
>>   	struct dentry *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
>>   	int i;
>>   
>> -	if (!d_counts)
>> -		goto out;
>> -
>>   	/*
>>   	 * Create the debugfs files
>>   	 *
>> @@ -159,21 +156,13 @@ static int __init init_lockevent_counts(void)
>>   	for (i = 0; i < lockevent_num; i++) {
>>   		if (skip_lockevent(lockevent_names[i]))
>>   			continue;
>> -		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
>> -					 (void *)(long)i, &fops_lockevent))
>> -			goto fail_undo;
>> +		debugfs_create_file(lockevent_names[i], 0400, d_counts,
>> +				    (void *)(long)i, &fops_lockevent);
>>   	}
>>   
>> -	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
>> -				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
>> -				 &fops_lockevent))
>> -		goto fail_undo;
>> +	debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200, d_counts,
>> +			    (void *)(long)LOCKEVENT_reset_cnts, &fops_lockevent);
>>   
>>   	return 0;
>> -fail_undo:
>> -	debugfs_remove_recursive(d_counts);
>> -out:
>> -	pr_warn("Could not create '%s' debugfs entries\n", LOCK_EVENTS_DIR);
>> -	return -ENOMEM;
>>   }
>>   fs_initcall(init_lockevent_counts);
>> -- 
>> 2.1.0
>>

