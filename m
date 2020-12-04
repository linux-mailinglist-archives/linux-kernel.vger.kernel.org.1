Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9D2CE699
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgLDDhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:37:02 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41224 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgLDDhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:37:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UHSkLPj_1607052978;
Received: from 30.21.164.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UHSkLPj_1607052978)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Dec 2020 11:36:19 +0800
Subject: Re: [RFC PATCH] blk-iocost: Optimize the ioc_refreash_vrate()
 function
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <071dbbbdfecaebf9e850e622c52dd591969e21ab.1606617087.git.baolin.wang@linux.alibaba.com>
 <X8f5zQi+AzaY+ieY@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <9d1098dc-f716-872b-ea63-aea4a44355dc@linux.alibaba.com>
Date:   Fri, 4 Dec 2020 11:36:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8f5zQi+AzaY+ieY@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2020/12/3 4:32, Tejun Heo д��:
> On Sun, Nov 29, 2020 at 10:37:18AM +0800, Baolin Wang wrote:
>> The ioc_refreash_vrate() will only be called in ioc_timer_fn() after
>> starting a new period or stopping the period.
>>
>> So when starting a new period, the variable 'pleft' in ioc_refreash_vrate()
>> is always the period's time, which means if the abs(ioc->vtime_err)
>> is less than the period's time, the vcomp is 0, and we do not need
>> compensate the vtime_rate in this case, just set it as the base vrate
>> and return.
>>
>> When stopping the period, the ioc->vtime_err will be cleared to 0,
>> and we also do not need to compensate the vtime_rate, just set it as
>> the base vrate and return.
> 
> Before, the function did something which is conceptually discrete and
> describable. After, its operation is intertwined with when it's called. I
> don't think this sort of micro optimizations are beneficial in cold paths.

OK. I understood your concern. Thanks for your input.
