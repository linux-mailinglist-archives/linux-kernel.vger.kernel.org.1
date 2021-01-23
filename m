Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6B30124B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAWCcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbhAWCcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:32:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0DC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:32:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r4so4306378pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WlCYHQaPX6yYThqq6iqs2rd0OVk5cVfU0u96IS3rFGQ=;
        b=RgkAqRIKeZKtC6cw/hLL+vVUasoqrDxKFje1ofgtHe++Jp8klEwDV/Ze9BP53rgbJT
         zyimehOuaifByTxmk0rMU3hXUJsonEFsWv1u8kjCTOGyjaca8Qdxc/XvvY6hPAshqHUP
         0C+hM/mifjsPkzWp18AzID5N2vwMIqw8g3w4O6cldoCCphSXDBuXe9W4pLkNsSUyTDoK
         PrGacXK/yoTFXmxgz3eBR2OyN59v/RWOXSqamEqajuMt++5nEIZknOnAI5dKrlmWg8I+
         lMTet8Qfk6JtrfiKLaqj3nlzL/3TM4Rk6dNLP0gbz6no45T5ayv+Gb2G60mAVH/zdJl3
         Dozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WlCYHQaPX6yYThqq6iqs2rd0OVk5cVfU0u96IS3rFGQ=;
        b=g78jIxpwOUuL7H/XaVBAKWPplh5yFwDZgl8cuO1v6MrqFmSY2lnXLnFdzjaAMMN0yd
         mostT2yxFhmVOuP+cEyQGqS3ngi7pyvsGVIedz+4wgqQnnqYowFZnIvwPdpMPgfXd5ey
         yMA1qeds/gjMAPHT1JZ587eGEn6mtCNr9saCoo7uiWI4ELr6XnoeaXcGMn7BtWaCDvXJ
         8Dwqr9SFx0MZWqneKhQsxsE8S8+fo26HQ7h/rRzn1wh+TDq0YLghXzviscpwCBKZ4fwD
         RQDl2QDLS7tvPYa7MCyqXUe/7NiDSjOxxllhglQ5I7ier10/usUw5olqxV+u1cpZcSjK
         7e2Q==
X-Gm-Message-State: AOAM5312o3qTvtGrVUmzGu2bCxYYpXz/Rg87NBiH5vM9qqgubJ0wLUoN
        EYBNe9978w8AHcwsX4Mx57vJ8eozioo=
X-Google-Smtp-Source: ABdhPJzK1T8HWc7If0w2WyuBba+z7rUjPE7qEFfA0RVBG70ze70fTsBWvWzvSu5EjJeaegfOnG8llg==
X-Received: by 2002:a17:90a:77c1:: with SMTP id e1mr8902647pjs.141.1611369131333;
        Fri, 22 Jan 2021 18:32:11 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id k9sm10368897pji.8.2021.01.22.18.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 18:32:11 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH] mm/swapfile.c: fix debugging information problem
Date:   Sat, 23 Jan 2021 10:32:00 +0800
Message-Id: <1611369120-2276-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the function name is changed, it may be easy to forget to modify
the corresponding code here.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 mm/swapfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9fffc5a..12a18b8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1158,13 +1158,13 @@ static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
 	return p;
 
 bad_offset:
-	pr_err("swap_info_get: %s%08lx\n", Bad_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
 	goto out;
 bad_device:
-	pr_err("swap_info_get: %s%08lx\n", Unused_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Unused_file, entry.val);
 	goto out;
 bad_nofile:
-	pr_err("swap_info_get: %s%08lx\n", Bad_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
 out:
 	return NULL;
 }
@@ -1181,7 +1181,7 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return p;
 
 bad_free:
-	pr_err("swap_info_get: %s%08lx\n", Unused_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
 out:
 	return NULL;
 }
-- 
1.8.3.1

