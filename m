Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5442979AB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 01:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758730AbgJWX2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 19:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758723AbgJWX2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 19:28:20 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5942168B;
        Fri, 23 Oct 2020 23:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603495700;
        bh=T3uwsNs7A0BKQjRH8LF/cDQDMTP5GDmkrV+Ttr91asc=;
        h=From:To:Cc:Subject:Date:From;
        b=gXYhXxRK6yFnYIPUbfAC87ScYdkfJ5ggr1ju9aVkscpHMCO62FxcLVx1ntGeJ+oXf
         +R7AUyfkzBdFaDzAKilgdnehbq7dcikjPir5sfsh0TQURGTW8xFABPbvmZBgnsi0ow
         A0XSlKy4VdKS1zaUs1yKKAIcNsEcyzf2KE+n4PcU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] mm: remove kzfree() compatibility definition
Date:   Fri, 23 Oct 2020 16:27:16 -0700
Message-Id: <20201023232716.417926-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 453431a54934 ("mm, treewide: rename kzfree() to
kfree_sensitive()") renamed kzfree() to kfree_sensitive(), but it left a
compatibility definition of kzfree() to avoid being too disruptive.
Since then a few more instances of kzfree() have slipped in.  Just get
rid of them and remove the compatibility definition once and for all.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Linus, are you interested in applying this around the time of v5.10-rc1?
There's not really any reason to keep this around, and people will
otherwise keep introducing new uses.

 drivers/staging/rtl8192e/rtllib_crypt_tkip.c              | 2 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c               | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c  | 2 +-
 include/linux/slab.h                                      | 2 --
 net/tipc/crypto.c                                         | 4 ++--
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 8c2ff37b2d3a..238387d6221b 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -100,7 +100,7 @@ static void rtllib_tkip_deinit(void *priv)
 		crypto_free_shash(_priv->tx_tfm_michael);
 		crypto_free_shash(_priv->rx_tfm_michael);
 	}
-	kzfree(priv);
+	kfree_sensitive(priv);
 }
 
 
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index 7cdd17f907fa..7790271a6a40 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -49,7 +49,7 @@ static void *prism2_wep_init(int keyidx)
 
 static void prism2_wep_deinit(void *priv)
 {
-	kzfree(priv);
+	kfree_sensitive(priv);
 }
 
 /* Perform WEP encryption on given skb that has at least 4 bytes of headroom
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 4b415cc76715..e8fa1d385f24 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -107,7 +107,7 @@ static void ieee80211_tkip_deinit(void *priv)
 		crypto_free_shash(_priv->tx_tfm_michael);
 		crypto_free_shash(_priv->rx_tfm_michael);
 	}
-	kzfree(priv);
+	kfree_sensitive(priv);
 }
 
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index 1c56e2d03aae..a41b6510481b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
@@ -54,7 +54,7 @@ static void *prism2_wep_init(int keyidx)
 
 static void prism2_wep_deinit(void *priv)
 {
-	kzfree(priv);
+	kfree_sensitive(priv);
 }
 
 /* Perform WEP encryption on given skb that has at least 4 bytes of headroom
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9e155cc83b8a..dd6897f62010 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -187,8 +187,6 @@ void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
 
-#define kzfree(x)	kfree_sensitive(x)	/* For backward compatibility */
-
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 			bool to_user);
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 40c44101fe8e..740ab9ae41a6 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -418,7 +418,7 @@ static void tipc_aead_free(struct rcu_head *rp)
 		kfree(head);
 	}
 	free_percpu(aead->tfm_entry);
-	kzfree(aead->key);
+	kfree_sensitive(aead->key);
 	kfree(aead);
 }
 
@@ -2452,7 +2452,7 @@ static void tipc_crypto_work_tx(struct work_struct *work)
 		     tipc_crypto_key_init(tx, skey, PER_NODE_KEY, false);
 		if (likely(rc > 0))
 			rc = tipc_crypto_key_distr(tx, rc, NULL);
-		kzfree(skey);
+		kfree_sensitive(skey);
 	}
 
 	if (unlikely(rc))
-- 
2.29.0.rc1.297.gfa9743e501-goog

