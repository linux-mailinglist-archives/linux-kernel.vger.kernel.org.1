Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6892B08BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgKLPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:45:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgKLPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:45:50 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFX3IU190272;
        Thu, 12 Nov 2020 10:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aMlyye4rrFcjn8vxBO/cshtHW6Pbn22aPrH1Hrnofpc=;
 b=tcHZWvAF+X1+9DdRIxvCpTp8eNRVV2y8Z6Y855iagIDhfFlOwpwzQDrr+OscJMEd/cvh
 9vCuv7t7qVzlkVxEiqn5kTdR+kqpC7XI2zlNRck19HaPfLNsWl9xCsWX4f8KDrbv6AH4
 Wc0y0KUPbDJ4AiWKC/hTMp/6c0O5cFilpHJ9Zo6bnW5xm/INjUMrxjMvphZce6Za9vf+
 qX0qOU7LJSSatl9UJ0zhN6Ltz8vRI4ogDHf/eYsbGLxIb4GkHi/NUKXmadSpKlBgfGVC
 /w8HLvcCEtiD4Z7kxKczt8nnWry44uKiH2xa/DqOxd8ynMDDK9N6TBSG5m4egpyoBH3N 0g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34rjnps6b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 10:45:40 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFTRbT007103;
        Thu, 12 Nov 2020 15:45:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh5u0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 15:45:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ACFjaMZ45810040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 15:45:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01885AE05D;
        Thu, 12 Nov 2020 15:45:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B00D5AE045;
        Thu, 12 Nov 2020 15:45:35 +0000 (GMT)
Received: from [9.171.86.225] (unknown [9.171.86.225])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 15:45:35 +0000 (GMT)
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
Date:   Thu, 12 Nov 2020 16:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_06:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 3:53 PM, Keith Busch wrote:
> On Thu, Nov 12, 2020 at 09:23:00AM +0100, Niklas Schnelle wrote:
>> while searching for a bug around zPCI + NVMe IRQ handling on a distro
>> kernel, I got confused around handling of the maximum number
>> of I/O queues in the NVMe driver.
>> I think I groked it in the end but would like to propose the following
>> improvements, that said I'm quite new to this code.
>> I tested both patches on s390x (with a debug config) and x86_64 so
>> with both data center and consumer NVMes.
>> For the second patch, since I don't own a device with the quirk, I tried
>> always returning 1 from nvme_max_io_queues() and confirmed that on my
>> Evo 970 Pro this resulted in about half the performance in a fio test
>> but did not otherwise break things. I couldn't find a reason why
>> allocating only the I/O queues we actually use would be problematic in
>> the code either but I might have missed something of course.
> 
> I don't think you missed anything, and the series looks like a
> reasonable cleanup. I suspect the code was left over from a time when we
> didn't allocate the possible queues up-front.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> 

You got to get something wrong, I hope in this case it's just the subject
of the cover letter :D
Thanks for the review, I appreciate it. Might be getting ahead of
myself but I'm curious who would take this change through their
tree if accepted?
