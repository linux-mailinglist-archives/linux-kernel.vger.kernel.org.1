Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7820A2C71E7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389963AbgK1Vu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbgK1SPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:15:38 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E2C02A185
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 04:16:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t21so6437549pgl.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 04:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dFDolAZiGf4URri4VHKxX9kxJbVzHoUu314H0MoB7Dk=;
        b=EwOHvZEMmGXuqNzhfAhHzZnEx6ZUMkbhcVqa72XlEuN/iZmAjYn1D0B5XEXRm8vOZL
         /FD5op8rvtoDXff3mlfXhFcDuSeJLQUNn+fyXTkHtR9gK0lzcde+NfJzZfD1DM2IXNn4
         8lNB+VoHf+tZ4zLtdg9jNV2KzVduLG6TdI5/3EVIiBnrD+YK94S/f1Vo80sYDZFg6RvZ
         0fgVBZP2/W9eRsqXIEdMMV3ZooJZOiwMdogweWQYCy+N9P+t5y5QMyxoIeKUU+iFWx00
         xi6zvWrrU7SYvc3LMFBD5Vg4bZJQcHnPpJKfF588/KFHQtHo1S8FffSfd5cLwZiaPF/K
         Fyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dFDolAZiGf4URri4VHKxX9kxJbVzHoUu314H0MoB7Dk=;
        b=Xv93eCLyrelrfM8zJLND6tfu9BAuILWfpTa+EBO85tP0yGVuwacwfxsq2yd0cFQehJ
         5vWEjp2bBiDSNImDfllVLdAduiFJ8xFUvEId6YAWWp4bHZpUYZOo4I5jdcCA5CgrH3U6
         0vB8u/hz9d3tT+ecGq8HHpulULpHUmYGtdcvyKMcfE8j7Qf7oPBk44emz4f+yYwnOJ49
         prXdsiwNPB5LLRxwNwmi3ov+mXo4QciaKjn5Q7+yDmHiO83CWChbsSwQMspSkbaEKcTK
         bhkiH601MufTYPIewJyBZDz8zRCejqtRxmivV7YSmEOT2rUbpageELvDLshN7YW56Zsa
         ZlQg==
X-Gm-Message-State: AOAM531H0h0zcB+m59JYj1d9vOEpnNDmClqhmYmQ0i87iPlTX2+czJg4
        aDY0e9AIeKVOCcFV+Oljgik=
X-Google-Smtp-Source: ABdhPJz7f37xy2ooexfQ2C9/O7rpdOWumaNVq1nqzbdziPFrPX/nJoL8M+6edZp8gvV9yfvowLTLZw==
X-Received: by 2002:a17:90a:cb95:: with SMTP id a21mr9849898pju.38.1606565793817;
        Sat, 28 Nov 2020 04:16:33 -0800 (PST)
Received: from worker-node1 ([2401:4900:5198:5ee9:a3f:ebde:1df3:55f4])
        by smtp.gmail.com with ESMTPSA id s15sm10240670pfd.33.2020.11.28.04.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 04:16:33 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:46:27 +0530
From:   Vishawanath Jadhav <jvishwanath66@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, surenb@google.com
Subject: [PATCH] Staging: android: ashmem: Fixed a coding style issue.
Message-ID: <20201128121627.GA27317@worker-node1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue, file_operations structure should be declared as a constant.

Signed-off-by: Vishawanath Jadhav <jvishwanath66@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 10b4be1f3e78..d90fca07c17f 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.20.1

