Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32087290DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbgJPWxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:53:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57344 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391017AbgJPWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:53:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GMoQbZ028445
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:53:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=nVcWRyEwxNd3Ji+bB1DfzrrYhgMCm7kylhpy1EG3lOQ=;
 b=T71wcns7PKbDIvJRMkUidiTnM7aZ4//HBWcbhTkYvX22aRocQon/2sDfoOeX24l+wGlN
 /jY+munTitE0I6IMBeF7JdKxccXVRpjDWRDaRDO6JAKIErGKM7zCHG0Y8G+rs45zi7m7
 F//6IduGb29sd2hauzfo+Z4mFOqV+aR69sQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 346ppeh5j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:53:01 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 15:53:00 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 9593916EFB76; Fri, 16 Oct 2020 15:52:56 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
Date:   Fri, 16 Oct 2020 15:52:52 -0700
Message-ID: <20201016225254.3853109-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_12:2020-10-16,2020-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=478 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010160162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset makes cma_release() non-blocking and simplifies
the code in hugetlbfs, where previously we had to temporarily drop
hugetlb_lock around the cma_release() call.

It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
THP under a memory pressure requires a cma_release() call. If it's
a blocking function, it complicates the already complicated code.
Because there are at least two use cases like this (hugetlbfs is
another example), I believe it's just better to make cma_release()
non-blocking.

It also makes it more consistent with other memory releasing functions
in the kernel: most of them are non-blocking.


Roman Gushchin (2):
  mm: cma: make cma_release() non-blocking
  mm: hugetlb: don't drop hugetlb_lock around cma_release() call

 mm/cma.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/hugetlb.c |  6 ------
 2 files changed, 49 insertions(+), 8 deletions(-)

--=20
2.26.2

