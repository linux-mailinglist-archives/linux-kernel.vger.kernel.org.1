Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC3D2F54DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbhAMWTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:19:21 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40609 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbhAMWOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:14:31 -0500
Received: by mail-wr1-f43.google.com with SMTP id 91so3752282wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VK/iM6R27LRQ/Qm/8qm5HUt4QdKjqmK+S3xgybZNYKk=;
        b=oZ21GT+y+r5Jo07k5WPdgC8S859Rbn91fDMmQhKkWmt9azJ3a8eatvKf1nolTSP68H
         +d0RH35VuD5uRbQpx93C42b7P5T9tGF9B3Dg0jHDmg+uTheZKZ+BvqEhwzRhw5Ou8Qsi
         75ngOqkd51qxrrNhgEmdPI0qjktpMu22rNMOVMko+0m5nnMZbHelecacapiqQO63tAw+
         PkONROlil2sds4lEmops0FisuTVFGpjl/Im6/GC3pa/oa46xtj28VceNhayXKoPUFsQB
         MOPqmk6sfsa3E7X9DrSXACs3WcYfbEAMkOjbAG20UMAHe9k/cE67O+Fed8PJRNU9nmyv
         +cPg==
X-Gm-Message-State: AOAM531OTNxtam238TMw+KHTQHiSWB+Jy9Mm0CEMpAA/UJ9kebWbKYJ3
        xBs0A1vyH2d7jYS1/MDJTKE=
X-Google-Smtp-Source: ABdhPJwEyYL3weXHM+uwbX5BM3Ogp/SoLHVZ6sVZ0fmQP+g4Ys36zOKb4ergNxlvtvMYnE10wvC8Gg==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr4617979wrg.285.1610575983501;
        Wed, 13 Jan 2021 14:13:03 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id s25sm5764685wrs.49.2021.01.13.14.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 14:13:03 -0800 (PST)
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Li Feng <fengli@smartx.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "lifeng1519@gmail.com" <lifeng1519@gmail.com>
References: <20210113160621.98615-1-fengli@smartx.com>
 <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
Date:   Wed, 13 Jan 2021 14:12:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> The nvme spec(1.4a, figure 248) says:
>> "A value smaller than 9 (i.e., 512 bytes) is not supported."
>>
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>>   drivers/nvme/host/core.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f320273fc672..1f02e6e49a05 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2161,6 +2161,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>>   
>>   	blk_mq_freeze_queue(ns->disk->queue);
>>   	ns->lba_shift = id->lbaf[lbaf].ds;
>> +	if (ns->lba_shift < 9) {
>> +		pr_warn("%s: bad lba_shift(%d)\n", ns->disk->disk_name, ns->lba_shift);
>> +		ret = -1;

Meaningful errno would be useful. Also better to use dev_warn

>> +		goto out_unfreeze;
>> +	}
>> +
>>   	nvme_set_queue_limits(ns->ctrl, ns->queue);
>>   
>>   	if (ns->head->ids.csi == NVME_CSI_ZNS) {
>>
> 
> 
> But this only catches a physical block size < 512 for NVMe, not any other block device.
> 
> Please fix it for the general case in blk_queue_physical_block_size().

We actually call that later and would probably be better to check here..
