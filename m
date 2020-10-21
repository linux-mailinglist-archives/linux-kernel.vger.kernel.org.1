Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726D6295138
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503286AbgJUQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:58:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39322 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503273AbgJUQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:58:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LGssuE087714;
        Wed, 21 Oct 2020 16:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=St6NbUuetB4WWahignxQ8U4PRoP0SojmI+uST7Q/AiQ=;
 b=zkgyUFyh879JxQkM0hgpKjbPDQIMYy3pyZVIj98XKui70FhOOzzclZrN5NNyxQtl4Khy
 2qulsexTFlyVco9x8KNR3L9hnyEhJ08hTKFR+TEJGFH0EEfyDSSWbTAZcKMDdKYxazy/
 vVn9Z8GVxbC+B0nuR2brqgPo30zTUClFFbni4LBB4RZnYZkCmo1njxLTBPSbxb+6ZMom
 dt2f7kmmpgnU9NZ1Bi8BGnsU8p3BGu44xDC+MBHOShH9J/+FBZvr+j05xHRuO4+yf/OQ
 WJChPtdEdrfmTAMWRoprfFzESMUf/cj0PkgunpFDw5jlfdyN1YR5MF3oQk72ceDtAudg tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 347p4b1rwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 16:58:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LGte6e125398;
        Wed, 21 Oct 2020 16:58:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 348agyw3k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 16:58:28 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09LGwQhU023106;
        Wed, 21 Oct 2020 16:58:26 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Oct 2020 09:58:26 -0700
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
To:     David Hildenbrand <david@redhat.com>,
        Michal Privoznik <mprivozn@redhat.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
 <c78634ee-0d6f-c98c-3c2a-8cb500c0ae47@oracle.com>
 <b24380ad-b87c-a3a1-d25e-ee30c10ed0d2@redhat.com>
 <312246f4-4e5f-1425-1bc2-1b356db0fbad@oracle.com>
 <df406c04-b0f4-367f-d675-87e0231500d0@redhat.com>
 <9ad697d7-ed64-24f3-17cf-fa8dbbdcf86a@redhat.com>
 <bcbe71c9-f6a4-be19-329c-2fb0b675ae89@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <be1e53c3-262c-e6f5-d68b-ab41c40d11ac@oracle.com>
Date:   Wed, 21 Oct 2020 09:58:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <bcbe71c9-f6a4-be19-329c-2fb0b675ae89@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 21.10.20 15:11, David Hildenbrand wrote:
>> On 21.10.20 14:57, Michal Privoznik wrote:
>>> On 10/21/20 5:35 AM, Mike Kravetz wrote:
>>>> On 10/20/20 6:38 AM, David Hildenbrand wrote:
>>>>
>>>> It would be good if Mina (at least) would look these over.  Would also
>>>> be interesting to know if these fixes address the bug seen with the qemu
>>>> use case.
>>>>
>>>> I'm still doing more testing and code inspection to look for other issues.
>>>>
...
...
>>>
>>> I've applied, rebuilt and tested, but unfortunately I still hit the problem:
>>> [ 6472.719047] ------------[ cut here ]------------
>>> [ 6472.719052] WARNING: CPU: 6 PID: 11773 at mm/page_counter.c:57 
...
...
>>
>> Agreed, same over here. :(
>>
> 
> I *think* the following on top makes it fly
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 67fc6383995b..5cf7f6a6c1a6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -656,6 +656,9 @@ static long region_del(struct resv_map *resv, long
> f, long t)
> 
>                         del += t - f;
> 
> +                       hugetlb_cgroup_uncharge_file_region(
> +                               resv, rg, t - f);
> +
>                         /* New entry for end of split region */
>                         nrg->from = t;
>                         nrg->to = rg->to;
> @@ -667,9 +670,6 @@ static long region_del(struct resv_map *resv, long
> f, long t)
>                         /* Original entry is trimmed */
>                         rg->to = f;
> 
> -                       hugetlb_cgroup_uncharge_file_region(
> -                               resv, rg, nrg->to - nrg->from);
> -
>                         list_add(&nrg->link, &rg->link);
>                         nrg = NULL;
>                         break;
> 
> 

Thanks, yes that certainly does look like a bug in that code.

Does that resolve the issue with quemu?

I want to do a little more testing/research before sending a patch later
today.
-- 
Mike Kravetz
