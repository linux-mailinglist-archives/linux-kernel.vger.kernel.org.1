Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB10A271922
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIUCG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIUCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:06:28 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F9C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 19:06:28 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id db4so6549482qvb.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8XvG3aKhTCgccN6tRKYf0OEdn6z/jVHZpdf2bD7EVt4=;
        b=ViMXvi1i1rBoozLaponJ8XmTqWwdl0ZDlk2syzw6q6Cndef1k2VBGGr2jNDfxv3cEb
         z9o2nY1FniBKhJBYmTRHMDG0XIk91GYL7OmRz3SatZU8veeeNqRXca8XbDCeyiArMMnn
         yHyxwk5pqWcmdJgeGM3K8FN9YIEQxgkc3kqX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8XvG3aKhTCgccN6tRKYf0OEdn6z/jVHZpdf2bD7EVt4=;
        b=JS4sU5HjAukiTWjJ0VA5GGLhVfwhe871G1nnWnh0zXcYzBph8kRSbNYS+0Srhq3zJ2
         k3p4HR0F8XtJkgllNWJELU7wPKiUtlt6bqHh9EVWNXSeQJvmR7uSfMyKuipxamRvu/Ap
         whqN7gtcqnu1mljTFmzuTTPXCxqis7I/u8T2K4tiCuderVMENjk2d/bV2nVh+ozXZ6zA
         xuuN2TxEFbtsetOUvJMWvOX5clEyqzK2UjnJDd6txs8sRlLepkNSYRRYpjSigfHHCVMw
         dnuRijMc/vGafKscCz7I+o37X+IzmZEjtxCB7HyskoRksYhF302FfBWp3eMhBdglCx00
         +7ng==
X-Gm-Message-State: AOAM53383lTTfoTRKT4VPHKtPUyYVz899KYg9752zexE+uhndVNABnL+
        QXz39NA1qvVaCOzeBiA/QmOGDpHuri92HA==
X-Google-Smtp-Source: ABdhPJwbILutUjjIKTVYjrlvsuBu67cUo6cnl+kFKNVXxxYX0DTBupenLyv6mbXXDzzRrk59s/r2mQ==
X-Received: by 2002:a0c:e294:: with SMTP id r20mr27506071qvl.60.1600653986814;
        Sun, 20 Sep 2020 19:06:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c70sm7764311qkg.4.2020.09.20.19.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 19:06:26 -0700 (PDT)
Date:   Sun, 20 Sep 2020 22:06:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [RFC v5 0/5] Add support length of each segment in the segcblist
 (breaks TREE04)
Message-ID: <20200921020625.GA2930323@google.com>
References: <20200921012152.2831904-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921012152.2831904-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 09:21:47PM -0400, Joel Fernandes (Google) wrote:
> 
> NOTE: I marked as RFC since TREE 04 fails even though TREE03 passes. I don't
> see any RCU errors in the counters, however when shutdown thread tries to
> shutdown the system, it hangs when trying to shutdown the rcu_barrier thread.

Looks like if I restore the logic of setting the segcb_list ->len field from
the callers of extract_done_cbs(), then TREE04 issues go away. I am inclined
to do that considering this series, for what it is trying to do, does not
really need to optimize that logic (can be done later).

With the below diff on top of this series, TREE04 passes. I will await any
other review comments before posting another series.. meanwhile, will pass
it through the grinders..

---8<---
diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 319a565f6ecb..d462ae5e340a 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -76,7 +76,6 @@ struct rcu_segcblist {
 #endif
 	u8 enabled;
 	u8 offloaded;
-	u8 invoking;
 };
 
 #define RCU_SEGCBLIST_INITIALIZER(n) \
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index ec9a609a461b..3c82c016feb1 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -388,7 +388,6 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
 	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
-	rcu_segcblist_add_len(rsclp, -(rclp->len));
 }
 
 /*
@@ -452,7 +451,17 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
 		rcu_segcblist_set_seglen(rsclp, i, 0);
 	}
-	rcu_segcblist_add_len(rsclp, -(rclp->len));
+}
+
+/*
+ * Insert counts from the specified rcu_cblist structure in the
+ * specified rcu_segcblist structure.
+ */
+void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
+				struct rcu_cblist *rclp)
+{
+	rcu_segcblist_add_len(rsclp, rclp->len);
+	rclp->len = 0;
 }
 
 /*
@@ -476,7 +485,6 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 			break;
 	rclp->head = NULL;
 	rclp->tail = &rclp->head;
-	rcu_segcblist_add_len(rsclp, rclp->len);
 }
 
 /*
@@ -492,7 +500,6 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
-	rcu_segcblist_add_len(rsclp, rclp->len);
 }
 
 /*
@@ -637,9 +644,12 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 	rcu_cblist_init(&donecbs);
 	rcu_cblist_init(&pendcbs);
 
+	rcu_segcblist_set_len(src_rsclp, 0);
 	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
 	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
 
+	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
+	rcu_segcblist_insert_count(dst_rsclp, &pendcbs);
 	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
 	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index c2dc08a9b020..15c10d30f88c 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -40,33 +40,14 @@ static inline bool rcu_segcblist_empty(struct rcu_segcblist *rsclp)
 	return !READ_ONCE(rsclp->head);
 }
 
-static inline void rcu_segcblist_set_invoking(struct rcu_segcblist *rsclp)
-{
-	WRITE_ONCE(rsclp->invoking, 1);
-}
-
-static inline void rcu_segcblist_reset_invoking(struct rcu_segcblist *rsclp)
-{
-	WRITE_ONCE(rsclp->invoking, 0);
-}
-
 /* Return number of callbacks in segmented callback list. */
 static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 {
-	long ret;
 #ifdef CONFIG_RCU_NOCB_CPU
-	ret = atomic_long_read(&rsclp->len);
+	return atomic_long_read(&rsclp->len);
 #else
-	ret = READ_ONCE(rsclp->len);
+	return READ_ONCE(rsclp->len);
 #endif
-
-	/*
-	 * An invoking list should not appear empty. This is required
-	 * by rcu_barrier().
-	 */
-	if (ret)
-		return ret;
-	return (READ_ONCE(rsclp->invoking) ? 1 : 0);
 }
 
 /*
@@ -112,6 +93,8 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 				    struct rcu_cblist *rclp);
 void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 				    struct rcu_cblist *rclp);
+void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
+				struct rcu_cblist *rclp);
 void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
 void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 62b83fb997ee..0f23d20d485a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1196,6 +1196,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	 * schedule another round of callback invocation.
 	 */
 	spin_lock_irq_rcu_node(sdp);
+	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&ssp->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b4dc18e4661c..64dff7b17e74 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2465,7 +2465,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	}
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
-	rcu_segcblist_set_invoking(&rdp->cblist);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
@@ -2524,9 +2523,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-
-	smp_mb();
-	rcu_segcblist_reset_invoking(&rdp->cblist);
+	smp_mb(); /* List handling before counting for rcu_barrier(). */
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
