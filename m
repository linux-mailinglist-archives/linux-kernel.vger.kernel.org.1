Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44326202B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIHUKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgIHPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:16:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0AC00459A;
        Tue,  8 Sep 2020 08:06:16 -0700 (PDT)
Date:   Tue, 8 Sep 2020 17:06:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599577574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0xWEdkJYmjRskXLYyHk2uavdx98cfyorxmAk0N3TxQ=;
        b=zsrVpoXooUj5pWkLJvETQqtS6gTvhVilchXveVcnplPj50R4uAEX5pC2mbFAZ9NVwPwWYn
        3OGhIozIaVwaskUDb05DiWjSbkcAex40rGFmrDdRst++XuYWd5GMl/r8OD/WUNbMJg7E8I
        UK1gxthhAepVtZgD0mb9232T+RxhIfSQMLvgEiK5AoTrp5SAbEiCeW6auHdjDprjlV7HP0
        fWXWiY1Drc8xXESZ3vW9MpFbO07qG7RdDsDML5I1OpUbweFfRwC2u8fVovKY4rrGlOZTJr
        3pQe82IGnXAfM1UaINcsrwINDxOuptk4T/mK0W0t0ELYuHeNblEuSIJxtG9+9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599577574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0xWEdkJYmjRskXLYyHk2uavdx98cfyorxmAk0N3TxQ=;
        b=yqWIqRbNY6439Nztjozsb47laPF1yKXWv3y43MElehArGG8Q8xTaCwqoOO6QO8pjXaa1V7
        XRGXAbKkISg6jZBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
Message-ID: <20200908150612.6qlygag7e7pzhr22@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
 <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
 <20200908121902.zlfd3balosnu7ies@linutronix.de>
 <3471761a379062a474ba32f9d0157eb3020244cf.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3471761a379062a474ba32f9d0157eb3020244cf.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-08 16:56:20 [+0200], Mike Galbraith wrote:
> On Tue, 2020-09-08 at 14:19 +0200, Sebastian Andrzej Siewior wrote:
> >
> > This has nothing to do with the bridge but with the fact that you use a
> > non standard queue class (something else than pfifo_fast).
> 
> That must be SUSE, I don't muck about in network land.  I downloaded a
> whole library of RFCs decades ago, but turns out that one of those is
> all the bedtime story you'll ever need.  Huge waste of bandwidth :)

I see.
This should cure it:

Subject: [PATCH] net: Properly annotate the try-lock for the seqlock

In patch
   ("net/Qdisc: use a seqlock instead seqcount")

the seqcount has been replaced with a seqlock to allow to reader to
boost the preempted writer.
The try_write_seqlock() acquired the lock with a try-lock but the
seqcount annotation was "lock".

Opencode write_seqcount_t_begin() and use the try-lock annotation for
lockdep.

Reported-by: Mike Galbraith <efault@gmx.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/net_seq_lock.h |  9 ---------
 include/net/sch_generic.h  | 10 +++++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/net/net_seq_lock.h b/include/net/net_seq_lock.h
index 95a497a72e511..67710bace7418 100644
--- a/include/net/net_seq_lock.h
+++ b/include/net/net_seq_lock.h
@@ -6,15 +6,6 @@
 # define net_seq_begin(__r)		read_seqbegin(__r)
 # define net_seq_retry(__r, __s)	read_seqretry(__r, __s)
 
-static inline int try_write_seqlock(seqlock_t *sl)
-{
-	if (spin_trylock(&sl->lock)) {
-		write_seqcount_begin(&sl->seqcount);
-		return 1;
-	}
-	return 0;
-}
-
 #else
 # define net_seqlock_t			seqcount_t
 # define net_seq_begin(__r)		read_seqcount_begin(__r)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 796ac453d9519..40be4443b6bdb 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -168,8 +168,16 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		return false;
 	}
 #ifdef CONFIG_PREEMPT_RT
-	if (try_write_seqlock(&qdisc->running))
+	if (spin_trylock(&qdisc->running.lock)) {
+		seqcount_t *s = &qdisc->running.seqcount.seqcount;
+		/*
+		 * Variant of write_seqcount_t_begin() telling lockdep that a
+		 * trylock was attempted.
+		 */
+		raw_write_seqcount_t_begin(s);
+		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
 		return true;
+	}
 	return false;
 #else
 	/* Variant of write_seqcount_begin() telling lockdep a trylock
-- 
2.28.0


> 	-Mike

Sebastian
