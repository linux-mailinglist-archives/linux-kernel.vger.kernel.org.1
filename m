Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429C62F5BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbhANHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbhANHya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:54:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7470239FF;
        Thu, 14 Jan 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=AIc2wW620mOmuszeWZXDxQT5qZVzYGxu91AL11TYNE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fo0BHM4dtTH6oMYdIRblWAn8G+JBudfr5/3qR5qz3qF/4FeyE2O9EbKvp0Y0gJfP5
         wwSPRApjShInvuDLfFbSvBl2bfp0DI6WDY9KBrRh3aTPLZIEwdrkFTU77Na0HBgziF
         Ct8Rw3GcGFHxr53YNC8qcifzeXpoFvKGd2nwMvsXRSKqOCTReyKHDqq5f6TeqfULj9
         mGqNIpg5UklWKBa5/veG8QlmUvBkoM5/L6IULwt3J5fnFjmJjMZu1+4vyOkneeG2TT
         Zs8Phb4BlLPZYfl3NB10ODfQgVRxaZEPnZgzx5IGCnKgFxn8k1Z0RNRpT3vEgMpoD3
         0AVBT7tb43cQQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPuL-DL; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] seqlock: kernel-doc: fix a prototype
Date:   Thu, 14 Jan 2021 08:53:45 +0100
Message-Id: <84693a4901efb553dd95fe4909b50d6d8faf8107.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, kernel-doc produces a warning:

	./include/linux/seqlock.h:829: warning: wrong kernel-doc identifier on line:
	 * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t

The issue is that Kernel-doc valid syntaxes for function/define
declarations are either:

	function_foo - description

or:

	function_foo() - description

The function parameters should be declared only afterwards.

So, replace it to:
	DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 2f7bb92b4c9e..209454cedf61 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -826,7 +826,7 @@ typedef struct {
 	} while (0)
 
 /**
- * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
+ * DEFINE_SEQLOCK() - Define a statically allocated seqlock_t
  * @sl: Name of the seqlock_t instance
  */
 #define DEFINE_SEQLOCK(sl) \
-- 
2.29.2

