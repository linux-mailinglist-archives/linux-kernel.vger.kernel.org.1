Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9B1AF624
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDSBjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgDSBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:39:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A545CC061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n17so4815510ejh.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0z07W0i5lACCA4tx1d7PSEMm+ePwZcbmHDi4QNrUNW8=;
        b=ic9YCn4huKX1BFpVVvXT8DU2gGd9dOXFhlxx+eI5j2c8I66fl2T9LdK7jfq6A+6O1G
         g6NigPIbVwqrMeayiy1hOuVAsNSAK/syvhsRpHAcLVXTQ92vHZOMXIhTFN2rQlTPPs1g
         Fk0gmRH5mYwtlJ8Cb3Jk7IhBLkrMThnNerPRpsoaFPh6/9S6UiEqnN7UV55Iys++dfy0
         N+kgHg44B7jxTywaF354O0y+V9RySlEotFj1cQcULPCgUoYD0fTD/WAiXjTk58xGIvDn
         LAyGTl+QKyn1RlgVTZRWLktRVYXJ6f1zj0ssPKGfIZzRFqntvnZ7LAgWMObcvUUouil7
         fBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0z07W0i5lACCA4tx1d7PSEMm+ePwZcbmHDi4QNrUNW8=;
        b=CB9SyPOcfMX8Q9/oyjR95BeswXxjEP4Rac89S+PDGkTznZjnfyB3tUVwqe+BKBg2lq
         4ZrJ8qzEZGmF8Q6KKwa6CMfMAtVWQB4vclWNn57Ek/bLZ0oWRe/6rQc1nGpvNblQb554
         7Xni2lMgGRxsMdHGI0y2pVg19sE2nDQ9Ntc/Eh5IIvNBbxMxDiXRBYlblye8KHtNwN0U
         YgkPmYRjqQFIxkHo04wBJKjSWRTgpoq6OcW16lThed8U075wAb+ZUF77JaFudZypV7QL
         YbW/9pnKfeZ4jodyiLi03M3I7hHFmWB09Kq9RX0Exs78wp5b4xQkuUqT/fDrYD0bhb3B
         Vucw==
X-Gm-Message-State: AGi0PubYA003Hj/NEijnSpL2dyjvJhB/EhZBX5UoSnZb5f9/nfdOD3lF
        HI+YPP41sTz/vZBOmB5W9BE=
X-Google-Smtp-Source: APiQypLgDnYl2t/SpoaWdQtu4L+o6/wPL0v2CiO4qkeVDBcDEAQB5xhqxU7g3SeBX5A/86vcildY3w==
X-Received: by 2002:a17:906:1641:: with SMTP id n1mr9988302ejd.365.1587260370404;
        Sat, 18 Apr 2020 18:39:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e5sm3452394edq.76.2020.04.18.18.39.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Apr 2020 18:39:29 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, ying.huang@intel.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/4] mm/swapfile.c: tmp is always smaller than max
Date:   Sun, 19 Apr 2020 01:39:19 +0000
Message-Id: <20200419013921.14390-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200419013921.14390-1-richard.weiyang@gmail.com>
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tmp is bigger or equal to max, we would jump to new_cluster.

Return true directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 654bad5173bc..3aae700f9931 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -647,7 +647,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	cluster->next = tmp + 1;
 	*offset = tmp;
 	*scan_base = tmp;
-	return tmp < max;
+	return true;
 }
 
 static void __del_from_avail_list(struct swap_info_struct *p)
-- 
2.23.0

