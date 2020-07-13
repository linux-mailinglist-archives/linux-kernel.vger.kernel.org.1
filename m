Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D5218332
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGHJMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgGHJMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:12:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC38C08E763
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:12:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p22so50765403ybg.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wV4Dlp1PtfRWNCEDy3OUVmwFuHR/znQviVm4udIzuj8=;
        b=TmfFQqldI6NR71g11ccYeLYb4YMRJ9TbhNQpLgbner44eVMPHA3+K4/r3OVoQRVqiU
         oNB0e489EVTL8XxXR17WKGxWV7xu+at9ec0oMAxeMgcQ5T9k9n+ssKWhtmWGqmjnLnUM
         6BeB3sGPZLxW+Crt0D7Jg9uTB3Ou/lbVcbRxBFVNT1U7DJ5xXK91RBF+UxS6r65lKZvH
         mb0YANeHYaPI2HDI/q5KpLu4zwrnZ/Hd496MiPfyQOJR1nAqzsvRk07T0x7CzCU/v40I
         9VR02aGQQCuV7etZAmEfaL4xiNC9HANSW/5B2aq3+iMK4Qs+wEkrnXqi/ckFCoDMjrjA
         I0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wV4Dlp1PtfRWNCEDy3OUVmwFuHR/znQviVm4udIzuj8=;
        b=aSyALk7vZtGxEAD6sgp+gwddeS7EOjSdDb0/7BAD18xAZDXer9gWrAU+mLiSL4QhIH
         ABqEoS6bTJ9fBwmP2rwXCt3s8vDk8xGmzi/PgaflNd5fbvCq4AI1Xp/nCBEs3DqBih3q
         h8XJfz/J948SXUCnPr7RhG28hzqJ+gdGMSGVYC3tw/6QnktBkxKDG+iiLXvHbmKPXoLO
         GUV5KwiUbNiOLU0s4YGj4tGEXDmJiv7ZZo1+khff2+FljqbM6DyuIjQqmfXY07XoQXaH
         LXolYuwVpN0vKeqg6QElBuTzx9SgiNpfLW6opFjV4jJY0xIx6iuccnumPJCVG1yeEYR1
         OGvg==
X-Gm-Message-State: AOAM530h8qo7VDtRkQIFmkDdd0XiKwFMaEQTTzzzjV+AZSTPY76UHK5z
        VZt6RLAsD4LMA3UJe6Jaz8JrGOOL3T4=
X-Google-Smtp-Source: ABdhPJxT53xSTJPoJDE7zNOjGdUzwbWSLO3iz5TcZnavMsDjJ7aSH9oD27jm9uQKje34VSZMZujf2U3uXyg=
X-Received: by 2002:a25:9a41:: with SMTP id r1mr1597091ybo.516.1594199562803;
 Wed, 08 Jul 2020 02:12:42 -0700 (PDT)
Date:   Wed,  8 Jul 2020 02:12:34 -0700
In-Reply-To: <20200708091237.3922153-1-drosen@google.com>
Message-Id: <20200708091237.3922153-2-drosen@google.com>
Mime-Version: 1.0
References: <20200708091237.3922153-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v12 1/4] unicode: Add utf8_casefold_hash
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
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a case insensitive hash function to allow taking the hash
without needing to allocate a casefolded copy of the string.

The existing d_hash implementations for casefolding allocate memory
within rcu-walk, by avoiding it we can be more efficient and avoid
worrying about a failed allocation.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/unicode/utf8-core.c  | 23 ++++++++++++++++++++++-
 include/linux/unicode.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115..dc25823bfed9 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -6,6 +6,7 @@
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
+#include <linux/stringhash.h>
 
 #include "utf8n.h"
 
@@ -122,9 +123,29 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
-
 EXPORT_SYMBOL(utf8_casefold);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur;
+	int c;
+	unsigned long hash = init_name_hash(salt);
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	while ((c = utf8byte(&cur))) {
+		if (c < 0)
+			return -EINVAL;
+		hash = partial_name_hash((unsigned char)c, hash);
+	}
+	str->hash = end_name_hash(hash);
+	return 0;
+}
+EXPORT_SYMBOL(utf8_casefold_hash);
+
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 990aa97d8049..74484d44c755 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -27,6 +27,9 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str);
+
 struct unicode_map *utf8_load(const char *version);
 void utf8_unload(struct unicode_map *um);
 
-- 
2.27.0.383.g050319c2ae-goog

