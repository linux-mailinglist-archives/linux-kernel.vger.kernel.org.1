Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5572AB7FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgKIMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:18:24 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41462 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgKIMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:18:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UEkmXrf_1604924299;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEkmXrf_1604924299)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Nov 2020 20:18:20 +0800
Subject: Re: [REF PATCH] mm/swap: fix swapon failure
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1604922436-16597-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201109120705.GZ17076@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <88fb2ed0-cb0c-2b4b-a73e-3a64fdc0a2cd@linux.alibaba.com>
Date:   Mon, 9 Nov 2020 20:17:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109120705.GZ17076@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/9 ÏÂÎç8:07, Matthew Wilcox Ð´µÀ:
> On Mon, Nov 09, 2020 at 07:47:16PM +0800, Alex Shi wrote:
>> Go through the context I found the exit_swap_address_space(p->type)
>> shouldn't be used in good result path. So just move it to error path.
> 
> But ... it's not used in the success path.  There's a 'goto' right
> before it.  Does this really fix your problem?
> 

The trick thing is. It do fix my problem on my centos 7 with gcc 8.3.1...

I am getting headache on this problem...

>> @@ -3339,7 +3339,8 @@ static bool swap_discardable(struct swap_info_struct *si)
>>  	error = inode_drain_writes(inode);
>>  	if (error) {
>>  		inode->i_flags &= ~S_SWAPFILE;
>> -		goto free_swap_address_space;
>> +		exit_swap_address_space(p->type);
>> +		goto bad_swap_unlock_inode;
>>  	}
>>  
>>  	mutex_lock(&swapon_mutex);
>> @@ -3364,8 +3365,6 @@ static bool swap_discardable(struct swap_info_struct *si)
>>  
>>  	error = 0;
>>  	goto out;
>> -free_swap_address_space:
>> -	exit_swap_address_space(p->type);
>>  bad_swap_unlock_inode:
>>  	inode_unlock(inode);
>>  bad_swap:
>> -- 
>> 1.8.3.1
>>
>>
