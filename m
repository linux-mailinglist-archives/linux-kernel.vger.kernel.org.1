Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD222F5182
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbhAMRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:54:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbhAMRyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:54:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DHZBf3098943;
        Wed, 13 Jan 2021 17:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qbDssNLS+0hbXxL6onEJkAwBEjoO8dlE/j6HkmFwTeY=;
 b=MnKxaB132BD0cjCstxYNiLVb9rhVB/jswC6f9oBB+CJa/ZywkWZGW7hE7Hn4d5F4ac3P
 nI2GDY5qJev2g5DR3IjPKNUxak3OA3jcRL2r8u1K3fxLmK/Gh869CXAO+F5quzxstb1E
 Ret5JhhU0KvRP13pOgmQ9NZMIjzBJMw2xtDVLJKhuLTXKMXE7FVPjgwQnmUFsXKNihQR
 CkWdVlZk963xcp9SJbjMZYuZVZuo5OYq3ok8O00PFHVMsYCi3KLeiA0boOz1ePR04F5s
 WPzMTqvyrNeRCu6yIZ3puOQUqDSqaMCJTL67VoaQg4lMkcHB6banwLXZZEZV8Zp3kMIh JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 360kvk4phy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 17:53:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DHYZL0148702;
        Wed, 13 Jan 2021 17:51:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 360kf81pwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 17:51:13 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10DHpAVH020877;
        Wed, 13 Jan 2021 17:51:10 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 09:51:10 -0800
Subject: Re: [RFC PATCH 1/3] hugetlb: use page.private for hugetlb specific
 page flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-2-mike.kravetz@oracle.com>
 <20210113144520.GO35215@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <967613fc-c970-dc22-efef-ef442b65245b@oracle.com>
Date:   Wed, 13 Jan 2021 09:51:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210113144520.GO35215@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=954 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=979 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 6:45 AM, Matthew Wilcox wrote:
> On Mon, Jan 11, 2021 at 01:01:50PM -0800, Mike Kravetz wrote:
>> +	if (hpage_spool(page)) {
> 
> Could this be named hpage_subpool(), please?
> 

Of course!

-- 
Mike Kravetz
