Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E272B2A1887
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgJaPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgJaPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604157920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=JjYat0788HUsBBtsJEIIXb/BxUZc1qYlxRZUzCe4wXY=;
        b=PAYwJAp7VPyWPKk5ybc4P9q5mca3Ch+vAanbZrtQDCWG6zihRpJPiUfdKinzG9QkBnIJSM
        jPjLjeQ5vhOPXTTIwBNuJpuelONA7NunCeLZlgkZaEnwsnV2K5mW8D4WfpOS3gqYvGtmeI
        NgNI9O7LQ6TjHlKFLK3GDb4R+DlVvv8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-ylsfHjMmPMqmmlnuKN-WWQ-1; Sat, 31 Oct 2020 11:25:18 -0400
X-MC-Unique: ylsfHjMmPMqmmlnuKN-WWQ-1
Received: by mail-oo1-f71.google.com with SMTP id d6so3927599ooi.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JjYat0788HUsBBtsJEIIXb/BxUZc1qYlxRZUzCe4wXY=;
        b=gHGD5i3yp/DLhGfVmauBcE1mMzlojIEkDRW0GzEGJpna0mGKXYLCMIV434z4LtV4Qn
         zd0ZPK64Ufs1iUZGG2vsXLhRbgzLO4qLUZueaIs5jH53iWHseGzQDaDXnWWzu8qbYBZr
         HNJOf0FKekw6+AW3/S0+qEycJ7/BXGdUZA0WRQDvDqsNbv3/EM+XMqoeYWdy3olNLFS2
         2RoNSxEYsp4oUhJqPwlZb3pdtq08eTDiEQPK0+qgTfcqFVPvEQNJQX5zX0xrK7DYF9nw
         fMnyzNcKxV/3slbu7+HBb+lXCEUkfyVeJvOyaW8q7/3mUuSRcl8+zOLIhfum8qpjFD3Q
         VfKA==
X-Gm-Message-State: AOAM5312a2onWL6fX1pKA1KWPW/4wpmWN3XWmL39ZVRH0qu2loSyYgqH
        aY8mObt+S4BOp2iI1AH2YNEjyqH3eZTYtDuXUTmdQa8KGn0xzLmjIhzttImf65JdPilzwdGyOvs
        KiGxayzg9+EYFrLfoYX6wS869
X-Received: by 2002:a05:6830:12d9:: with SMTP id a25mr5494083otq.168.1604157918025;
        Sat, 31 Oct 2020 08:25:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypbwHZqL4YPPs21focFr9NNNhKYiVKkzf9sT+6fcBBEJrI02ZuHlaQBQfVLwpJ89isFonW+Q==
X-Received: by 2002:a05:6830:12d9:: with SMTP id a25mr5494069otq.168.1604157917868;
        Sat, 31 Oct 2020 08:25:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m13sm2206853otn.20.2020.10.31.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:25:17 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org, lee.jones@linaro.org,
        colin.king@canonical.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: ti-st: st_core: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 08:24:56 -0700
Message-Id: <20201031152456.2146104-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/ti-st/st_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index f4ddd1e67015..5a0a5fc3d3ab 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -380,7 +380,7 @@ void st_int_recv(void *disc_data,
 			st_gdata->rx_state = ST_W4_HEADER;
 			st_gdata->rx_count = st_gdata->list[type]->hdr_len;
 			pr_debug("rx_count %ld\n", st_gdata->rx_count);
-		};
+		}
 		ptr++;
 		count--;
 	}
-- 
2.18.1

