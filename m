Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB981CFE88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 21:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgELTnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELTnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:43:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A8C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:43:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w11so15456669iov.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDftBJHTSVWUMGmOVvO/pH+pahE34h/2CLqQbMrb1kQ=;
        b=VzOhyBJ50rj9y88lIuva7HYzzznyCm0H+hG7FD00dWc/TiDJCA0E+1yzh9jKD03Cfi
         kSccnBPJ+dd0SV6w5izzhPQuEkkxsawS6RQRRTCRL1INujJo/0rcYEQ2llTEpm97/DVq
         mEJYM55GogDCJuBTiXAFQQf9lmZRzfKSyTmK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDftBJHTSVWUMGmOVvO/pH+pahE34h/2CLqQbMrb1kQ=;
        b=hv3XmiSrNZmARhHiuZ5HMbqxV28f/ZV2KhDNhKTgDFs4YAuuVXF/7ZjdKr0KoEP/CB
         Y61gIL/80OLGBxeBhbBRPeWacSQsz3S1H0+N5eil5TEil4Ale8SIX1dQ3+tLcNACw2Zp
         Kn3YVMmz3Y+szJeA5Mp0l+xooTsgM18ps1M6KFXt4wxdJN7Hw623tpZe1ydckGVvKVAs
         KulwF1BdVb2gjTkJQ/58+DxWanLTb7pToDrqNQIHCqZyp/SmNx8x9JwBptGdwSK+BU6e
         6kwgxN2Tf+0BO1jJm/ehl6PsuaLDgCbCYAEp+Rw2MhMjmHibt+XmSMvz5E7WvtBPEFj0
         mm5w==
X-Gm-Message-State: AGi0Puaq7D15UbBl1PHgKDPVIfjX/7AssbArx5a/7NUxCO9itk4BhDng
        UdPZTN/CwSS7MVoje412OCC3hA==
X-Google-Smtp-Source: APiQypIsGCeZQw29/QluF60afoXeCbOYKr29SjbfKMLdQ5jsD5GwNaMMwLiS2ovQFxknpVAAqHt+kg==
X-Received: by 2002:a02:a1c8:: with SMTP id o8mr9897803jah.38.1589312589835;
        Tue, 12 May 2020 12:43:09 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm6177781iok.4.2020.05.12.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:43:09 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
Date:   Tue, 12 May 2020 13:43:04 -0600
Message-Id: <71cc3966f60f884924f9dff8875ed478e858dca1.1589311577.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589311577.git.skhan@linuxfoundation.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
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
Reference: commit 22f96b3808c1 ("fs: add sync_file_range() helper")

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/sync.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..300ca73ec87c 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -364,15 +364,15 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags)
 {
-	int ret;
-	struct fd f;
+	int ret = -EBADF;
+	struct fd f = fdget(fd);
 
-	ret = -EBADF;
-	f = fdget(fd);
-	if (f.file)
-		ret = sync_file_range(f.file, offset, nbytes, flags);
+	if (!f.file)
+		goto out;
 
+	ret = sync_file_range(f.file, offset, nbytes, flags);
 	fdput(f);
+out:
 	return ret;
 }
 
-- 
2.25.1

