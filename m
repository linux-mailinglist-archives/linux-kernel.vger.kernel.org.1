Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6821BB68
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgGJQwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgGJQwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:52:40 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9355D206F4;
        Fri, 10 Jul 2020 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399960;
        bh=ioP+zE3QcZYWtrbP8JNe5R3MHrpHsHsJaawhzRfRFq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olt02LKeAL91nPxgaC1qQAJZnrzmwBteJROoi562TZOoKlwf2GsHdueJYh9wQvHS3
         ta9HVOXq+Jp+Nl1VoxyEu4NOLAeCoB6OaLnJ5Iop/QE1Nmg6joEiitmdW4N8HXMUXb
         PbP/PPuekBo452bRN9Tvaf8qj1qEbhU6Ap3dq+mo=
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
Subject: [PATCH v3 07/19] vhost: Remove redundant use of read_barrier_depends() barrier
Date:   Fri, 10 Jul 2020 17:51:51 +0100
Message-Id: <20200710165203.31284-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 76ebbe78f739 ("locking/barriers: Add implicit
smp_read_barrier_depends() to READ_ONCE()"), there is no need to use
smp_read_barrier_depends() outside of the Alpha architecture code.

Unfortunately, there is precisely _one_ user in the vhost code, and
there isn't an obvious READ_ONCE() access making the barrier
redundant. However, on closer inspection (thanks, Jason), it appears
that vring synchronisation between the producer and consumer occurs via
the 'avail_idx' field, which is followed up by an rmb() in
vhost_get_vq_desc(), making the read_barrier_depends() redundant on
Alpha.

Jason says:

  | I'm also confused about the barrier here, basically in driver side
  | we did:
  |
  | 1) allocate pages
  | 2) store pages in indirect->addr
  | 3) smp_wmb()
  | 4) increase the avail idx (somehow a tail pointer of vring)
  |
  | in vhost we did:
  |
  | 1) read avail idx
  | 2) smp_rmb()
  | 3) read indirect->addr
  | 4) read from indirect->addr
  |
  | It looks to me even the data dependency barrier is not necessary
  | since we have rmb() which is sufficient for us to the correct
  | indirect->addr and driver are not expected to do any writing to
  | indirect->addr after avail idx is increased

Remove the redundant barrier invocation.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vhost.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d7b8df3edffc..74d135ee7e26 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2092,11 +2092,6 @@ static int get_indirect(struct vhost_virtqueue *vq,
 		return ret;
 	}
 	iov_iter_init(&from, READ, vq->indirect, ret, len);
-
-	/* We will use the result as an address to read from, so most
-	 * architectures only need a compiler barrier here. */
-	read_barrier_depends();
-
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
-- 
2.27.0.383.g050319c2ae-goog

