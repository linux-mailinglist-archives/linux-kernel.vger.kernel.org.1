Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E288271C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIUIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:00:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIUH7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C97DB50F;
        Mon, 21 Sep 2020 07:59:57 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Petr Tesarik <ptesarik@suse.cz>,
        Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH 14/41] random: drop __credit_entropy_bits_fast()
Date:   Mon, 21 Sep 2020 09:58:30 +0200
Message-Id: <20200921075857.4424-15-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All former call sites of __credit_entropy_bits_fast() have been converted
to the new __dispatch_queued_entropy_fast() API. Drop the now unused
__credit_entropy_bits_fast().

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/random.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index dfbe49fdbcf1..60ce185d7b2d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -900,20 +900,6 @@ static bool __dispatch_queued_entropy_fast(struct entropy_store *r,
 	return false;
 }
 
-/*
- * Credit the entropy store with n bits of entropy.
- * To be used from hot paths when it is either known that nbits is
- * smaller than one half of the pool size or losing anything beyond that
- * doesn't matter. Must be called with r->lock being held.
- */
-static bool __credit_entropy_bits_fast(struct entropy_store *r, int nbits)
-{
-	struct queued_entropy q = { 0 };
-
-	__queue_entropy(r, &q, nbits << ENTROPY_SHIFT);
-	return __dispatch_queued_entropy_fast(r, &q);
-}
-
 /*
  * Credit the pool with previously queued entropy.
  *
-- 
2.26.2

