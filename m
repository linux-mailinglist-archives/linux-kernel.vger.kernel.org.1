Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38D32D164C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgLGQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727800AbgLGQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLCQKZfzWqBvZ3fNsIg7ssx6JJEt23zVLXYENI3nPr8=;
        b=NzcW/TcdiYV6pe1NgnOv5g6YUXRyR/VrkxlnoTfJC6Znr2SP2NwJkexB6GkfXWON7a7P3Z
        TTFpRPJa9xv96xSiNSiNQIm1vQULhhl2R27lICZ+HD74AvwwL4+NSAZybNyGbbIfZC1u6r
        dgodPu8m0X3hvGSRx+zlsN6Oexn8/xc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Qa8E_xTsP6SqmefuKuo1EQ-1; Mon, 07 Dec 2020 11:33:13 -0500
X-MC-Unique: Qa8E_xTsP6SqmefuKuo1EQ-1
Received: by mail-ej1-f71.google.com with SMTP id m4so998812ejc.14
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLCQKZfzWqBvZ3fNsIg7ssx6JJEt23zVLXYENI3nPr8=;
        b=ocS+chuRwP8gnMPi9p+Onhu2eAOnT6WIxduGbqrC3BpK0EVVEeKGU3uJSPubLlg4Ux
         v9yRcI1BlZ7OE+kflzEKeBCzfAs/+cpnKZa6uhxpRd9M3oYtc6Heh1begArmGHDhQygn
         jce9BIQfLuxDjmSkGZpeqJLBmwzjPNKaW+leYtSJfiiSS8SnmaGPM9QLahdMpOLpgMNk
         930Yh2OsKf7PXRXvxt+HMuDaGjhxzs0v5DB4uP+SlrV0CbuI/Wu8vHnwMqnOuCO85y6m
         LH5UT81kWwNYqadd2hLQ6+IbMkfGx10RXyCY3LdN4tsaWMQ4CK8ThM4MhTrTsNj1b9u/
         cu2A==
X-Gm-Message-State: AOAM532K0rY6Pb4NUcJcRScc3PJz4ZLPPuGqbdTv+YeaSN0PRWttgLPI
        rS7ilIzp6l2wfXHt5ST1V3wDh+GX082nlpVkpOB2XUZRnB+7RWJPYobZiDbFaWBu/EEqCP0mjZZ
        H5MMYEn5s6qbHOSF3udNqgu6O
X-Received: by 2002:a50:9f4a:: with SMTP id b68mr20511324edf.296.1607358792115;
        Mon, 07 Dec 2020 08:33:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcfXNOTxIA60QUdAr/l6040dD7T0L3kweELtDlwwC95Xbikn5wQvx9TnMAECGb3KS/JY4RKA==
X-Received: by 2002:a50:9f4a:: with SMTP id b68mr20511314edf.296.1607358791932;
        Mon, 07 Dec 2020 08:33:11 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:11 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] ovl: do not get metacopy for userxattr
Date:   Mon,  7 Dec 2020 17:32:54 +0100
Message-Id: <20201207163255.564116-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking up an inode on the lower layer for which the mounter lacks
read permisison the metacopy check will fail.  This causes the lookup to
fail as well, even though the directory is readable.

So ignore EACCES for the "userxattr" case and assume no metacopy for the
unreadable file.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 66eaf4db027f..703c6e529f39 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -880,6 +880,13 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return 0;
+		/*
+		 * getxattr on user.* may fail with EACCES in case there's no
+		 * read permission on the inode.  Not much we can do, other than
+		 * tell the caller that this is not a metacopy inode.
+		 */
+		if (ofs->config.userxattr && res == -EACCES)
+			return 0;
 		goto out;
 	}
 
-- 
2.26.2

