Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A329556A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 02:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507406AbgJVAQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 20:16:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59728 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507399AbgJVAQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 20:16:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M0F6Gs066888;
        Thu, 22 Oct 2020 00:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qton4V8YMssGlbqndgLCxMLgvps5qQDKbjPPPF+Lq4w=;
 b=SbjI6inLQvPQlpE04tCLH9aNYclxHYLTA7v1a5jRhXEkzE7k+HywiZRvTY8cyAtyF2Cq
 KnMVQwSbHoEyTh4j7TD8QCipVDa94dCZellWfa5cea0pxMsrZVOSU9lcnkbAgsv8QS6Q
 MDDktK/K7LLAJdkzkRXBoxvGHVHsi5YSxPCLHH5aK1Eh7Kv6WNvqoAfcMYh58P7Q75tH
 r2f7GoFe+sDPT8IIvtZG8ndJ9v3QGv7C3qDfuO3FSiZ53ii4zyWUx3AhJ1CqBGzKAeBm
 YeTUm/SUTVYAvkhCl0jjzI3VPufLrJdynJbfGoHCKwKCgJ0PL5qkCWKOtWcZPACwcDRp Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 349jrpueuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 00:16:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M0G6LN151197;
        Thu, 22 Oct 2020 00:16:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 348a6q0t8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 00:16:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M0FsFh020722;
        Thu, 22 Oct 2020 00:15:55 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Oct 2020 17:15:54 -0700
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
References: <20201016225254.3853109-1-guro@fb.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3f455d27-6d99-972f-b77f-b5b473b7614d@oracle.com>
Date:   Wed, 21 Oct 2020 17:15:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201016225254.3853109-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:52 PM, Roman Gushchin wrote:
> This small patchset makes cma_release() non-blocking and simplifies
> the code in hugetlbfs, where previously we had to temporarily drop
> hugetlb_lock around the cma_release() call.
> 
> It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
> THP under a memory pressure requires a cma_release() call. If it's
> a blocking function, it complicates the already complicated code.
> Because there are at least two use cases like this (hugetlbfs is
> another example), I believe it's just better to make cma_release()
> non-blocking.
> 
> It also makes it more consistent with other memory releasing functions
> in the kernel: most of them are non-blocking.

Thanks for looking into this Roman.

I may be missing something, but why does cma_release have to be blocking
today?  Certainly, it takes the bitmap in cma_clear_bitmap and could
block.  However, I do not see why cma->lock has to be a mutex.  I may be
missing something, but I do not see any code protected by the mutex doing
anything that could sleep?

Could we simply change that mutex to a spinlock?
-- 
Mike Kravetz
