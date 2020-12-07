Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A62D1650
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgLGQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:35:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbgLGQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5CrqcdZP0JC44tlDBTo3v7wQmTJC4XSFRl9brgS1vk=;
        b=f3CxmPz3l2wgYX1Sj9t3YFjF4OP3sLcykQIQ5XXdw/XF1FE7NxM6/beyDf52AtxCsKpUth
        FIbVRBNwO2fPIWRGOwYyDjQmSZlU9SvAVeEXJ5+1u3YzFUgk5c/dPXzehWsUxBy8cAdeB1
        wYlpm6qXJWGiheoyuPk3IXxMujf/I6k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-b8_4Fz0yPL2oUPkrQRMQ0w-1; Mon, 07 Dec 2020 11:33:09 -0500
X-MC-Unique: b8_4Fz0yPL2oUPkrQRMQ0w-1
Received: by mail-ed1-f72.google.com with SMTP id ca7so6045838edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5CrqcdZP0JC44tlDBTo3v7wQmTJC4XSFRl9brgS1vk=;
        b=VAw41GbiOdVk03pH2a1GNrT95mJIUUcfuAygU643wcF2d2mXe8RjJnG76xXfTRP5ZS
         aFo/AtnLjgPL19TI0SpJKGroSS+/q9/clJqk1RmSSrXuVQ4plZUW8dmk7BDq/qFdk6fD
         zDwJhJofjG5ubBFfzpehcNx4O5ChkFOAFGM2rR10x8ntQW1DEW5RfLPoZkBSxLUun+CU
         Wd2craviurXXp2XSXbczZRIu5/qFhQ3gA4mzyY70NBC4nCkLQxkzI94huCPLBq7+f2AD
         1T6NeTC01+dY68qqj+3GpG0NyELknbszFyAVhRRrLRvpGjkQaAkY4nSdkWKV/+Z02kad
         CG/g==
X-Gm-Message-State: AOAM531/PfN0Uzr6/bS75KKwJkRJiR2TlVzSAsBudQgGICExfEvdfkmh
        5CaVq0yYGulcotY0yiOptWSyJ6tUQXHKmmO1J/b0+7gTXu3C0N5jkr/w9gpQYq4MmLnIOcxWDPi
        p111+Z/qWvbKjNHhc1bCbMqtX
X-Received: by 2002:a05:6402:1748:: with SMTP id v8mr21085849edx.136.1607358787973;
        Mon, 07 Dec 2020 08:33:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzAuhTSfXXuoEIUlmALY4vyTdGWr6hP1fGthB3JW1sF+CSvvUQT2iRkv0cNIfX52kx8D749Q==
X-Received: by 2002:a05:6402:1748:: with SMTP id v8mr21085829edx.136.1607358787676;
        Mon, 07 Dec 2020 08:33:07 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:06 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] ovl: user xattr
Date:   Mon,  7 Dec 2020 17:32:51 +0100
Message-Id: <20201207163255.564116-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optionally allow using "user.overlay." namespace instead of
"trusted.overlay."

This is necessary for overlayfs to be able to be mounted in an unprivileged
namepsace.

Make the option explicit, since it makes the filesystem format be
incompatible.

