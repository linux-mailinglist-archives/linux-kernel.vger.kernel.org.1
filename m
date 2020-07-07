Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4733B216C00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgGGLpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 07:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgGGLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:45:16 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EADC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:45:15 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id k7so24833733pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d6FGoIGfQ0jy4H4DPDBQTUQ6jcb24MsxrcjNcngUmx4=;
        b=u6XnDnbyIXd6p+RTjT7PJsDAOLaFGoxAZCIKkA3ptT0YRj71raFfPE3xOVU7qJqc9a
         u3AN5RlPdMR7YqEqh1M683omsV8sz3KhikKAe/aUo1Al5jH1Z7NzlIY2VVfi/XOGnBZO
         Tc36idYsDCq5/fyMInzISFw7loVgcE/KUBFeWnQmLZ9OK0k4ZX7+M8czsVamO7ERAX9O
         cDvGo7gLjopuHh7Zh61xmB0in2dD0issAJ5hCSHaiu/W2HM4jZYH8yi/nrsxw7pyXKpB
         ecJGK7HOsQ/oZfoD7neeU/GsHGWaiQrOAv0IYoF+VeEaobz1BZX/pJkm6ZCyaMfBY2Z1
         C30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d6FGoIGfQ0jy4H4DPDBQTUQ6jcb24MsxrcjNcngUmx4=;
        b=gCLAM6RRcTcDSqysfHt1sx9gK39e87abAeJ+ypXnxIPV6xDpDAMaRxeq0/No8ey+n/
         FL7T7n6mSyctyrJRqwCfv20y4TrvNQJ5vkI2dzauUW/IQ3y96DNx2gUmVXKL4ZjmjqWa
         NiN7ODmjDIboqhWCRiq1DFYlS0t7hoNmOrJ2WsOisJdIcZI03Oj9UJ/OmetG+uoDjarD
         6dV1rxpEBq1KNclPPyAOun1XdMls2vJFOz6oe8yflUG9aVS92+bnjbjJVg555Z2Z/dFn
         ewYYMiMlc4NojU/BAsEoaujDGDSdsPukYu4pJpPqgmLmrE01HgtuELfgU/NcY3ntsaq4
         heZg==
X-Gm-Message-State: AOAM533fH4CIulpClfsKbCgRdLmU6QyYgeCO+EhFM+jEHVLpKXNLngRV
        ep9rq1tyTumTczK0Yl++gGikE0u2Vac=
X-Google-Smtp-Source: ABdhPJxZ2YPNzWFkjyy52xU3QoqJ8gSjkJ0wULacOHbe5rDbKGxI12I7OAkhpU8mqfUeh+VULkPt+/6D4gQ=
X-Received: by 2002:a62:8307:: with SMTP id h7mr34550200pfe.149.1594122315288;
 Tue, 07 Jul 2020 04:45:15 -0700 (PDT)
Date:   Tue,  7 Jul 2020 04:31:21 -0700
In-Reply-To: <20200707113123.3429337-1-drosen@google.com>
Message-Id: <20200707113123.3429337-3-drosen@google.com>
Mime-Version: 1.0
References: <20200707113123.3429337-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v10 2/4] fs: Add standard casefolding support
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds general supporting functions for filesystems that use
utf8 casefolding. It provides standard dentry_operations and adds the
necessary structures in struct super_block to allow this standardization.

The new dentry operations are functionally equivalent to the existing
operations in ext4 and f2fs, apart from ths use of utf8_casefold_hash to
avoid an allocation, and dealing with casefolding and encryption. It
doesn't make sense to casefold the no-key token for the encrypted name,
so we don't casefold in that case.

By providing a common implementation, all users can benefit from any
optimizations without needing to port over improvements.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/libfs.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h | 16 ++++++++
 2 files changed, 112 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4d08edf19c78..f7df13806f36 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -20,6 +20,8 @@
 #include <linux/fs_context.h>
 #include <linux/pseudo_fs.h>
 #include <linux/fsnotify.h>
