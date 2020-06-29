Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2220D2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 21:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgF2SyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:54:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3342 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728460AbgF2SyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:03 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05T5nVFZ024006
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:58:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PXwo5w25H1G3trFLqpf6ijaWoyxKihUhCvb9tnUjxmk=;
 b=MAEwAxmwX9IbQ+/LhoO8OUG4LxYmT//9QLKqCAIRNPKNO6ywihqUMAZ74tjiWf306UlT
 lQya+YSxxOW+uWxHrxS7mRbm9zeChqxBkN9VtdlUyKodUaLotXXr/LCxEhw3egY8HLpX
 kFMKbxptCaly8puWDd+yz2a8ORLQVmC2vD4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31x3upddn4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 22:58:21 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Jun 2020 22:58:20 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BA97B62E520B; Sun, 28 Jun 2020 22:55:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@chromium.org>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 3/4] bpf: allow %pB in bpf_seq_printf() and bpf_trace_printk()
Date:   Sun, 28 Jun 2020 22:55:29 -0700
Message-ID: <20200629055530.3244342-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200629055530.3244342-1-songliubraving@fb.com>
References: <20200629055530.3244342-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_04:2020-06-26,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 cotscore=-2147483648
 suspectscore=8 mlxscore=0 malwarescore=0 clxscore=1015 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290042
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easy to dump stack trace in text.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/trace/bpf_trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 977ba3b6f6c64..1d874d8e4384b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -376,7 +376,7 @@ static void bpf_trace_copy_string(char *buf, void *un=
safe_ptr, char fmt_ptype,
=20
 /*
  * Only limited trace_printk() conversion specifiers allowed:
- * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pks %pus %s
+ * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
  */
 BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
@@ -420,6 +420,11 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_s=
ize, u64, arg1,
 				goto fmt_str;
 			}
=20
+			if (fmt[i + 1] =3D=3D 'B') {
+				i++;
+				goto fmt_next;
+			}
+
 			/* disallow any further format extensions */
 			if (fmt[i + 1] !=3D 0 &&
 			    !isspace(fmt[i + 1]) &&
@@ -636,7 +641,8 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char=
 *, fmt, u32, fmt_size,
 		if (fmt[i] =3D=3D 'p') {
 			if (fmt[i + 1] =3D=3D 0 ||
 			    fmt[i + 1] =3D=3D 'K' ||
-			    fmt[i + 1] =3D=3D 'x') {
+			    fmt[i + 1] =3D=3D 'x' ||
+			    fmt[i + 1] =3D=3D 'B') {
 				/* just kernel pointers */
 				params[fmt_cnt] =3D args[fmt_cnt];
 				fmt_cnt++;
--=20
2.24.1

