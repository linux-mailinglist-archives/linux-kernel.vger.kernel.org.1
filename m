Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97DB2EEAB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbhAHBJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:09:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41086 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbhAHBJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:09:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10813oah092989;
        Fri, 8 Jan 2021 01:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vJYZ13cXxFkQ+MJP9Qv7/yIo9FE9hy8UjOwKUfe1eg4=;
 b=tt+/21Oo6cFEyIfSy850JdlWYQ5LjFNV8at6v4cKOo3H5m+HQl1QpQTf+D21oxzd0Cbs
 OQSKqoEEjXFowLHCZNn+1HWTkAm0nEHELWvLYHA8CHvfgSAerO5QB1cMdb/QQT+H/IE+
 lXRdrflyC5j5Y53e8Qx67AZf0HYwSm4sAwIaK1OK0/G/xXXcisPZDXd1l4ODw6uTM4kR
 KFHI30NiTvPmc7kf6UyuajSbBWUSQiPByFtOqf5yBvEeqQjf2jMvUHrkiXVUY35lyWtQ
 dWjtmQzZp/E74PlyLBm1CBOc7CFBtwVu7Hy3PhORg8Ezin7/BOSRhL78FvRcsutkt4V5 UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35wftxenvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 01:08:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10810VK3160063;
        Fri, 8 Jan 2021 01:06:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35w3qujs04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 01:06:30 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10816RRa025514;
        Fri, 8 Jan 2021 01:06:27 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 01:06:26 +0000
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com>
 <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz>
 <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz>
 <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz>
 <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz>
 <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <eccfda79-eeb6-7081-4902-1881f8910610@oracle.com>
Date:   Thu, 7 Jan 2021 17:06:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 7:11 AM, Muchun Song wrote:
> On Thu, Jan 7, 2021 at 10:11 PM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Thu 07-01-21 20:59:33, Muchun Song wrote:
>>> On Thu, Jan 7, 2021 at 8:38 PM Michal Hocko <mhocko@suse.com> wrote:
>> [...]
>>>> Right. Can we simply back off in the dissolving path when ref count is
>>>> 0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
>>>> when the all above is true and the page is not being freed?
>>>
>>> The list_empty(&page->lru) may always return false.
>>> The page before freeing is on the active list
>>> (hstate->hugepage_activelist).Then it is on the free list
>>> after freeing. So list_empty(&page->lru) is always false.
>>
>> The point I was trying to make is that the page has to be enqueued when
>> it is dissolved and freed. If the page is not enqueued then something
>> racing. But then I have realized that this is not a great check to
>> detect the race because pages are going to be released to buddy
>> allocator and that will reuse page->lru again. So scratch that and sorry
>> for the detour.
>>
>> But that made me think some more and one way to reliably detect the race
>> should be PageHuge() check in the freeing path. This is what dissolve
>> path does already. PageHuge becomes false during update_and_free_page()
>> while holding the hugetlb_lock. So can we use that?
> 
> It may make the thing complex. Apart from freeing it to the
> buddy allocator, free_huge_page also does something else for
> us. If we detect the race in the freeing path, if it is not a HugeTLB
> page, the freeing path just returns. We also should move those
> things to the dissolve path. Right?
> 
> But I find a tricky problem to solve. See free_huge_page().
> If we are in non-task context, we should schedule a work
> to free the page. We reuse the page->mapping. If the page
> is already freed by the dissolve path. We should not touch
> the page->mapping. So we need to check PageHuge().
> The check and llist_add() should be protected by
> hugetlb_lock. But we cannot do that. Right? If dissolve
> happens after it is linked to the list. We also should
> remove it from the list (hpage_freelist). It seems to make
> the thing more complex.

You are correct.  This is also an issue/potential problem with this
race.  It seems that adding the state information might be the least
complex way to address issue.

-- 
Mike Kravetz
