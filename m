Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2AE1D119A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgEMLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 07:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgEMLlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:41:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171AAC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:41:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n11so7655642pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvvYDsDzRmhFLM4A9oVavXTflTQql5yNcbzYUVmhfHM=;
        b=LcjCZBTk984pSAqEaQLI7C5L6PnGB68x8usQUPH8/EGOhPZw2EZWvpvSHY2tXdJ9kB
         DcLAv5fSjF+Pfh62wm18ADjpRxFhfs+V/NcnJGMX6cnqtxRHtzKCf19bTiD2WtlFsltO
         eszN19ys5wXoK0OJl7R9miz4r65j0BI29rVfcfed0IQO5SyjE1JXNDpctxWnQzIWVYah
         MCGp2YTIAb1DY8PHDdvfRxQcs5aeESqLCQB2Jo2s2ukS2cJ6umz0lp1aE0xloUVJvUhL
         WS/VnGWq81gbmnEIqxD8Fa0QD1CIbhTV5+TK7mvOfyWe+K5IA8WRFEgsappl1OJ09EVb
         HInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvvYDsDzRmhFLM4A9oVavXTflTQql5yNcbzYUVmhfHM=;
        b=ggjYZaon9nO/h8KqLz0LP5qHkQ+Bi27eZPp1AXbctNh3W16XJEp8tpj1GHTZVvB/G9
         Dg2AbcYQtpLHIm18JM5tSciv7UwOXW6YdxgyQiHxhxFCL/8dBCR3QoQgg1vIiD06syxS
         DWTM4MRds1MbSQrj0jHUA4kXgEGu3GMKq+5nyZFxFYd4Dp1hXyr9+u1cxlo674rsoZMo
         SBSzq1Vhe/wddEkLGbyTN/UMRXlIEexzAgx/nT+BV1bJUNcnLboBfYEMlx4E80Tp0ZWV
         wMcWxMR9d8VfaOvxy7oRlpuGjg3cYppHYsQamUkH2z0qB98wkkVK+AZkKvq2opHHiXOb
         3iHQ==
X-Gm-Message-State: AGi0PubLDCA5ihuMrE6so79ZHKUtsNEpDZTgnrMSIHO+UkI5EQkKhtZS
        G5OPxWpyJD+u/xeEIdeIdlsoMqvmeszEjw==
X-Google-Smtp-Source: APiQypJ2fzLimkKBCJzMa3CUHEDSDv9lWQdCBA2HiCqhvjfxuliwudX2IO8Fps8d8HAMqWklmofJxw==
X-Received: by 2002:a63:360f:: with SMTP id d15mr23107940pga.102.1589370089460;
        Wed, 13 May 2020 04:41:29 -0700 (PDT)
Received: from localhost.localdomain ([42.108.246.232])
        by smtp.googlemail.com with ESMTPSA id g9sm12992533pgj.89.2020.05.13.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 04:41:28 -0700 (PDT)
From:   Anmol <anmol.karan123@gmail.com>
X-Google-Original-From: Anmol <anmol.karan123@.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Anmol <anmol.karan123@gmail.com>
Subject: [PATCH] staging: android: ashmem: Fixed a issue related to file_operations
Date:   Wed, 13 May 2020 17:11:16 +0530
Message-Id: <20200513114116.26410-1-user@debian>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anmol <anmol.karan123@gmail.com>

Fixed a issue related to struct file_operations which should normally be const.

Signed-off-by: Anmol <anmol.karan123@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 8044510d8ec6..fbb6ac9ba1ab 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.20.1

