Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49612E2004
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgLWRnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgLWRnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE3C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:42:43 -0800 (PST)
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5BE71EC04A6;
        Wed, 23 Dec 2020 18:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aT0inzHQPvajM88a2z7+x3Y8U1TGXPOYHXa0Jp3SI4I=;
        b=I6vgCgrpQQ5dn6Pk4PQLg6nTULjv0aHZKWXTM8epeXhC1b5IsPkAvP3bj/Lg+RakeyV7x/
        FJT/Gx7Y8UbGV0Fo2ZD7EBCBnXYgHAi88rzCWlnp7T7dW+0MDsoyZ0Jwlax34iWlD/s/ha
        zJhssZD63W+vhsShsyo4OYhLMqAFLC4=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 02/19] x86/insn: Add @buf_len param to insn_init() kernel-doc comment
Date:   Wed, 23 Dec 2020 18:42:16 +0100
Message-Id: <20201223174233.28638-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It wasn't documented so add it. No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/lib/insn.c       | 1 +
 tools/arch/x86/lib/insn.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..1ba994862b56 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -37,6 +37,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..f3277d6e4ef2 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -37,6 +37,7 @@
  * insn_init() - initialize struct insn
  * @insn:	&struct insn to be initialized
  * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @buf_len:	length of the insn buffer at @kaddr
  * @x86_64:	!0 for 64-bit kernel or 64-bit app
  */
 void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
-- 
2.29.2

