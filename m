Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74082A69DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgKDQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:34:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:57917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDQeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604507643;
        bh=JQ1+kuAhPc5zrxcsod7naZRChLWOHa0kUh1Dpk6f9oE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=C6IdB7dlsGVB5jTZo79XdIN8BJp4R3LOSAGGj+r5Hpxbml5887LIgzAzJZnR6EHkf
         gPajhs56WGFctgozRGUz2nCWn5dReLuEaJKnmrlgaGI8+rDIhUrwdcMLoHedwdVdG5
         hhdqiKvqb4UjQ4PEQg/H9K78vHA98O6PsaXIzp/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.197]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1koamk49lE-00VuOv; Wed, 04
 Nov 2020 17:34:03 +0100
Date:   Wed, 4 Nov 2020 17:34:01 +0100
From:   Helge Deller <deller@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] timer_list: Use printk format instead of open-coded symbol
 lookup
Message-ID: <20201104163401.GA3984@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:K/1cX+HkApjnvuPRyCwOVVA+fZJN7hWQ5Tq77eAPpllSeiDeiTd
 O2naFKhM95tdpZzlMDuIMIkb7kIePMuay6qf8Jtdrxgbr1wtSekGTy8PEJlJQQcqRPpbUnS
 x5egFypPLDGt9lWEluwcOfsJvE5MpN9ouCvU01j7yWg4sLSJn00W8tot5a/SS8GTwdqIETp
 72JIK49OK9Wu7HpFBwlcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sXblRT6eSmQ=:MPNEFF+P9xA663fpVyVNQ0
 9ylebX6BeQSgjUnRHx+JHRlqSeP/Very568Fnnxw3KFTFc9/ZZF+Snw8mv4H1zqPiE8pVbyyc
 s2y9LlTJ8u6Z8rotKyHNrv2JgiisRQ61ux599oLs0VGP12iowD7j8b1r1hK0ger3EAaCRp8dD
 pzqoBvVAoJf1Ky1VB1DGFdrg4hIJuQ9K6MBTe7J+ca03F5JrKbOsIELu5bHc5JoXGjdUSiELO
 hPbTVzO1cDn/vuejalB3lvmyPaFnGzDOlGO/w7uOmmmZT+6LnysR+I+YSgEz3FfWQVGQqIG/2
 Jv5FmVmeEZpYKq8e2JyZhY2k8JLvTc8LxqE2ELbJBgFHM3VaPtYi96pigQxLtVxxAhiXAEpvp
 3tzlxQuL4DUhtPA85Apbj1XvwajS5eFtEr4lhp7nKKwI7YBjhOo1eKjvK9EYiP0ARmeiSm+a6
 4sruj2JjWLCvdjwNizVupVUK3N9L+O7ybi5FEyYL54DjslF4UYvZAoxLvg1QVpBvnoiAK3wyv
 DIPJwCzdk4kihg8KpYgEJCnl5SabCVWfh7DFR/Y7c30Qof33R/Pmif4UEdNgYFEN6LL0Eoipw
 /ZJXiE069K/lS1BuRirxv9yCd6Lhd70H3h/+iqOi9NTSO7OzmZdaXNA5SmXKRWpuc0yk+0r/d
 as2krrqgWhQwdOF7wlGgZT2Fup/x9YLM6YUCZW//suGPt8ZoHspxXhQY7UpU0UYUDWr8zY6Kq
 7PzyReHdYIffr6GAymqOz/D8L7a9dz5coLWskfWzZ/mk1dQTCjVezKU+bpY9bqSHE+CrkBLZe
 n25CyCZLAfTnSI88d7kGieA5DdjaPm/3V8EHT6kyah7cnjIPAydMIAP1Qh2MyOerefDabZLCE
 oJ65CQd75YAAdYIRpttQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the "%ps" printk format string to resolve symbol names.

This works on all platforms, including ia64, ppc64 and parisc64 on which
one needs to dereference pointers to function descriptors instead of
function pointers.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index acb326f5f50a..6939140ab7c5 100644
=2D-- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -42,24 +42,11 @@ static void SEQ_printf(struct seq_file *m, const char =
*fmt, ...)
 	va_end(args);
 }

-static void print_name_offset(struct seq_file *m, void *sym)
-{
-	char symname[KSYM_NAME_LEN];
-
-	if (lookup_symbol_name((unsigned long)sym, symname) < 0)
-		SEQ_printf(m, "<%pK>", sym);
-	else
-		SEQ_printf(m, "%s", symname);
-}
-
 static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *ti=
mer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: ", idx);
-	print_name_offset(m, taddr);
-	SEQ_printf(m, ", ");
-	print_name_offset(m, timer->function);
+	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
@@ -116,9 +103,7 @@ print_base(struct seq_file *m, struct hrtimer_clock_ba=
se *base, u64 now)

 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);

-	SEQ_printf(m,   "  .get_time:   ");
-	print_name_offset(m, base->get_time);
-	SEQ_printf(m,   "\n");
+	SEQ_printf(m,   "  .get_time:   %ps\n", base->get_time);
 #ifdef CONFIG_HIGH_RES_TIMERS
 	SEQ_printf(m, "  .offset:     %Lu nsecs\n",
 		   (unsigned long long) ktime_to_ns(base->offset));
@@ -218,42 +203,29 @@ print_tickdevice(struct seq_file *m, struct tick_dev=
ice *td, int cpu)
 	SEQ_printf(m, " next_event:     %Ld nsecs\n",
 		   (unsigned long long) ktime_to_ns(dev->next_event));

-	SEQ_printf(m, " set_next_event: ");
-	print_name_offset(m, dev->set_next_event);
-	SEQ_printf(m, "\n");
+	SEQ_printf(m, " set_next_event: %ps\n", dev->set_next_event);

-	if (dev->set_state_shutdown) {
-		SEQ_printf(m, " shutdown: ");
-		print_name_offset(m, dev->set_state_shutdown);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_shutdown)
+		SEQ_printf(m, " shutdown:       %ps\n",
+			dev->set_state_shutdown);

-	if (dev->set_state_periodic) {
-		SEQ_printf(m, " periodic: ");
-		print_name_offset(m, dev->set_state_periodic);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_periodic)
+		SEQ_printf(m, " periodic:       %ps\n",
+			dev->set_state_periodic);

-	if (dev->set_state_oneshot) {
-		SEQ_printf(m, " oneshot:  ");
-		print_name_offset(m, dev->set_state_oneshot);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_oneshot)
+		SEQ_printf(m, " oneshot:        %ps\n",
+			dev->set_state_oneshot);

-	if (dev->set_state_oneshot_stopped) {
-		SEQ_printf(m, " oneshot stopped: ");
-		print_name_offset(m, dev->set_state_oneshot_stopped);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->set_state_oneshot_stopped)
+		SEQ_printf(m, " oneshot stopped: %ps\n",
+			dev->set_state_oneshot_stopped);

-	if (dev->tick_resume) {
-		SEQ_printf(m, " resume:   ");
-		print_name_offset(m, dev->tick_resume);
-		SEQ_printf(m, "\n");
-	}
+	if (dev->tick_resume)
+		SEQ_printf(m, " resume:         %ps\n",
+			dev->tick_resume);

-	SEQ_printf(m, " event_handler:  ");
-	print_name_offset(m, dev->event_handler);
+	SEQ_printf(m, " event_handler:  %ps\n", dev->event_handler);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " retries:        %lu\n", dev->retries);
 	SEQ_printf(m, "\n");
