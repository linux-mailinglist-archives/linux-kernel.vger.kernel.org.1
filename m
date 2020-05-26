Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37B41A165F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgDGUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:01:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgDGUBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586289681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QLx4/sdG9v1nmxm7Nxx7v62MFnknzk0r6dRJ8swzlNk=;
        b=bxvWZRdhlwLxXXX19n2LyOJt+yLPKossX2vynBO1Gka42MdFLzQLipHJlAy53lYeDI0xWP
        0eBbUQYk7uEGTskGvYrF2n3zBflwqUHs/ofLwhKDBoXWX0XGU6FEk/EK7F8ZpqW7w2sYJp
        dn1K4HHVBCHG+n3g1LRtqnpKs1NL7Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-2GKLxJrtOlasm_FTZn-O1g-1; Tue, 07 Apr 2020 16:01:19 -0400
X-MC-Unique: 2GKLxJrtOlasm_FTZn-O1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A521005509;
        Tue,  7 Apr 2020 20:01:17 +0000 (UTC)
Received: from llong.com (ovpn-117-180.rdu2.redhat.com [10.10.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7190992FA2;
        Tue,  7 Apr 2020 20:01:12 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-mm@kvack.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Date:   Tue,  7 Apr 2020 16:01:06 -0400
Message-Id: <20200407200106.10917-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kvmalloc'ed data object that contains sensitive information like
cryptographic key, we need to make sure that the buffer is always
cleared before freeing it. Using memset() alone for buffer clearing may
not provide certainty as the compiler may compile it away. To be sure,
the special memzero_explicit() has to be used.

This patch introduces a new kvfree_sensitive() for freeing those
sensitive data objects allocated by kvmalloc(). The relevnat places
where kvfree_sensitive() can be used are modified to use it.

Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key read")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mm.h       |  1 +
 mm/util.c                | 18 ++++++++++++++++++
 security/keys/internal.h | 11 -----------
 security/keys/keyctl.c   | 16 +++++-----------
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7dd5c4ccbf85..9b3130b20f42 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -757,6 +757,7 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
 }
 
 extern void kvfree(const void *addr);
+extern void kvfree_sensitive(const void *addr, size_t len);
 
 static inline int compound_mapcount(struct page *page)
 {
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..01e210766f3d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -604,6 +604,24 @@ void kvfree(const void *addr)
 }
 EXPORT_SYMBOL(kvfree);
 
+/**
+ * kvfree_sensitive - free a data object containing sensitive information
+ * @addr - address of the data object to be freed
+ * @len  - length of the data object
+ *
+ * Use the special memzero_explicit() function to clear the content of a
+ * kvmalloc'ed object containing sensitive data to make sure that the
+ * compiler won't optimize out the data clearing.
+ */
+void kvfree_sensitive(const void *addr, size_t len)
+{
+	if (likely(!ZERO_OR_NULL_PTR(addr))) {
+		memzero_explicit((void *)addr, len);
+		kvfree(addr);
+	}
+}
+EXPORT_SYMBOL(kvfree_sensitive);
+
 static inline void *__page_rmapping(struct page *page)
 {
 	unsigned long mapping;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 6d0ca48ae9a5..153d35c20d3d 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -350,15 +350,4 @@ static inline void key_check(const struct key *key)
 #define key_check(key) do {} while(0)
 
 #endif
-
-/*
- * Helper function to clear and free a kvmalloc'ed memory object.
- */
-static inline void __kvzfree(const void *addr, size_t len)
-{
-	if (addr) {
-		memset((void *)addr, 0, len);
-		kvfree(addr);
-	}
-}
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 5e01192e222a..edde63a63007 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -142,10 +142,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 
 	key_ref_put(keyring_ref);
  error3:
-	if (payload) {
-		memzero_explicit(payload, plen);
-		kvfree(payload);
-	}
+	kvfree_sensitive(payload, plen);
  error2:
 	kfree(description);
  error:
@@ -360,7 +357,7 @@ long keyctl_update_key(key_serial_t id,
 
 	key_ref_put(key_ref);
 error2:
-	__kvzfree(payload, plen);
+	kvfree_sensitive(payload, plen);
 error:
 	return ret;
 }
@@ -914,7 +911,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 */
 		if (ret > key_data_len) {
 			if (unlikely(key_data))
-				__kvzfree(key_data, key_data_len);
+				kvfree_sensitive(key_data, key_data_len);
 			key_data_len = ret;
 			continue;	/* Allocate buffer */
 		}
@@ -923,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 			ret = -EFAULT;
 		break;
 	}
-	__kvzfree(key_data, key_data_len);
+	kvfree_sensitive(key_data, key_data_len);
 
 key_put_out:
 	key_put(key);
@@ -1225,10 +1222,7 @@ long keyctl_instantiate_key_common(key_serial_t id,
 		keyctl_change_reqkey_auth(NULL);
 
 error2:
-	if (payload) {
-		memzero_explicit(payload, plen);
-		kvfree(payload);
-	}
+	kvfree_sensitive(payload, plen);
 error:
 	return ret;
 }
-- 
2.18.1

