Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BAD21BB77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgGJQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgGJQxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:53:05 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D94207D0;
        Fri, 10 Jul 2020 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399984;
        bh=VrO79BAPTvsqAJryzs9s1s3QDGGNJm8F0l70wqqFpU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jam5ZhL7YFw3WEWoDK4X/DgucvuEh9nG7hSocGIPPVCsksf00rD+mmRcYz24AMjrM
         Jh25rSdnNLlJzDLK65c+dx9KNEB6UiQdh6XhxypYADF/2yRjCxPIZm8BJyB1GWrygl
         4satdWCb0CSVj6Lcv08gKW1K7H6n/gtqeUd7cY8M=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH v3 13/19] include/linux: Remove smp_read_barrier_depends() from comments
Date:   Fri, 10 Jul 2020 17:51:57 +0100
Message-Id: <20200710165203.31284-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_read_barrier_depends() doesn't exist any more, so reword the two
comments that mention it to refer to "dependency ordering" instead.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/percpu-refcount.h | 2 +-
 include/linux/ptr_ring.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 22d9d183950d..87d8a38bdea1 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -155,7 +155,7 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
 	 * between contaminating the pointer value, meaning that
 	 * READ_ONCE() is required when fetching it.
 	 *
-	 * The smp_read_barrier_depends() implied by READ_ONCE() pairs
+	 * The dependency ordering from the READ_ONCE() pairs
 	 * with smp_store_release() in __percpu_ref_switch_to_percpu().
 	 */
 	percpu_ptr = READ_ONCE(ref->percpu_count_ptr);
diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 417db0a79a62..808f9d3ee546 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -107,7 +107,7 @@ static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 		return -ENOSPC;
 
 	/* Make sure the pointer we are storing points to a valid data. */
-	/* Pairs with smp_read_barrier_depends in __ptr_ring_consume. */
+	/* Pairs with the dependency ordering in __ptr_ring_consume. */
 	smp_wmb();
 
 	WRITE_ONCE(r->queue[r->producer++], ptr);
-- 
2.27.0.383.g050319c2ae-goog

