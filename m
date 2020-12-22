Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2720E2E0DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgLVRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:12:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50454 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgLVRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:12:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BMHBOoM008703;
        Tue, 22 Dec 2020 17:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=JusvLBof39d9s3mZwhNp42BnZTVvAAQXELwM+TbZut8=;
 b=RxjFhqTPOQtM0f//cuKFWLTiIqPgYARszFgnfBiZwOdf0dg/90432B/haMb0Wuk6CPOO
 0ib+fhL6sug2oRZU5zbtbM/3ko8Dlltb/wURF5MRAYwEJqwlbOsr1SJPnbfCRtLBiSv6
 77Kw0KjEHaCgyjYbDr9O6dA4SVRIk5IKWhkZXMJHzszpYgxZY10SQla+FdIkk0q3o0sJ
 hR9uJMKH9+Ov6Hjb5hss5ll2HrRlalJbW5oBbeWWeKP2MLoATSxkQZPEKmkMbNZgMsxE
 5RBHWkAv52/+DxD+cZ2ZHvvmJgi1fsVGYy7t54UcB+uP0JGtBBGRzdI6C9QQX+Fa5K+E 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35k0d14ekp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 17:11:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BMHBY4s007935;
        Tue, 22 Dec 2020 17:11:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35k0e1jrma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 17:11:35 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BMHBNsI025821;
        Tue, 22 Dec 2020 17:11:23 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Dec 2020 09:11:23 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Liang Li <liliang.opensource@gmail.com>,
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
        Liang Li <liliangleo@didiglobal.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
In-Reply-To: <20201221162519.GA22504@open-light-1.localdomain>
References: <20201221162519.GA22504@open-light-1.localdomain>
Date:   Tue, 22 Dec 2020 12:11:21 -0500
Message-ID: <87wnx9rcjq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012220127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liang Li <liliang.opensource@gmail.com> writes:
> The first version can be found at: https://lkml.org/lkml/2020/4/12/42
>
> Zero out the page content usually happens when allocating pages with
> the flag of __GFP_ZERO, this is a time consuming operation, it makes
> the population of a large vma area very slowly. This patch introduce
> a new feature for zero out pages before page allocation, it can help
> to speed up page allocation with __GFP_ZERO.

kzeropaged appears to escape some of the kernel's resource controls, at
least if I'm understanding this right.

The heavy part of a page fault is moved out of the faulting task's
context so the CPU controller can't throttle it.  A task that uses
these pages can benefit from clearing done by CPUs that it's not allowed
to run on.  How can it handle these cases?
