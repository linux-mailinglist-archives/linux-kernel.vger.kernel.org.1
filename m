Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6C2EB726
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbhAFAyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbhAFAyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:54:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9564322EBF;
        Wed,  6 Jan 2021 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894449;
        bh=kRpZWm5PgDMmZLtf+kkcLLcT/9so+o68wCUaaW0QNj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr7ZYdmPAlXlfx1llukiGbkCUhIaTwkuiPwePltEVspBeLNdx3FJraMymTU/dzWvS
         oYy8yJ52OClNiURrlWGik+noDIU0DFkCX2nOCT9Zm5hVvKgDKTMk7yhfGDELRts8Y7
         GK+31f+QSHws1rp3XGMYjuL1bvaA6w7giTL791v4fcO/+25682cyW46i87QsbARQ3Q
         gz2aHt3VJ6pH19vFfys+YbVXDALXYSeY32UflrfLg+mtsGWAQF26tjEfKpj733+YX1
         7X9UJ9iBgaA99v4s3wF8ltILuim6mSoO0j74AayRFex37rBlsZ/efED+5y9A1MUqhd
         aacP99iJueb5w==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/8] list: Fix a typo at the kernel-doc markup
Date:   Tue,  5 Jan 2021 16:54:02 -0800
Message-Id: <20210106005407.12295-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

hlist_add_behing -> hlist_add_behind

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 89bdc92..f2af4b4 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -901,7 +901,7 @@ static inline void hlist_add_before(struct hlist_node *n,
 }
 
 /**
- * hlist_add_behing - add a new entry after the one specified
+ * hlist_add_behind - add a new entry after the one specified
  * @n: new entry to be added
  * @prev: hlist node to add it after, which must be non-NULL
  */
-- 
2.9.5

