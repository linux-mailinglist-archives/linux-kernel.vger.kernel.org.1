Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED593013D7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 09:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbhAWIFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 03:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAWIEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 03:04:50 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A6C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 00:04:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so5320947pfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qd/nKYmF7vBNwnZrZPX7WGC1NvdZ4WnO74O5vXZhiTk=;
        b=UFDIrx9gN0kTbwNUMg0cLrGv+qeLMtVhcewlhPXMZpgf1nc4Rt3NjN8qmuMm5/uRtA
         WHbMWqB23Rd11OAN6sx9t95V8WQGGqHUGdQNRBPdKiFwBIu4Wo6rCuGscr65ZmNng8C6
         +UufDCxsAOj5od0EQsUkhw+oCOW4jEeiWvCbQBW8uZzdsD5dEeT2eXE+Hn0rsAOqtWLX
         ka3LtvUGSSG50l8HuYYnQXXUmjZFC3DrK5nPM2oaXOiWK0iUdF0SzTftyOfK3Dl/jQd+
         jbikBJlsOzFTcCZoCNKHrFT6gZbXEKuYE+CKbFBoLupuOCfZLp/uzi6XDDXcedSnGrm0
         Ro1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qd/nKYmF7vBNwnZrZPX7WGC1NvdZ4WnO74O5vXZhiTk=;
        b=mtfOV51VGp35k8yr4mZuzf1ZEjNmcYWYYf4pHGzl2Al68NAvdvhRSnIwphJOrXnzka
         G0fZOQ9eb5u8c38OzBGoVearMrk1EAW5iJuKAGgK7ZKRvoLzxBKaOZGSaO1U6LRLjanr
         yfounSPyBO5c54/d05W/GjBRZxvIIEFiSwBqlBWO0zSxmGUCjUWgQSnQZqVqEP/FL+4n
         xyISnHbKMR1v3B0nMiq8eSDN7SerAL5KHk+6Glncmbd0YZM0NZd4sSfXVOtTjbO5Vwsa
         daS/AN6VhdYM8vlLiULyHKFmBbc18Ue585dI7EIfi5qN6ey8eQWOoRKH6uGwRUoVeIGz
         d84A==
X-Gm-Message-State: AOAM533HRK9Un235oPbLJAgO7FEyX+Kv+gHNFi72AErOZDvjgKf1jW+s
        UBN5jIxn585uhhondXEMEfg=
X-Google-Smtp-Source: ABdhPJz7W9poiCXLcKLLCIYOnYLQP0YxwAJHM1106BXcBaOTqG9E8gsXsT3DA82WN/itvBXlyaRb/Q==
X-Received: by 2002:a62:7c86:0:b029:1b7:cf7b:7d79 with SMTP id x128-20020a627c860000b02901b7cf7b7d79mr9091316pfc.48.1611389047360;
        Sat, 23 Jan 2021 00:04:07 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id m4sm10710987pgv.16.2021.01.23.00.04.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 00:04:06 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH] workqueue: Use %s instead of function name
Date:   Sat, 23 Jan 2021 16:04:00 +0800
Message-Id: <1611389040-5014-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to replace the function name with %s, in case the function
name changes.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9880b6c..8b1b616 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2964,8 +2964,8 @@ void drain_workqueue(struct workqueue_struct *wq)
 
 		if (++flush_cnt == 10 ||
 		    (flush_cnt % 100 == 0 && flush_cnt <= 1000))
-			pr_warn("workqueue %s: drain_workqueue() isn't complete after %u tries\n",
-				wq->name, flush_cnt);
+			pr_warn("workqueue %s: %s() isn't complete after %u tries\n",
+				wq->name, __func__, flush_cnt);
 
 		mutex_unlock(&wq->mutex);
 		goto reflush;
-- 
1.8.3.1

