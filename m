Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCD28C660
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgJMAew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgJMAdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:33:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037CC0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:32:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7so19056355ybq.22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=b5rCnYz4obhAgpKHq4mgEn5Hvv5UPGIbAlGkTv5aKg4=;
        b=MykYLsVoW6bkD+kFLc2l4bZyxZpNnxo5YIENz3yzcHdNClIoPGRyCYicb5g8AQrHlf
         df0Gi9/JPdft0uy6mxQ8xnHAIiPgUf/18ZfL8+WUyQb/jixQHXBLhPe7l8ku7/iBS+dk
         mWk3XCOGF5DUG3vDFMYT/uzcvXkm9kiXnlA1gynp2l/H8pHXYSzhOHAKpK0ZbzYicU1P
         frWYR08lQPhQRINUTpGAlkvjHk+GvfxvYhoX8ZHnGwBsE5Y4RkibJPqELUFCiH0ueFWl
         1IdBzaLdFbnfnlmrxckdCqOEsoDhKenpLBG0Q/F1J5BC444cYLDhWDWGR3dyO2Uj2m9+
         febQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b5rCnYz4obhAgpKHq4mgEn5Hvv5UPGIbAlGkTv5aKg4=;
        b=jYX+pqS8j2hWKR41Pv+ANyCPneQOivpKPgo13vS0NTHAQ5JG6KsiT7ShUjU6LdJUZ7
         JHMQhz2beLDH2JVxfql9X4P2VIPKm4zwZek8hkzuJ7vvOofWCm/s7AEl6UTIp4qfmO7x
         173WsaIxaUiz/lDH1C0tJk5dx3h6tU+7tq4eATz0lgSSZcXDJ+t4j+PU3N+1IMG4OtX1
         /PXCK4BRYztvemj9YGKac1Nzbi0O7DNdSEUXQEhZ9kolRUapBNajXli2u1so2EtpuC5f
         21YPS36lYeiCVuRESDOVWZOyHvVeO3IQ9KAhs3RJDSUyVzmiMh3gnm43vz4GEVUC7Nyl
         YfoA==
X-Gm-Message-State: AOAM5304YmC8cTp5yo57QxSS80eByRjsLZ/lWfTUBmKx6zl1rMbJCRGg
        65UEyCtYBwVYJoKLc2Vxb1UpiWyAJptfHM5fRiA=
X-Google-Smtp-Source: ABdhPJxj3WaxnTrI4Y+21BRW/jvruhJbF5tMQ4nUmURYi2TvGAs4d/9YZvJC9PHsI7NLcVk286bnvQSZPRgh877RCN0=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:73c9:: with SMTP id
 o192mr13193667ybc.353.1602549162840; Mon, 12 Oct 2020 17:32:42 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:55 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 17/25] PCI: Fix PREL32 relocations for LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
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
index 835530605c0d..4e64421981c7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1909,19 +1909,28 @@ enum pci_fixup_pass {
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
2.28.0.1011.ga647a8990f-goog

