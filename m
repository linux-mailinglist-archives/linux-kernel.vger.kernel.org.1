Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCFF27BDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgI2H0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:26:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgI2H0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:26:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T73PKa051700;
        Tue, 29 Sep 2020 03:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9RtEMHaKi+1MTiyYg24OgQEf8tCsc8bulyo4UQQJu4c=;
 b=RIt9eZBm2Gtnh9NPJ11VuwZIpny/FbqWM3h+9ZLpdFnw7hTo4onQ7x8koxHJS5hSw5wO
 wP7nQ1gKhMuBOLGpyKmKpVAYDM/g9jrhMdmvEDetxXYmHKJ0mDfSEW2TZbzjpAE6+jBM
 Vfe/1pwIKJiiY5RVCdzshS2QRW2kQP+6r4MCMGJ1YxkCISWIyHfnBmtQjy00HwVtEr84
 +ybv0Jfp/e/Pvsy/0l3twosT67jgJzkbAhV9+EM+cfyzK7NLiwDk9u/2o+G/ftKI6epK
 GtQ3id8qfgxT/vr/1Gn4KWHS275MuZ3yI5RlvRyvC7R3ml1OLfPyVTHNkEVNYWvqbjLr WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33uwyq4nby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 03:26:31 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08T74TRl057212;
        Tue, 29 Sep 2020 03:26:30 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33uwyq4nah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 03:26:30 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08T7MsXV029561;
        Tue, 29 Sep 2020 07:26:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 33sw97u04k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 07:26:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08T7QQ3931064362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 07:26:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFF0EA4051;
        Tue, 29 Sep 2020 07:26:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2C96A404D;
        Tue, 29 Sep 2020 07:26:24 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.79.47])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Sep 2020 07:26:24 +0000 (GMT)
Date:   Tue, 29 Sep 2020 10:26:22 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de, rdunlap@infradead.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-ID: <20200929072622.GN2645148@linux.ibm.com>
References: <20200926213919.26642-1-willy@infradead.org>
 <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
 <20200929034026.GA20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929034026.GA20115@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=5
 spamscore=0 impostorscore=0 mlxlogscore=992 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:40:26AM +0100, Matthew Wilcox wrote:
> On Mon, Sep 28, 2020 at 06:03:07PM -0700, Andrew Morton wrote:
> > Well that's weird and scary looking.  `page' has non-zero refcount yet
> > we go and free random followon pages.  Methinks it merits an
> > explanatory comment?
> 
> Here's some kernel-doc.  Opinions?
> 
> /**
>  * __free_pages - Free pages allocated with alloc_pages().
>  * @page: The page pointer returned from alloc_pages().
>  * @order: The order of the allocation.
>  *
>  * This function differs from put_page() in that it can free multi-page

This sentence presumes existing description/prior knowledge about
put_page().

Maybe

  This function can free multi-page allocations that were not allocated
  with %__GFP_COMP, unlike put_page() that would free only the first page
  in such case. __free_pages() does not ...

>  * allocations that were not allocated with %__GFP_COMP.  This function
>  * does not check that the @order passed in matches that of the
>  * allocation, so it is possible to leak memory.  Freeing more memory than
>  * was allocated will probably be warned about by other debugging checks.
>  *
>  * It is only safe to use the page reference count to determine when
>  * to free an allocation if you use %__GFP_COMP (in which case, you may
>  * as well use put_page() to free the page).  Another thread may have a
>  * speculative reference to the first page, but it has no way of knowing
>  * about the rest of the allocation, so we have to free all but the
>  * first page here.
>  *
>  * Context: May be called in interrupt context but not NMI context.
>  */
> 

-- 
Sincerely yours,
Mike.
