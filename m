Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7B297429
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465738AbgJWQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751857AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741E8246C0;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=9Nh3/zUjIfiEVQ01kmUiyq82XA7e0shNpKQNIZuVNB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWKegXc41sR390mnbbSlOh1al/Q5gjHY78Ad/xOaAbLVBCVK1vslMxqoBCB/hDj3W
         4Dw6BX6laEb6N4cvSjsDs4aRdIIMbLnNsbfwdbHB4DCxp2AdkbxX7Ojsq25RVSow8L
         AZZm2SXXeKVYyoq4vm6tCALx78e5mlw+sKKXcdog=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Ax7-BL; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 39/56] completion: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:26 +0200
Message-Id: <071fa0e17be1d7cfaf34440f4a5d302b05e28095.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc only supports having the comment just before
the identifier.

The markup for init_completion is actually for
__init_completion.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---

Thats said, IMHO, it would make sense to simply
rename __init_completion() to init_completion() and drop
this define:

	 #define init_completion(x) __init_completion(x)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/completion.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e77001f18..ff354918dbf4 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -29,6 +29,14 @@ struct completion {
 };
 
 #define init_completion_map(x, m) __init_completion(x)
+
+/**
+ * init_completion - Initialize a dynamically allocated completion
+ * @x:  pointer to completion structure that is to be initialized
+ *
+ * This macro will initialize a dynamically created completion
+ * structure.
+ */
 #define init_completion(x) __init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
@@ -76,7 +84,7 @@ static inline void complete_release(struct completion *x) {}
 #endif
 
 /**
- * init_completion - Initialize a dynamically allocated completion
+ * __init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
-- 
2.26.2

