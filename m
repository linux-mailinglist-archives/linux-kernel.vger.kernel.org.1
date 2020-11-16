Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2711D2B40DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgKPKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgKPKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6D22462E;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=PJLtGmv4En+3vnXJ8f68rtLRDgDexuQGTS2qS58wwhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytSPsuGlZFKDV6u1q67oMSxli+OouGHtwkj0M3/nr7jxJ5PUOGdCMXexpyzTi6Vgq
         mwC8Jb4JIoxuO0NB2HW+a00xg+3tXBe6PYbM9w1lEKzDSdrqBnr9JwgCAP1N8NfwHq
         AIRKiBrHVJHMc5jvyoNgabljsfNi5fDBEl9OqoiM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEa-Hl; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Asif Rasheed <b00073877@aus.edu>,
        Eric Dumazet <edumazet@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/27] list: fix a typo at the kernel-doc markup
Date:   Mon, 16 Nov 2020 11:18:16 +0100
Message-Id: <d0ef485aaaa648bf6ebbc26a4082ccb2ff6a8e5b.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hlist_add_behing -> hlist_add_behind

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 89bdc92e75c3..f2af4b4aa4e9 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -884,41 +884,41 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 		WRITE_ONCE(first->pprev, &n->next);
 	WRITE_ONCE(h->first, n);
 	WRITE_ONCE(n->pprev, &h->first);
 }
 
 /**
  * hlist_add_before - add a new entry before the one specified
  * @n: new entry to be added
  * @next: hlist node to add it before, which must be non-NULL
  */
 static inline void hlist_add_before(struct hlist_node *n,
 				    struct hlist_node *next)
 {
 	WRITE_ONCE(n->pprev, next->pprev);
 	WRITE_ONCE(n->next, next);
 	WRITE_ONCE(next->pprev, &n->next);
 	WRITE_ONCE(*(n->pprev), n);
 }
 
 /**
- * hlist_add_behing - add a new entry after the one specified
+ * hlist_add_behind - add a new entry after the one specified
  * @n: new entry to be added
  * @prev: hlist node to add it after, which must be non-NULL
  */
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
 	WRITE_ONCE(n->next, prev->next);
 	WRITE_ONCE(prev->next, n);
 	WRITE_ONCE(n->pprev, &prev->next);
 
 	if (n->next)
 		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
 /**
  * hlist_add_fake - create a fake hlist consisting of a single headless node
  * @n: Node to make a fake list out of
  *
  * This makes @n appear to be its own predecessor on a headless hlist.
  * The point of this is to allow things like hlist_del() to work correctly
-- 
2.28.0

