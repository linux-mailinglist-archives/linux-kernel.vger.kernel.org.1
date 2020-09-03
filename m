Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4606B25CAD6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgICUfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgICUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:32:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E248AC06123A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:31:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 207so3968814ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eXyK7J9+wEoy6n93pGjsemhSapgcmFl0BX/NaB/p9Jk=;
        b=bl8y7IQFLGNeyUAeZcfI04liBm2+5Zu2fhovRckS3HbShVs/pKY6yijYdoZGgjXbe9
         rnxHlZIFkhdAC3UL0J1KPXOl/qNLi62/6WiZKWSWivwBFIdb1nS7FU25EYtuAYUJmGv8
         +qz++Je0zhFE7opCb1BqdwzM2IDaUvm0cTqiaobW/Sp0ZiEVR2t6jKZvd+n2Cqqzbh8Y
         kwXyVj1GLGn4l5bafljvZKOUNQdm4i+Il6qu14szG7RRqeufJYl6I/DnRE+ba3CTgsG4
         QlyOJKGfXIwTRIG9BHfsdwEpvtfi7qErAYGP0+FUfzucydQmKqVh5VMxBUoKCqntz4Ew
         9X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eXyK7J9+wEoy6n93pGjsemhSapgcmFl0BX/NaB/p9Jk=;
        b=fwIWmVn7lrcRZUM7nBpsi4Zx6fjn37X4pPbqLiLGI7UHr4NOCDcOkVXksl8mfoYrpX
         qeRjyUsC3dV3W1WUBWz9amZXABFEw5dhvCAdgeXQPlMAlEFk3kxLe6/c2lXYKUFvOJQp
         g52aNA2vIKSelVelVbG5lSN8VxKgI2aQn+t+RySL76gJgbyfzHQ2lfgTnk8PWKJL/WpM
         IBK78mypzF0YfwiJBbT37DcQ66oI+GTrrFDVly4RGcRJkG6Khf3PsgQASt0c7MZ1XNvz
         k3NSHEiNRXzKfbkpCrjYJ98D02/umpP6FfGixr8jxHccKyTJHmpjcn8yJ93tNZXRm39p
         jF0g==
X-Gm-Message-State: AOAM530vPaE2a+syk0fZaOBNSoGA1vHoHMDefooNorKdO909XZmhLzFV
        TOve3vxTctMOPcOAFW3X0pV1OmX5rPCAfgr3VS4=
X-Google-Smtp-Source: ABdhPJzL5rJmpcBKWDSFuqkgaUQFoP665rSkqnN6Fo73XdVlItxzzwLHKRC84PR6feaowJ2duaBg4X7jp0x4RA6WkXE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:aab1:: with SMTP id
 t46mr4799689ybi.249.1599165090093; Thu, 03 Sep 2020 13:31:30 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:42 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 17/28] PCI: Fix PREL32 relocations for LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
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
2.28.0.402.g5ffc5be6b7-goog

