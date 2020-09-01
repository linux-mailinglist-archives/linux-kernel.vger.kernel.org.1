Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4525A071
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 23:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgIAVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 17:05:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37374 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIAVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:05:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081L3Z2O178125;
        Tue, 1 Sep 2020 21:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nXG4/CL+hVOi2jIopJ0MFc0Agwfhg8ZWSwan1tEwxp4=;
 b=EVBdaelk/wBjPsGKV4go/ME7XRFrsAWxDVSpr6FSNW5MF+HmUPfM8vRl4CVxcXQTdCTS
 hiZkFOw2UUmRxkwUkvld8+313wUpezgN71VXwPIXV86uMGVKeRj7fqPQhkx84ZUVbZ3C
 PKkC/j4VovMpniWbFPgUmN2g+q3DZsY9ZRFwzzow0YRir6SwXGWM7ix4jeY71SzIbJIf
 Jv6umT0S65S50y1RF/dGJqe/gnwA22qtBxg+plfUgBFqPD6geKWGImQYU1ukWayiCIno
 oIeJVO7lJf9gH0bhmMeVH+aQowLPEkeBylHwGPzukzV9lRbdR9ugEclJrKbZLms/Uy6z 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmmwbu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 21:05:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081L51n4054616;
        Tue, 1 Sep 2020 21:05:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380ssjgr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 21:05:03 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 081L51Uf014522;
        Tue, 1 Sep 2020 21:05:02 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 14:05:01 -0700
Subject: Re: [Patch v4 7/7] mm/hugetlb: take the free hpage during the
 iteration directly
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com
References: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
 <20200901014636.29737-8-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <aa572a2a-6184-7317-8209-bf07dd05af5f@oracle.com>
Date:   Tue, 1 Sep 2020 14:05:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901014636.29737-8-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=2
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 6:46 PM, Wei Yang wrote:
> Function dequeue_huge_page_node_exact() iterates the free list and
> return the first valid free hpage.
> 
> Instead of break and check the loop variant, we could return in the loop
> directly. This could reduce some redundant check.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Thank you!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
