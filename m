Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AFD1AC059
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634320AbgDPLyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633920AbgDPLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD709C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GbPqE3mfOetHUtuB+gPFjnQNDr1UBAvzbfzHTV0Kr/8=; b=CnG07FO+CZvkicC3wNgu3SyyQJ
        2kR85uR0JwEMu1bjOYNlYStZVt6i992gE4GUDMu5yorWvAgmOFaDLMw26wG3Gxei4SvnybE3ADQ9U
        /L1mmszWdk6K1yUn1ys96qW6kUJDIZZBPakq7c1oNYmsFfmnKM+ihbOnapUmvgZPBEpXA4gK9e8MF
        7U14QoxAKePhF0V6MvYi8azgeVeU3vRXIlo3Pv1NXghm+ImZRVWOOitAOkv8SUzOkaSkrVtLxdABY
        jL5BZLfxEQ65lilT/J5C9ktQWKyE8W+AaSjKkRrB8e/e4mmYJXS855B1vAW9HpOiSYueyb5CColFN
        2/1T6DFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34G-0006jb-Ld; Thu, 16 Apr 2020 11:52:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68B05307881;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 53B1B2B0DE4C3; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.287494491@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 13/17] kbuild/objtool: Add objtool-vmlinux.o pass
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that objtool is capable of processing vmlinux.o and actually has
something useful to do there, (conditionally) add it to the final link
pass.

This will increase build time by a few seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Kconfig.debug       |    5 +++++
 scripts/link-vmlinux.sh |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -379,6 +379,11 @@ config STACK_VALIDATION
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
+config VMLINUX_VALIDATION
+	bool
+	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	default y
+
 config DEBUG_FORCE_WEAK_PER_CPU
 	bool "Force weak per-cpu definitions"
 	depends on DEBUG_KERNEL
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -55,6 +55,29 @@ modpost_link()
 	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
 }
 
+objtool_link()
+{
+	local objtoolopt;
+
+	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
+		objtoolopt="check"
+		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
+			objtoolopt="${objtoolopt} --no-fp"
+		fi
+		if [ -n "${CONFIG_GCOV_KERNEL}" ]; then
+			objtoolopt="${objtoolopt} --no-unreachable"
+		fi
+		if [ -n "${CONFIG_RETPOLINE}" ]; then
+			objtoolopt="${objtoolopt} --retpoline"
+		fi
+		if [ -n "${CONFIG_X86_SMAP}" ]; then
+			objtoolopt="${objtoolopt} --uaccess"
+		fi
+		info OBJTOOL ${1}
+		tools/objtool/objtool ${objtoolopt} ${1}
+	fi
+}
+
 # Link of vmlinux
 # ${1} - output file
 # ${2}, ${3}, ... - optional extra .o files
@@ -244,6 +267,7 @@ ${MAKE} -f "${srctree}/scripts/Makefile.
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
+objtool_link vmlinux.o
 
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1


