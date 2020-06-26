Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B997F20B6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 19:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFZRV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 13:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFZRVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:21:23 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A356B20707;
        Fri, 26 Jun 2020 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192082;
        bh=rNBkOdFFjPU7AEXE+DgR/v/daMsve5cpZy8JC6DX1ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/3LHwJ3oEtznMDU+nFKghpHgcn1o/ctkRWpzVk0e2RcXTKC2IGupaWfr30FKDKYR
         oqVZ4piA5WSzuqdPxDftuzZE8iFILLEDZ2eJzE7YxlWCVJUQQSEyotPkUo0hxg9jpn
         JMpr5XrI2m5gIZg/3ooHlR66IEK71tS0fjrnTk3s=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4/6] selftests/x86/syscall_nt: Add more flag combinations
Date:   Fri, 26 Jun 2020 10:21:14 -0700
Message-Id: <12924e2fe2c5826568b7fc9436d85ca7f5eb1743.1593191971.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593191971.git.luto@kernel.org>
References: <cover.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EFLAGS.AC to the mix.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/syscall_nt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index 02309a195041..f060534b66a0 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -73,6 +73,12 @@ int main(void)
 	printf("[RUN]\tSet NT and issue a syscall\n");
 	do_it(X86_EFLAGS_NT);
 
+	printf("[RUN]\tSet AC and issue a syscall\n");
+	do_it(X86_EFLAGS_AC);
+
+	printf("[RUN]\tSet NT|AC and issue a syscall\n");
+	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC);
+
 	/*
 	 * Now try it again with TF set -- TF forces returns via IRET in all
 	 * cases except non-ptregs-using 64-bit full fast path syscalls.
@@ -80,8 +86,17 @@ int main(void)
 
 	sethandler(SIGTRAP, sigtrap, 0);
 
+	printf("[RUN]\tSet TF and issue a syscall\n");
+	do_it(X86_EFLAGS_TF);
+
 	printf("[RUN]\tSet NT|TF and issue a syscall\n");
 	do_it(X86_EFLAGS_NT | X86_EFLAGS_TF);
 
+	printf("[RUN]\tSet AC|TF and issue a syscall\n");
+	do_it(X86_EFLAGS_AC | X86_EFLAGS_TF);
+
+	printf("[RUN]\tSet NT|AC|TF and issue a syscall\n");
+	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC | X86_EFLAGS_TF);
+
 	return nerrs == 0 ? 0 : 1;
 }
-- 
2.25.4

