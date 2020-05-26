Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DEE1D2315
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbgEMXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732662AbgEMXdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:33:25 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F3C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:25 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d7so1011564ioq.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIVBkEnP87U+pncWWkJ98oCkeUAmYEYzyhCqp+CwhGk=;
        b=Ur8oBLYkjV/8PqnONhGlqnu5TPGksfmb5kJNs87WznvzEl4fbUx3dgeXjQwbYBH5u8
         teWj3up+D0s6zdQZmjA2/0rTcXEAFX0TKxZsXsNn3qpuxBE8ZTpQKTSrjPxguTdGgyOd
         CFVBXW8esGIhAlWvyiUuwtFnMpVzMxHH9t2AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIVBkEnP87U+pncWWkJ98oCkeUAmYEYzyhCqp+CwhGk=;
        b=UJ1lG6z7GkrJz0GIW2bdmkYEtMRiJJpc2XMU7+DcFQc9/SKBioRNvNUAzWwBxQzEk9
         +Gp8Qa3qyZURa1TGnSw1h3y4DgoiNXgL9ATpwHOaO3aU2micRlMw/WTre5qYcO8VT6t0
         WQ+9TYEfeBywWq8aeyUyyeTM9NxBpkxfzIGtVkKxhmnyWVa53nuIWdPZi1xP+R3X4Bjo
         OcJ7zdEdKE88qvNUZ6YWA6tFNj3akasuJL98kKYRmxG8Q1esBkGDjt0OohFqH5+OPUIE
         +iKVkGwZWbvZ3ZA2jgNk03fI6dfROoycAVc3P1iMoaLAYeCgo80sv4H3/LEBCOOfu67M
         IiXQ==
X-Gm-Message-State: AOAM532iZfwaOMh+DBGXVquFgFMZMVKiBHxFSMIU3fRfaj0lHVPZ+dnY
        mQckFE4tr+udw/yPWyj4WLGHfA==
X-Google-Smtp-Source: ABdhPJxrQfNaJJQZD33SRhuVe4mPSy/1ZZDejjjnHvXe+HZnMWaAXWGF7d6/TirpF6KzUtt8mGy0zA==
X-Received: by 2002:a5e:8c07:: with SMTP id n7mr1623113ioj.58.1589412804662;
        Wed, 13 May 2020 16:33:24 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b1sm398072ilr.23.2020.05.13.16.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:33:24 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
Date:   Wed, 13 May 2020 17:33:20 -0600
Message-Id: <5945f42e08ee037c4d1d0492622defb5904f4850.1589411496.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589411496.git.skhan@linuxfoundation.org>
References: <cover.1589411496.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags.

Change it anyway since failed fdget() doesn't require a fdput(). Refine
the code path a bit for it to read more clearly.
Reference: 22f96b3808c1 ("fs: add sync_file_range() helper")

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/sync.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..3ec312bf62eb 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -365,14 +365,14 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags)
 {
 	int ret;
-	struct fd f;
+	struct fd f = fdget(fd);
 
-	ret = -EBADF;
-	f = fdget(fd);
-	if (f.file)
-		ret = sync_file_range(f.file, offset, nbytes, flags);
+	if (!f.file)
+		return -EBADF;
 
+	ret = sync_file_range(f.file, offset, nbytes, flags);
 	fdput(f);
+
 	return ret;
 }
 
-- 
2.25.1

