Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0972A2E106A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgLVW4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:56:44 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52968 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgLVW4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:56:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BMMpWlD174018;
        Tue, 22 Dec 2020 22:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=N+6K3mCeYK/CoMCgVBBUHQgK04gVj9asaTrrtBEH5II=;
 b=xMjE8Cj23ZoYzPmldN5IYeUk4iWwtF72gnepmDtV597NPn+XfF/jb1Yqrc4kKLw8UPuO
 PuF+Gz3HXDcBc8LC/BTKqPlOSqus6fuXw1pYdzahisjKl8VvplckbgiyU4x5/a0YAlA5
 pvvmTYnW+6aTLZ+MmYu5u+nPG0qfNtOB+LJZVbltZ1NPMgEk+3WkY6XpZYmQqog0CkBa
 pBHUX6Ng/TtbZo+eFfHgMj8dxB2ZNakMuz8QmkhyC2kX5wLAuh4l+nO2UADVxEcBKLAK
 g5RCX73Cbryr+0+2pEz/MzI+NpM0d6/yup1ELAwRsjFUI1THCc84UNGYBpn1IWzB/fUQ iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35k0d15m2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 22:55:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BMMnvTk007881;
        Tue, 22 Dec 2020 22:55:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35k0ea3sym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 22:55:35 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BMMtUxk026442;
        Tue, 22 Dec 2020 22:55:31 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Dec 2020 14:55:30 -0800
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Liang Li <liliang324@gmail.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
References: <20201222074656.GA30035@open-light-1.localdomain>
 <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <52a6cb93-1fed-dfd7-d21e-f14197a9c9dc@oracle.com>
Date:   Tue, 22 Dec 2020 14:55:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012220165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012220165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 11:59 AM, Alexander Duyck wrote:
> On Mon, Dec 21, 2020 at 11:47 PM Liang Li <liliang.opensource@gmail.com> wrote:
>> +
>> +       if (huge_page_order(h) > MAX_ORDER)
>> +               budget = HUGEPAGE_REPORTING_CAPACITY;
>> +       else
>> +               budget = HUGEPAGE_REPORTING_CAPACITY * 32;
> 
> Wouldn't huge_page_order always be more than MAX_ORDER? Seems like we
> don't even really need budget since this should probably be pulling
> out no more than one hugepage at a time.

On standard x86_64 configs, 2MB huge pages are of order 9 < MAX_ORDER (11).
What is important for hugetlb is the largest order that can be allocated
from buddy.  Anything bigger is considered a gigantic page and has to be
allocated differently.

If the code above is trying to distinguish between huge and gigantic pages,
it is off by 1.  The largest order that can be allocated from the buddy is
(MAX_ORDER - 1).  So, the check should be '>='.

-- 
Mike Kravetz
