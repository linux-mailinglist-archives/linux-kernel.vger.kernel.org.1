Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89502C7C87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgK3Bou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgK3Bou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:44:50 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 17:44:10 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id t21so340790pjw.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 17:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AN3HoLklghH6G8u0k3IsJXj4kaG/6hWtQpUEebx624=;
        b=bJ4NeL1F1HUuWUXg46EF0dbZ8bZxbbF2dT0fbc49F94fE8oPholtAsRnTvVlGIJzev
         Md3E1HRJKTOhvqPOltP5gT/WmFTQ670fWFXfFMByZQt7TM80Iziez+9S0YwubhoLce/W
         qyg+Ucne3+RZT1orCxClteKC8+p0VKvfQsAVV9yYgi6r/GpH/dJykGJLVb9t6qcDIEm1
         Hgy5C3DwSLuC8GBz3wLg1ouon1w4ns0D4fg2c97NVB/dUaSWoiNqSdtPbxtgcyVBHL2p
         AcO/81zUyhBdBBXcop/fA4BZV0qTbfCOgLouDo84ZRE9cXOtlFZJjB9UzHoqwRBN1xeN
         OMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AN3HoLklghH6G8u0k3IsJXj4kaG/6hWtQpUEebx624=;
        b=twOtM4UvijyhI3PWHk6dRglDgJBGLnAYPkotbq9bSn3P4u5RfEjWVO9F8O56wp4csj
         Cq63SxA7mOpnskUJ9aGfY5a2937TuXUlPy73Twu+S/Rzjnpsg0rhqQdZkD44MHI7BZXr
         DZvKcdKCMAqQU9cxC+wvgFLjXyZp/gf1W4RZm1QZWxIF1TD8bKuVSfaUyJ9P6Wii4Io7
         uDAQu98gF9KD5ifTbmG1ZEx6f2H4KcnDWVsCwrZ1n0COpyxzmTHfmLHN6lPh71Y1kZmH
         T8suR6nNM3nJj5n9xeerfxXNYRHg60BXdlq2hX/n1J67T2RtbSzaCnxaNJTxkGVS0URm
         cBHQ==
X-Gm-Message-State: AOAM532xls+3m11Mv0XBiBlrlNeiFyB50waOMqsYrlO9sEedeDS3EHS9
        gaUD1wmsxRdrSFZej7eL7BU=
X-Google-Smtp-Source: ABdhPJywH0uelXjY+4lbFJAVcLwEC1HQ01A8hljq52bzes7ZPHtw2EY+uCz0j9mMp5tW9FXMpOyRUA==
X-Received: by 2002:a17:90b:110:: with SMTP id p16mr24296413pjz.54.1606700649865;
        Sun, 29 Nov 2020 17:44:09 -0800 (PST)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a2sm14825602pfo.117.2020.11.29.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:44:09 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] posix_acl.h: define missing ACL functions on non-posix-acl build
Date:   Mon, 30 Nov 2020 10:44:04 +0900
Message-Id: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions that are declared when CONFIG_POSIX_ACL is defined
are not declared when CONFIG_POSIX_ACL is not defined. Add the
missing ones:
  set_posix_acl(), posix_acl_update_mode(), get_cached_acl(),
  get_cached_acl_rcu(), set_cached_acl(), forget_cached_acl().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/posix_acl.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 90797f1b421d..f6d206359da5 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -117,6 +117,39 @@ static inline int posix_acl_create(struct inode *inode, umode_t *mode,
 static inline void forget_all_cached_acls(struct inode *inode)
 {
 }
+
+static inline int set_posix_acl(struct inode *inode, int type,
+				struct posix_acl *acl)
+{
+	return 0;
+}
+
+static inline int posix_acl_update_mode(struct inode *, umode_t *,
+					struct posix_acl **)
+{
+	return 0;
+}
+
+static inline struct posix_acl *get_cached_acl(struct inode *inode,
+					       int type)
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
 #endif /* CONFIG_FS_POSIX_ACL */
 
 struct posix_acl *get_acl(struct inode *inode, int type);
-- 
2.29.2

