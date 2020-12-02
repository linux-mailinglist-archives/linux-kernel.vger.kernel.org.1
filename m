Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81242CB728
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgLBI2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbgLBI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:28:00 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 1/2] asm: sgx.h: fix a typo on a kernel-doc markup
Date:   Wed,  2 Dec 2020 09:27:14 +0100
Message-Id: <ca11a4540d981cbd5f026b6cbc8931aa55654e00.1606897462.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606897462.git.mchehab+huawei@kernel.org>
References: <cover.1606897462.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by kernel-doc:
	arch/x86/include/uapi/asm/sgx.h:19: warning: expecting prototype for enum sgx_epage_flags. Prototype was for enum sgx_page_flags instead

There is a typo at the kernel-doc markup:

	sgx_epage_flags -> sgx_page_flags

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/x86/include/uapi/asm/sgx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 791e45334a4a..9034f3007c4e 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -9,7 +9,7 @@
 #include <linux/ioctl.h>
 
 /**
- * enum sgx_epage_flags - page control flags
+ * enum sgx_page_flags - page control flags
  * %SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
  *			ENCLS[EEXTEND] operations.
  */
-- 
2.28.0

