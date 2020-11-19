Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974442B8CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKSIOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:14:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60374 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKSIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:14:03 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605773641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fsM3MOW7VcBlFGlF2WTn1/yDE1kwl59IbpeJ7qJYx4M=;
        b=bldivxMIzK8MJBiYQMIkKPGGmYs78H99H+MHdu0llpMIkjlexR7kwaIRqMCIc1hg4KLg47
        9Clh+6wZUjYr90ldJ1OfDXDAx5P2Z07nvbvlyaGOo7RwC50mfcbsW5uGRYE6uHDNeIsEea
        yfBVK8SWBsdQL2SjxU00SvOHwsORoskxMu20gFQpqy1Pb78/WvDTbSLEqlWV1ARx+gDSVl
        MyYnSUlLBZa0xvmm5nVjHP0cspEzpeH0YYTBfoUBkIE0ZW54ynAWDL5DSnph4ItsKYmRNG
        j1MbogQk5G/GV8j6ghisv5Wla6PpaptIz6Ag+iPPDgappGhsfeS24x36XU4Gkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605773641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fsM3MOW7VcBlFGlF2WTn1/yDE1kwl59IbpeJ7qJYx4M=;
        b=XhNClj1/IRzVQIf2OBlYUnP+XNU4pGt1XfzkkWZifePI8MoKLinaDOec7sJ1qRt8e0fzWa
        q6v1Z72V+qExf5BA==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH] misc/sgi-xp: Replace in_interrupt() usage
Date:   Thu, 19 Nov 2020 09:13:54 +0100
Message-Id: <20201119081354.836813-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The usage of in_interrupt() in xpc_partition_disengaged() is clearly
intended to avoid canceling the timeout timer when the function is invoked
from the timer callback.

While in_interrupt() is deprecated and ill defined as it does not provide
what the name suggests it catches the intended case.

Add an argument to xpc_partition_disengaged() which is true if called
from timer and otherwise false.
Use del_timer_sync() instead of del_singleshot_timer_sync() which is the
same thing.

Note: This does not prevent reentrancy into the function as the function
has no concurrency control and timer callback and regular task context
callers can happen concurrently on different CPUs or the timer can
interrupt the task context before it is able to cancel it.

While the only driver which is providing the arch_xpc_ops callbacks
(xpc_uv) seems not to have a reentrancy problem and the only negative
effect would be a double dev_info() entry in dmesg, the whole mechanism is
conceptually broken.

But that's not subject of this cleanup endeavour and left as an exercise to
the folks who might have interest to make that code fully correct.

[bigeasy: Add the argument, use del_timer_sync().]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Cliff Whickman <cpw@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Robin Holt <robinmholt@gmail.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
---
 drivers/misc/sgi-xp/xpc.h           | 2 +-
 drivers/misc/sgi-xp/xpc_main.c      | 8 ++++----
 drivers/misc/sgi-xp/xpc_partition.c | 9 ++++-----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc.h b/drivers/misc/sgi-xp/xpc.h
index 71db60edff655..bbcf10ca3ab7f 100644
--- a/drivers/misc/sgi-xp/xpc.h
+++ b/drivers/misc/sgi-xp/xpc.h
@@ -633,7 +633,7 @@ extern void *xpc_kmalloc_cacheline_aligned(size_t, gfp_=
t, void **);
 extern int xpc_setup_rsvd_page(void);
 extern void xpc_teardown_rsvd_page(void);
 extern int xpc_identify_activate_IRQ_sender(void);
-extern int xpc_partition_disengaged(struct xpc_partition *);
+extern int xpc_partition_disengaged(struct xpc_partition *, bool from_time=
r);
 extern enum xp_retval xpc_mark_partition_active(struct xpc_partition *);
 extern void xpc_mark_partition_inactive(struct xpc_partition *);
 extern void xpc_discovery(void);
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index e5244fc1dab30..c85f2434fb091 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -179,7 +179,7 @@ xpc_timeout_partition_disengage(struct timer_list *t)
=20
 	DBUG_ON(time_is_after_jiffies(part->disengage_timeout));
=20
-	(void)xpc_partition_disengaged(part);
+	xpc_partition_disengaged(part, true);
=20
 	DBUG_ON(part->disengage_timeout !=3D 0);
 	DBUG_ON(xpc_arch_ops.partition_engaged(XPC_PARTID(part)));
@@ -341,7 +341,7 @@ xpc_channel_mgr(struct xpc_partition *part)
 {
 	while (part->act_state !=3D XPC_P_AS_DEACTIVATING ||
 	       atomic_read(&part->nchannels_active) > 0 ||
-	       !xpc_partition_disengaged(part)) {
+	       !xpc_partition_disengaged(part, false)) {
=20
 		xpc_process_sent_chctl_flags(part);
=20
@@ -364,7 +364,7 @@ xpc_channel_mgr(struct xpc_partition *part)
 				 part->chctl.all_flags !=3D 0 ||
 				 (part->act_state =3D=3D XPC_P_AS_DEACTIVATING &&
 				 atomic_read(&part->nchannels_active) =3D=3D 0 &&
-				 xpc_partition_disengaged(part))));
+				 xpc_partition_disengaged(part, false))));
 		atomic_set(&part->channel_mgr_requests, 1);
 	}
 }
@@ -983,7 +983,7 @@ xpc_do_exit(enum xp_retval reason)
 		for (partid =3D 0; partid < xp_max_npartitions; partid++) {
 			part =3D &xpc_partitions[partid];
=20
-			if (xpc_partition_disengaged(part) &&
+			if (xpc_partition_disengaged(part, false) &&
 			    part->act_state =3D=3D XPC_P_AS_INACTIVE) {
 				continue;
 			}
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_=
partition.c
index 57df06820bae2..30fa9998c5629 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -262,8 +262,7 @@ xpc_get_remote_rp(int nasid, unsigned long *discovered_=
nasids,
  * from us. Though we requested the remote partition to deactivate with re=
gard
  * to us, we really only need to wait for the other side to disengage from=
 us.
  */
-int
-xpc_partition_disengaged(struct xpc_partition *part)
+int xpc_partition_disengaged(struct xpc_partition *part, bool from_timer)
 {
 	short partid =3D XPC_PARTID(part);
 	int disengaged;
@@ -289,9 +288,9 @@ xpc_partition_disengaged(struct xpc_partition *part)
 		}
 		part->disengage_timeout =3D 0;
=20
-		/* cancel the timer function, provided it's not us */
-		if (!in_interrupt())
-			del_singleshot_timer_sync(&part->disengage_timer);
+		/* Cancel the timer function if not called from it */
+		if (!from_timer)
+			del_timer_sync(&part->disengage_timer);
=20
 		DBUG_ON(part->act_state !=3D XPC_P_AS_DEACTIVATING &&
 			part->act_state !=3D XPC_P_AS_INACTIVE);
--=20
2.29.2

