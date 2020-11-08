Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534442AAB19
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 14:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgKHNO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 08:14:58 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38360 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgKHNOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 08:14:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id EFCFCCF8;
        Sun,  8 Nov 2020 14:14:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m1gaJec65rC8; Sun,  8 Nov 2020 14:14:45 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 11869CF7;
        Sun,  8 Nov 2020 14:14:44 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kbkUj-009KMT-Vb; Sun, 08 Nov 2020 14:12:33 +0100
Date:   Sun, 8 Nov 2020 14:12:33 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup ttyio: Do not schedule() in ttyio_in_nowait
Message-ID: <20201108131233.tadycr73sxlvodgo@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the ltlk and spkout drivers, the index read function, i.e.
in_nowait, is getting called from the read_all_doc mechanism, from
the timer softirq:

Call Trace:
 <IRQ>
 dump_stack+0x71/0x98
 dequeue_task_idle+0x1f/0x28
 __schedule+0x167/0x5d6
 ? trace_hardirqs_on+0x2e/0x3a
 ? usleep_range+0x7f/0x7f
 schedule+0x8a/0xae
 schedule_timeout+0xb1/0xea
 ? del_timer_sync+0x31/0x31
 do_wait_for_common+0xba/0x12b
 ? wake_up_q+0x45/0x45
 wait_for_common+0x37/0x50
 ttyio_in+0x2a/0x6b
 spk_ttyio_in_nowait+0xc/0x13
 spk_get_index_count+0x20/0x93
 cursor_done+0x1c6/0x4c6
 ? read_all_doc+0xb1/0xb1
 call_timer_fn+0x89/0x140
 run_timer_softirq+0x164/0x1a5
 ? read_all_doc+0xb1/0xb1
 ? hrtimer_forward+0x7b/0x87
 ? timerqueue_add+0x62/0x68
 ? enqueue_hrtimer+0x95/0x9f
 __do_softirq+0x181/0x31f
 irq_exit+0x6a/0x86
smp_apic_timer_interrupt+0x15e/0x183
 apic_timer_interrupt+0xf/0x20
 </IRQ>

We thus should not schedule() at all, even with timeout == 0, this
crashes the kernel.  We can however use try_wait_for_completion()
instead of wait_for_completion_timeout(0).

Cc: stable@vger.kernel.org
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reported-by: John Covici <covici@ccs.covici.com>
Tested-by: John Covici <covici@ccs.covici.com>

---
 drivers/accessibility/speakup/spk_ttyio.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -298,11 +298,13 @@ static unsigned char ttyio_in(int timeou
 	struct spk_ldisc_data *ldisc_data = speakup_tty->disc_data;
 	char rv;
 
-	if (wait_for_completion_timeout(&ldisc_data->completion,
+	if (!timeout) {
+		if (!try_wait_for_completion(&ldisc_data->completion))
+			return 0xff;
+	} else if (wait_for_completion_timeout(&ldisc_data->completion,
 					usecs_to_jiffies(timeout)) == 0) {
-		if (timeout)
-			pr_warn("spk_ttyio: timeout (%d)  while waiting for input\n",
-				timeout);
+		pr_warn("spk_ttyio: timeout (%d)  while waiting for input\n",
+			timeout);
 		return 0xff;
 	}
 