+#include <linux/unicode.h>
+#include <linux/fscrypt.h>
 
 #include <linux/uaccess.h>
 
@@ -1363,3 +1365,97 @@ bool is_empty_dir_inode(struct inode *inode)
 	return (inode->i_fop == &empty_dir_operations) &&
 		(inode->i_op == &empty_dir_inode_operations);
 }
+
+#ifdef CONFIG_UNICODE
+/*
+ * Determine if the name of a dentry should be casefolded. It does not make
+ * sense to casefold the no-key token of an encrypted filename.
+ *
+ * Return: if names will need casefolding
+ */
+static bool needs_casefold(const struct inode *dir, const struct dentry *dentry)
+{
+	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
+			!(dentry->d_flags & DCACHE_ENCRYPTED_NAME);
+}
+
+/**
+ * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
+ * @dentry:	dentry whose name we are checking against
+ * @len:	len of name of dentry
+ * @str:	str pointer to name of dentry
+ * @name:	Name to compare against
+ *
+ * Return: 0 if names match, 1 if mismatch, or -ERRNO
+ */
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			  const char *str, const struct qstr *name)
+{
+	const struct dentry *parent = READ_ONCE(dentry->d_parent);
+	const struct inode *inode = READ_ONCE(parent->d_inode);
+	const struct super_block *sb = dentry->d_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	struct qstr qstr = QSTR_INIT(str, len);
+	char strbuf[DNAME_INLINE_LEN];
+	int ret;
+
+	if (!inode || !needs_casefold(inode, dentry))
+		goto fallback;
+	/*
+	 * If the dentry name is stored in-line, then it may be concurrently
+	 * modified by a rename.  If this happens, the VFS will eventually retry
+	 * the lookup, so it doesn't matter what ->d_compare() returns.
+	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
+	 * string.  Therefore, we have to copy the name into a temporary buffer.
+	 */
+	if (len <= DNAME_INLINE_LEN - 1) {
+		memcpy(strbuf, str, len);
+		strbuf[len] = 0;
+		qstr.name = strbuf;
+		/* prevent compiler from optimizing out the temporary buffer */
+		barrier();
+	}
+	ret = utf8_strncasecmp(um, name, &qstr);
+	if (ret >= 0)
+		return ret;
+
+	if (sb_has_strict_encoding(sb))
+		return -EINVAL;
+fallback:
+	if (len != name->len)
+		return 1;
+	return !!memcmp(str, name->name, len);
+}
+EXPORT_SYMBOL(generic_ci_d_compare);
+
+/**
+ * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
+ * @dentry:	dentry whose name we are hashing
+ * @str:	qstr of name whose hash we should fill in
+ *
+ * Return: 0 if hash was successful, or -ERRNO
+ */
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+{
+	const struct inode *inode = READ_ONCE(dentry->d_inode);
+	struct super_block *sb = dentry->d_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	int ret = 0;
+
+	if (!inode || !needs_casefold(inode, dentry))
+		return 0;
+
+	ret = utf8_casefold_hash(um, dentry, str);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+err:
+	if (sb_has_strict_encoding(sb))
+		ret = -EINVAL;
+	else
+		ret = 0;
+	return ret;
+}
+EXPORT_SYMBOL(generic_ci_d_hash);
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..af8f2ecec8ff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1392,6 +1392,12 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_ACTIVE	(1<<30)
 #define SB_NOUSER	(1<<31)
 
+/* These flags relate to encoding and casefolding */
+#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+
+#define sb_has_strict_encoding(sb) \
+	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
+
 /*
  *	Umount options
  */
@@ -1461,6 +1467,10 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+#endif
+#ifdef CONFIG_UNICODE
+	struct unicode_map *s_encoding;
+	__u16 s_encoding_flags;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
@@ -3385,6 +3395,12 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
+#ifdef CONFIG_UNICODE
+extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
+extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+				const char *str, const struct qstr *name);
+#endif
+
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct address_space *,
 				struct page *, struct page *,
-- 
2.27.0.212.ge8ba1cc988-goog

