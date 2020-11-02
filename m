Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A632A3493
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKBTw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgKBTvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:51:15 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DB120731;
        Mon,  2 Nov 2020 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346674;
        bh=GHgrqrZC9saaja+OzUUhbi6fJEQlVSb7/fyvPZXEx6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7QGQFGKYZgnL1CsRgcfXVEJvGkahE5IE4nzejf579kzL6B8XT7ZdxEhVxbHLOHU7
         MAuwKup1AUq//kIiOQKGwxQCgXQqnb1QxEzZB0MryPCZhiGoz3m2/+0AAs3vC7QziW
         jLvQQ7kEIVxh0NhHZ13ei69dtOzjLXtJMbwVnixg=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] selftests/x86: Add missing .note.GNU-stack sections
Date:   Mon,  2 Nov 2020 11:51:11 -0800
Message-Id: <6f043c03e9e0e4557e1e975a63b07a4d18965a68.1604346596.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604346596.git.luto@kernel.org>
References: <cover.1604346596.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several of the x86 selftests end up with executable stacks because
the asm was missing the annotation that says that they are modern
and don't need executable stacks.  Add the annotations.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/raw_syscall_helper_32.S | 2 ++
 tools/testing/selftests/x86/thunks.S                | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/x86/raw_syscall_helper_32.S b/tools/testing/selftests/x86/raw_syscall_helper_32.S
index 94410fa2b5ed..a10d36afdca0 100644
--- a/tools/testing/selftests/x86/raw_syscall_helper_32.S
+++ b/tools/testing/selftests/x86/raw_syscall_helper_32.S
@@ -45,3 +45,5 @@ int80_and_ret:
 
 	.type int80_and_ret, @function
 	.size int80_and_ret, .-int80_and_ret
+
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/thunks.S b/tools/testing/selftests/x86/thunks.S
index 1bb5d62c16a4..a2d47d8344d4 100644
--- a/tools/testing/selftests/x86/thunks.S
+++ b/tools/testing/selftests/x86/thunks.S
@@ -57,3 +57,5 @@ call32_from_64:
 	ret
 
 .size call32_from_64, .-call32_from_64
+
+.section .note.GNU-stack,"",%progbits
-- 
2.28.0

