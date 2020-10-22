Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F13296778
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373126AbgJVWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:54:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S373119AbgJVWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:54:19 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MMpKHl011992
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=iaQ6uUUMB3v2zOgoAFTWl7pLBRX74lAv1EY9e2OAqjY=;
 b=HYJ0nzsKiUyuB8zs5NFyy03Y9MQP5y8F509t7DCidNrBIpRK3EtAiEg7/5/B1S3A37dx
 MHP+3e9bC6XFlTWEkvE2rNQhG6eKKfmA1yHWYdOc/cTOPe8gTjLlZJS5JrxVeNlfPa3B
 Ex35skwFrOzdOZ4u0IhjesfEV1XiZB187dk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34bbqgb39g-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:54:18 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 15:53:21 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id E69E91A3AE48; Thu, 22 Oct 2020 15:53:12 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Zi Yan <ziy@nvidia.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 0/2] mm: cma: introduce a non-blocking version of cma_release()
Date:   Thu, 22 Oct 2020 15:53:06 -0700
Message-ID: <20201022225308.2927890-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_17:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=574 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset introduces a non-blocking version of cma_release()
and simplifies the code in hugetlbfs, where previously we had to
temporarily drop hugetlb_lock around the cma_release() call.

It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
THP under a memory pressure requires a cma_release() call. If it's
a blocking function, it complicates the already complicated code.
Because there are at least two use cases like this (hugetlbfs is
another example), I believe it's just better to make cma_release()
non-blocking.

v1:
  - introduce cma_release_nowait() instead of making cma_release()
    non-blocking, for performance reasons

rfc:
  https://lkml.org/lkml/2020/10/16/1050


Roman Gushchin (2):
  mm: cma: introduce cma_release_nowait()
  mm: hugetlb: don't drop hugetlb_lock around cma_release() call

 include/linux/cma.h |  2 +
 mm/cma.c            | 93 +++++++++++++++++++++++++++++++++++++++++++++
 mm/cma.h            |  5 +++
 mm/hugetlb.c        | 11 ++----
 4 files changed, 103 insertions(+), 8 deletions(-)

--=20
2.26.2

