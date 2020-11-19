Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D592B9023
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKSKbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKSKbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:31:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 02:31:55 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:31:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605781913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpd5RZFpstT09gTei2wvHM1D0nBgK/DhVnpvj+YO9FE=;
        b=dW3/UQQtGlFgGY1CgMpAFEz2JARXtXiYS5AowMkxMQiKYH9sf33uho/ai+JXyRUxaKMesO
        40bdrX7S6dsK1lmwlNWV6WeGwxuKcdO/6iXn78zTIuy/38NJVdpX2IX9YDlRtowPsOQIMR
        qk2hg2LSA2mUqo68eHeT8aGCl/b2C8eYScB3xRT+1n8Pi0ZOf+4ZIm3Y1sOw33qH8Iikcm
        UJXMboHpGRP24aFIpzXXaOP9l0s5oB67Iyz/4/9eDSPv6N64lJbOS5xKDHh0YbDgTqeFaj
        c4eT4Fgb4o45yIOieyigW/+mw181kEzGuC/xfw7I7CZRy9R43cHdcYvNhIWkZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605781913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpd5RZFpstT09gTei2wvHM1D0nBgK/DhVnpvj+YO9FE=;
        b=tFFDfRT/pFLMP9416qiwyrk5a6wAJIMNa02eMg5LsKnUnmyMale498pyQi9cGD01GjHnYs
        Y2ABKe5p4uXvmfAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH v2] misc/sgi-xp: Replace in_interrupt() usage
Message-ID: <20201119103151.ppo45mj53ulbxjx4@linutronix.de>
References: <20201119081354.836813-1-bigeasy@linutronix.de>
 <X7YwZZgvk92Cghl7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <X7YwZZgvk92Cghl7@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=46rom: Thomas Gleixner <tglx@linutronix.de>

The usage of in_interrupt() in xpc_partition_disengaged() is clearly
intended to avoid canceling the timeout timer when the function is invoked
=66rom the timer callback.

While in_interrupt() is deprecated and ill defined as it does not provide
what the name suggests it catches the intended case.

Add an argument to xpc_partition_disengaged() which is true if called
=66rom timer and otherwise false.
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
v1=E2=80=A6v2: Use xpc_partition_disengaged_from_timer() and don't export t=
he
       argument. Suggested by Greg.

 drivers/misc/sgi-xp/xpc.h           |  1 +
 drivers/misc/sgi-xp/xpc_main.c      |  2 +-
 drivers/misc/sgi-xp/xpc_partition.c | 20 +++++++++++++++-----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc.h b/drivers/misc/sgi-xp/xpc.h
index 71db60edff655..225f2bb84e39b 100644
--- a/drivers/misc/sgi-xp/xpc.h
+++ b/drivers/misc/sgi-xp/xpc.h
@@ -634,6 +634,7 @@ extern int xpc_setup_rsvd_page(void);
 extern void xpc_teardown_rsvd_page(void);
 extern int xpc_identify_activate_IRQ_sender(void);
 extern int xpc_partition_disengaged(struct xpc_partition *);
+extern int xpc_partition_disengaged_from_timer(struct xpc_partition *part);
 extern enum xp_retval xpc_mark_partition_active(struct xpc_partition *);
 extern void xpc_mark_partition_inactive(struct xpc_partition *);
 extern void xpc_discovery(void);
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index e5244fc1dab30..84610bbcc1314 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -179,7 +179,7 @@ xpc_timeout_partition_disengage(struct timer_list *t)
=20
 	DBUG_ON(time_is_after_jiffies(part->disengage_timeout));
=20
-	(void)xpc_partition_disengaged(part);
+	xpc_partition_disengaged_from_timer(part);
=20
 	DBUG_ON(part->disengage_timeout !=3D 0);
 	DBUG_ON(xpc_arch_ops.partition_engaged(XPC_PARTID(part)));
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_=
partition.c
index 57df06820bae2..1999d02923dee 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -262,8 +262,8 @@ xpc_get_remote_rp(int nasid, unsigned long *discovered_=
nasids,
  * from us. Though we requested the remote partition to deactivate with re=
gard
  * to us, we really only need to wait for the other side to disengage from=
 us.
  */
-int
-xpc_partition_disengaged(struct xpc_partition *part)
+static int __xpc_partition_disengaged(struct xpc_partition *part,
+				      bool from_timer)
 {
 	short partid =3D XPC_PARTID(part);
 	int disengaged;
@@ -289,9 +289,9 @@ xpc_partition_disengaged(struct xpc_partition *part)
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
@@ -303,6 +303,16 @@ xpc_partition_disengaged(struct xpc_partition *part)
 	return disengaged;
 }
=20
+int xpc_partition_disengaged(struct xpc_partition *part)
+{
+	return __xpc_partition_disengaged(part, false);
+}
+
+int xpc_partition_disengaged_from_timer(struct xpc_partition *part)
+{
+	return __xpc_partition_disengaged(part, true);
+}
+
 /*
  * Mark specified partition as active.
  */
--=20
2.29.2

