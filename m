Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4499A204504
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgFWAJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731506AbgFWAJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC4820874;
        Tue, 23 Jun 2020 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870990;
        bh=+PcUzT2UD1F7Itvq3ICpa8xeVmpjTjGlVpiq7NztraQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmWBAJV6XOlOI33dnDLX/AUvrcewSLmpBYL5l5h/l3ECR2aB7qiiFji6TEPF+dNb9
         2bjXRv60YpjaOKQMk30R9KNW8TIP/KDPZMCv+BJOs7OHQprvKZDRESgzxDWv3GBuN2
         S7Wyf4Rr44bWPr5PGy5v2SbJr1sW3LE1cA/x2j2U=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/10] docs: RCU: Convert rcuref.txt to ReST
Date:   Mon, 22 Jun 2020 17:09:43 -0700
Message-Id: <20200623000947.25222-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst                  |   1 +
 Documentation/RCU/{rcuref.txt => rcuref.rst} | 199 ++++++++++++++-------------
 2 files changed, 104 insertions(+), 96 deletions(-)
 rename Documentation/RCU/{rcuref.txt => rcuref.rst} (50%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 5d5f9a1..9a1d51f 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -18,6 +18,7 @@ RCU concepts
    whatisRCU
    rcu
    rculist_nulls
+   rcuref
    torture
    listRCU
    NMI-RCU
diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.rst
similarity index 50%
rename from Documentation/RCU/rcuref.txt
rename to Documentation/RCU/rcuref.rst
index 5e6429d6..b33aeb1 100644
--- a/Documentation/RCU/rcuref.txt
+++ b/Documentation/RCU/rcuref.rst
@@ -1,4 +1,8 @@
-Reference-count design for elements of lists/arrays protected by RCU.
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================================================
+Reference-count design for elements of lists/arrays protected by RCU
+====================================================================
 
 
 Please note that the percpu-ref feature is likely your first
@@ -12,32 +16,33 @@ please read on.
 Reference counting on elements of lists which are protected by traditional
 reader/writer spinlocks or semaphores are straightforward:
 
-CODE LISTING A:
-1.				2.
-add()				search_and_reference()
-{				{
-    alloc_object		    read_lock(&list_lock);
-    ...				    search_for_element
-    atomic_set(&el->rc, 1);	    atomic_inc(&el->rc);
-    write_lock(&list_lock);	     ...
-    add_element			    read_unlock(&list_lock);
-    ...				    ...
-    write_unlock(&list_lock);	}
-}
-
-3.					4.
-release_referenced()			delete()
-{					{
-    ...					    write_lock(&list_lock);
-    if(atomic_dec_and_test(&el->rc))	    ...
-	kfree(el);
-    ...					    remove_element
-}					    write_unlock(&list_lock);
- 					    ...
-					    if (atomic_dec_and_test(&el->rc))
-					        kfree(el);
-					    ...
-					}
+CODE LISTING A::
+
+    1.					    2.
+    add()				    search_and_reference()
+    {					    {
+	alloc_object				read_lock(&list_lock);
+	...					search_for_element
+	atomic_set(&el->rc, 1);			atomic_inc(&el->rc);
+	write_lock(&list_lock);			 ...
+	add_element				read_unlock(&list_lock);
+	...					...
+	write_unlock(&list_lock);	   }
+    }
+
+    3.					    4.
+    release_referenced()		    delete()
+    {					    {
+	...					write_lock(&list_lock);
+	if(atomic_dec_and_test(&el->rc))	...
+	    kfree(el);
+	...					remove_element
+    }						write_unlock(&list_lock);
+						...
+						if (atomic_dec_and_test(&el->rc))
+						    kfree(el);
+						...
+					    }
 
 If this list/array is made lock free using RCU as in changing the
 write_lock() in add() and delete() to spin_lock() and changing read_lock()
@@ -46,34 +51,35 @@ search_and_reference() could potentially hold reference to an element which
 has already been deleted from the list/array.  Use atomic_inc_not_zero()
 in this scenario as follows:
 
-CODE LISTING B:
-1.					2.
-add()					search_and_reference()
-{					{
-    alloc_object			    rcu_read_lock();
-    ...					    search_for_element
-    atomic_set(&el->rc, 1);		    if (!atomic_inc_not_zero(&el->rc)) {
-    spin_lock(&list_lock);		        rcu_read_unlock();
-					        return FAIL;
-    add_element				    }
-    ...					    ...
-    spin_unlock(&list_lock);		    rcu_read_unlock();
-}					}
-3.					4.
-release_referenced()			delete()
-{					{
-    ...					    spin_lock(&list_lock);
-    if (atomic_dec_and_test(&el->rc))       ...
-        call_rcu(&el->head, el_free);       remove_element
-    ...                                     spin_unlock(&list_lock);
-} 					    ...
-					    if (atomic_dec_and_test(&el->rc))
-					        call_rcu(&el->head, el_free);
-					    ...
-					}
+CODE LISTING B::
+
+    1.					    2.
+    add()				    search_and_reference()
+    {					    {
+	alloc_object				rcu_read_lock();
+	...					search_for_element
+	atomic_set(&el->rc, 1);			if (!atomic_inc_not_zero(&el->rc)) {
+	spin_lock(&list_lock);			    rcu_read_unlock();
+						    return FAIL;
+	add_element				}
+	...					...
+	spin_unlock(&list_lock);		rcu_read_unlock();
+    }					    }
+    3.					    4.
+    release_referenced()		    delete()
+    {					    {
+	...					spin_lock(&list_lock);
+	if (atomic_dec_and_test(&el->rc))	...
+	    call_rcu(&el->head, el_free);	remove_element
+	...					spin_unlock(&list_lock);
+    }						...
+						if (atomic_dec_and_test(&el->rc))
+						    call_rcu(&el->head, el_free);
+						...
+					    }
 
 Sometimes, a reference to the element needs to be obtained in the
-update (write) stream.  In such cases, atomic_inc_not_zero() might be
+update (write) stream.	In such cases, atomic_inc_not_zero() might be
 overkill, since we hold the update-side spinlock.  One might instead
 use atomic_inc() in such cases.
 
@@ -82,39 +88,40 @@ search_and_reference() code path.  In such cases, the
 atomic_dec_and_test() may be moved from delete() to el_free()
 as follows:
 
-CODE LISTING C:
-1.					2.
-add()					search_and_reference()
-{					{
-    alloc_object			    rcu_read_lock();
-    ...					    search_for_element
-    atomic_set(&el->rc, 1);		    atomic_inc(&el->rc);
-    spin_lock(&list_lock);		    ...
-
-    add_element				    rcu_read_unlock();
-    ...					}
-    spin_unlock(&list_lock);		4.
-}					delete()
-3.					{
-release_referenced()			    spin_lock(&list_lock);
-{					    ...
-    ...					    remove_element
-    if (atomic_dec_and_test(&el->rc))       spin_unlock(&list_lock);
-        kfree(el);			    ...
-    ...                                     call_rcu(&el->head, el_free);
-} 					    ...
-5.					}
-void el_free(struct rcu_head *rhp)
-{
-    release_referenced();
-}
+CODE LISTING C::
+
+    1.					    2.
+    add()				    search_and_reference()
+    {					    {
+	alloc_object				rcu_read_lock();
+	...					search_for_element
+	atomic_set(&el->rc, 1);			atomic_inc(&el->rc);
+	spin_lock(&list_lock);			...
+
+	add_element				rcu_read_unlock();
+	...				    }
+	spin_unlock(&list_lock);	    4.
+    }					    delete()
+    3.					    {
+    release_referenced()			spin_lock(&list_lock);
+    {						...
+	...					remove_element
+	if (atomic_dec_and_test(&el->rc))	spin_unlock(&list_lock);
+	    kfree(el);				...
+	...					call_rcu(&el->head, el_free);
+    }						...
+    5.					    }
+    void el_free(struct rcu_head *rhp)
+    {
+	release_referenced();
+    }
 
 The key point is that the initial reference added by add() is not removed
 until after a grace period has elapsed following removal.  This means that
 search_and_reference() cannot find this element, which means that the value
 of el->rc cannot increase.  Thus, once it reaches zero, there are no
-readers that can or ever will be able to reference the element.  The
-element can therefore safely be freed.  This in turn guarantees that if
+readers that can or ever will be able to reference the element.	 The
+element can therefore safely be freed.	This in turn guarantees that if
 any reader finds the element, that reader may safely acquire a reference
 without checking the value of the reference counter.
 
@@ -130,21 +137,21 @@ the eventual invocation of kfree(), which is usually not a problem on
 modern computer systems, even the small ones.
 
 In cases where delete() can sleep, synchronize_rcu() can be called from
-delete(), so that el_free() can be subsumed into delete as follows:
-
-4.
-delete()
-{
-    spin_lock(&list_lock);
-    ...
-    remove_element
-    spin_unlock(&list_lock);
-    ...
-    synchronize_rcu();
-    if (atomic_dec_and_test(&el->rc))
-    	kfree(el);
-    ...
-}
+delete(), so that el_free() can be subsumed into delete as follows::
+
+    4.
+    delete()
+    {
+	spin_lock(&list_lock);
+	...
+	remove_element
+	spin_unlock(&list_lock);
+	...
+	synchronize_rcu();
+	if (atomic_dec_and_test(&el->rc))
+	    kfree(el);
+	...
+    }
 
 As additional examples in the kernel, the pattern in listing C is used by
 reference counting of struct pid, while the pattern in listing B is used by
-- 
2.9.5

