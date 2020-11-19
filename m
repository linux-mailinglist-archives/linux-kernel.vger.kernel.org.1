Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC12B99A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgKSRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:39:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18302 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729484AbgKSRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:38:15 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AJHTug1026476
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:38:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=M+0ILuiaD6+1fkeZ4SUYhsSshDmJ3vpGG9x3Lp/tMEM=;
 b=gqook8ZZ/sehT9hKxrbP/h2uPScnz7rotOtiRGWJ7asbNBHUMQqss48egGA5ALue+ckV
 yDeNtD2vINbm+BGnxY0lcxpw4dXsNRhIgmdrFiBty05sH7MENCLVmvanr1tKwD8sozNY
 svzkmyHT7ii65gJuyPpUNaaN+y46kqN0l1Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34wfdq70ap-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:38:14 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 09:38:06 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id F1306145BD0B; Thu, 19 Nov 2020 09:37:56 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v7 26/34] bpf: eliminate rlimit-based memory accounting for reuseport_array maps
Date:   Thu, 19 Nov 2020 09:37:46 -0800
Message-ID: <20201119173754.4125257-27-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119173754.4125257-1-guro@fb.com>
References: <20201119173754.4125257-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=765 malwarescore=0 bulkscore=0 suspectscore=38
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011190125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use rlimit-based memory accounting for reuseport_array maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/reuseport_array.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index a55cd542f2ce..4838922f723d 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -150,9 +150,8 @@ static void reuseport_array_free(struct bpf_map *map)
=20
 static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 {
-	int err, numa_node =3D bpf_map_attr_numa_node(attr);
+	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct reuseport_array *array;
-	struct bpf_map_memory mem;
 	u64 array_size;
=20
 	if (!bpf_capable())
@@ -161,20 +160,13 @@ static struct bpf_map *reuseport_array_alloc(union =
bpf_attr *attr)
 	array_size =3D sizeof(*array);
 	array_size +=3D (u64)attr->max_entries * sizeof(struct sock *);
=20
-	err =3D bpf_map_charge_init(&mem, array_size);
-	if (err)
-		return ERR_PTR(err);
-
 	/* allocate all map elements and zero-initialize them */
 	array =3D bpf_map_area_alloc(array_size, numa_node);
-	if (!array) {
-		bpf_map_charge_finish(&mem);
+	if (!array)
 		return ERR_PTR(-ENOMEM);
-	}
=20
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
-	bpf_map_charge_move(&array->map.memory, &mem);
=20
 	return &array->map;
 }
--=20
2.26.2

