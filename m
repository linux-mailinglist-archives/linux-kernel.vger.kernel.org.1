Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08D271C94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIUIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:00:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIUH70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BDA5B514;
        Mon, 21 Sep 2020 07:59:59 +0000 (UTC)
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
Subject: [RFC PATCH 18/41] random: move arch_get_random_seed() calls in crng_reseed() into own loop
Date:   Mon, 21 Sep 2020 09:58:34 +0200
Message-Id: <20200921075857.4424-19-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86's RDSEED/RDRAND insns have reportedly been slowed down significantly
due to the ucode update required to mitigate against the "Special Register
Buffer Data Sampling" vulnerability (CVE-2020-0543) and should not get
invoked from the interrupt path anymore.

In preparation of getting rid of that arch_get_random_long() call currently
found in add_interrupt_randomness(), move those arch_get_random_long()
calls in crng_reseed() into a separate loop and outside of the crng->lock.

There is no functional change.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/random.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a49805d0d23c..1945249597e0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1200,14 +1200,18 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		_crng_backtrack_protect(&primary_crng, buf.block,
 					CHACHA_KEY_SIZE);
 	}
-	spin_lock_irqsave(&crng->lock, flags);
+
 	for (i = 0; i < 8; i++) {
 		unsigned long	rv;
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv))
 			rv = random_get_entropy();
-		crng->state[i+4] ^= buf.key[i] ^ rv;
+		buf.key[i] ^= rv;
 	}
+
+	spin_lock_irqsave(&crng->lock, flags);
+	for (i = 0; i < 8; i++)
+		crng->state[i+4] ^= buf.key[i];
 	memzero_explicit(&buf, sizeof(buf));
 	crng->init_time = jiffies;
 	spin_unlock_irqrestore(&crng->lock, flags);
-- 
2.26.2

