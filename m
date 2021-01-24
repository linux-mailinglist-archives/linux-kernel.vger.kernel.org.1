Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1849301935
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 03:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAXCY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 21:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAXCY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 21:24:26 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5D0C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 18:23:45 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u11so5485393plg.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 18:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eM7G10SsulrYvWpwzx1SSvVfv4zOutKSaprQVQH/14I=;
        b=IR8oBcxo4j9AWWEwOOWHuktyS0AQyjFtzQ5S3qMLD8pUuGRXqzc3BjgdCj5JzuREnl
         RD6nNeNGUzD7xTgYtgahoz8RzrtnSV7NA3TkKvzHNFylUJdWfYzvez8z2l+f1mkoMzUr
         0yQl+qJTpn620WvSOdHpQOA2l9A5HrQa47rI121ldxDypff1sWguluWBzEna3gHUnyjP
         vBSROqHMJ/e2BFs7DCnS7jgu+oSI0xo5AXgZ/hK0QbiPU8l8n6DTsvFbDXNHs9nOA1tD
         GcMah9wiEz0PIjYT8hCrSoWMn7xKpWuKTFgBl4SjbkLIfqAna5X6tfxeTdJKUUZh0LtP
         dDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eM7G10SsulrYvWpwzx1SSvVfv4zOutKSaprQVQH/14I=;
        b=pdb6xw+gtvrJcJEYrI/bWC9NY/X2/SKN20h8ivptLkWXwmgU46Y0NeC8++cC8Y1f4b
         NFOmO7eR444U03kf88vhvviibUF13TDVXIYULEoHXfL2xdoYMFZmx0SPA0mvVOs/zb8s
         2zz1gsN1GaN4f51olH8/Li2ZlXkvoutm5qhp0YMtJvCIlnH5vVPh3HL35yE7jL+S87kR
         /0WmuLil+YtzIrA91QBM2qhxUDVP5hNGXwEOMYFX9Nnx9e0lp2hgSJL1JmIH2om5N7OF
         WTeOxtVZCqCHUYXShp2RNLSDNbyaXjLtovFv1nY5QraYpGThHvkoCtTQcUbsds7lKsBV
         Iw3w==
X-Gm-Message-State: AOAM5301s/cUDajNYEmIcNQCL/m1BYGtQjmqBnxZLJnp2MQ22h7IljDo
        zXIxQnoKc8ZW/Q0kHPPO1Ho=
X-Google-Smtp-Source: ABdhPJzLp1FpRGsWgawxV/W/MUC92TZNFCXo/++eU1xad8shffqyJUkrBSk5IhqoxHVs0XWhil80dA==
X-Received: by 2002:a17:90a:bf05:: with SMTP id c5mr3607750pjs.90.1611455025469;
        Sat, 23 Jan 2021 18:23:45 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id 184sm12377674pgi.92.2021.01.23.18.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 18:23:45 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH] mm/memfd: replace strcpy() by strscpy()
Date:   Sun, 24 Jan 2021 10:23:37 +0800
Message-Id: <1611455017-2210-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strcpy() function is being deprecated. Replace it by the safer
strscpy().

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 mm/memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 2647c89..bb90862 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -278,7 +278,7 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!name)
 		return -ENOMEM;
 
-	strcpy(name, MFD_NAME_PREFIX);
+	strscpy(name, MFD_NAME_PREFIX, len + MFD_NAME_PREFIX_LEN);
 	if (copy_from_user(&name[MFD_NAME_PREFIX_LEN], uname, len)) {
 		error = -EFAULT;
 		goto err_name;
-- 
1.8.3.1

