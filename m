Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE572D0511
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgLFNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:14:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F26C0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 05:13:21 -0800 (PST)
Date:   Sun, 06 Dec 2020 13:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607260400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Hlce5dtrxscrYtFsEPStm3g5GCMcyGKB2xY4z3FRnQI=;
        b=r3JXvxBfiCwSrqG6WJrNnPZ4Ri4swdh+lypRvIvk4/VYnnzmg3hV4PUXQHrugD9ecdtJk5
        uhs7/N6rnnpl97fGaZlR7fnAyNby2J/TOv6neIYgZ0H7L6Q6hVjPKchYoe81hkqtpZ9Wib
        gdeTxhrKC1WqdnpcJHRjoSRSNzDmUNjtPRbYpjR76y0E4tmHjLt175jMsXuXr/gVyX7mG2
        F8KMIe1DJ3dSKNXhtOuxis0xAIqVZt/igtalpffPghIqCoO0UDgalHcYiWtFvHNbAgVNDU
        ek09lrTTR7ZcHGme6lzhvS6qMFSckzzngpqbpHLHL1KW7wVNpvCAd7R5hJpM3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607260400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Hlce5dtrxscrYtFsEPStm3g5GCMcyGKB2xY4z3FRnQI=;
        b=Ap6JBIsySxgEvMT+fjRIiW3Pefw1OiQjFWtA2dplkOg5ZjvtQqaJ0MXF20KtBb3UL9frO8
        nelmSuwvEnklobAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.10-rc7
References: <160726029814.10836.11636935433736940390.tglx@nanos>
Message-ID: <160726030055.10836.6112093149252426489.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-12-06

up to:  fc17db8aa4c5: perf/x86/intel: Check PEBS status correctly


Two fixes for performance monitoring on X86:

    - Add recursion protection to another callchain invoked from
      x86_pmu_stop() which can recurse back into x86_pmu_stop(). The first
      attempt to fix this missed this extra code path.

    - Use the already filtered status variable to check for PEBS counter
      overflow bits and not the unfiltered full status read from
      IA32_PERF_GLOBAL_STATUS which can have unrelated bits check which
      would be evaluated incorrectly.


Thanks,

	tglx

------------------>
Namhyung Kim (1):
      perf/x86/intel: Fix a warning on x86_pmu_stop() with large PEBS

Stephane Eranian (1):
      perf/x86/intel: Check PEBS status correctly


 arch/x86/events/intel/ds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b47cc4226934..485c5066f8b8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1916,7 +1916,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		 * that caused the PEBS record. It's called collision.
 		 * If collision happened, the record will be dropped.
 		 */
-		if (p->status != (1ULL << bit)) {
+		if (pebs_status != (1ULL << bit)) {
 			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
 				error[i]++;
 			continue;
@@ -1940,7 +1940,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if (error[bit]) {
 			perf_log_lost_samples(event, error[bit]);
 
-			if (perf_event_account_interrupt(event))
+			if (iregs && perf_event_account_interrupt(event))
 				x86_pmu_stop(event, 0);
 		}
 

