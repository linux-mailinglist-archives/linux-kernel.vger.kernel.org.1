Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8027E4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgI3JSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:18:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgI3JSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:18:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U92npw057276;
        Wed, 30 Sep 2020 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jou9a6b3mVxlmiaWvzipgh0QBKlAf+7R092Q78+GeyM=;
 b=Y4IbQSLIbg5BeJnC1MZkxPS03vdWDBrkYhpsJ61ZnrfcXTRbRlfw6VQaLTUD5fulbRZ1
 YtwUIS7eJOWz10eSr20Sxi4eKVr5rcxm1prRJX+qNHaM+5wNj0qOdg4zn36suFAqUgb3
 QiT7zB4XDdiotLHxy64c23KWT4H3St1FviFM/t1EZ5m6CX1Vh8LsF83P2GnJQQMBWcn/
 kAnGG0m77HJ1j2Psd2krQ7qqvqtLepMHgEGmM0Xun8AzfyBMrtfmFDtjNIz3OelWuI4V
 j7isICpJm3CInFsTvAYwvaBbdC8zx3Ifuf/JQjXS9C9BueoE1+uHFZYDExBoSvlSRUJL Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vp1vjn6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 05:18:05 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08U92peY057459;
        Wed, 30 Sep 2020 05:18:04 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vp1vjn5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 05:18:04 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08U9DY4t023494;
        Wed, 30 Sep 2020 09:18:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw9847wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 09:18:02 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08U9I0Am33358292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 09:18:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00B574C04A;
        Wed, 30 Sep 2020 09:18:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B45E14C046;
        Wed, 30 Sep 2020 09:17:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.79.47])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 09:17:57 +0000 (GMT)
Date:   Wed, 30 Sep 2020 12:17:55 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de, rdunlap@infradead.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-ID: <20200930091755.GB3226834@linux.ibm.com>
References: <20200926213919.26642-1-willy@infradead.org>
 <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
 <20200929034026.GA20115@casper.infradead.org>
 <20200929072622.GN2645148@linux.ibm.com>
 <20200929140622.GE20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929140622.GE20115@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=801
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 suspectscore=5 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 03:06:22PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 29, 2020 at 10:26:22AM +0300, Mike Rapoport wrote:
> > This sentence presumes existing description/prior knowledge about
> > put_page().
> > 
> > Maybe
> > 
> >   This function can free multi-page allocations that were not allocated
> >   with %__GFP_COMP, unlike put_page() that would free only the first page
> >   in such case. __free_pages() does not ...
> 
> Thanks.  After waking up this morning I did a more extensive rewrite:

I like this one

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> /**
>  * __free_pages - Free pages allocated with alloc_pages().
>  * @page: The page pointer returned from alloc_pages().
>  * @order: The order of the allocation.
>  *
>  * This function can free multi-page allocations that are not compound
>  * pages.  It does not check that the @order passed in matches that of
>  * the allocation, so it is easy to leak memory.  Freeing more memory
>  * than was allocated will probably emit a warning.
>  *
>  * If the last reference to this page is speculative, it will be released
>  * by put_page() which only frees the first page of a non-compound
>  * allocation.  To prevent the remaining pages from being leaked, we free
>  * the subsequent pages here.  If you want to use the page's reference
>  * count to decide when to free the allocation, you should allocate a
>  * compound page, and use put_page() instead of __free_pages().
>  *
>  * Context: May be called in interrupt context or holding a normal
>  * spinlock, but not in NMI context or while holding a raw spinlock.
>  */
> 

-- 
Sincerely yours,
Mike.
