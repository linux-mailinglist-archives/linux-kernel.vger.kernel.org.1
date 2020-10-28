Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF529DBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390868AbgJ2ASe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgJ2ASc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:18:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C4C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:18:31 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r9so1491603ioo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VF4gZYFcsN8OoJPW68XIA2tKZhPCND0dogeoGUQ8I+s=;
        b=cG6/9o1qdaoV4pOSKSDRmJgwS/h28HObCWhgg8QoMsjiZW3QFu3IyNmlqLLWbQWlNG
         BYmTShzU6Ysvq8wJeXjJGaZd2tBxE+k2TpNikW1aPZlcK9AfQd7u3dVHtf3kl/+ZFnr2
         3ZbHdvVLzwlIsWhiim8HNUQBsHzASEMYnK9ZBmMEoqjiFLEqZ1ECArOz+f8TrjpFDcRH
         IW3hZsSzVVnyJTaERt6xqtSFTSmT2TwcvidnYhqItLt4gJLG0y4rSFZv3kZnHmzR+zpo
         /TnIOWZLtvXCpnnb/D8LL00syPOSwkMsQwpCze93yhVCk0Rifz4Rm+9nXqBDCFXHdvSS
         6GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VF4gZYFcsN8OoJPW68XIA2tKZhPCND0dogeoGUQ8I+s=;
        b=CgryA2B4LxKGN7s8FWCBC2/nd3XSXKaybzI+9tSt7Yb2EDlo6/KfgWFra2uykopj+D
         saT0OhsseLL7JVTCZ7hj5hl60sZg2OwzPi0cMegbuhGhmDM9V8npuKomF3DbwBH6u85y
         vs98El1dDqhhG4bLs0oCKNwpiSgyoBx+g/M6HTWySzbv1lCBdd4If1ObGrDzxg27IRG6
         iTphgUYN+2pzA7k2mHDQreVLVn2bnqhiiz727HnRmH3sl7wIa1IfpNjoz4s6Fd0zySJF
         D2PQJfaWsB9KSCMjoL4xjZqQ3hAlqWphYv6h5odDskJTqzgB5cvUbC6q5HhlYZM3+SCQ
         OV6w==
X-Gm-Message-State: AOAM533Y/xQOyPGWZ6MpxEa8UJ8gkFWL/r2vHE+UNZtPM2zbvriAtQHp
        yycA6KjUHwxlyh3FwUCeRtHayU3xSHm7OQ==
X-Google-Smtp-Source: ABdhPJw+bDN8DYPHU262PoQiwijKVoHIXzGCs+naDHi90BaCNDFL/gdQ+2pDeJs7wr9RyZn8jR0tsA==
X-Received: by 2002:a65:6883:: with SMTP id e3mr5314254pgt.38.1603877346669;
        Wed, 28 Oct 2020 02:29:06 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id y1sm4733534pjl.12.2020.10.28.02.29.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 02:29:06 -0700 (PDT)
Subject: Re: [External] Re: [PATCH 1/2] nvmet: introduce transport layer
 keep-alive
To:     Sagi Grimberg <sagi@grimberg.me>, hch@lst.de,
        chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201027121546.1776104-1-pizhenwei@bytedance.com>
 <bbbb8d0e-22a3-0e94-9a0a-b7ce1792a1ae@grimberg.me>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <3f8e5405-152f-d71b-a37f-9bf4f85714c2@bytedance.com>
Date:   Wed, 28 Oct 2020 17:29:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bbbb8d0e-22a3-0e94-9a0a-b7ce1792a1ae@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 3:15 PM, Sagi Grimberg wrote:
> 
> On 10/27/20 5:15 AM, zhenwei pi wrote:
>> In the zero KATO scenario, if initiator crashes without transport
>> layer disconnection, target side would never reclaim resources.
>>
>> A target could start transport layer keep-alive to detect dead
>> connection for the admin queue.
> 
> Not sure why we should worry about kato=0, it's really
> more for debug purposes. I'd rather that we block this
> option from the host altogether.
> 

A target can't suppose that initiator always runs as expected.
I'm developing a user level NVMeOF library, in my plan, user level KATO 
timer gets a little complex, I'd like to use TCP level keep-alive
to make code simple. So the target side needs to handle zero KATO case.

>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/nvme/target/admin-cmd.c |  2 +-
>>   drivers/nvme/target/core.c      | 14 +++++++++++---
>>   drivers/nvme/target/nvmet.h     |  3 ++-
>>   3 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c 
>> b/drivers/nvme/target/admin-cmd.c
>> index dca34489a1dc..53fbd5c193a1 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -729,7 +729,7 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
>>       nvmet_stop_keep_alive_timer(req->sq->ctrl);
>>       req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
>> -    nvmet_start_keep_alive_timer(req->sq->ctrl);
>> +    nvmet_start_keep_alive_timer(req->sq->ctrl, req);
>>       nvmet_set_result(req, req->sq->ctrl->kato);
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 957b39a82431..451192f7ad6a 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -395,10 +395,18 @@ static void nvmet_keep_alive_timer(struct 
>> work_struct *work)
>>       nvmet_ctrl_fatal_error(ctrl);
>>   }
>> -void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
>> +void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct 
>> nvmet_req *req)
>>   {
>> -    if (unlikely(ctrl->kato == 0))
>> +    if (unlikely(ctrl->kato == 0)) {
>> +        if (req->ops->keep_alive)
>> +            pr_info("ctrl %d starts with transport keep-alive %s\n", 
>> ctrl->cntlid,
>> +                req->ops->keep_alive(req) ? "failed" : "succeed");
>> +        else
>> +            pr_info("ctrl %d starts without both NVMeOF and transport 
>> keep-alive",
>> +                ctrl->cntlid);
>> +
>>           return;
>> +    }
>>       pr_debug("ctrl %d start keep-alive timer for %d secs\n",
>>           ctrl->cntlid, ctrl->kato);
>> @@ -1383,7 +1391,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, 
>> const char *hostnqn,
>>       ctrl->err_counter = 0;
>>       spin_lock_init(&ctrl->error_lock);
>> -    nvmet_start_keep_alive_timer(ctrl);
>> +    nvmet_start_keep_alive_timer(ctrl, req);
>>       mutex_lock(&subsys->lock);
>>       list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 559a15ccc322..de1785ce9fcd 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -305,6 +305,7 @@ struct nvmet_fabrics_ops {
>>       u16 (*install_queue)(struct nvmet_sq *nvme_sq);
>>       void (*discovery_chg)(struct nvmet_port *port);
>>       u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
>> +    int (*keep_alive)(struct nvmet_req *req);
>>   };
>>   #define NVMET_MAX_INLINE_BIOVEC    8
>> @@ -395,7 +396,7 @@ void nvmet_get_feat_async_event(struct nvmet_req 
>> *req);
>>   u16 nvmet_set_feat_kato(struct nvmet_req *req);
>>   u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
>>   void nvmet_execute_async_event(struct nvmet_req *req);
>> -void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
>> +void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct 
>> nvmet_req *req);
>>   void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
>>   u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
>>

-- 
zhenwei pi
