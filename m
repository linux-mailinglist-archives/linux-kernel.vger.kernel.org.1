Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED01B0A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgDTMsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:48:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39861 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgDTMsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:48:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id 18so1244373pfx.6;
        Mon, 20 Apr 2020 05:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZP/0iYmD/H54p8CqHE4Y7J8ed0tbv+i/HVHsWZbrMk=;
        b=iaxux+3PSCXp10dZI3+AdV9cTAZ2NlYpakrt+LWoFTtsBOqiTBDoR3UjVIks8IFuGk
         OQAc43VnqlzOfsLNAa3eN/ft2MuNfj20tOtWC+IB/LtELuWlw+A+sQ0Yw9cKHdafCINj
         vRWpC/LE9M4jkbLvnP4R8CS19Z1rJq1PNlK4LEBxidU2+f1ecwUNgoOKRqnmdVV74JbT
         qEmeyDJxP+m7ZAPCz3Lq++XRgaSl2uM0Q064Cxws2zlV9MSWmj+b05U4UD2UTd8S6og4
         4NE25yXf3psH9lL5GPslyTpmNLCsOYKIYMHX1bMc3P4UIIZ7QBZn786IiGHk5A2Sl4p9
         XXIw==
X-Gm-Message-State: AGi0PuY2tp+mUUXm5Mi4/vu5CQTAMy7GS1LMe4wXXmhYKHark1l13VY3
        vATRw0K1oQuNu0kzWlPf4lh76ZM3
X-Google-Smtp-Source: APiQypKtBb/IXceWbDe5CMNWJm//QZH8agRsemv9yl7WdzWlqnqObNfzUAgzhR9X5A2pdS6dfkidYQ==
X-Received: by 2002:a63:a362:: with SMTP id v34mr15923320pgn.198.1587386914648;
        Mon, 20 Apr 2020 05:48:34 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.3])
        by smtp.gmail.com with ESMTPSA id t126sm1056573pfb.29.2020.04.20.05.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 05:48:33 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when
 no budget
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
References: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
 <e5416179-2ba0-c9a8-1b86-d52eae29e146@acm.org>
 <663d472a-5bde-4b89-3137-c7bfdf4d7b97@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <287efbca-b8ca-1aa8-484f-a98e5205592c@acm.org>
Date:   Mon, 20 Apr 2020 05:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <663d472a-5bde-4b89-3137-c7bfdf4d7b97@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 1:22 AM, John Garry wrote:
> On 18/04/2020 03:43, Bart Van Assche wrote:
>> On 2020-04-16 04:18, John Garry wrote:
>>> If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
>>> dispatch loop, but the request may keep the driver tag, evaulated
>>> in 'nxt' in the previous loop iteration.
>>>
>>> Fix by putting the driver tag for that request.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 8e56884fd2e9..a7785df2c944 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1222,8 +1222,10 @@ bool blk_mq_dispatch_rq_list(struct 
>>> request_queue *q, struct list_head *list,
>>>           rq = list_first_entry(list, struct request, queuelist);
>>>           hctx = rq->mq_hctx;
>>> -        if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
>>> +        if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
>>> +            blk_mq_put_driver_tag(rq);
>>>               break;
>>> +        }
>>>           if (!blk_mq_get_driver_tag(rq)) {
>>>               /*
>>
>> Is this something that can only happen if q->mq_ops->queue_rq(hctx, &bd)
>> returns another value than BLK_STS_OK, BLK_STS_RESOURCE and
>> BLK_STS_DEV_RESOURCE? 
> 
> Right, as that case is handled in blk_mq_handle_dev_resource()
> 
> If so, please add a comment in the source code
>> that explains this.
> 
> So important that we should now do this in an extra patch?

Probably not, unless someone else feels strongly about this.

Thanks,

Bart.
