Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D727A245229
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHOVoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:44:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:55010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgHOVnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:43:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CFB7B052;
        Sat, 15 Aug 2020 10:07:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 4/6] x86/entry/32: revert "Fix XEN_PV build dependency"
Date:   Sat, 15 Aug 2020 12:06:39 +0200
Message-Id: <20200815100641.26362-5-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200815100641.26362-1-jgross@suse.com>
References: <20200815100641.26362-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 32-bit Xen PV support gone commit a4c0e91d1d65bc58
("x86/entry/32: Fix XEN_PV build dependency") can be reverted again.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/idtentry.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a43366191212..337dcfd45472 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -547,7 +547,7 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	exc_machine_check);
 
 /* NMI */
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
-#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
+#ifdef CONFIG_XEN_PV
 DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
 #endif
 
@@ -557,7 +557,7 @@ DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
 #else
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	exc_debug);
 #endif
-#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
+#ifdef CONFIG_XEN_PV
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
 #endif
 
-- 
2.26.2

