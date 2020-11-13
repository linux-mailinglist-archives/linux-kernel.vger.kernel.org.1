Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5403C2B1FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMQTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:19:22 -0500
Received: from foss.arm.com ([217.140.110.172]:40996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMQTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:19:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 097BF1042;
        Fri, 13 Nov 2020 08:19:22 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF1363F718;
        Fri, 13 Nov 2020 08:19:20 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] random: Use arch_get_random_long_early() for init_std_data()
Date:   Fri, 13 Nov 2020 16:19:12 +0000
Message-Id: <20201113161912.62068-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 253d3194c2b5 ("random: add arch_get_random_*long_early()") we
introduced _early versions of arch_get_random_long(), that are used on
arm64 to use the CPU RNDR instruction early in the boot process, before
we have established system-wide availability.
This covers the calls in crng_initialize_primary(), but missed the calls
in init_std_data(), happening just before that.

Use the _early versions of the arch_get_random* calls also in
init_std_data(), to help initialising the pool with proper seed values.

Fixes: 253d3194c2b5 ("random: add arch_get_random_*long_early()")
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2a41b21623ae..43bb331a67bd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1778,8 +1778,8 @@ static void __init init_std_data(struct entropy_store *r)
 
 	mix_pool_bytes(r, &now, sizeof(now));
 	for (i = r->poolinfo->poolbytes; i > 0; i -= sizeof(rv)) {
-		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv))
+		if (!arch_get_random_seed_long_early(&rv) &&
+		    !arch_get_random_long_early(&rv))
 			rv = random_get_entropy();
 		mix_pool_bytes(r, &rv, sizeof(rv));
 	}
-- 
2.17.1

