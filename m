Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91FF1FF52C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgFROpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbgFROoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC2CC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s23so2879771pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=qn8Ub7OYxVXKid0SneeEv6VlK8roF4pAhw3PBRQGk58=;
        b=JsQWJAr0eX5i4/3VH0JUUcbrX1hvyikPQulQivfaSDiMps3VzdLvSQq6dC4JKqWrJw
         KNxWMk6jyBDtv6zAbNsi8EXWu/yzVZs9PhGYrbDhl/fbSE8G4wRID9uPFVW7kqxk71SV
         0TMZ2olNJApcg9LZpxFyKjUmCe4HMfr+UszmCR8CNyND2jnymuGfLJggvQZrlKsGiP5H
         olUIpqHBAvyxiNTFfvQ13/71tmHFNQyLLqdFLI0ERuAdJTxyxlimD9W8/4OLmmmYJWbC
         NDlNdD05mAC1WxkMhISVU5ejMHN0Tp6Wbi9rsSKqKY3u8ZOVaCzS4KBi9ffc4A0l9I/a
         Yiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=qn8Ub7OYxVXKid0SneeEv6VlK8roF4pAhw3PBRQGk58=;
        b=XSA+O0+Cq0TxJaa6zPc70+2S7vZ/Xqi4yA2QtUq6DXW/bZPu75MFIHKbTUdDVtZfbs
         DkMoym2HUcNpNPHZtr3G8j8oFaimlbwp2GjDGTKXtRNpJDFI+CktZfbXLOiWK2hhdRV8
         g0bVnc9r6mGLFqXTW2cVSdPeKpxPWj7026zAb8K6eCz6yaRTbYYnkPy5bu7SQntXu1uH
         f5lRYjz/Sn9DGysSZedN6YCCPxPDv5AUvT9/9JTgXj8Ql2eoN+Xc744P16du9Cx9NlDh
         X3BWsztHBrG1yEBCtM4/pywq32QEzxg5/wmduxheb3e9Bg1QHscpcdP1oa9bKo6MrHqU
         p1xw==
X-Gm-Message-State: AOAM530OYezdrFeyjpGe02JwUMjbXNde5mWr8LBEskfnryo4IgI8F4Jv
        Q3r5jxweh74rBeSBKExzMJt3hg==
X-Google-Smtp-Source: ABdhPJxqRDix9IaoTIWmuLrGVEzpKy6hFma+ZgZz9Se6n9okXrRAwv8gfsXZq8bmQZ3+Gotx4PSctg==
X-Received: by 2002:a65:6119:: with SMTP id z25mr3404328pgu.52.1592491456371;
        Thu, 18 Jun 2020 07:44:16 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>
Subject: [PATCH 12/15] btrfs: flag files as supporting buffered async reads
Date:   Thu, 18 Jun 2020 08:43:52 -0600
Message-Id: <20200618144355.17324-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrfs uses generic_file_read_iter(), which already supports this.

Acked-by: Chris Mason <clm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2c14312b05e8..234a418eb6da 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3472,7 +3472,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return generic_file_open(inode, filp);
 }
 
-- 
2.27.0

