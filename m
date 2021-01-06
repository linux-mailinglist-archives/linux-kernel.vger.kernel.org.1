Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8682C2EB6B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAFAIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:08:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34720 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:08:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10604jKt081856;
        Wed, 6 Jan 2021 00:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=J/YOMPAISoWCw/4a9GsBv0ENoQiezDgKQoXpHWXosMo=;
 b=Mr1LMciFlfwTjMqWiVtkAzi3nT1D8vtofUYMko4zEtLpoPRtffJn44pBsiu0Bk7GDxcy
 mQHvOxTx3dt/0+PciEFJGzOWk7KGg7adAdWTtynLEhZTSxmWLmgq8AKhZdroA8HeYPR5
 51Q/hpv7PckrHJRXvjBbRGAaRw2flwg+XxZw4d89SG2QtXBr39XOE112Ia+XnR5i7CRJ
 ssyzHxg/kmx0GZdonEaKwmKU20eQCws08ubzilQX0sdI3JFZ6qqU+kDdVzsLrzCwNHgo
 c1fnHkszkoB+ELh1Sy6cfdFY3uNhjsWnxCT2padHjejiCqVLo+wLhHSrPbkzM1Wj9M4O JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35tebaubrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 00:07:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10600lFV003405;
        Wed, 6 Jan 2021 00:07:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 35v1f9843g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 00:07:51 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10607nkC027331;
        Wed, 6 Jan 2021 00:07:50 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 16:07:49 -0800
Subject: Re: [External] Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-4-songmuchun@bytedance.com>
 <e043e137-5ca7-d478-248c-9defcecc6ac7@oracle.com>
 <CAMZfGtXZqbNwb2k5sq29gXSBMO3sVNaATiJnPWSggoAG5mZMqA@mail.gmail.com>
 <CAMZfGtVU5WfEWbin5hxAkkWLVJw15n2crtPMkmHDRxkBo4_TOQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7b30ad06-aced-817c-181c-a2099ba08918@oracle.com>
Date:   Tue, 5 Jan 2021 16:07:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVU5WfEWbin5hxAkkWLVJw15n2crtPMkmHDRxkBo4_TOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 7:46 PM, Muchun Song wrote:
> On Tue, Jan 5, 2021 at 11:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
>>
>> On Tue, Jan 5, 2021 at 9:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 1/3/21 10:58 PM, Muchun Song wrote:
>>>> When dissolve_free_huge_page() races with __free_huge_page(), we can
>>>> do a retry. Because the race window is small.
>>>
>>> In general, I agree that the race window is small.  However, worst case
>>> would be if the freeing of the page is put on a work queue.  Is it acceptable
>>> to keep retrying in that case?  In addition, the 'Free some vmemmap' series
>>> may slow the free_huge_page path even more.
>>
>> I also consider the 'Free some vmemmap' series case. In my next
>> version series, I will flush the work before dissolve_free_huge_page
>> returns when encountering this race. So the retry is acceptable.
>> Right?
> 
> Hi Mike,
> 
> How about flushing the @free_hpage_work when
> encountering this race?

Flushing should be fine.

The more I think about it, the more I think spinning to retry is not
going to be an issue.  Why?  As you mentioned the race window is quite
small.  It just makes me a bit nervous to retry in a tight loop.
-- 
Mike Kravetz
