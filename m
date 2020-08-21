Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E654524D855
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHUPSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 11:18:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33490 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727955AbgHUPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:17:56 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LFATTT023038
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:17:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LNqDcun6xOIbIYkt7APuKm2n1cxQU9Xgs1+YBzvY3CU=;
 b=bkc8WAgjswd6/P9ezFXqKebSYv3F5r46qS7qWlyI1IgLW+ckvGB4ve6nWBhkW/QFtqqF
 PTwnwq/m945BNsQagr6yoBdbqfEgRpF7hCiqENUnt/BMJXYOaR+SFxyYotsBNFUZ7Hz6
 jfvyMG6s8Z/IhhDJbYMb07WbzIHl6fE0hb0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 332ehfrrfd-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:17:55 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:17:52 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 970993441073; Fri, 21 Aug 2020 08:01:35 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v4 22/30] bpf: eliminate rlimit-based memory accounting for reuseport_array maps
Date:   Fri, 21 Aug 2020 08:01:26 -0700
Message-ID: <20200821150134.2581465-23-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200821150134.2581465-1-guro@fb.com>
References: <20200821150134.2581465-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=38 mlxlogscore=768
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
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
index 90b29c5b1da7..9d0161fdfec7 100644
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

