Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE14F2FDA00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392697AbhATTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392711AbhATTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:41:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E7C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:41:08 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611171667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6U5TkjZCVVrN/oMjfIPQanim8D8kqSXoj9EEMcAXkRk=;
        b=oOtGaSyg01QRa4jyYvlWhXHgNtqPwO7eQ4E8Z/ia6X3U3WCMfBLx2qm7OUsPWFdSU7yeHD
        G/NV2GCvHq3Et3adCokZSPH79KTPJCsK4r4hQ6TVMjdilw81BrvzET14REZj8e6O3TM2Qa
        OVGXkwelSS8I7uJy2zUXzYnaCjAYw8oEvo5BD8cg3f7wdGDsKUbNnB6aS6uSAFx1VC9dy9
        NR7r8I7kfim6Pq67Viqqb0WWHYB8exUj3VQUFCnJLKj7zERK++nVSnb1slkectQq7s8NqD
        L0G36daGnJXrOsSokNLz7hYh8y7QIKv3tY3KdwXpj1PL2T+Ql0ncJc+w9mQk4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611171667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6U5TkjZCVVrN/oMjfIPQanim8D8kqSXoj9EEMcAXkRk=;
        b=kXXGpf+ued3WoBhADdf/OM0P97CDMnKufHyezATdRPCGU7TAbGFKDDvuCc25w1itpgxTqq
        pBkEp+BTlnOODGDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] another size-1 fixup from msg_print_text()
Date:   Wed, 20 Jan 2021 20:47:05 +0106
Message-Id: <20210120194106.26441-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think this is the last fixup from the msg_print_text() size-1
quirk that has been hiding in the kernel for nearly 8 years.

This is a very simple fix for an obvious problem, so my commit
message may be way too large. There probably is not a need to
prove the error. Trim/edit the commit message as you feel fit.

This change as a separate commit is important because I will be
to posting a series that consolidates this code and I don't want
my consolidation secretly fixing such long-standing issues.

John Ogness (1):
  printk: fix syslog_print_all() 1024-byte edge case

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1

