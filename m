Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1C2F8F80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 22:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhAPVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 16:54:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbhAPVyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 16:54:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10GLp10A149789;
        Sat, 16 Jan 2021 21:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NPIaIH+BiKIGU4IcGwHo877WmE0TuIG7/Z86F4Smw9Q=;
 b=tV5Qhd7RliAo5YHgDKAmw8D1eImMwF8b/ZiUi1oErr1nzg1XiJR3RW0N2YoROGE2Cw5L
 J2yryF2kWKc8JK9C40O6vm2Ti0OA2jRuc5Qh1OblM87F6pVlThaJ06pH1RoYU/+ihDqE
 Fwi3dojSNci2+VugLNRFah+BjR36odSzp8uSGH9gI4gbKyc5gez0owc+QqK8VfZta6sD
 7unzePDdlYhffYgDCiDu3y5AdUxy3JYga5MyqRj84oKZGtTVDY6N4ENPgggoym3rVkN9
 x8azapdEp6HvxeQgKCVREbxGEZWTGjXcU5EotIaOtPWdb77fxvYDzSZx2l/Uo/GcLOiR 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 363r3kh8r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 21:53:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10GLoUOT187635;
        Sat, 16 Jan 2021 21:53:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 363p6cbvym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 21:53:35 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10GLrPUB004858;
        Sat, 16 Jan 2021 21:53:26 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 Jan 2021 13:53:25 -0800
Subject: Re: [PATCH 2/5] hugetlb: convert page_huge_active() to HP_Migratable
 flag
To:     Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210116003105.182918-1-mike.kravetz@oracle.com>
 <20210116003105.182918-3-mike.kravetz@oracle.com>
 <20210116042416.GA2260413@casper.infradead.org>
 <20210116120628.GA3024@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b6c9d475-c944-ffe0-0da5-31090d684f2c@oracle.com>
Date:   Sat, 16 Jan 2021 13:53:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210116120628.GA3024@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9866 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9866 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/21 4:06 AM, Oscar Salvador wrote:
> On Sat, Jan 16, 2021 at 04:24:16AM +0000, Matthew Wilcox wrote:
>> and name these HPG_restore_reserve and HPG_migratable
>>
>> and generate the calls to hugetlb_set_page_flag etc from macros, eg:
>>
>> #define TESTHPAGEFLAG(uname, lname)					\
>> static __always_inline bool HPage##uname(struct page *page)		\
>> { return test_bit(HPG_##lname, &page->private); }
>> ...
>> #define HPAGEFLAG(uname, lname)						\
>> 	TESTHPAGEFLAG(uname, lname)					\
>> 	SETHPAGEFLAG(uname, lname)					\
>> 	CLEARHPAGEFLAG(uname, lname)
>>
>> HPAGEFLAG(RestoreReserve, restore_reserve)
>> HPAGEFLAG(Migratable, migratable)
>>
>> just to mirror page-flags.h more closely.
> 
> That is on me.
> I thought that given the low number of flags, we coud get away with:
> 
> hugetlb_{set,test,clear}_page_flag(page, flag)
> 
> and call it from the code.
> But some of the flags need to be set/tested outside hugetlb code, so
> it indeed looks nicer and more consistent to follow page-flags.h convention.
> 
> Sorry for the noise.

Thanks everyone!

I was unsure about the best way to go for this.  Will send out a new version
in a few days using the page-flag style macros.

-- 
Mike Kravetz
