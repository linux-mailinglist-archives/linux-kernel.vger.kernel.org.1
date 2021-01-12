Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75672F3CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437419AbhALVeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34716 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436764AbhALUNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:13:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CK9oEL032853;
        Tue, 12 Jan 2021 20:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=laFX/HAfU+qzq2ofvncNg04yx1ExXeNRXIbgc+vDoeQ=;
 b=ErpmWMRe1ncknNKD84nF8AtT1rjqLV6bvWfOH+jjM28E/p8kk2S1ep6Z1jQvt3Olsb4k
 YJjLIiUDEdVGjFxXKM9J1HmDyL8BZEHveKDyI9mYyfhXDsHaHjsMv1pfvLI0/ycOkhFE
 F74o9uzorMgIZS6n9BJ4Qbaq6bk64kMgwABQeKW59XdrxuKJ/6yMyJABe+DExuBpPhrc
 ZRFWttMnpk2OjyH4UwmdhkBFdr2qjUgAdJeDt2Pyu7WAuHixvHd7IObFvCoq/xw4oqEc
 fVOg7czlh+FXv2l0tghyUWcQRCDre80ZKpU92ETQC0hwUZQsS1iLeVfJQbt6eZwBkgfj Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyr9p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 20:12:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CKA4F8102785;
        Tue, 12 Jan 2021 20:12:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 360keybfcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 20:12:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CKCA6P026278;
        Tue, 12 Jan 2021 20:12:11 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 12:12:10 -0800
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
 <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com>
 <20210112112709.GO22493@dhcp22.suse.cz>
 <d00da0ca-8a2b-f144-b455-2887fd269ed7@redhat.com>
 <20210112121643.GP22493@dhcp22.suse.cz>
 <20210112142337.GR22493@dhcp22.suse.cz>
 <52ec4899-80df-4cbe-41f1-e0a29e838afa@redhat.com>
 <20210112145325.GS22493@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <70b5cf44-9f8c-2149-0920-823045be3fe1@oracle.com>
Date:   Tue, 12 Jan 2021 12:12:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210112145325.GS22493@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 6:53 AM, Michal Hocko wrote:
> On Tue 12-01-21 15:41:02, David Hildenbrand wrote:
>> On 12.01.21 15:23, Michal Hocko wrote:
>>> On Tue 12-01-21 13:16:45, Michal Hocko wrote:
>>> [...]
>>>> Well, currently pool pages are not migrateable but you are right that
>>>> this is likely something that we will need to look into in the future
>>>> and this optimization would stand in the way.
>>>
>>> After some more thinking I believe I was wrong in my last statement.
>>> This optimization shouldn't have any effect on pages on the pool as
>>> those stay at reference count 0 and they cannot be isolated either
>>> (clear_page_huge_active before it is enqueued).
>>>
>>> That being said, the migration code would still have to learn about
>>> about this pages but that is out of scope of this discussion.
>>>
>>> Sorry about the confusion from my side.
>>>
>>
>> At this point I am fairly confused what's working at what's not :D
> 
> heh, tell me something about that. Hugetlb is a maze full of land mines.
> 
>> I think this will require more thought, on how to teach
>> alloc_contig_range() (and eventually in some cases offline_pages()?) to
>> do the right thing.
> 
> Well, offlining sort of works because it retries both migrates and
> dissolves. It can fail with the later due to reservations but that can
> be expected. We can still try harder to rellocate/rebalance per numa
> pools to keep the reservation but I strongly suspect nobody has noticed
> this to be a problem so there we are.

Due to my time zone, I get to read all the previous comments before
commenting myself. :)

To be clear, this patch is handling a very specific case where a hugetlb
page was isolated for migration and after being isolated the last reference
to the page was dropped.  Normally, dropping the last reference would send
the page to free_huge_page processing.  free_huge_page processing would
either dissolve the page to the buddy allocator or more likely place the
page on the free list of the pool.  However, since isolation also holds
a reference to the page, processing is continued down the migration path.

Today there is no code to migrate free huge pages in the pool.  Only
active in use pages are migrated.  Without this patch, 'free pages' in
the very specific state above would be migrated.  But to be clear, that
was never the intention of any hugetlb migration code.  In that respect,
I believe this patch helps the current code work as designed.

David brings up the valid point that alloc_contig_range needs to deal
with free hugetlb pool pages.  However, that is code which needs to be
written as it does not exist today.  I suspect nobody thought about free
hugetlb pages when alloc_contig_range was written.  This patch should
in no way hinder development of that code.  Free huge pages have a ref
count of 0, and this code is checking for ref count of 1.

That is a long way of saying that I still agree with this patch.  The
only modification/suggestion would be enhancing the commit message as
suggested by Michal.
-- 
Mike Kravetz
