Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50762B8774
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKRWIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbgKRWHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:07:53 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEAAC061A51
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:07:53 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id 60so2506253qvb.15
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bMl2xGwOyye8qFQQO5LhDpDmrDsCMs58eGZcnuWlmjA=;
        b=Nd7GPjj0ywkFIgMBmhds53YYdSle4acSaIFPLbVd61W8stSkNuoz0WxEayV/OD+juR
         7iFFwAf5WeBqFMYZtbNZKvYarFFEIh0TRBfk8yozSVYTyizaOQn7nV/yOM5qfxhN6W3x
         F41WPEwVNkENBqTup7x2SW7FaXclkPY/jek8JoLFOskeSCczH+BvXJtXBg4dfeqkMd7O
         5Jgsz0yx51vX7weJ6s9P7KIXrk46KNMTxH11C5CzpPEqWRCRyIwkXB16YTNgAiWSsV8M
         KuNdy4S5hjgNwFDrtraKFHI+LKTEBWBcWNWdPZnYpkQRqJAXNOz0JKEptCIRYdyLVRVY
         EmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bMl2xGwOyye8qFQQO5LhDpDmrDsCMs58eGZcnuWlmjA=;
        b=JNt5ey6kXTDDeoTHih6MZksPNNxx/LpGWUjbhEuJmZQDhu/cxdVSQ3I2QsJanDLfHY
         OOmM7lglvI6bz6Y9fCXoNhL9B9UFbI31a/Il6jAdQP+KWB53YBe4E2aP1zSXNNOMO2TO
         QLTbK6UpeT6Vwp8m7ntUBTvJeCyn0Z+fXbR9cBiS1yLsEPCcF43Px05GbwuAYFzExgEp
         OU2/eYmU0nPOhP9pF5FcstcYKHZ4Q8rc36H3XVmFhOApaXkD9LASaivTL/hMFc3q4wAF
         ZNj8oXzdmfycMqZ8CHu8EJn+M4/EoTqwN+FmInzYAOF8eXK6Yzs4uaWNneYwDQ6OtXPF
         mv0w==
X-Gm-Message-State: AOAM531XVjrdBmL2dnHeRM+wtAKMRblJBuIKHHpas5iL3lFBzD1ccVVJ
        ehMpkNUrwWL8+hDkZHxNdPLRCKgYpox6YnLoBdY=
X-Google-Smtp-Source: ABdhPJw3XblGH0ype4DsebvgJ6qN/grSpkQ1FW0TAdSpMqPujHMfKBlR5uzuC4pXuA1vl9up5ivNoLV3rdGadkF867U=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:a94b:: with SMTP id
 z11mr3035952qva.24.1605737272927; Wed, 18 Nov 2020 14:07:52 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:23 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 09/17] PCI: Fix PREL32 relocations for LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Clang's Link Time Optimization (LTO), the compiler can rename
static functions to avoid global naming collisions. As PCI fixup
functions are typically static, renaming can break references
to them in inline assembly. This change adds a global stub to
DECLARE_PCI_FIXUP_SECTION to fix the issue when PREL32 relocations
are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pci.h | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a79762c..5b8505a5ca5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1912,19 +1912,28 @@ enum pci_fixup_pass {
 };
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
-				    class_shift, hook)			\
-	__ADDRESSABLE(hook)						\
+#define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook, stub)		\
+	void stub(struct pci_dev *dev);					\
+	void stub(struct pci_dev *dev)					\
+	{ 								\
+		hook(dev); 						\
+	}								\
 	asm(".section "	#sec ", \"a\"				\n"	\
 	    ".balign	16					\n"	\
 	    ".short "	#vendor ", " #device "			\n"	\
 	    ".long "	#class ", " #class_shift "		\n"	\
-	    ".long "	#hook " - .				\n"	\
+	    ".long "	#stub " - .				\n"	\
 	    ".previous						\n");
+
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook, stub)		\
+	___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook, stub)
 #define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				  class_shift, hook)			\
 	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
-				  class_shift, hook)
+				  class_shift, hook, __UNIQUE_ID(hook))
 #else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
-- 
2.29.2.299.gdc1121823c-goog

