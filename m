Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8529E13D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgJ2B4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:56:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44208 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgJ2BzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:55:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SIjMeh153267;
        Wed, 28 Oct 2020 18:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uDQ5BM3hbkhk4YSWy/Thm03XBgjemEvk/Pf2a3J9hIc=;
 b=ILeclu69TR4C3jJ918ppU9GKE/sFNqrA7ft70NLwxIFO92ExP71aMHVmKBxTJ+6w+O76
 NlVCi9W2KLXKon+jxmoE9qEMk3K9cIRTcK7AjUlXo6d9OzwHtkaXVNm/dMOSmxEVQ+ll
 PfzwGTqiojnO5RCDruqTBeGihQvsS7SuMCldseZX+syFfdteSsownRDpdK5Jbajy9E/d
 jwXXG3mN6nl7seKFfkN9Q8O0cTm8hM1fQOn3KMRwoC0sXGl+h4qcV8ds2QZzFqZxOBpS
 qHWj+ttwk7/dBIvN5t6lQVU+e9RCdWea1+qDeodDOyPUWSkJ52/ZEfINfQ5KPOqlTSJW +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34c9sb1atg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 18:48:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SIkThZ027035;
        Wed, 28 Oct 2020 18:48:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34cwunx6pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 18:48:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SIlwJ9010274;
        Wed, 28 Oct 2020 18:47:59 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 11:47:58 -0700
Subject: Re: [RFC PATCH 0/3] Allocate memmap from hotadded memory (per device)
To:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
 <3c18e078-25df-3fd4-9988-1b7677d8e05f@redhat.com>
 <20201027154031.GA11489@linux>
 <daedbc08-7275-40ad-0d07-007ef89ca25f@redhat.com>
 <20201027155851.GA11785@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <259889fb-f01b-9537-7948-f1a75a372617@oracle.com>
Date:   Wed, 28 Oct 2020 11:47:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201027155851.GA11785@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=952 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 8:58 AM, Oscar Salvador wrote:
> On Tue, Oct 27, 2020 at 04:44:33PM +0100, David Hildenbrand wrote:
>> I'm planning on looking into patch #2/3 later this or next week (this week
>> is open source summit / KVM Forum).
> 
> Sure, aprecciated the time ;-)
> 
>>
>> One thing to look into right now is how to make this fly this with vmemmap
>> optimizations for hugetlb pages.
>>
>> https://lkml.kernel.org/r/20201026145114.59424-1-songmuchun@bytedance.com
> 
> I was about to have a look at that series eitherway, but good you mentioned.
> 

More eyes on that series would be appreciated.

That series will dynamically free and allocate memmap pages as hugetlb
pages are allocated or freed.  I haven't looked through this series, but
my first thought is that we would need to ensure those allocs/frees are
directed to the device.  Not sure if there are interfaces for that.
-- 
Mike Kravetz
