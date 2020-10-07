Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D29285ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgJGMJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:09:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728008AbgJGMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:09:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097C1KWl189060;
        Wed, 7 Oct 2020 08:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+3SnTg0+Tz+IauzN1r7hHhljC5k2snRN3dEYbYQmFEc=;
 b=APDtPc9iDqpvdMqQsbASDgmx+nYnPFh8tqQFmAJ7uG6LFqMkG2m1lLQLBJwYwJhAbtQl
 m2A+LpfDUh6GXKb2KRB2bW3RcgcqibcECixqM0/RVO/eoF5OsKHFkCIeQxuLExLmj7IK
 b/GMA4BjJf9rglZ2o0vaAPkqznbPLzrBTtMxRI8eDlxjdpqc6MADG2Qt/AXDGHNa23Hd
 jXVeSYAzkvRifG50+k+MXj9W0iXemh85Gy1yQlq41RIPXeh7toFZCP1SVgPczbUHQiXd
 12KgSqmDX7Yj6mU8uaHD6IcqF2B6qBzu2xqJ6HSeKfV5ttbDVqdkMBiu9i9JpCowStks ew== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 341d1c0xaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 08:09:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097C7M2G029732;
        Wed, 7 Oct 2020 12:09:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx848g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 12:09:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 097C9JdH28705254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 12:09:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD2B452050;
        Wed,  7 Oct 2020 12:09:19 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.175.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 40C9C5204E;
        Wed,  7 Oct 2020 12:09:19 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519142259.102279-3-sth@linux.ibm.com>
 <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
 <20201007103936.GA24327@lst.de>
 <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
 <20201007120005.GA29788@lst.de>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Message-ID: <e1e4afa1-faa2-aa19-a973-ee1286288802@de.ibm.com>
Date:   Wed, 7 Oct 2020 14:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201007120005.GA29788@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_08:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.20 14:00, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 12:44:55PM +0200, Christian Borntraeger wrote:
>>
>>
>> On 07.10.20 12:39, Christoph Hellwig wrote:
>>> On Wed, Oct 07, 2020 at 11:34:17AM +0200, Christian Borntraeger wrote:
>>>>
>>>> On 19.05.20 16:22, Stefan Haberland wrote:
>>>>> The IBM partition parser requires device type specific information only
>>>>> available to the DASD driver to correctly register partitions. The
>>>>> current approach of using ioctl_by_bdev with a fake user space pointer
>>>>> is discouraged.
>>>>>
>>>>> Fix this by replacing IOCTL calls with direct in-kernel function calls.
>>>>>
>>>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>>>>> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
>>>>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>>>>
>>>> FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.
>>>
>>> What are the symptoms?
>>
>> During boot I normally have
> 
>> [    0.930231] virtio_blk virtio1: [vda] 5409180 4096-byte logical blocks (22.2 GB/20.6 GiB)
>> [    0.930233] vda: detected capacity change from 0 to 22156001280
>> [    0.932806]  vda:VOL1/  0X3333: vda1 vda2 vda3
>>
>> With this change, the last line is no longer there (if CONFIG_DASD=m) and this also 
>> reflects itself in /proc/partitions. The partitions are no longer detected.
> 
> Can you try this patch?


