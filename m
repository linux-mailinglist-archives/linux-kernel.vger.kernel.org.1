Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C083281AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbgJBSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:31:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBSba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:31:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092IPGUU177987;
        Fri, 2 Oct 2020 18:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9gBQcuPz6m35wYXTPN7cEh5aSZK5ohuA7xTu1JKejGg=;
 b=geaoa7EnzX6OI0Kld1LwXpyDkYQJjyuKYPlmwM9BAESb42XS2ui7Gnr7kZHpptWTuXGz
 06GSfQ+fsi+shNdyGhRz7UHPTr4sbtIkoXOpdCGP71KglVNu5vZjjbzdIThuWYkNsEJ8
 eVsUr11SrUAgxqvZiMkFjLceAtC9tbjs7Fea5HUQSr/1VnWjqPkmWKPQ5BhfAKg+qcxr
 DehVe6pkEjLzTW1AdCNdTWAGeH9lizzhClJa3gR8gUEhjchwU8eA8InbZpHoyHJETHu7
 YWXbhw0Bhbj+ZwZS/58Vr98tnDZjrKtHCjaWXXGhEcSBRGn6v+p0ctMOwrmQKTpQ7axL IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33sx9nma66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 18:31:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092IOtB0040175;
        Fri, 2 Oct 2020 18:31:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33tfdxxpy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 18:31:14 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 092IVCkD012243;
        Fri, 2 Oct 2020 18:31:12 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 11:31:11 -0700
Subject: Re: [v5] mm: khugepaged: recalculate min_free_kbytes after memory
 hotplug as expected by khugepaged
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1601398153-5517-1-git-send-email-vijayb@linux.microsoft.com>
 <2a380b84-4fee-fa4e-e862-8a8577961088@oracle.com>
 <8cdb105c-2b7b-1997-ed82-22f4bb25638c@linux.microsoft.com>
 <638ebb7a-72e3-a219-ee2b-55f1c028efad@oracle.com>
 <20201002112516.GD4555@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9bc3d446-ea25-6abf-bd9d-0c24009c8a19@oracle.com>
Date:   Fri, 2 Oct 2020 11:31:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002112516.GD4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 4:25 AM, Michal Hocko wrote:
> On Wed 30-09-20 15:03:11, Mike Kravetz wrote:
>> On 9/30/20 1:47 PM, Vijay Balakrishna wrote:
>>> On 9/30/2020 11:20 AM, Mike Kravetz wrote:
>>>> On 9/29/20 9:49 AM, Vijay Balakrishna wrote:
>>>>
>>>> Sorry for jumping in so late.  Should we use this as an opportunity to
>>>> also fix up the messages logged when (re)calculating mfk?  They are wrong
>>>> and could be quite confusing.
>>>
>>>
>>> Sure.  Please share your thoughts regarding appropriate message.  Here is what I'm thinking
>>>
>>> pr_warn("min_free_kbytes is not updated to %d because current value %d is preferred\n", new_min_free_kbytes, min_free_kbytes);
>>>
>>> If above message is reasonable I can post a new revision (v6).
>>
>> Just considering the below example,
>>
>>>> For example consider the following sequence
>>>> of operations and corresponding log messages produced.
>>>>
>>>> Freshly booted VM with 2 nodes and 8GB memory:
>>>> # cat /proc/sys/vm/min_free_kbytes
>>>> 90112
>>>> # echo 90000 > /proc/sys/vm/min_free_kbytes
>>>> # cat /proc/sys/vm/min_free_kbytes
>>>> 90000
>>>> # echo 0 > /sys/devices/system/node/node1/memory56/online
>>>> [  135.099947] Offlined Pages 32768
>>>> [  135.102362] min_free_kbytes is not updated to 11241 because user defined value 90000 is preferred
>>
>> I am not sure if there is any value in printing the above line.  Especially
>> in this context as it becomes obsolete with the printing of the next line.
> 
> The original intention was to make it explicit that auto-tuning is
> influenced by the user provided configuration.
> 
>>>> [  135.109070] khugepaged: raising min_free_kbytes from 90000 to 90112 to help t
>>>> ransparent hugepage allocations
>>
>> IMO, the above line is the only one that should be output as a result of the
>> recalculation.
> 
> Well, but khugepaged could be disabled and then the above might not get
> printed. Sure the code could get reorganized and all that but is this
> really worth that?
> 
>> I guess that brings up the question of 'should we continue to track the user
>> defined value if we overwrite it?".  If we quit tracking it may help with the
>> next message.
> 
> Auto tuning and user provided override is quite tricky to get sensible.
> Especially in the case here. Admin has provided an override but has the
> potential memory hotplug been considered? Or to make it even more
> complicated, consider that the hotplug happens without admin involvement
> - e.g. memory gets hotremoved due to HW problems. Is the admin provided
> value still meaningful? To be honest I do not have a good answer and I
> am not sure we should care all that much until we see practical
> problems.

I am not insisting that this be cleaned up.  The change in this patch to
ensure THP related calculations are performed during hotplug is the most
important.

I became aware of the logging issues when looking at a customer issue with
an older kernel.  The min_free_kbytes setting was integral to the issue we
were investigating, and it was unclear whether or not the customer had
changed the value.  I knew the system log should contain evidence of manually
setting min_free_kbytes.  However, there was no evidence in the log.  Turns
out the customer did not change the value, but it did cause me to do a deep
dive into the logging code.
-- 
Mike Kravetz
