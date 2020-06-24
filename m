Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECB209690
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 00:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbgFXWuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 18:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387974AbgFXWux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:50:53 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B85920768;
        Wed, 24 Jun 2020 22:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593039052;
        bh=P5ZTgqOEqubrFlz1VMbmsQWDYNF2ojtgUJjGOh04Vgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWJHmbUzGOqAdjDNIFb/jx+hH7zLw7ubm1LlBXunFAOkAK1vF21dICPuP+1GewUSC
         OtTrJ91ZvD1IIyWC4jP6RJ82RWcdMWkJ1sBuW1zm9nmwiq7O+se1mBR/t90Po0RkDh
         VSCUILMYE94VZ78MXYv5Y16/eN/HLkWXE0oBmNfE=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] selftests/x86/fsgsbase: Fix a comment in the ptrace_write_gsbase test
Date:   Wed, 24 Jun 2020 15:50:48 -0700
Message-Id: <901034a91a40169ec84f1f699ea86704dff762e4.1593038991.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593038991.git.luto@kernel.org>
References: <cover.1593038991.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A comment was unclear.  Fix it.

Fixes: 5e7ec8578fa3 ("selftests/x86/fsgsbase: Test ptracer-induced GS base write with FSGSBASE")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 9a4349813a30..f47495d2f070 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -498,7 +498,8 @@ static void test_ptrace_write_gsbase(void)
 			 * base would zero the selector.  On newer kernels,
 			 * this behavior has changed -- poking the base
 			 * changes only the base and, if FSGSBASE is not
-			 * available, this may not effect.
+			 * available, this may have no effect once the tracee
+			 * is resumed.
 			 */
 			if (gs == 0)
 				printf("\tNote: this is expected behavior on older kernels.\n");
-- 
2.25.4

