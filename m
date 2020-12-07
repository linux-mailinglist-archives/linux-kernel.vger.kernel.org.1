Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8293B2D1662
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgLGQfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727660AbgLGQec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otYj369xse9R2kbOApLqBDn6NdlRsKHBl6lYbw3xZEw=;
        b=iRBYEDZ5TcYh8gOy7m4RTWnNIoebpQCuqYbCb4djgaqxlaYvqsFfry2hidLYKloUG3zlgb
        4kwpujHI/F4/R6InTYpDGKjzSsu/YLQ0DQg0BXbu4AjwDn/7qx+Zdte8V+sMMwe0cGvOgB
        hzCIhfizlEQZiggUkoQ+Ma5CCGPbziM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-idMyDOxRMhiYd4VoPOEeMw-1; Mon, 07 Dec 2020 11:33:03 -0500
X-MC-Unique: idMyDOxRMhiYd4VoPOEeMw-1
Received: by mail-ej1-f71.google.com with SMTP id dv25so4021524ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otYj369xse9R2kbOApLqBDn6NdlRsKHBl6lYbw3xZEw=;
        b=EGNUOwdV8jRo5sonwqlRwIyBWNjxHG/59tWOEjMT1jrnegRJ6iShD6QefcojVK3yiW
         mRmXseCyK4yNEZolK7mzU5sVmh/88hfC6Yda20YMsvHqF/JltYv1jCeE1ZgD48lAxAc3
         qGHkXDkavrpX/UzLgtQXX9lHlwF1RygSKk04/ENvLX5WzFoBUxN7RZlvkwVOU8W48zB9
         qqVrw0B/+piHXNDQwpX+M9Rst169VcrdK5o4pN8lRvPVZ9UGdF7GPnP1s6eCs37xQzC7
         Hbsao2fif7cXWYUHJFyNgXHw18KgOHWI9SneC1O9BkrFBvPejLudkwaNElS8SIBZhY00
         OSdA==
X-Gm-Message-State: AOAM533l9Gh2yLcJQwVxW3bP3OZ/F//EqpHzOvy31iVjvr8qbBZq9KCo
        Q9ZHYuxxw+OOH5gM9VdIJ+VQLtvPDk6fl/kunf3RZ/F8tqXuFJqh0AaqO2cmt32suMpBx/zm6Sx
        +Q1EH0faQ0C+wue7vOSHQftPF
X-Received: by 2002:a17:906:c83b:: with SMTP id dd27mr19881672ejb.356.1607358782442;
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygw9J/iNohcy2imBMmRfiewi1ytt2qnsha6UorIQb1JISBnH+1nxrUZXhES5TAxxlwjwkJkQ==
X-Received: by 2002:a17:906:c83b:: with SMTP id dd27mr19881657ejb.356.1607358782244;
        Mon, 07 Dec 2020 08:33:02 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:01 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] vfs: verify source area in vfs_dedupe_file_range_one()
Date:   Mon,  7 Dec 2020 17:32:47 +0100
Message-Id: <20201207163255.564116-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call remap_verify_area() on the source file as well as the destination.

When called from vfs_dedupe_file_range() the check as already been
performed, but not so if called from layered fs (overlayfs, etc...)

Could ommit the redundant check in vfs_dedupe_file_range(), but leave for
now to get error early (for fear of breaking backward compatibility).

This call shouldn't be performance sensitive.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/remap_range.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e6099beefa97..77dba3a49e65 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -456,8 +456,16 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 	if (ret)
 		return ret;
 
+	/*
+	 * This is redundant if called from vfs_dedupe_file_range(), but other
+	 * callers need it and it's not performance sesitive...
+	 */
+	ret = remap_verify_area(src_file, src_pos, len, false);
+	if (ret)
+		goto out_drop_write;
+
 	ret = remap_verify_area(dst_file, dst_pos, len, true);
-	if (ret < 0)
+	if (ret)
 		goto out_drop_write;
 
 	ret = -EPERM;
-- 
2.26.2

