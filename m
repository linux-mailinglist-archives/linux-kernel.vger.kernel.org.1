Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0771D7373
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgERJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 05:07:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERJHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:07:36 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F1628BB492F0240FEF8D;
        Mon, 18 May 2020 10:07:31 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.146) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 18 May
 2020 10:07:30 +0100
Subject: Re: [PATCH] libata: Use per port sync for detach
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200515110916.11556-1-kai.heng.feng@canonical.com>
 <555101fd-71bc-fa0b-98c2-69249bb3eda6@huawei.com>
 <15CFC20D-B8CB-43D7-8973-60E82DE6B894@canonical.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <91334913-eac8-c8e0-ced6-f1bb8d8b2507@huawei.com>
Date:   Mon, 18 May 2020 10:06:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <15CFC20D-B8CB-43D7-8973-60E82DE6B894@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.146]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 18:48, Kai-Heng Feng wrote:
>> 841]  ret_from_fork+0x10/0x1c
>> [   28.393400] ---[ end trace 9972785c7052048f ]---
>> [   28.435826] ahci 0000:b4:03.0: SSS flag set, parallel bus scan disabled
> Can you please test the following patch:
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 474c6c34fe02..51ee0cc4d414 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3583,8 +3583,10 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>          rc = 0;
>   
>          /* if UNLOADING, finish immediately */
> -       if (ap->pflags & ATA_PFLAG_UNLOADING)
> +       if (ap->pflags & ATA_PFLAG_UNLOADING) {
> +               ap->pflags |= ATA_PFLAG_UNLOADED;
>                  goto out;
> +       }
> 
> It's only compile-tested, many drivers panic with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled, so the system I have can't even boot properly:(

ok, let me debug this today.

Thanks,
John
