Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2328FB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbgJOXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:14:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36194 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgJOXO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:14:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FNEGti178107;
        Thu, 15 Oct 2020 23:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hJx/AgWMGPKkGZaHQF/0+N3HhJZonJmQaRzSZ2ORaOE=;
 b=qNWBDJ94FU15z5ETkIjDsfCCj1wuoHpqrz/GRK5qZh52Ql39atO5RilXs0jzOpCvVOEf
 3YDm3L4WzEsxTxIwf9FX1JeFWXEiOSPPsfe+VXdM24lJ+sXdiPPL68Oo+hdGfN+keA15
 upipCVmSWjHS9bmvXzjq/DPEgajrm/cW/tMsmRZFiHCLyBLuKWJo2PEtES3dc3UO6T55
 zhjdzrbAor4sHnSgUu5TbMcsrX51r8bwleaKhUVhR5fO+r38ngrP0qiz58dDoGlqT8yX
 57TWmgPegsN6zPLuV+fVmJbnFcSagUmTiBTdyZ1fvECdU3NV0elSjMgl97wpPvVHuNWT ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 343vaenp4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 23:14:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FNAe0j112404;
        Thu, 15 Oct 2020 23:14:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 343pw10ey0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 23:14:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FNEEI8014291;
        Thu, 15 Oct 2020 23:14:14 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 16:14:14 -0700
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Privoznik <mprivozn@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <c1ea7548-622c-eda7-66f4-e4ae5b6ee8fc@redhat.com>
 <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
 <CAHS8izPEHZunoeXYS5ONfRoSRMpC7DQwtpjJ8g4nXiddTfNoaA@mail.gmail.com>
 <65a1946f-dbf9-5767-5b51-9c1b786051d1@redhat.com>
 <5f196069-8b98-0ad3-55e8-19af03d715cd@oracle.com>
Message-ID: <c78634ee-0d6f-c98c-3c2a-8cb500c0ae47@oracle.com>
Date:   Thu, 15 Oct 2020 16:14:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5f196069-8b98-0ad3-55e8-19af03d715cd@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=2 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=2 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 11:31 AM, Mike Kravetz wrote:
> On 10/14/20 11:18 AM, David Hildenbrand wrote:
> 
> FWIW - I ran libhugetlbfs tests which do a bunch of hole punching
> with (and without) hugetlb controller enabled and did not see this issue.
> 

I took a closer look after running just the fallocate_stress test
in libhugetlbfs.  Here are the cgroup counter values:

hugetlb.2MB.failcnt 0
hugetlb.2MB.limit_in_bytes 9223372036854771712
hugetlb.2MB.max_usage_in_bytes 209715200
hugetlb.2MB.rsvd.failcnt 0
hugetlb.2MB.rsvd.limit_in_bytes 9223372036854771712
hugetlb.2MB.rsvd.max_usage_in_bytes 601882624
hugetlb.2MB.rsvd.usage_in_bytes 392167424
hugetlb.2MB.usage_in_bytes 0

We did not hit the WARN_ON_ONCE(), but the 'rsvd.usage_in_bytes' value
is not correct in that it should be zero.   No huge page reservations
remain after the test.

HugePages_Total:    1024
HugePages_Free:     1024
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:         2097152 kB

To try and better understand the reservation cgroup controller, I addded
a few printks to the code.  While running fallocate_stress with the
printks, I can consistently hit the WARN_ON_ONCE() due to the counter
going negative.  Here are the cgroup counter values after such a run:

hugetlb.2MB.failcnt 0
hugetlb.2MB.limit_in_bytes 9223372036854771712
hugetlb.2MB.max_usage_in_bytes 209715200
hugetlb.2MB.rsvd.failcnt 3
hugetlb.2MB.rsvd.limit_in_bytes 9223372036854771712
hugetlb.2MB.rsvd.max_usage_in_bytes 251658240
hugetlb.2MB.rsvd.usage_in_bytes 18446744073487253504
hugetlb.2MB.usage_in_bytes 0

Again, no reserved pages after the test.

HugePages_Total:    1024
HugePages_Free:     1024
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:         2097152 kB

I have some basic hugetlb hole punch functionality tests.  Running
these on the kernel with added printk's does not cause any issues.
In order to reproduce, I need to run fallocate_stress test which
will cause hole punch to race with page fault.  Best guess at this
time is that some of the error/race detection reservation back out
code is not properly dealing with cgroup accounting.

I'll take a look at this as well.
-- 
Mike Kravetz
