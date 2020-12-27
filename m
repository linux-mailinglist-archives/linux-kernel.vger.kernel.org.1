Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777042E30EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 12:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgL0L15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 06:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgL0L14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 06:27:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F8EC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 03:27:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so4944353pjl.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 03:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sj7zNDV7up4xyTXjHAMWjDBa/hYjY3JMoH2M3A8nvI=;
        b=HNyRxbZWLfHucmIRnwQDhdZW1wdAvM5bu4NMyWlzpu2nCf33J6tIwAujfEpAJN+FWK
         jAEk5vW/KwoIk1HppxZfmDi1p8ThkG4fFIWCRLG9CLNOxYA+NqzvCUrE+fMSVglQC+Z9
         obtFtwgSZECAvJzW25gW04jwXPw2hf57OkHNb6O6yRpVS2KuecdYyzpAd6oclxXMvOV+
         BIzVGvzXC7nWAdD5N9xQFTdOvZ+eCJ/pJU8BqUSsxruVJroSPx2s2ndqqofkozc3mqL0
         CV17AQaGkoaEbYc/2dXDpZdNykbiF575vWfUop5F+KIH2V9t+suppoCLsFrcc+wliSdY
         dqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Sj7zNDV7up4xyTXjHAMWjDBa/hYjY3JMoH2M3A8nvI=;
        b=YCX8MeFxZ2h6f00zw5H0lJQwFCg0sScFyqzcx4x+n3iACojF4mMaryuDytKihaKa68
         UtX6jxf8rh/SLclXRgZLPnZY4nCaknWSogYQ1HvfKWizim+kSAKOTRo4m8uuJDk8WTER
         Mk8/+Mwhf/hzfKtkw3YV9YU68nw5rNWKS+QnvQC3LY6g3LXxXzW2/upcAJE0kUNYClON
         3lz9D/9h3XVB/OvmEsUOUyLJWHEpKSNrgQ/+JEZHCJEuF+M3yhYanZqXw1kmtfag0xOA
         6DM14JMmx18hB/wSfub9F7IaRqxW7AZOpHuoScstgV40QgkTJPOMhFswi3VBpgdD46tT
         CbzA==
X-Gm-Message-State: AOAM532iZlIm/rIag1FqNpgFgE8be1F7YJ4EV5Y9pbMFTR+RBwXmfwkq
        ffyu7cWZnQXeSEF3ZIi5slNwR4Xia5ZHm2Zw4hc=
X-Google-Smtp-Source: ABdhPJyIHvpsO8covr+GAATO0jMY7qZ2rIho3vecxzsgh3+2uCQRNSRoC50s4W3Tf2gIuI4ncZNj/w==
X-Received: by 2002:a17:90a:f0c5:: with SMTP id fa5mr16494755pjb.144.1609068434931;
        Sun, 27 Dec 2020 03:27:14 -0800 (PST)
Received: from localhost.localdomain ([2409:4061:694:ca06:6ac9:32ec:907c:e017])
        by smtp.gmail.com with ESMTPSA id z20sm10282308pjq.16.2020.12.27.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 03:27:14 -0800 (PST)
From:   Angshuman Sengupta <senguptaangshuman17@gmail.com>
Cc:     senguptaangshuman17@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem: Fixed warning for structure declaration
Date:   Sun, 27 Dec 2020 16:56:45 +0530
Message-Id: <20201227112645.256943-1-senguptaangshuman17@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: Angshuman Sengupta <senguptaangshuman17@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 4789d36ddfd3..2cb665e0228c 100644
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
2.29.2

