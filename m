Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32E2D164F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgLGQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbgLGQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrWD39vQ5236vo/77WTHcclMwYYEe2kMnOzynaA/vIg=;
        b=YDqWPjUj/8lqyT1F5XRm7icpgYt7c0nHhZNKdTf2NEI7ucPxViLtvKG8lff+gpZltWx6EM
        v0XBExBkbrfhjUQltdjjnhRX16bm8Re/SJhmwJsWSGSHHxObZlu8SCZfglb8ewVT/lPZW4
        rza9e1NDZEy31k6WPZP7zQNfz/+qDDE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-HZxGL2VONWGXVY4m7I403g-1; Mon, 07 Dec 2020 11:33:10 -0500
X-MC-Unique: HZxGL2VONWGXVY4m7I403g-1
Received: by mail-ed1-f71.google.com with SMTP id p17so6016412edx.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrWD39vQ5236vo/77WTHcclMwYYEe2kMnOzynaA/vIg=;
        b=l0xdAQfJ1D1E0PwqqXFbOgf2WEwAGw41UrtHaSpyAlt+SBbR9WxI4RJVIJYngerW5U
         6WffuD5ArdypuXvIodUXgIDdiVN1UExkpehQ9tJ2eodHtay92WhBuqs5Ahd6j0KNounI
         AJs9e75C9chydWqyS2sA6jbXlSNGMMdEO0KbGVXJiCwr73pB/mKgC/aSbWZhElU+lLfj
         pSjZrVp3lsEGZzNx0Q+kcVQFvD1xbaMl+4UQo9JZaoijHcNw5RzywOF8lA86oL9fZzeN
         iZ5lFg5anXYuQ2fifaeLBPieTvEa+5MOUacC/wcIRWWhHRJPvCStWo7IjOZcWQShBytF
         umKg==
X-Gm-Message-State: AOAM531vwFBZnpjRxzXhDCY+MFTjvjg7EBoUo8vw4OJ/V+bQJcZJO5i1
        0tJemtPANUTnjgUN/loL0mNDqdELDSphJntcNvwfpi6ep0n5mUuvvZhQI9+vGrYm8sEN3EeDOZp
        9N+tnf0aUOGnwGGTWw+hcqcmn
X-Received: by 2002:a05:6402:b57:: with SMTP id bx23mr20433025edb.191.1607358789300;
        Mon, 07 Dec 2020 08:33:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDZ8PBOMTmy7Viq25/DAuAax7RMDShGdfStsG7a9V/Uv4Vpsy2gyL1w0kDb+e0n297b859wQ==
X-Received: by 2002:a05:6402:b57:: with SMTP id bx23mr20433017edb.191.1607358789148;
        Mon, 07 Dec 2020 08:33:09 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:08 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] ovl: do not fail when setting origin xattr
Date:   Mon,  7 Dec 2020 17:32:52 +0100
Message-Id: <20201207163255.564116-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment above call already says this, but only EOPNOTSUPP is ignored, other
failures are not.

For example setting "user.*" will fail with EPERM on symlink/special.

Ignore this error as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 955ecd4030f0..8a7ef40d98f8 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -352,7 +352,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 				 fh ? fh->fb.len : 0, 0);
 	kfree(fh);
 
-	return err;
+	/* Ignore -EPERM from setting "user.*" on symlink/special */
+	return err == -EPERM ? 0 : err;
 }
 
 /* Store file handle of @upper dir in @index dir entry */
-- 
2.26.2

