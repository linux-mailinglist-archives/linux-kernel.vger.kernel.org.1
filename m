Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8457B27F4CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgI3WFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:05:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39574 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgI3WF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:05:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UM4J8n128444;
        Wed, 30 Sep 2020 22:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dEI1XFVAP3dO22J83ni6gam/jwqNT6J8dRFRe/LNyUY=;
 b=IvlUP+pkxPJVt0ergcD/KafVY/MoorsaP0zVgRx+6Zphm5h2Xu8y8KeaEfCLSqN682z+
 ePhKYYKbudlg6ghnhTgo1ObY1j3/OX5y3rw3N47yOSwAvCEj2iZBTwKcn73MDnWg0A7x
 kjUHeNxXPZU65H4Eu0QdRdv2qG4ee45DRymC6Q6sW/U5KdEylwGUEoeYrX2euuzN5r2s
 OxOxxzaaHouFdZ1hbSof/8yqPeHW79WuxiEfUlnu2mrGIBYavnXAsaFc4FLmPU2cMvgc
 X0B7tFpTURCNGcgn9BvGQJOnXbUKwL9lPT7nXX6GqrZfSdhHiVxdm5sVqjsJ6hXEA8VK YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33su5b33vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 22:05:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ULinrw165081;
        Wed, 30 Sep 2020 22:03:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33tfdupnms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 22:03:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UM3CYQ014537;
        Wed, 30 Sep 2020 22:03:13 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 15:03:12 -0700
Subject: Re: [v5] mm: khugepaged: recalculate min_free_kbytes after memory
 hotplug as expected by khugepaged
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1601398153-5517-1-git-send-email-vijayb@linux.microsoft.com>
 <2a380b84-4fee-fa4e-e862-8a8577961088@oracle.com>
 <8cdb105c-2b7b-1997-ed82-22f4bb25638c@linux.microsoft.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <638ebb7a-72e3-a219-ee2b-55f1c028efad@oracle.com>
Date:   Wed, 30 Sep 2020 15:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8cdb105c-2b7b-1997-ed82-22f4bb25638c@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/20 1:47 PM, Vijay Balakrishna wrote:
> On 9/30/2020 11:20 AM, Mike Kravetz wrote:
>> On 9/29/20 9:49 AM, Vijay Balakrishna wrote:
>>
>> Sorry for jumping in so late.  Should we use this as an opportunity to
>> also fix up the messages logged when (re)calculating mfk?  They are wrong
>> and could be quite confusing.
> 
> 
> Sure.  Please share your thoughts regarding appropriate message.  Here is what I'm thinking
> 
> pr_warn("min_free_kbytes is not updated to %d because current value %d is preferred\n", new_min_free_kbytes, min_free_kbytes);
> 
> If above message is reasonable I can post a new revision (v6).

Just considering the below example,

>> For example consider the following sequence
>> of operations and corresponding log messages produced.
>>
>> Freshly booted VM with 2 nodes and 8GB memory:
>> # cat /proc/sys/vm/min_free_kbytes
>> 90112
>> # echo 90000 > /proc/sys/vm/min_free_kbytes
>> # cat /proc/sys/vm/min_free_kbytes
>> 90000
>> # echo 0 > /sys/devices/system/node/node1/memory56/online
>> [  135.099947] Offlined Pages 32768
>> [  135.102362] min_free_kbytes is not updated to 11241 because user defined value 90000 is preferred

I am not sure if there is any value in printing the above line.  Especially
in this context as it becomes obsolete with the printing of the next line.

>> [  135.109070] khugepaged: raising min_free_kbytes from 90000 to 90112 to help t
>> ransparent hugepage allocations

IMO, the above line is the only one that should be output as a result of the
recalculation.

I guess that brings up the question of 'should we continue to track the user
defined value if we overwrite it?".  If we quit tracking it may help with the
next message.

>> # cat /proc/sys/vm/min_free_kbytes
>> 90112
>> # echo 1 > /sys/devices/system/node/node1/memory56/online
>> [  231.656075] min_free_kbytes is not updated to 11334 because user defined value 90000 is preferred

I do not see any value in this line of output.  Neither value (11334 or 90000)
is actually of use.  We did not recalculate/change mfk.  Perhaps no output is
necessary in this case? 

>> # cat /proc/sys/vm/min_free_kbytes
>> 90112

All this may be out of scope for this patch and done with a update.  However,
I think it is something that should be considered.
-- 
Mike Kravetz
