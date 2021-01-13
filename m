Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA42F4973
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhAMLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbhAMLBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B04E23444;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=0sIdqGIhB9vU4qbNCe86TIJtSTKzTyJaNLdk3IQ3IZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9e9BbuTlTgfRJ71Z7ztrTm8unT8w2iXoF5SCzbr/6Lh90sL7xSBO2D/83/Gv9yec
         8r4Ik7om5f4ai0ygSqfoH5Awjx7AoYNLIH5S2LR2APEgEa2HWbpFk4uyemiMvPFhMf
         YhfU5E5qTc/Xh/lnO2AJMNXw39AqWPJqMTozlGpweap7pwMr3aWzuhc2BugiQJLbyn
         rNfOLouyMY4Rg/G8UKrIm0qt8WFCGDfYHDEFZUiysdt+D+27nI9tNno2+zjp+OiMUv
         VaXBTbpJlW93R+ttNQ0zarVBCUAu1noH428gZeXwmBPyCGQlO1n5IBzqLvDtsVV9Uj
         nL5cPrKpnaqQQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGc-M7; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] arch/Kconfig: update unaligned-memory-access.rst reference
Date:   Wed, 13 Jan 2021 11:59:18 +0100
Message-Id: <24c3aa427cf7e99e01f49a221a15c2eb5768b63e.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 997c798e1444 ("docs: sysctl/kernel: document unaligned controls")
renamed: Documentation/unaligned-memory-access.txt
to: Documentation/process/unaligned-memory-access.rst.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a3de881ed54a..89bcfa1c3ad8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -156,7 +156,7 @@ config HAVE_64BIT_ALIGNED_ACCESS
 	  accesses are required to be 64 bit aligned in this way even
 	  though it is not a 64 bit architecture.
 
-	  See Documentation/unaligned-memory-access.txt for more
+	  See Documentation/process/unaligned-memory-access.rst for more
 	  information on the topic of unaligned memory accesses.
 
 config HAVE_EFFICIENT_UNALIGNED_ACCESS
-- 
2.29.2

