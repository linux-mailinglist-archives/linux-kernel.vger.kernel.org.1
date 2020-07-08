Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52F521907D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 21:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgGHTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 15:30:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgGHT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:29:56 -0400
Message-Id: <20200708192934.076519438@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594236594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0jgxh9T9RaQnXULIzk201sZw8AO824RYyv3j/77l178=;
        b=Kdi1i7xYRfZGQWJtduMwalp3dRKOWrVjVGbDmKh2bBhufFl8QG4IyUBCz2OEbSpS8zm9pu
        /Cj5CN0fIT2ve9HXwxjqXl2oEMaOQVJNrXSIa9lBF5C3ntDDd8Tc6pKbChSO1PvzH7zWgp
        pgxnKTTwJKZRT+NUe4mtX28bGQpsQ0E5oBIHySSfyfT2q7ToKIRdBeM9mliHY6JrbYqEWj
        8jht6wMnEDTGO32YoB/xj4uogMtX2k6pI8POAe7oqMsios4v7anjhXaLOEd/ZS48CuVetV
        dDa0pf/Ty286nJUzXig48KvyLHpAFTu0DK6HSd+2JEs6yfuQJKTTtwZ/pjwMIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594236594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0jgxh9T9RaQnXULIzk201sZw8AO824RYyv3j/77l178=;
        b=oQ1ykJNF+DL7THMBVWcwvfgAkXTcWNiWpUDOhecVfhB1+EywdovbXbu9PkJvTLJ83FgasR
        yezgyU/yLeLuz4AA==
Date:   Wed, 08 Jul 2020 21:28:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org,
        syzbot+0889df9502bc0f112b31@syzkaller.appspotmail.com
Subject: [patch 1/3] x86/traps: Disable interrupts in exc_aligment_check()
References: <20200708192804.911958542@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exc_alignment_check() fails to disable interrupts before returning to the
entry code.

Fixes: ca4c6a9858c2 ("x86/traps: Make interrupt enable/disable symmetric in C code")
Reported-by: syzbot+0889df9502bc0f112b31@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/traps.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -303,6 +303,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_
 
 	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
 		error_code, BUS_ADRALN, NULL);
+
+	local_irq_disable();
 }
 
 #ifdef CONFIG_VMAP_STACK

