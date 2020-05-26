Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755571C1072
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgEAJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728236AbgEAJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 05:40:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A40C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 02:40:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jUS9l-00038k-HG; Fri, 01 May 2020 11:40:29 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] crash: add VMCOREINFO macro for anonymous structs
Date:   Fri,  1 May 2020 11:46:08 +0206
Message-Id: <20200501094010.17694-2-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501094010.17694-1-john.ogness@linutronix.de>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some structs are not named and are only available via their typedef.
Add a VMCOREINFO macro to export field offsets for such structs.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/crash_core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 525510a9f965..43b51c9df571 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -53,6 +53,9 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 #define VMCOREINFO_OFFSET(name, field) \
 	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
 			      (unsigned long)offsetof(struct name, field))
+#define VMCOREINFO_TYPE_OFFSET(name, field) \
+	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
+			      (unsigned long)offsetof(name, field))
 #define VMCOREINFO_LENGTH(name, value) \
 	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
 #define VMCOREINFO_NUMBER(name) \
-- 
2.20.1

