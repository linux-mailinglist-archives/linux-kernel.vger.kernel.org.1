Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4879E2F87A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbhAOV0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:26:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42722 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbhAOV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:26:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FLOBOJ054198;
        Fri, 15 Jan 2021 21:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=d6vPsUrqgeQ55O+NW9PYrSEgpb2SKLM0EMmhPdABAws=;
 b=HvqI1pbv6WspHu7IpnttlXzFCAjdcaZEHH1lWNsetbsALBstleOu8Vtd2+G96lJhofKd
 hR1UP4aOHv0dmFl5Z6wPguumPstFJMLaeoONkkMv5rWs3TOZgZimVzEVDrfZPBxBltgG
 +PsHkgUtBInPTufDpQiEV8+ZwJPIoFrsrhYo0aCmtxSdYQenNJggFopEdE1TWYJ0F5Xl
 kFjkwRmP+G0tdafKEgooynYm8chHRaChkYVx7JwdjnJhMRS6ohKgNohpo+9L0v9+tiOQ
 eBaYM5e0kmqKFcP+hieB85vQuGrvbv++K8i4RNpJqSF9iPPfVSNQolGkpvG7k6j5DF3O 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kd06th3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 21:25:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10FLKIf3027199;
        Fri, 15 Jan 2021 21:25:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360kf3tju9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 21:25:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10FLPBtA015311;
        Fri, 15 Jan 2021 21:25:11 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jan 2021 13:25:11 -0800
Subject: Re: [RFC PATCH 2/3] hugetlb: convert page_huge_active() to
 HPageMigratable flag
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-3-mike.kravetz@oracle.com>
 <20210115091755.GB4092@linux>
 <d98039ef-8489-6d8c-a323-44e3f0d8acee@oracle.com>
 <41ca9f90-63e3-f991-3f78-433f77250527@oracle.com>
 <20210115202915.GA3322@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d38c9342-2544-0a0d-c905-2f81af105dac@oracle.com>
Date:   Fri, 15 Jan 2021 13:25:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210115202915.GA3322@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 12:29 PM, Oscar Salvador wrote:
> 
> About that alloc_contig_range topic, I would like to take a look unless
> someone is already on it or about to be.
> 
> Thanks Mike for the time ;-)

Feel free.

My first thought is that migration of a free hugetlb page would need to
be something like:
1) allocate a fresh hugetlb page from buddy
2) free the 'migrated' free huge page back to buddy

I do not think we can use the existing 'isolate-migrate' flow.  Isolating
a page would make it unavailable for allocation and that could cause
application issues.  

-- 
Mike Kravetz
