Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0204B285DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgJGLJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:09:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJGLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:09:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097B2A77028964;
        Wed, 7 Oct 2020 07:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fAqO8BX/aXcP6/YtZxMLJUw+RFGRDjOYRBGUkViGUhg=;
 b=RBrpQveTlyv/bLwDx5GKAo2yJbepHT5ISZ/vgNcR5AWURM6KWpDB/GSNwL3eMm5sEBrb
 7jG8oKnwDW4CSdTAI7HggcbAHDI1xrJU5ft+vUDWSqwLasrWC70EaFL1PHwg6+nutSE8
 jiyTEhEh6usrn6ioxfsnPgl+aFK5E3fLfa9TCyBPaL84BvGltgxeMwK1bmrWE35SjdbY
 i9evuXAW+QKIZ7l5Px5XGCc/uPWiwg+ZKyRFONUDVK7gdCPzhDF5ggjZXqXB2igtErn2
 WQurix5GJD+UdXIgtXYjV5o987JlbCGUuPW8xlE+cNPTyz7MTUgKqEcnBWBIAwsOMUZi 5A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341c5g0sv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 07:09:38 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097B6fKF024824;
        Wed, 7 Oct 2020 11:09:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh47bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 11:09:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 097B9X0P31130094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 11:09:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE53A405C;
        Wed,  7 Oct 2020 11:09:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D434A405B;
        Wed,  7 Oct 2020 11:09:32 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.147.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Oct 2020 11:09:32 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519142259.102279-3-sth@linux.ibm.com>
 <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
 <20201007103936.GA24327@lst.de>
 <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Autocrypt: addr=sth@linux.ibm.com; keydata=
 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
 cH4TNHyhiR0KAbxE8qKx3Jc=
Message-ID: <d339d5c2-30c7-5073-1ba8-6fbb83400d8c@linux.ibm.com>
Date:   Wed, 7 Oct 2020 13:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ca1bad1e-6d4b-7e86-4a98-b9ba12e2bef2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_08:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.10.20 um 12:44 schrieb Christian Borntraeger:
>
> On 07.10.20 12:39, Christoph Hellwig wrote:
>> On Wed, Oct 07, 2020 at 11:34:17AM +0200, Christian Borntraeger wrote:
>>> On 19.05.20 16:22, Stefan Haberland wrote:
>>>> The IBM partition parser requires device type specific information only
>>>> available to the DASD driver to correctly register partitions. The
>>>> current approach of using ioctl_by_bdev with a fake user space pointer
>>>> is discouraged.
>>>>
>>>> Fix this by replacing IOCTL calls with direct in-kernel function calls.
>>>>
>>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>>>> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
>>>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>>> FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.
>> What are the symptoms?
> During boot I normally have
>  
> [    0.930231] virtio_blk virtio1: [vda] 5409180 4096-byte logical blocks (22.2 GB/20.6 GiB)
> [    0.930233] vda: detected capacity change from 0 to 22156001280
> [    0.932806]  vda:VOL1/  0X3333: vda1 vda2 vda3
>
> With this change, the last line is no longer there (if CONFIG_DASD=m) and this also 
> reflects itself in /proc/partitions. The partitions are no longer detected.

OK, looks like the module is not loaded and with

        fn = symbol_get(dasd_biodasdinfo);
        if (!fn)
                goto out_exit;

the ibm.c partition detection aborts.

Solution could be not to exit in this case but jump to the probing
process. I will have a closer look at this.