Disable redirect_dir and metacopy options, because these would allow
privilege escalation through direct manipulation of the
"user.overlay.redirect" or "user.overlay.metacopy" xattrs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/inode.c     | 10 ++++++--
 fs/overlayfs/overlayfs.h |  8 +++---
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/super.c     | 55 ++++++++++++++++++++++++++++++++++++----
 fs/overlayfs/util.c      |  5 ++--
 5 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b584dca845ba..8ec3062999a9 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -329,8 +329,14 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 bool ovl_is_private_xattr(struct super_block *sb, const char *name)
 {
-	return strncmp(name, OVL_XATTR_PREFIX,
-		       sizeof(OVL_XATTR_PREFIX) - 1) == 0;
+	struct ovl_fs *ofs = sb->s_fs_info;
+
+	if (ofs->config.userxattr)
+		return strncmp(name, OVL_XATTR_USER_PREFIX,
+			       sizeof(OVL_XATTR_USER_PREFIX) - 1) == 0;
+	else
+		return strncmp(name, OVL_XATTR_TRUSTED_PREFIX,
+			       sizeof(OVL_XATTR_TRUSTED_PREFIX) - 1) == 0;
 }
 
 int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..46282111d6e6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -22,7 +22,9 @@ enum ovl_path_type {
 #define OVL_TYPE_MERGE(type)	((type) & __OVL_PATH_MERGE)
 #define OVL_TYPE_ORIGIN(type)	((type) & __OVL_PATH_ORIGIN)
 
-#define OVL_XATTR_PREFIX XATTR_TRUSTED_PREFIX "overlay."
+#define OVL_XATTR_NAMESPACE "overlay."
+#define OVL_XATTR_TRUSTED_PREFIX XATTR_TRUSTED_PREFIX OVL_XATTR_NAMESPACE
+#define OVL_XATTR_USER_PREFIX XATTR_USER_PREFIX OVL_XATTR_NAMESPACE
 
 enum ovl_xattr {
 	OVL_XATTR_OPAQUE,
@@ -113,10 +115,10 @@ struct ovl_fh {
 #define OVL_FH_FID_OFFSET	(OVL_FH_WIRE_OFFSET + \
 				 offsetof(struct ovl_fb, fid))
 
-extern const char *ovl_xattr_table[];
+extern const char *ovl_xattr_table[][2];
 static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr ox)
 {
-	return ovl_xattr_table[ox];
+	return ovl_xattr_table[ox][ofs->config.userxattr];
 }
 
 static inline int ovl_do_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..d634c7ba3b9c 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -17,6 +17,7 @@ struct ovl_config {
 	bool nfs_export;
 	int xino;
 	bool metacopy;
+	bool userxattr;
 	bool ovl_volatile;
 };
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..189380b946be 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -411,6 +411,7 @@ enum {
 	OPT_INDEX_ON,
 	OPT_INDEX_OFF,
 	OPT_NFS_EXPORT_ON,
+	OPT_USERXATTR,
 	OPT_NFS_EXPORT_OFF,
 	OPT_XINO_ON,
 	OPT_XINO_OFF,
@@ -429,6 +430,7 @@ static const match_table_t ovl_tokens = {
 	{OPT_REDIRECT_DIR,		"redirect_dir=%s"},
 	{OPT_INDEX_ON,			"index=on"},
 	{OPT_INDEX_OFF,			"index=off"},
+	{OPT_USERXATTR,			"userxattr"},
 	{OPT_NFS_EXPORT_ON,		"nfs_export=on"},
 	{OPT_NFS_EXPORT_OFF,		"nfs_export=off"},
 	{OPT_XINO_ON,			"xino=on"},
@@ -585,6 +587,10 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->ovl_volatile = true;
 			break;
 
+		case OPT_USERXATTR:
+			config->userxattr = true;
+			break;
+
 		default:
 			pr_err("unrecognized mount option \"%s\" or missing value\n",
 					p);
@@ -688,6 +694,28 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 		}
 	}
 
+
+	/* Resolve userxattr -> !redirect && !metacopy dependency */
+	if (config->userxattr) {
+		if (config->redirect_follow && redirect_opt) {
+			pr_err("conflicting options: userxattr,redirect_dir=%s\n",
+			       config->redirect_mode);
+			return -EINVAL;
+		}
+		if (config->metacopy && metacopy_opt) {
+			pr_err("conflicting options: userxattr,metacopy=on\n");
+			return -EINVAL;
+		}
+		/*
+		 * Silently disable default setting of redirect and metacopy.
+		 * This shall be the default in the future as well: these
+		 * options must be explicitly enabled if used together with
+		 * userxattr.
+		 */
+		config->redirect_dir = config->redirect_follow = false;
+		config->metacopy = false;
+	}
+
 	return 0;
 }
 
@@ -1037,8 +1065,14 @@ ovl_posix_acl_default_xattr_handler = {
 	.set = ovl_posix_acl_xattr_set,
 };
 
-static const struct xattr_handler ovl_own_xattr_handler = {
-	.prefix	= OVL_XATTR_PREFIX,
+static const struct xattr_handler ovl_own_trusted_xattr_handler = {
+	.prefix	= OVL_XATTR_TRUSTED_PREFIX,
+	.get = ovl_own_xattr_get,
+	.set = ovl_own_xattr_set,
+};
+
+static const struct xattr_handler ovl_own_user_xattr_handler = {
+	.prefix	= OVL_XATTR_USER_PREFIX,
 	.get = ovl_own_xattr_get,
 	.set = ovl_own_xattr_set,
 };
@@ -1049,12 +1083,22 @@ static const struct xattr_handler ovl_other_xattr_handler = {
 	.set = ovl_other_xattr_set,
 };
 
-static const struct xattr_handler *ovl_xattr_handlers[] = {
+static const struct xattr_handler *ovl_trusted_xattr_handlers[] = {
+#ifdef CONFIG_FS_POSIX_ACL
+	&ovl_posix_acl_access_xattr_handler,
+	&ovl_posix_acl_default_xattr_handler,
+#endif
+	&ovl_own_trusted_xattr_handler,
+	&ovl_other_xattr_handler,
+	NULL
+};
+
+static const struct xattr_handler *ovl_user_xattr_handlers[] = {
 #ifdef CONFIG_FS_POSIX_ACL
 	&ovl_posix_acl_access_xattr_handler,
 	&ovl_posix_acl_default_xattr_handler,
 #endif
-	&ovl_own_xattr_handler,
+	&ovl_own_user_xattr_handler,
 	&ovl_other_xattr_handler,
 	NULL
 };
@@ -1991,7 +2035,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
 
 	sb->s_magic = OVERLAYFS_SUPER_MAGIC;
-	sb->s_xattr = ovl_xattr_handlers;
+	sb->s_xattr = ofs->config.userxattr ? ovl_user_xattr_handlers :
+		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
 	sb->s_iflags |= SB_I_SKIP_SYNC;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..66eaf4db027f 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -582,9 +582,10 @@ bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
 #define OVL_XATTR_METACOPY_POSTFIX	"metacopy"
 
 #define OVL_XATTR_TAB_ENTRY(x) \
-	[x] = OVL_XATTR_PREFIX x ## _POSTFIX
+	[x] = { [false] = OVL_XATTR_TRUSTED_PREFIX x ## _POSTFIX, \
+		[true] = OVL_XATTR_USER_PREFIX x ## _POSTFIX }
 
-const char *ovl_xattr_table[] = {
+const char *ovl_xattr_table[][2] = {
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_OPAQUE),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_REDIRECT),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_ORIGIN),
-- 
2.26.2

