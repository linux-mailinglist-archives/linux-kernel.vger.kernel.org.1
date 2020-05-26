Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8011E2F50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 21:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbgEZTvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389269AbgEZTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD1C03E96F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:51:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w20so5537748pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJi+qFrBerZp7lBzD9z2X8A704PrrK58u6ckL/rX8b0=;
        b=QGGh7eDvuMEBseMP4f9z7p3YtnoMdEdl9ZhyIAyPiRAlOPWyjOt58ZYAEOyE5NGpZ+
         VbiVeaEvFBaRPyUFJs+jXjd5VlpU+FnFUdGnRwd4iM9vS4L8882zLFU0dJLNP83bH/7X
         Hr9aSoECE600nn2BUNPRRieqpYPuc2kJasfGr0Oad4cVuC7JJqYajXm+cBZv+VfHISga
         vLPJeD20yZMDEi0ileA+x1DrR5XEs54TlbjSVb6dXpEJAnHRCLPDGSG+Q65Af5so6wyt
         UoNhrMBuw8SKSezT9NYfONZtHHhz+/qyOtkgNQTZkmJfGXNjvokqDQxWupSNHXy0H+/a
         mcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJi+qFrBerZp7lBzD9z2X8A704PrrK58u6ckL/rX8b0=;
        b=NsQVfq6liO8hXZuNe1fT31iclzZ+VYPo8BVq5/bzRqmXn8RQbt3L20aCdOGjyUSc1Y
         HWE2A+vp7oW8z2w0/O6JBHiAJBkQLXvDwRTjFnqJUJmVS3ChbDDDN1YlVLaPifhPjsvv
         O+T+QhPY1hDkXrpWKsLNZNYsTxSppAHTCZGUG+6q3Xusg1amOw6QQXH9gqOWMo0+NFIP
         F9zM/oIrplNs7ab1/ahUwvGBZIHOAHUxR7Khvv6HK+v2Dp1psYHfrb2d8FZqyvFeEpuH
         0fZIfypbmNmNfIoETCOD8gJ7NZoQwmqHYgABCeNDHbDQX1uxIJVx2a2fo66UVrHhyYB6
         hv4A==
X-Gm-Message-State: AOAM533HhXireoq3S4Z6DnJHnG2RPOtb9/M8YtAE41ntSzuovE9EcrRj
        EXB6shadjFzsqAHUKD7VYTXTVw==
X-Google-Smtp-Source: ABdhPJzJqSQxVJW7x8nTJ31d7qT/FMci6We/odd5NaY49/EasjZOkFDNFy9QZL38JZHs/iDqJ2x1gQ==
X-Received: by 2002:a63:5245:: with SMTP id s5mr481181pgl.394.1590522694841;
        Tue, 26 May 2020 12:51:34 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/12] fs: add FMODE_BUF_RASYNC
Date:   Tue, 26 May 2020 13:51:17 -0600
Message-Id: <20200526195123.29053-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set, this indicates that the file system supports IOCB_WAITQ for
buffered reads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ba1fff0e7bca..5ffc6d236b01 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File supports async buffered reads */
+#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
-- 
2.26.2

