Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8829FE33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJ3HFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ3HFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:05:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264FAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:05:18 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d5so3303481qkg.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JUjPXaFt8ltda/O/lcrAPgOc/YuvqN8RFWlZpTW+2Ys=;
        b=iQb33AsjK681dzamV9RVYJ0CiP/ONMrk6dylEDE5fXoNEbE2Gr+fHdPgQuHJc1MYIQ
         jJ+kPvlfWp0X2pvnPA71EnjLBh1J2GE5unQiZ0kgyVYdfScZOXRt8B/VbhccgeIGplW7
         kStghDxGYqrgaoFMZn7SwQxoswb15Idm+dcze59g57mDpLYreW36Gi4wx7Qd3cSN/eL1
         jjDxyEohf2zMoR4nVY1ZbYuQMGXuC0iFvJqauLRc2/nPcCUATxVkRpaHxaQmfqpoNsms
         kcKxkHI69UaQbJn5g2I4604b8BTWDJ6N6nD/rSayEzyma1hitRG9tWSIw0HH2D02EPUl
         dm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JUjPXaFt8ltda/O/lcrAPgOc/YuvqN8RFWlZpTW+2Ys=;
        b=qTBy6T2b1QTC5lgB8Em1lMG9Bd/Q3lMty/EW6k+YtuT/FeH1qOJcqKcbOf1KIvpMXD
         lpnEi7u3XQZccAjiryHOZB+nilk5kiyVH1Owlc0gO3sXHkv1sao7j9cIpVIx5nn50v10
         WQiC5XoUel7jq++FZHpr/TLCzfJY33DHLlOvuyhqbyyTxdgqofBHcsKEtNr6dN5lPTX7
         40CdU9rxIrwtE/1oK/8zBF0QWrglUw01/srEkgLOXartuM11YcAdkkZ0yBbI+IIIqSnE
         W3oSl+NmXknYnyhSi+Q0EqkcLkrVhbvG+rkOFbR4Y99yo/IDgkkKG0AE+oe1LS8yn26Z
         grCw==
X-Gm-Message-State: AOAM533utWs1IDxiCCXLQfXHF59AdiV6EuOmVGoZf7cmMDUJfGlBX7Jz
        Bzyv6sMvbbqSyMftugWW9ADbUpR0EuzJL+RqtApJL4vajs3YyJq03eVwC6Gz5yI61iWQ0D04p5t
        eFSBhJuTYr2aMdeXpJMINEDduqxNpWP5FyWN0UQLyaPUKr2Hl5HD7lhDjLh2AEhBYp8tVQDAQ
X-Google-Smtp-Source: ABdhPJz40/0+ffVqnmjCC0nyJil+ugLiZkxZPBEuwBzf/9m+wI9EuTJSUHZTb6JLj745T+uuZK2efdOsoaLi
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:ad4:5762:: with SMTP id
 r2mr7997574qvx.53.1604041517277; Fri, 30 Oct 2020 00:05:17 -0700 (PDT)
Date:   Fri, 30 Oct 2020 18:04:42 +1100
In-Reply-To: <20201030070442.457739-1-amistry@google.com>
Message-Id: <20201030180403.1.I9c36fd7a0e4d52e300c1004a0f6f2fc705e2b065@changeid>
Mime-Version: 1.0
References: <20201030070442.457739-1-amistry@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 1/1] debugfs: Add a helper to export atomic64_t values
From:   Anand K Mistry <amistry@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mirrors support for exporting atomic_t values.

Signed-off-by: Anand K Mistry <amistry@google.com>

---

 fs/debugfs/file.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |  6 ++++++
 2 files changed, 43 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a768a09430c3..798bd3bdedec 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -770,6 +770,43 @@ void debugfs_create_atomic_t(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
 
+static int debugfs_atomic64_t_set(void *data, u64 val)
+{
+	atomic64_set((atomic64_t *)data, val);
+	return 0;
+}
+static int debugfs_atomic64_t_get(void *data, u64 *val)
+{
+	*val = atomic64_read((atomic64_t *)data);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t, debugfs_atomic64_t_get,
+			debugfs_atomic64_t_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t_ro, debugfs_atomic64_t_get, NULL,
+			"%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t_wo, NULL, debugfs_atomic64_t_set,
+			"%lld\n");
+
+/**
+ * debugfs_create_atomic64_t - create a debugfs file that is used to read and
+ * write an atomic64_t value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ */
+void debugfs_create_atomic64_t(const char *name, umode_t mode,
+			       struct dentry *parent, atomic64_t *value)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, value,
+				   &fops_atomic64_t, &fops_atomic64_t_ro,
+				   &fops_atomic64_t_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_atomic64_t);
+
 ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 			       size_t count, loff_t *ppos)
 {
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 851dd1f9a8a5..0fac84c53eab 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -126,6 +126,8 @@ void debugfs_create_size_t(const char *name, umode_t mode,
 			   struct dentry *parent, size_t *value);
 void debugfs_create_atomic_t(const char *name, umode_t mode,
 			     struct dentry *parent, atomic_t *value);
+void debugfs_create_atomic64_t(const char *name, umode_t mode,
+				     struct dentry *parent, atomic64_t *value);
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 				  struct dentry *parent, bool *value);
 
@@ -291,6 +293,10 @@ static inline void debugfs_create_atomic_t(const char *name, umode_t mode,
 					   atomic_t *value)
 { }
 
+static inline void debugfs_create_atomic64_t(const char *name, umode_t mode,
+					     struct dentry *parent, atomic64_t *value)
+{ }
+
 static inline struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 						 struct dentry *parent,
 						 bool *value)
-- 
2.29.1.341.ge80a0c044ae-goog

