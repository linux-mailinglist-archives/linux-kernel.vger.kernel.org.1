Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6615D2DA484
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgLOAD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgLOADT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:03:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B654C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bu4H45hAtfsZq1Tas/LunrKn8O0pX1xkwgMpn9D0ovc=; b=KHaOTBthXQqAX7PHcLzOxgYRg1
        h0OTS8lUmLIUe+iBkCsoCtGuDQ52vF4nzYYX2VFhbAdYUnE2yT9G1xxncpNhljcUp6keVug4Th07I
        mwus84MD+zJ4pxBQfonKe5bnpKLlTtAPLcaczMuXJXoQ1VZVCIplji3qE4sJlxoWGn8pDJu66KP/2
        thtDX6ajxK7nS9tBL+gfiZNA2dfcC2wb6mcmTGd7F3F6P6+bZkyumhBARql+Uh9UDomSiWMej2j23
        i5AfwaJEjq24ymvnZwHXW9Tvrltq8ADXylQOGgcYMLoeYiKna6uJI8gjm1h1h5kwKp9jL4i1WQg7w
        Vj5ccHDA==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koxnY-0000UQ-Qx; Tue, 15 Dec 2020 00:02:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -next] x86: vmlinux.lds.S: explain link error better when PHYSICAL_START is LARGE
Date:   Mon, 14 Dec 2020 16:02:32 -0800
Message-Id: <20201215000232.25594-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, when CONFIG_PHYSICAL_START is very large, it causes a
confusing or misleading linker error message:

  ld: kernel image bigger than KERNEL_IMAGE_SIZE

so expand this message to include the possibility that the problem
could be due to CONFIG_PHYSICAL_START.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/vmlinux.lds.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201214.orig/arch/x86/kernel/vmlinux.lds.S
+++ linux-next-20201214/arch/x86/kernel/vmlinux.lds.S
@@ -458,7 +458,7 @@ SECTIONS
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
  */
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
-	   "kernel image bigger than KERNEL_IMAGE_SIZE");
+	   "kernel image bigger than KERNEL_IMAGE_SIZE or CONFIG_PHYSICAL_START too large");
 
 #ifdef CONFIG_X86_64
 /*
