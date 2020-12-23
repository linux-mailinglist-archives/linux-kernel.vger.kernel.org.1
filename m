Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314442E1B48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgLWK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:57:02 -0500
Received: from mail.wangsu.com ([123.103.51.227]:56178 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLWK5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:57:01 -0500
Received: from fedora31.wangsu.com (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewDHz2MqIuNf_mYEAA--.4681S2;
        Wed, 23 Dec 2020 18:55:45 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linf@wangsu.com
Subject: [PATCH] sysctl.c: fix underflow value setting risk in vm_table
Date:   Wed, 23 Dec 2020 18:55:35 +0800
Message-Id: <20201223105535.2875-1-linf@wangsu.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewDHz2MqIuNf_mYEAA--.4681S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1xAFWkWF17ur4rGFWxJFb_yoW8CrWxpF
        9xXryUKF45WF1SvasayF4a9F17u3ykGr47t3ZFgrySk3y3XrZ5JFn5Z347try5KFWSyF1j
        q3Wjvrs8uan5AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVWx
        JVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
        8vx2IErcIFxwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv
        8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUcbAwDUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from subsystem specific .proc_handler handler, all ctl_tables with
extra1 and extra2 members set should use proc_dointvec_minmax instead of
proc_dointvec, or the limit set in extra* never work and potentially echo
underflow values(negative numbers) is likely make system unstable.

Especially vfs_cache_pressure and zone_reclaim_mode, -1 is apparently not
a valid value, but we can set to them. And then kernel may crash.
# echo -1 > /proc/sys/vm/vfs_cache_pressure

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 kernel/sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9fbdd848138..62fbd09b5dc1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2962,7 +2962,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &block_dump,
 		.maxlen		= sizeof(block_dump),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
 	{
@@ -2970,7 +2970,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_vfs_cache_pressure,
 		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
 #if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
@@ -2980,7 +2980,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_legacy_va_layout,
 		.maxlen		= sizeof(sysctl_legacy_va_layout),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
@@ -2990,7 +2990,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &node_reclaim_mode,
 		.maxlen		= sizeof(node_reclaim_mode),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
 	{
-- 
2.25.4

