Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA58D286E32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgJHFk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:40:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJHFk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:40:27 -0400
Received: from weisslap.m4st3rnet.de ([178.27.102.19]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlwBf-1kqLd51Qwt-00j4Ec; Thu, 08 Oct 2020 07:40:24 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH v2 3/4] fs/proc: apply timens offset for start_boottime of processes
Date:   Thu,  8 Oct 2020 07:39:43 +0200
Message-Id: <20201008053944.32718-4-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gkGH2ghT/qCNiw5iGUUIvPpGaJ+WEAkjymoe1/KsKbP9aLE34fU
 wXqE07ZP73SN8wwEDQRplyZ0ebEG6eJmWB6v/m5RJ8x7RWxC+m2UwlAt220JPnMwH5UPBRv
 mqNIMbls2Kw2Y3+z09vl8oX3phTUJ66L+ecIupJxq5r4Ps5H4ZKgX8lskyaABvd4VPM03/L
 rck+MTjs2Vd1i0xIrYiRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nrQwEhQww+8=:e1QwlgfPpHZXhEakzLdpCy
 eQ6u2xet4PXmsNVYpF7jiJFm7g6aeXASJ8B2s5NUNK7Jy7PUouv5NnmG5YQPWwT6oHMyN0CCV
 kq4qZpFRlIkYh9RFxUdQLWclnsJPkqTdr82DDoqxMsFfOUhQublx0AoA1e06m1mJCQCNsR0WT
 G3Fpz5AldfesVuRhif7mtwEZV/0nuq1hxY+e+yzEHd80VGensvdHwPM382UrvJlAGaNToqwOD
 NDZ8KRNQwiJ0GBfJkCyV8kNS8Nonoyr8+nfgnOGxQaRiQNwVyr48V4n/R8ef91ipFUbq5kmA/
 1TqdbvwzlEnzZYx3sdJaX4sqWF5RuDUXM6DcijAow8pmn4ylkNu37bF8qz5U0EcBCdUJ7JWQT
 Y6785NxSAOUFLPyBVScGBfCwJvUmtkh6bMm94AN9Q6WPxQsKcSOk5J4ilsYE8RjcqHnuokGzb
 7JwBw6GGlFrrybksBQneR+PKIjFRwciX75LSqjBDqZFymyO0qHa3hCLONrMo12dLiO6oElcky
 VFBzYVOVyXPzGZWW2aDkqNyiXzu7Ik6HW50l7RmA7yAposCx2LmTBuwLqhXuWKAtP6kqnhWLz
 pbWOVp7dQigckN6LZL+4ooPbbYRnEuHnBZJ+79PlVZRy/fP+UoTFoGr/D08l3R2FtmTFv0mlj
 etUbWRknjsHORo6eOAu/rabfyCIrKjoheFRnXrhTOGhbl1C0RIS4NCh1W8vSmk3kcgekTzqRg
 dq2pK5QSceo5J5zLxlxHZAXtkgyC7Z4fjodBJ+2GnOmCFkCiz9svIc8A+D6ZpClO5LzikpFqU
 /mEwGXU5k3FIIKRyFM8zqIaIxsg6i1Fty5qkHcT17RXjVl8yIRT0pVoYtH1TZDCm0vj9QV/rY
 tH2bpDYNuXYSK1rDiqKQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since start_boottime of processes are seconds since boottime and the
boottime stamp is now shifted according to the timens offset, the
offset of the time namespace also needs to be applied before the
process stats are given to userspace.

This avoids that processes shown, e.g., by 'ps' appear as time
travelers in the corresponding time namespace.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/proc/array.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65ec2029fa80..277f654f289e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -56,6 +56,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
 #include <linux/tty.h>
@@ -533,8 +534,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	priority = task_prio(task);
 	nice = task_nice(task);
 
-	/* convert nsec -> ticks */
-	start_time = nsec_to_clock_t(task->start_boottime);
+	/* apply timens offset for boottime and convert nsec -> ticks */
+	start_time =
+		nsec_to_clock_t(timens_add_boottime_ns(task->start_boottime));
 
 	seq_put_decimal_ull(m, "", pid_nr_ns(pid, ns));
 	seq_puts(m, " (");
-- 
2.20.1

