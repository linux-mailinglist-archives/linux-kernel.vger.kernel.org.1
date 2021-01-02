Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250212E886B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 21:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbhABUNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 15:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbhABUNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 15:13:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8CBC061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 12:12:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k10so13606301wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QUB4+4d1LDuvfodpASBj+IEX3GafEWaRMquf7qx7cRs=;
        b=OqTDsRn4oML0wLkk1QCLGIRyCp4OOlaZzpkr28FjjsuARS1LNhgAufItGJP/3AfynU
         5KQJoIsIMXNYsk3FgMHtSz8odKgz0wxAcbd1naGdDS7p3A+9uBxeMbf2kqxKX9pH7PEf
         NarlxHv6F9gE8bpCWidZJ/Ffwxjc2FYc28xMSMKVQD/lasEwWC0tb/SMKJh9sAZUO372
         RCu8uocVyeaEM7jR+3oL7E8v7uPYgsrkHstpy9aH+RC9q8tofULPk0QnDRnk+HH+kZjd
         UwDF/LWmi69M+j3eY1VSWRCDxi7Ms4xInlEKeAoB0KeTcidyqC7smvNpxsC7nWE6AALI
         Cx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QUB4+4d1LDuvfodpASBj+IEX3GafEWaRMquf7qx7cRs=;
        b=ScgMg9hHjJDczEHgsY0zjf+LoByYjmWbO0TfmeQ0nnYmEEUovntx+TQclWmC62V1PR
         /W05nXBlablb+tYmLYcSGNd+6fInET8oEWLhVDTUMhescs+5M79zYOa5p6bmZFhew3Pr
         J/Xn1I2e9WpcUIUJjvdhGf0KK1uYSfeZ+6/DG6kJWFViORqjAz6nCo7siuELnx0rbDJP
         fY9RrVcBKx/tqucq6o+26ibLkQw04yOdR27SezewMy+smOE1cw80kXyg1kmBJZj32+ka
         6GO/wB6dEeAGSVZC9mtJvC1ZLAV55VKr+mufdlpd0H2KS+Vu//WxyG8v/CkkoNVvP88o
         nN0A==
X-Gm-Message-State: AOAM530XrF7RZhJj9T5UDuX6BiEHopJ7RqQGoT26rrnMSMDtJtylzNnU
        GI/6+EUn2YBWgfz4JvbUSGY=
X-Google-Smtp-Source: ABdhPJwgK6UuqAY6qoQQUSAP+SFTqQPtExweuUv2K2cP05/4Km2aJ9YB2hQvBPPO0xTrg8NgKXSIKQ==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr20838226wmk.29.1609618344134;
        Sat, 02 Jan 2021 12:12:24 -0800 (PST)
Received: from localhost.localdomain (bzq-109-64-2-78.red.bezeqint.net. [109.64.2.78])
        by smtp.gmail.com with ESMTPSA id x18sm95692603wrg.55.2021.01.02.12.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 12:12:23 -0800 (PST)
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
X-Google-Original-From: Ariel Marcovitch <ariel.marcovitch@gmail.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, keescook@chromium.org, dja@axtens.net,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        maskray@google.com, ariel.marcovitch@gmail.com, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: fix alignment bug whithin the init sections
Date:   Sat,  2 Jan 2021 22:11:56 +0200
Message-Id: <20210102201156.10805-1-ariel.marcovitch@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bug that causes early crashes in builds with a
.exit.text section smaller than a page and a .init.text section that
ends in the beginning of a physical page (this is kinda random, which
might explain why this wasn't really encountered before).

The init sections are ordered like this:
	.init.text
	.exit.text
	.init.data

Currently, these sections aren't page aligned.

Because the init code might become read-only at runtime and because the
.init.text section can potentially reside on the same physical page as
.init.data, the beginning of .init.data might be mapped read-only along
with .init.text.

Then when the kernel tries to modify a variable in .init.data (like
kthreadd_done, used in kernel_init()) the kernel panics.

To avoid this, make _einittext page aligned and also align .exit.text
to make sure .init.data is always seperated from the text segments.

Fixes: 060ef9d89d18 ("powerpc32: PAGE_EXEC required for inittext")
Signed-off-by: Ariel Marcovitch <ariel.marcovitch@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 6db90cdf11da..b6c765d8e7ee 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -187,6 +187,11 @@ SECTIONS
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
 		_sinittext = .;
 		INIT_TEXT
+
+		/* .init.text might be RO so we must
+		* ensure this section ends in a page boundary.
+		*/
+		. = ALIGN(PAGE_SIZE);
 		_einittext = .;
 #ifdef CONFIG_PPC64
 		*(.tramp.ftrace.init);
@@ -200,6 +205,8 @@ SECTIONS
 		EXIT_TEXT
 	}
 
+	. = ALIGN(PAGE_SIZE);
+
 	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
 		INIT_DATA
 	}

base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
2.17.1

