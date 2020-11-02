Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD562A3490
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKBTw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgKBTvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:51:14 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9390420731;
        Mon,  2 Nov 2020 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346673;
        bh=FpDcuq4X3c15OGqODzqAwNDRNZ4X0QXyRi03Om0x8cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4MuecLoB0CKibj8VPiip0cqlcGFmU8mf36eiMbFOAj8zw8/ufHZz5ucsKwh79UiX
         B/XiV+Fq4ANoCjppDyyzPSuSkTLX7c21X3/dWkkQ0Yu3a6E084gHeP4Esg2yB8mM9R
         zFfP+32Qszb23XR7z3oAWgoWT5rOnfKo7XhBT9AU=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/2] selftests/x86/fsgsbase: Fix GS == 1, 2, and 3 tests
Date:   Mon,  2 Nov 2020 11:51:10 -0800
Message-Id: <7567fd44a1d60a9424f25b19a998f12149993b0d.1604346596.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604346596.git.luto@kernel.org>
References: <cover.1604346596.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting GS to 1, 2, or 3 causes a nonsensical part of the IRET
microcode to change GS back to zero on a return from kernel mode to
user mode.  The result is that these tests fail randomly depending
on when interrupts happen.  Detect when this happens and let the
test pass.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 7161cfc2e60b..8c780cce941d 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -392,8 +392,8 @@ static void set_gs_and_switch_to(unsigned long local,
 		local = read_base(GS);
 
 		/*
-		 * Signal delivery seems to mess up weird selectors.  Put it
-		 * back.
+		 * Signal delivery is quite likely to change a selector
+		 * of 1, 2, or 3 back to 0 due to IRET being defective.
 		 */
 		asm volatile ("mov %0, %%gs" : : "rm" (force_sel));
 	} else {
@@ -411,6 +411,14 @@ static void set_gs_and_switch_to(unsigned long local,
 	if (base == local && sel_pre_sched == sel_post_sched) {
 		printf("[OK]\tGS/BASE remained 0x%hx/0x%lx\n",
 		       sel_pre_sched, local);
+	} else if (base == local && sel_pre_sched >= 1 && sel_pre_sched <= 3 &&
+		   sel_post_sched == 0) {
+		/*
+		 * IRET is misdesigned and will squash selectors 1, 2, or 3
+		 * to zero.  Don't fail the test just because this happened.
+		 */
+		printf("[OK]\tGS/BASE changed from 0x%hx/0x%lx to 0x%hx/0x%lx because IRET is defective\n",
+		       sel_pre_sched, local, sel_post_sched, base);
 	} else {
 		nerrs++;
 		printf("[FAIL]\tGS/BASE changed from 0x%hx/0x%lx to 0x%hx/0x%lx\n",
-- 
2.28.0

