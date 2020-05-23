Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9E1DF3F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 03:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgEWBvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 21:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbgEWBvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19228C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q9so5814468pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=xN8NwRmSZj3KWZhRv/KRaMZungdyWud1fPfvxX91TBDAas0f3RGQJhtwUc9bsOpYD+
         qehVzky+nxxds1s08uTpi6wNc8TSmWi+wAH1qS+2cwAlKmSLByajIDk3fKTDP07EBCv1
         ByzrBhkqH7Fi15hf+Xcef1drhJrC86fxHQy4O1XwSsOy6g6ZItp3jK4wbh6fQqdEYK1E
         +2XGqQXuLkliIC+pIUdmCRrWM3FS8yGjyJyGlVxU6myazzPESWv3XhG9efZtbIdTM8DE
         5Ve0zocw4u7wy39QwnyOZCoAfBY3yGuJ3lJHjSGqujeS9/y7N0Ws1hVjzPIG1hmM41Gb
         3hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=q0QgV+zHIJOJ0HmlpOJR6B8yFM4Cb9C3e+j9jOLgICYn4Otg+ex7V95Pva2QP9IUVD
         wCEzCqGWgERway8fHAroEsicvtS0jBzQwoU1Hqt0gpX7hV+iD9li8m0rduuTgf24i1J9
         DYfe6miqjWdEgN7PI5QUjO9+QZhOYY0fSiUpN6QR1AALnSjnJcfXoDH8P999UOKn5bsD
         fv27svNDKukZL53p5vtYTgoTQ3lMSV6AQBCcjl4ukInH7+tqw7b6gdsZJrIlul8zTcdn
         Q6QOXgp553MbgvI/uJXKj58Rs/x6wUbEBg4FF3fnC+hHvLzd2RxyMFKk6DRASQBPqRNs
         0POQ==
X-Gm-Message-State: AOAM5319vM1j29YcjKe9AKl7eW2yn7zfKXNf1kTFrie5e5jMykjg+B7i
        4rpdFved+lsW3t4sfEObRem6sA==
X-Google-Smtp-Source: ABdhPJztwQahKJhtCBJUZvWAeijHNskrzA5ff8ZARDi37j/dWUEIIWlaDM7fyqURSemcqutfVlZDKg==
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr8098085pjv.8.1590198668620;
        Fri, 22 May 2020 18:51:08 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] btrfs: flag files as supporting buffered async reads
Date:   Fri, 22 May 2020 19:50:47 -0600
Message-Id: <20200523015049.14808-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrfs uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 719e68ab552c..c933b6a1b4a8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3480,7 +3480,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return generic_file_open(inode, filp);
 }
 
-- 
2.26.2

