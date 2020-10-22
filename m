Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59B295C67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896311AbgJVKFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896255AbgJVKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:05:51 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BBC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:05:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j7so645793pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9SsBXZDSBj98gvytWEkQs58O58kWQRuE5OR0cysVKT0=;
        b=nb58Ogkumh/AWmt0Eft/7kqaafJ5Nn0Z2Chfc/EMjB37sp2/kmu3f+0LWvZdByzpvq
         GjggOSLsJZfnMczsPb9JvNQBWhL0YlsQjBUwCfCCh2iKGlODFhGESK4PoUXZ++1TWjm2
         Y4GJ78oYUDsW7nR4IeYgbpVzep5aTnjXCKt0Oa6MSo+vjXR+xxdga7bunLNoXQI3yM7L
         lnqP4Xdgi+udE6dm1PIKmwocnTaxNEBQiwxWRW+p9F13vucfQ5WEYFEjTB5Jfyq5OLnu
         fSmIgNSBeHgihvnBt82yYYoX066iqtj5GNs1t7gRDD5ax//Y73JD7dUhXUkd2nZ0BPrg
         ZqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9SsBXZDSBj98gvytWEkQs58O58kWQRuE5OR0cysVKT0=;
        b=ngTwW3FDk2bt1RGpFWeiIAbbvnow0/9S3B/v6ElfoFIiTz6rUqy1c4GvRkvOU7UrIF
         UFwGMj24v5EJdEbUGvnQHk5DZeOUBU4SE9dKVYFsPsc36DZGBv5KepCpWc1Mz6SmZgvA
         hGbApPbUqZHvqtrMGAw4KPbYCpSiVPjlmXszl9ui2daXkBb++eYBldBy+znZYZzlj4KY
         0KKrZAiggtj0bDfD+5hBxVGbcfOgdW4xbl2IuB1jklLF8bbsXRE8VU58+9o5iAH9gmsU
         Nfcf41FK/t6X0Mls6w8+duY1+MGSmnwphy71nmsvjSrwiR4la/9WyE4mfrlLRJmeA+hn
         7J7g==
X-Gm-Message-State: AOAM530qGw63HBbdBD24PXAZ+NuH6nUflbxfwMZ1q4V4T22AQBuI9V8m
        pXE+72LJ/Qbt9W6A637beMzU0Q==
X-Google-Smtp-Source: ABdhPJwRlAi2VPOFTRdwX0uwoS4bE4j+P41/Sc7/DDSmnv5tg2me6pfLreH3Gkh3MIukMQQZI9G05w==
X-Received: by 2002:a63:ed15:: with SMTP id d21mr1669802pgi.348.1603361150372;
        Thu, 22 Oct 2020 03:05:50 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id f7sm1672861pfd.111.2020.10.22.03.05.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 03:05:49 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] nvme-rdma: handle nvme completion data
 length
To:     Chao Leng <lengchao@huawei.com>
Cc:     kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Yibo Zhu <zhuyibo@bytedance.com>
References: <20201022083850.1334880-1-pizhenwei@bytedance.com>
 <04a97f73-ba13-a4b5-3ea4-fc438391507e@huawei.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <1c78dbe5-47a4-1590-e064-681cba5fb01d@bytedance.com>
Date:   Thu, 22 Oct 2020 18:05:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04a97f73-ba13-a4b5-3ea4-fc438391507e@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 5:55 PM, Chao Leng wrote:
> 
> 
> On 2020/10/22 16:38, zhenwei pi wrote:
>> Hit a kernel warning:
>> refcount_t: underflow; use-after-free.
>> WARNING: CPU: 0 PID: 0 at lib/refcount.c:28
>>
>> RIP: 0010:refcount_warn_saturate+0xd9/0xe0
>> Call Trace:
>>   <IRQ>
>>   nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
>>   __ib_process_cq+0x76/0x150 [ib_core]
>>   ...
>>
>> The reason is that a zero bytes message received from target, and the
>> host side continues to process without length checking, then the
>> previous CQE is processed twice.
>>
>> Handle data length, ignore zero bytes message, and try to recovery for
>> corrupted CQE case.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/nvme/host/rdma.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 9e378d0a0c01..9f5112040d43 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1767,6 +1767,17 @@ static void nvme_rdma_recv_done(struct ib_cq 
>> *cq, struct ib_wc *wc)
>>           return;
>>       }
>> +    if (unlikely(!wc->byte_len)) {
>> +        /* zero bytes message could be ignored */
>> +        return;
>> +    } else if (unlikely(wc->byte_len < len)) {
>> +        /* Corrupted completion, try to recovry */
>> +        dev_err(queue->ctrl->ctrl.device,
>> +            "Unexpected nvme completion length(%d)\n", wc->byte_len);
>> +        nvme_rdma_error_recovery(queue->ctrl);
>> +        return;
>> +    }
> !wc->byte_len and wc->byte_len < len may be the same type of anomaly.
> Why do different error handling?
> In which scenario zero bytes message received from target? fault inject 
> test or normal test/run?

Zero bytes message could be used as transport layer keep alive mechanism 
(I's also developing target side transport layer keep alive now. To 
reclaim resource, target side needs to close dead connections even kato 
is set as 0).

>> +
>>       ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
>>       /*
>>        * AEN requests are special as they don't time out and can
>>

-- 
zhenwei pi
