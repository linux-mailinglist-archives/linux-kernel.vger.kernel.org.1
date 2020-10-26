Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D4299A47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbgJZXQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:16:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3104 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404002AbgJZXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:16:16 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QNGDLj007307
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:16:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=RcUc89hkwQPY09B0FZeXbWxMhSN7y/9kMmbiPrfw3DE=;
 b=LAYv2kHpzNRaR6DR44pp6fCE9SxHfDZeekRafahu5BwmQ7AFZ1+W1efYo8wBXsezO2e7
 kqdUJk5sKlD8i6H8EfYs26kWm6RKwjlg6hPCN+7HI1/hPKsRaoe4JI676ru69PTQHq5n
 9paH2tSMW9FCFArnTyVrO5VEff4i1yHe+jo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34d4b6fy6a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:16:15 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 16:15:42 -0700
Received: by devvm1755.vll0.facebook.com (Postfix, from userid 111017)
        id 5B8431C4B9B2; Mon, 26 Oct 2020 16:13:27 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] mm: memcg: link page counters to root if use_hierarchy is false
Date:   Mon, 26 Oct 2020 16:13:26 -0700
Message-ID: <20201026231326.3212225-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_17:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard reported a warning which can be reproduced by running the LTP
madvise6 test (cgroup v1 in the non-hierarchical mode should be used):

[    9.841552] ------------[ cut here ]------------
[    9.841788] WARNING: CPU: 0 PID: 12 at mm/page_counter.c:57 page_count=
er_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:=
156)
[    9.841982] Modules linked in:
[    9.842072] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.9.0-rc7-22-=
default #77
[    9.842266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
[    9.842571] Workqueue: events drain_local_stock
[    9.842750] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/p=
age_counter.c:50 mm/page_counter.c:156)
[ 9.842894] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a f=
e ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0=
f> 0b eb ec 90 e8 4b f9 88 2a 48 8b 17 48 39 d6 72 41 41 54 49 89
[    9.843438] RSP: 0018:ffffb1c18006be28 EFLAGS: 00010086
[    9.843585] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: ffff94803=
bc2cae0
[    9.843806] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff94800=
7d2b248
[    9.844026] RBP: ffff948007d2b248 R08: ffff948007c58eb0 R09: ffff94800=
7da05ac
[    9.844248] R10: 0000000000000018 R11: 0000000000000018 R12: 000000000=
0000001
[    9.844477] R13: ffffffffffffffff R14: 0000000000000000 R15: ffff94803=
bc2cac0
[    9.844696] FS:  0000000000000000(0000) GS:ffff94803bc00000(0000) knlG=
S:0000000000000000
[    9.844915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.845096] CR2: 00007f0579ee0384 CR3: 000000002cc0a000 CR4: 000000000=
00006f0
[    9.845319] Call Trace:
[    9.845429] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
[    9.845582] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcont=
rol.c:3114)
[    9.845684] drain_local_stock (mm/memcontrol.c:2255)
[    9.845789] process_one_work (./arch/x86/include/asm/jump_label.h:25 .=
/include/linux/jump_label.h:200 ./include/trace/events/workqueue.h:108 ke=
rnel/workqueue.c:2274)
[    9.845898] worker_thread (./include/linux/list.h:282 kernel/workqueue=
.c:2416)
[    9.846034] ? process_one_work (kernel/workqueue.c:2358)
[    9.846162] kthread (kernel/kthread.c:292)
[    9.846271] ? __kthread_bind_mask (kernel/kthread.c:245)
[    9.846420] ret_from_fork (arch/x86/entry/entry_64.S:300)
[    9.846531] ---[ end trace 8b5647c1eba9d18a ]---

The problem occurs because in the non-hierarchical mode non-root page
counters are not linked to root page counters, so the charge is not
propagated to the root memory cgroup.

After the removal of the original memory cgroup and reparenting of the
object cgroup, the root cgroup might be uncharged by draining a objcg
stock, for example. It leads to an eventual underflow of the charge
and triggers a warning.

Fix it by linking all page counters to corresponding root page
counters in the non-hierarchical mode.

Please note, that in the non-hierarchical mode all objcgs are always
reparented to the root memory cgroup, even if the hierarchy has more
than 1 level. This patch doesn't change it.

The patch also doesn't affect how the hierarchical mode is working,
which is the only sane and truly supported mode now.

Thanks to Richard for reporting, debugging and providing an
alternative version of the fix!

Reported-by: ltp@lists.linux.it
Debugged-by: Richard Palethorpe <rpalethorpe@suse.com>
Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: stable@vger.kernel.org
---
 mm/memcontrol.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..009297017c87 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5339,17 +5339,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *=
parent_css)
 		memcg->swappiness =3D mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable =3D parent->oom_kill_disable;
 	}
-	if (parent && parent->use_hierarchy) {
+	if (!parent) {
+		page_counter_init(&memcg->memory, NULL);
+		page_counter_init(&memcg->swap, NULL);
+		page_counter_init(&memcg->kmem, NULL);
+		page_counter_init(&memcg->tcpmem, NULL);
+	} else if (parent->use_hierarchy) {
 		memcg->use_hierarchy =3D true;
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
-		page_counter_init(&memcg->memory, NULL);
-		page_counter_init(&memcg->swap, NULL);
-		page_counter_init(&memcg->kmem, NULL);
-		page_counter_init(&memcg->tcpmem, NULL);
+		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
+		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
+		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
+		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
 		/*
 		 * Deeper hierachy with use_hierarchy =3D=3D false doesn't make
 		 * much sense so let cgroup subsystem know about this
--=20
2.26.2

