Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779E42140F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGCVhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:37:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76FC061794;
        Fri,  3 Jul 2020 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wFJAil8Dz5TWKGz7NZcKWSg2CYXBI3uAgrbBWnvt1nw=; b=mXAOn5xjo5HVTc6KojnbKcDV8O
        qkBPyZRdqnydFkXrsFMFot7mJN8pwgMZ/feX1egc2ylCpbk1VkQPpStpn+veXfPifsfEeI1Qt5Q1z
        O7rBcukcxAO0wwDCOrK4+5eRNOqSN8FU7iDE/5AwfbtGs/Vw6PNIBGrgoWxaHC0iuZmZEhyvyHZhB
        jmPXa8cHqv0Z1KX+JrWp37TkDyMLneCImXSTq2T5cv88zvi+eJ2e4mnSKygjStcc6DZuiqFXhGv5h
        ultCC7I5z6UK+QEAGtzKXdbhQSAiS1ppDWcTGDjPY6+lrsuTQ/i7nulJXQD7Ms70w/KcbA+2ggepK
        Yqyw29Eg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTMf-0006gs-Kp; Fri, 03 Jul 2020 21:36:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] Documentation: locking: mutex-design: fix duplicated word
Date:   Fri,  3 Jul 2020 14:36:48 -0700
Message-Id: <20200703213649.30948-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703213649.30948-1-rdunlap@infradead.org>
References: <20200703213649.30948-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the phrase "at at least" to "to at least" to be more
readable.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
---
 Documentation/locking/mutex-design.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/locking/mutex-design.rst
+++ linux-next-20200701/Documentation/locking/mutex-design.rst
@@ -28,7 +28,7 @@ and implemented in kernel/locking/mutex.
 (->owner) to keep track of the lock state during its lifetime.  Field owner
 actually contains `struct task_struct *` to the current lock owner and it is
 therefore NULL if not currently owned. Since task_struct pointers are aligned
-at at least L1_CACHE_BYTES, low bits (3) are used to store extra state (e.g.,
+to at least L1_CACHE_BYTES, low bits (3) are used to store extra state (e.g.,
 if waiter list is non-empty).  In its most basic form it also includes a
 wait-queue and a spinlock that serializes access to it. Furthermore,
 CONFIG_MUTEX_SPIN_ON_OWNER=y systems use a spinner MCS lock (->osq), described