> 
> diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> index d6e18df9c53c6d..d91cee558ce67a 100644
> --- a/block/partitions/ibm.c
> +++ b/block/partitions/ibm.c
> @@ -305,8 +305,6 @@ int ibm_partition(struct parsed_partitions *state)
>  	if (!disk->fops->getgeo)
>  		goto out_exit;
>  	fn = symbol_get(dasd_biodasdinfo);
> -	if (!fn)
> -		goto out_exit;
>  	blocksize = bdev_logical_block_size(bdev);
>  	if (blocksize <= 0)
>  		goto out_symbol;
> @@ -326,7 +324,7 @@ int ibm_partition(struct parsed_partitions *state)
>  	geo->start = get_start_sect(bdev);
>  	if (disk->fops->getgeo(bdev, geo))
>  		goto out_freeall;
> -	if (fn(disk, info)) {
> +	if (!fn || fn(disk, info)) {
>  		kfree(info);
>  		info = NULL;
>  	}
> 

Unfortunately not. On insmodding virtio_blk I do get:
[    3.331256] vda: detected capacity change from 0 to 22156001280
[    3.332381] ------------[ cut here ]------------
[    3.332382] kernel BUG at kernel/module.c:1081!
[    3.332420] monitor event: 0040 ilc:2 [#1] SMP 
[    3.332422] Modules linked in: virtio_blk(+) kvm
[    3.332425] CPU: 0 PID: 136 Comm: insmod Not tainted 5.8.13+ #54
[    3.332425] Hardware name: IBM 3906 M04 704 (KVM/Linux)
[    3.332426] Krnl PSW : 0704c00180000000 0000000016cf4fc6 (__symbol_put+0x56/0x58)
[    3.332434]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[    3.332435] Krnl GPRS: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    3.332436]            0000000000000000 0000000000000018 0000000000000000 0000000000000098
[    3.332437]            0000000000000000 0000000000000001 0000000000000000 0000000004fd9180
[    3.332438]            000000001f70c000 0000000004fd9360 0000000016cf4fa2 000003e0000f7648
[    3.332445] Krnl Code: 0000000016cf4fb8: f0a8000407fe	srp	4(11,%r0),2046,8
[    3.332445]            0000000016cf4fbe: 47000700		bc	0,1792
[    3.332445]           #0000000016cf4fc2: af000000		mc	0,0
[    3.332445]           >0000000016cf4fc6: 0707		bcr	0,%r7
[    3.332445]            0000000016cf4fc8: c00400000000	brcl	0,0000000016cf4fc8
[    3.332445]            0000000016cf4fce: eb6ff0480024	stmg	%r6,%r15,72(%r15)
[    3.332445]            0000000016cf4fd4: b90400ef		lgr	%r14,%r15
[    3.332445]            0000000016cf4fd8: b90400b4		lgr	%r11,%r4
[    3.332454] Call Trace:
[    3.332456]  [<0000000016cf4fc6>] __symbol_put+0x56/0x58 
[    3.332458] ([<0000000016cf4fa2>] __symbol_put+0x32/0x58)
[    3.332462]  [<00000000171be268>] ibm_partition+0xa0/0xa28 
[    3.332464]  [<00000000171b952c>] blk_add_partitions+0x184/0x5b8 
[    3.332467]  [<0000000016f07e94>] bdev_disk_changed+0x8c/0x120 
[    3.332468]  [<0000000016f09872>] __blkdev_get+0x3fa/0x598 
[    3.332469]  [<0000000016f09a42>] blkdev_get+0x32/0x1c8 
[    3.332471]  [<00000000171b5ee4>] __device_add_disk+0x32c/0x510 
[    3.332473]  [<000003ff80068de0>] virtblk_probe+0x5f0/0xc30 [virtio_blk] 
[    3.332477]  [<00000000172cc110>] virtio_dev_probe+0x178/0x2a0 
[    3.332480]  [<000000001731cecc>] really_probe+0xf4/0x498 
[    3.332481]  [<000000001731da1a>] device_driver_attach+0xd2/0xd8 
[    3.332482]  [<000000001731dad8>] __driver_attach+0xb8/0x180 
[    3.332483]  [<000000001731a1e2>] bus_for_each_dev+0x82/0xb8 
[    3.332484]  [<000000001731bf66>] bus_add_driver+0x1fe/0x248 
[    3.332486]  [<000000001731e340>] driver_register+0xa0/0x168 
[    3.332487]  [<000003ff8006e068>] init+0x68/0x1000 [virtio_blk] 
[    3.332489]  [<0000000016bfc884>] do_one_initcall+0x3c/0x1f8 
[    3.332490]  [<0000000016cf6c98>] do_init_module+0x68/0x290 
[    3.332491]  [<0000000016cf9eec>] __do_sys_finit_module+0xa4/0xe8 
[    3.332494]  [<000000001766c760>] system_call+0xdc/0x2b0 
[    3.332495] Last Breaking-Event-Address:
[    3.332496]  [<0000000016cf4fa6>] __symbol_put+0x36/0x58
[    3.332498] ---[ end trace 4a4a7a5643aab422 ]---




