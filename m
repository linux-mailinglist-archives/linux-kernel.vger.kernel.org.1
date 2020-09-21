Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F95271C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIUH7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:59:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:56802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgIUH71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80FADB51D;
        Mon, 21 Sep 2020 08:00:02 +0000 (UTC)
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
Subject: [RFC PATCH 23/41] random: don't award entropy to non-SP800-90B arch RNGs in FIPS mode
Date:   Mon, 21 Sep 2020 09:58:39 +0200
Message-Id: <20200921075857.4424-24-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075857.4424-1-nstange@suse.de>
References: <20200921075857.4424-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is required by SP800-90C that only SP800-90B compliant entropy sources
may be used for seeding DRBGs.

Don't award any entropy to arch_get_random_long() if fips_enabled is
true. Don't award any entropy to arch_get_random_seed_long() if
fips_enabled && !arch_has_sp800_90b_random_seed().

This is achieved by making min_crng_reseed_pool_entropy() return the
full minimum seed size if fips_enabled && !arch_has_sp800_90b_random_seed()
is true. This prevents crng_reseed() from attempting to make up for any
lack of entropy in the input_pool by reading from the architectural RNG.

Make crng_reseed() bail out in FIPS mode if the input_pool provides
insufficient entropy and any of the arch_get_random_seed_long()
invocations fails: there's no statement regarding SP900-90B compliance of
arch_get_random_long() and so it can't be used as a backup.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/random.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7712b4464ef5..aaddee4e4ab1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1195,9 +1195,13 @@ static int min_crng_reseed_pool_entropy(void)
 	 * up to one half of the minimum entropy needed for
 	 * reseeding. That way it won't dominate the entropy
 	 * collected by other means at input_pool.
+	 * If in FIPS mode, restrict this to SP900-90B compliant
+	 * architectural RNGs.
 	 */
-	if (arch_has_random() || arch_has_random_seed())
+	if (arch_has_sp800_90b_random_seed() ||
+	    (!fips_enabled && (arch_has_random() || arch_has_random_seed()))) {
 		return 8;
+	}
 	return 16;
 }
 
@@ -1233,7 +1237,8 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	for (i = 0; i < 8; i++) {
 		unsigned long	rv;
 		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv)) {
+		    ((arch_randomness_required && fips_enabled) ||
+		     !arch_get_random_long(&rv))) {
 			if (arch_randomness_required) {
 				/*
 				 * The input_pool failed to provide
-- 
2.26.2

