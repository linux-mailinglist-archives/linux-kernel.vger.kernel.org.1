Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0008B2B5846
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgKQDm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:42:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35266 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgKQDlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:41:19 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH3duTh004371
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:41:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=5+g1vFpP44Fja8arvawtJQQABGc/XVnUEYIir2wRvvo=;
 b=F8xQfY6RLjmqWBfzHeVK8iG8Ebngj2mgldNcei8QEMgI8rj7CebWrVzI3isONw5Myfpw
 0e8i5xKBhBAc4MjmB/PgSaDU7V/wlxLuwAb0LrD7VaZbK6EEUKxaETRD1Qm3rZtkxhCS
 ZpGPuyr1N49LNzTqXQ4MakhSCI5u/Z61WjI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34tdmruh5j-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:41:18 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 19:41:13 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 31FC8C63A64; Mon, 16 Nov 2020 19:41:10 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v6 07/34] bpf: memcg-based memory accounting for bpf maps
Date:   Mon, 16 Nov 2020 19:40:41 -0800
Message-ID: <20201117034108.1186569-8-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201117034108.1186569-1-guro@fb.com>
References: <20201117034108.1186569-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_01:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=13 adultscore=0 phishscore=0 mlxlogscore=714 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables memcg-based memory accounting for memory allocated
by __bpf_map_area_alloc(), which is used by many types of bpf maps for
large memory allocations.

Following patches in the series will refine the accounting for
some of the map types.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d77fc2496da..fcadf953989f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -280,7 +280,7 @@ static void *__bpf_map_area_alloc(u64 size, int numa_=
node, bool mmapable)
 	 * __GFP_RETRY_MAYFAIL to avoid such situations.
 	 */
=20
-	const gfp_t gfp =3D __GFP_NOWARN | __GFP_ZERO;
+	const gfp_t gfp =3D __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUNT;
 	unsigned int flags =3D 0;
 	unsigned long align =3D 1;
 	void *area;
--=20
2.26.2

