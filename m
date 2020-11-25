Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41042C4141
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgKYNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:37:42 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57598 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727338AbgKYNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:37:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGWA1pi_1606311446;
Received: from 30.0.173.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGWA1pi_1606311446)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 21:37:26 +0800
Subject: Re: [PATCH 6/7] blk-iocost: Factor out the active iocgs' state check
 into a separate function
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <aa1f4c6e637974d7195bf4e019880e50acdd5ca5.1606186717.git.baolin.wang@linux.alibaba.com>
 <X75NOaW6AYyGZSF7@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <8e94be71-1f55-0bd2-fa76-de2ffa252895@linux.alibaba.com>
Date:   Wed, 25 Nov 2020 21:37:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X75NOaW6AYyGZSF7@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
> 
> On Tue, Nov 24, 2020 at 11:33:35AM +0800, Baolin Wang wrote:
>> -static void ioc_timer_fn(struct timer_list *timer)
>> +/*
>> + * Waiters determine the sleep durations based on the vrate they
>> + * saw at the time of sleep.  If vrate has increased, some waiters
>> + * could be sleeping for too long.  Wake up tardy waiters which
>> + * should have woken up in the last period and expire idle iocgs.
>> + */
> 
> Please reflow the comment.

Sure.

> 
> ...
>> +	nr_debtors = ioc_check_iocg_state(ioc, &now);
> 
> How about ioc_check_iocgs()?

Yes, sounds reasonable to me.

> 
>> +
>>   	commit_weights(ioc);
> 
> I think it'd make more sense to move commit_weights() inside the new
> function.

OK. Thanks.
