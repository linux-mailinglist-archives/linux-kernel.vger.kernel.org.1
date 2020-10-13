Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF53C28C772
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgJMDBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:01:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJMDBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:01:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09D2xuAv019221;
        Tue, 13 Oct 2020 03:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/Mgri97OI/0Hb0Kx0p6sujuGJ0viOu/SqhO8yDEIFOs=;
 b=KztlVukC0XJP18XPV3ZNk9OOd10EcV6UcLCCEZXFIS5T40BNd4k3odzknqCHRGIas0hg
 r/Nmo9Sj5IY2nlpUwldLY7hgbB/YBblTironBxhes6vdtluQYAEk4ahu59Q5VYSw4q4G
 o76MlMjISENMlVMKwAp/KiKQeA32CrTFFsPq38cWy6dRJBk336TVQo16iuzmP75jm7hr
 fi7Bia1cRkg8enRrhMy7fPYv4mLiyZ+fxY8MzjSjpDIf46xLMT40/20eZAgFOJKgWj96
 UOxAz5O6BAjzxieL7D1oD28I31SxcIuR9HSgFxMzJ80H3q0Z+86HdlWlZ4Z+OZmbCIG/ eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 343vae683g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 03:01:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09D2xaPT107501;
        Tue, 13 Oct 2020 03:01:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 343phmms47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 03:01:19 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09D31F91020084;
        Tue, 13 Oct 2020 03:01:16 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Oct 2020 20:01:14 -0700
Subject: Re: [LKP] Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput
 -33.4% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200622005551.GK5535@shao2-debian>
 <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
 <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
 <d945497d-0edb-f540-33e1-8b1ba1e20f62@linux.intel.com>
 <691152ef-6787-9598-4445-fd2a0164f70f@oracle.com>
 <1f6d321e-96b4-18c3-2991-d6a2e94c9e60@oracle.com>
 <68992a81-a1b9-467b-59c4-48ab65c601c5@linux.intel.com>
 <7540556c-1e07-51b2-d903-829a887ef5b6@oracle.com>
 <4c95b307-90b5-798f-34c1-000ea5331ebb@linux.intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a44417ad-ad5c-aab6-d656-badd4cfad60e@oracle.com>
Date:   Mon, 12 Oct 2020 20:01:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4c95b307-90b5-798f-34c1-000ea5331ebb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 6:59 PM, Xing Zhengjun wrote:
> 
> 
> On 10/13/2020 1:40 AM, Mike Kravetz wrote:
>> On 10/11/20 10:29 PM, Xing Zhengjun wrote:
>>> Hi Mike,
>>>
>>>     I re-test it in v5.9-rc8, the regression still existed. It is almost the same as 34ae204f1851. Do you have time to look at it? Thanks.
>>>
>>
>> Thank you for testing.
>>
>> Just curious, did you apply the series in this thread or just test v5.9-rc8?
>> If just testing v5.9-rc8, no changes to this code were added after 34ae204f1851,
>> so results being the same are expected.
>>
> 
> I just test v5.9-rc8. Where can I find the series patches you mentioned here? Or just wait for the next mainline release?
> 

My apologies.  I missed that you were not cc'ed on this thred:
https://lore.kernel.org/linux-mm/20200706202615.32111-1-mike.kravetz@oracle.com/

As mentioned, there will likely be another revision to the way locking is
handled.  The new scheme will try to consider performance as is done in
the above link.  I suggest you wait for next revision.  If you do not mind,
I will cc you when the new code is posted.
-- 
Mike Kravetz
