Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6D2E3414
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 06:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgL1FO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 00:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgL1FO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 00:14:28 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C7C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 21:13:48 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h4so8111759qkk.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg1rpBKeOs0Zwg0dgJvfTQqAURxAmynlKF8GOOw6tQ0=;
        b=Sg7iKYzJN4XOYobYdvR7uhLXHr6qNPc7Rqhx4S8tBZNR5wQ5iM7M9mFuys01m1upQB
         W07fsbIp5a7A0tSIsfeSUKhIvSRd1CNiUsRQ0UzI11T7Tk9B67gq7/bzktuCQpv2fN38
         iFeOnUISt+glb8MBWkD4JupvVm1suSbBJVwAA6u93/6pZrw1Rr6DuEOcmktgk0tpOZw0
         TR3d/WuUwSZOYbSJGlNNgAUyBaVBoruieBZeGNV56M4bhUMZlOanCwQSDGWtDWcEKN8d
         kc0PiNQ5376oEWocpz0SPZIER4Cmzzp9ylKMT2J4XTieczCkkNd9o2yfP8fUBhwBr1MB
         5fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg1rpBKeOs0Zwg0dgJvfTQqAURxAmynlKF8GOOw6tQ0=;
        b=ruhNzr98XUSMUH+pAg0dCihvAypkB79UtrNWQ8TBhl+SnVsDnD2uhqfr9L234I+a1U
         xPTICt4daKd2Oa9k85OXtcIQRcvhTJObXagLpt4uQCPbyPKBy8FBCZTAX7p47nPek+4A
         v1fkYtk6NFIt1ULhRBAgfzuTg8h8zerXNs0YdnKx/cClR80H4I7S2cZQSy3LNhH7L1pw
         Xox9VEtJeLnbk1RqNgbQsbhYZ83wEXIvlgL25msEQ9R5OA2cAUlLRZMxwcViMBZRVd+g
         ngxe1MioqRuGHWUxYy8yAtDqUyUAjdyAMHg4SWrTYpCuwqVXiJMJbtgQbpBnyc4Zsc4P
         VF0w==
X-Gm-Message-State: AOAM5338vuav3VuaF3LxkVek1UYxT1DsbwaDjJ8Kwx0cQ6NoS8lLDhXK
        IX+yNU3dLxtwW4Jzm4yN4D2u9V476lm3jRP0
X-Google-Smtp-Source: ABdhPJw9aZrwGMGM5CvfvqnvauqztJNhH55xSXsIu5BpMfoh5zvN5dwzdo5qo39ZRMugaspmlBJPpQ==
X-Received: by 2002:a05:620a:804:: with SMTP id s4mr44088233qks.158.1609132427247;
        Sun, 27 Dec 2020 21:13:47 -0800 (PST)
Received: from debian.hitronhub.home (cpe84948c98e773-cm84948c98e770.cpe.net.fido.ca. [72.140.62.181])
        by smtp.gmail.com with ESMTPSA id n195sm15706160qke.20.2020.12.27.21.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 21:13:46 -0800 (PST)
From:   jovin555 <jovin555@gmail.com>
Cc:     jovin555@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem: Declared file operation with const keyword
Date:   Mon, 28 Dec 2020 00:13:00 -0500
Message-Id: <20201228051301.14983-1-jovin555@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: jovin555 <jovin555@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index c05a214191da..f9cfa15b785f 100644
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

