Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624701DF408
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 03:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbgEWBvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 21:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbgEWBvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EBDC08C5C5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b190so6002375pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=viOUEJ1fR6EBYLV+aGk4n4pPCzVmSS3wNBos+myVsG9d41L0VNwWkGpSJmOhx3K9++
         f9KJqmYPc52aQNDh7YBCfGeiMDtYKLgYg3KJ8Tinr03i/xE1uwVTqvhDcqDMbeFtl0ry
         /Fbrftn8RXZ8jfaKQjlRMnDxcx7ZUeBqLwxIInOHFnGah2gnFiWL+aSKx/Vus5jvhAvb
         OUE0VGbgSSqfdsPWnexlxMY+WF6b/eVXTi5o6mZVwVvwHDPL5zY9JJY/lOfTSooU5zq/
         3vaOAuGthCRFAY6UAqlOO3/p3MtxKBubwxgq6lOmlbcoZuFWfQBxZer5UAP630v53ff+
         KF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=WEM2T+OFrGSzS7AIpaVFoy92fWOX3ZRkq+vxP46ZBbFCoUs6TQCjEhjb+OIBLgkPgK
         SOQxEIJybRiehMQkJTmYRswRxbLs1JxLBEDxgJ96yvpptFiD7A+/4b83VAtxHVwhcPNN
         aPKjvEaHwek2mMLzINgGD6Dq1DmZBzG7J7ALf4j+yJvzyd80X4nyFlbk8Jk+yMr7TyL/
         C0mk0Ohz8+7ocGSs/dmR7IJ2wZ7y0uWUf20gcwYngKPvskpHTyBSgQja55GjWaFbtdZO
         lv6KPpftXpyzT0FdN5xkT9D32dDZlagyBFK2Ydu7UciugqKQySSAlu5jsZW+k/VFzHPH
         Vv6Q==
X-Gm-Message-State: AOAM531SnDkNdJ/9d3wie/S4wGq9jZXrzr5iPScPLhBVMCFzfzAWEMlT
        YDCAIYHlAGXlbdE2ipzczdjJEw==
X-Google-Smtp-Source: ABdhPJxMDUN9GWGHzw/t3Lk7jZslvDAozX8xG9m2W1wpHYgfAm8cjUlGT/CMaOFe5dKd6Q6mLPzZ2A==
X-Received: by 2002:a65:6094:: with SMTP id t20mr16806792pgu.220.1590198665111;
        Fri, 22 May 2020 18:51:05 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] ext4: flag as supporting buffered async reads
Date:   Fri, 22 May 2020 19:50:44 -0600
Message-Id: <20200523015049.14808-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0d624250a62b..9f7d9bf427b4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -826,7 +826,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.26.2

