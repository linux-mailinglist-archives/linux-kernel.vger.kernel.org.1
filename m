Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE32C7D73
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgK3Din (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3Dim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:38:42 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD43FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 19:38:02 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o4so6989609pgj.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 19:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jhc+lVkqsX84CmnCJgcMdvNeWtYbhuxZA6U1hGDfCGs=;
        b=sr5bOr50tz6ihMGBHJWaQvOhIk8Bg1X0QcALns6jQeSuYfKCKOwkjys6p28+ANBkXs
         sPXVqph13y9tIu1ymUSN+KlVm/FbyHUf7sjCI7xgjyQQPNJOFjg6TVwThUHrF6fvV1bf
         9VLjExX0ZVuWmHE/jaXZzP1e5nMwsCvvIi6l1PoClPWxVMafi1PloU85hdqCBxIB8ZwZ
         hiToySufRSkARd/n87MR0F5wClOVoWgHn9DQ4xUtwAlfYo8z5RSIPDU+TABG4GitgXMV
         6aeklxLi6g4D7HvLUasFZpsWa6pfM+uy2VXLpu4E/BTjBepw3CQGB276F343u1K5xrK7
         TBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jhc+lVkqsX84CmnCJgcMdvNeWtYbhuxZA6U1hGDfCGs=;
        b=OF+nQ1SrOcQjtPJlHw/hlTvC8fLgmODJkfj9MPnAWQbs5GRVEvZjO/WzwNMWLLaRKF
         8sWiZUWWSv92Jkt9KeZNdE2wwHRAZO8bQZkA3poigEKHwLuEk/qanReeFSOAvQlH8SrY
         Xm+qUl5lM5w8KOvJHazBeIMg3YgGnGsUrE2u3xNPh0CGG0nqkKTZuP9nuvThKHeoYsp0
         PYKITPQVCyU11sOWL15Vfygz25/XeX8Adu95GnjoU0y+W1fljReH8U5AoHzbju0G5C88
         EFQ+M+IcTtUXRyQx4Wov9jAYdj+r5w+hV5zaNVaZCC3FBdaW5cCLHRfWpZR+V81+2GNE
         Ln8Q==
X-Gm-Message-State: AOAM530v21lHgV5TL6VrRRv5Cw0LGOa9mGK+dC/G6pL3LgY+XbXO9Vrp
        F4MZPGHU4m813QKmrf3qyYU=
X-Google-Smtp-Source: ABdhPJyqzPJpZ/psYEclGIIReWuFuHpYksWS8s0+fPSMVKqj2yfAaEieMi6Hmk4iHLZM5oIFsl9moA==
X-Received: by 2002:a63:5664:: with SMTP id g36mr15874386pgm.33.1606707481029;
        Sun, 29 Nov 2020 19:38:01 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id f18sm14786936pfa.167.2020.11.29.19.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 19:38:00 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:37:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] posix_acl.h: define missing ACL functions on
 non-posix-acl build
Message-ID: <X8RpFo+5m1i4L5Gn@jagdpanzerIV.localdomain>
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
 <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org>
 <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
 <X8RkVIxou1D1YfEb@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8RkVIxou1D1YfEb@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A quick question, shouldn't there be dummy definitions for
the EXPORT_SYMBOL-s? So that external modules can be modprobed
and used.

Some of posix_acl exported symbols have dummy definitions,
others don't.

E.g. posix_acl_create() is exported symbol and it's defined for
both FS_POSIX_ACL and !FS_POSIX_ACL. While exported set_posix_acl()
is defined only for FS_POSIX_ACL config.

---

diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 90797f1b421d..8a6c77a69761 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -59,19 +59,19 @@ posix_acl_release(struct posix_acl *acl)
 
 /* posix_acl.c */
 
+extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
+
+extern struct posix_acl *get_posix_acl(struct inode *, int);
+
+#ifdef CONFIG_FS_POSIX_ACL
 extern void posix_acl_init(struct posix_acl *, int);
 extern struct posix_acl *posix_acl_alloc(int, gfp_t);
-extern int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
-extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
-extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
 extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
+extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
 extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
 extern int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t);
-
-extern struct posix_acl *get_posix_acl(struct inode *, int);
 extern int set_posix_acl(struct inode *, int, struct posix_acl *);
-
-#ifdef CONFIG_FS_POSIX_ACL
+extern int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
 extern int posix_acl_chmod(struct inode *, umode_t);
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
 		struct posix_acl **);
@@ -91,18 +91,61 @@ static inline void cache_no_acl(struct inode *inode)
 	inode->i_acl = NULL;
 	inode->i_default_acl = NULL;
 }
+
+struct posix_acl *get_acl(struct inode *inode, int type);
 #else
+static inline void posix_acl_init(struct posix_acl *, int)
+{
+}
+
+static inline struct posix_acl *posix_acl_alloc(int, gfp_t)
+{
+	return NULL;
+}
+
+static inline int posix_acl_valid(struct user_namespace *,
+				  const struct posix_acl *)
+{
+	return 0;
+}
+
+static inline int posix_acl_equiv_mode(const struct posix_acl *, umode_t *)
+{
+	return 0;
+}
+
+static inline struct posix_acl *posix_acl_from_mode(umode_t, gfp_t)
+{
+	return NULL;
+}
+
 static inline int posix_acl_chmod(struct inode *inode, umode_t mode)
 {
 	return 0;
 }
 
+static inline int set_posix_acl(struct inode *, int, struct posix_acl *)
+{
+	return 0;
+}
+
 #define simple_set_acl		NULL
 
 static inline int simple_acl_create(struct inode *dir, struct inode *inode)
 {
 	return 0;
 }
+
+static inline int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *)
+{
+	return 0;
+}
+
+static inline int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t)
+{
+	return 0;
+}
+
 static inline void cache_no_acl(struct inode *inode)
 {
 }
@@ -117,8 +160,38 @@ static inline int posix_acl_create(struct inode *inode, umode_t *mode,
 static inline void forget_all_cached_acls(struct inode *inode)
 {
 }
+
+static inline struct posix_acl *get_cached_acl(struct inode *inode, int type)
+{
+	return NULL;
+}
+
+static inline struct posix_acl *get_cached_acl_rcu(struct inode *inode,
+						   int type)
+{
+	return NULL;
+}
+
+static inline void set_cached_acl(struct inode *inode, int type,
+				  struct posix_acl *acl)
+{
+}
+
+static inline void forget_cached_acl(struct inode *inode, int type)
+{
+}
+
+static inline struct posix_acl *get_acl(struct inode *inode, int type)
+{
+	return NULL;
+}
+
+static inline int posix_acl_update_mode(struct inode *, umode_t *,
+					struct posix_acl **)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
-struct posix_acl *get_acl(struct inode *inode, int type);
 
 #endif  /* __LINUX_POSIX_ACL_H */
