Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A72BC5A6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgKVMiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVMiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:38:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AF8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:38:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a65so14712227wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3VLXW1rcDNo+Xe65RcrgSoY2wSXK0LA37ix2JoPBdPA=;
        b=oKXC2ViQ/zZDfjqe1ZHPy2r1Inxtc0OsptSZ9pjfvPbJM7kVqrHb8/H0EOCTDPcJ4V
         kL/27x/HbyGAAdjSlezr9vFMxHpFma4i8FZIYb7iWLwF5VLD4kgn/L6Ks/GGCVVtvj6M
         08iNGG+jTgMLcZAiYpcIEpp35cmitxeEgKJpeARASKRnKfuvluerMKadmbXM48z5uqGz
         zHhrWNC//vCG8MHS1hs2JKxCr+BBKNz+4SMAHV+0z004QoxMYeYJ4DqIlwRJEl/23V7u
         95x9NC+fHs8MoHveCmnpdS+SnSWtlCZVvGl6EMcKo6qSP0Ztu/jRvVNe+hU6o0QOvZQA
         v1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3VLXW1rcDNo+Xe65RcrgSoY2wSXK0LA37ix2JoPBdPA=;
        b=KhFTxqIbO4u5c/dDaJvekL7gVpNHkfjk8rv/B8CQQ7U4KOFBWx0vE7WFtS4Rl5k0Vi
         GFN9V2EFYlQ+yFXHfnVuZBc3jRc3F8Dq2RXL+q+HL7RzRkVq02JdMPtE3/L8AQBfa2wD
         hIvJR4PwMDRJJeLb36s1FcTa7/dgHCzoufybpXeGnV0VVFi1sdTsoIeznJH/+POivKTv
         3DTxDlIhmKBDW8DyhISAPFo3OXqwlz/x23pRRCWmJMKhMF/ujEvxLDctzvCZS/nl++pE
         NTTyB2QM14xqqhMyP8QA1gn1R7UMFkskACsSGkPTa1TKBJfL1nYGqwoP4PUZYfaXIZPc
         BtUg==
X-Gm-Message-State: AOAM532uUJD2UtU+huuGHAzTvpA2SnuHDAqISzNK/DcXvy49jhFkBZRL
        q2lawBEkJJR1+ZAS0PKdvDdHxKclvg==
X-Google-Smtp-Source: ABdhPJz/NYhSDePs9ePcreKlkWqiDmULn0gfu12QFuhWkF/xrSY7R9CIHniLtBoG30etGmhtJlN4oA==
X-Received: by 2002:a1c:b104:: with SMTP id a4mr18329247wmf.138.1606048682055;
        Sun, 22 Nov 2020 04:38:02 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.228])
        by smtp.gmail.com with ESMTPSA id q1sm5515194wrj.8.2020.11.22.04.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 04:38:01 -0800 (PST)
Date:   Sun, 22 Nov 2020 15:37:59 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: cleanup kstrto*() usage
Message-ID: <20201122123759.GC92364@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Range checks can folded into proper conversion function.
kstrto*() exist for all arithmetic types.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 mm/khugepaged.c |   18 +++++++++---------
 mm/ksm.c        |   18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -131,11 +131,11 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
 					  struct kobj_attribute *attr,
 					  const char *buf, size_t count)
 {
-	unsigned long msecs;
+	unsigned int msecs;
 	int err;
 
-	err = kstrtoul(buf, 10, &msecs);
-	if (err || msecs > UINT_MAX)
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
 		return -EINVAL;
 
 	khugepaged_scan_sleep_millisecs = msecs;
@@ -159,11 +159,11 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   const char *buf, size_t count)
 {
-	unsigned long msecs;
+	unsigned int msecs;
 	int err;
 
-	err = kstrtoul(buf, 10, &msecs);
-	if (err || msecs > UINT_MAX)
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
 		return -EINVAL;
 
 	khugepaged_alloc_sleep_millisecs = msecs;
@@ -186,11 +186,11 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
 				   const char *buf, size_t count)
 {
+	unsigned int pages;
 	int err;
-	unsigned long pages;
 
-	err = kstrtoul(buf, 10, &pages);
-	if (err || !pages || pages > UINT_MAX)
+	err = kstrtouint(buf, 10, &pages);
+	if (err || !pages)
 		return -EINVAL;
 
 	khugepaged_pages_to_scan = pages;
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2840,11 +2840,11 @@ static ssize_t sleep_millisecs_store(struct kobject *kobj,
 				     struct kobj_attribute *attr,
 				     const char *buf, size_t count)
 {
-	unsigned long msecs;
+	unsigned int msecs;
 	int err;
 
-	err = kstrtoul(buf, 10, &msecs);
-	if (err || msecs > UINT_MAX)
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
 		return -EINVAL;
 
 	ksm_thread_sleep_millisecs = msecs;
@@ -2864,11 +2864,11 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
 				   const char *buf, size_t count)
 {
+	unsigned int nr_pages;
 	int err;
-	unsigned long nr_pages;
 
-	err = kstrtoul(buf, 10, &nr_pages);
-	if (err || nr_pages > UINT_MAX)
+	err = kstrtouint(buf, 10, &nr_pages);
+	if (err)
 		return -EINVAL;
 
 	ksm_thread_pages_to_scan = nr_pages;
@@ -2886,11 +2886,11 @@ static ssize_t run_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 			 const char *buf, size_t count)
 {
+	unsigned int flags;
 	int err;
-	unsigned long flags;
 
-	err = kstrtoul(buf, 10, &flags);
-	if (err || flags > UINT_MAX)
+	err = kstrtouint(buf, 10, &flags);
+	if (err)
 		return -EINVAL;
 	if (flags > KSM_RUN_UNMERGE)
 		return -EINVAL;
