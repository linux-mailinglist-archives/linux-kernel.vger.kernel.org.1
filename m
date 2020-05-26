Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99B21BD67F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgD2Hsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 03:48:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33164 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgD2Hsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:48:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so560131plr.0;
        Wed, 29 Apr 2020 00:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zQAeuXiODzsrKokYtoCnUSP6kZfr3hECcrcTl3BKAI=;
        b=BDZ4HRJEM6q07iRUHo/M2pg4Q6YUKT8UG7EwAEMNCzlwfcSV5cAZ+52IcKr3IrOzHI
         mW+Ch84ZPQxJfifigEqGctq5c7J2a4QXZxEv6RS/5ThyCdmvDBPIm2fovW87j8fqeCUe
         QkipCEr69SiPPg7nGxR7nGVm0L8hDf+j6VGtPSYrestXR7xaa9Rzqvbnr2h4I343EoQm
         zyj8/sDQzFaKBuc2v9aIiLHjlQ3tJmLJzjaxhGQu3ifpkT/bTlAxZkR40dBw+ecLRVjE
         tgsXdiM/U6cQbkk981hprGUio8wTE2PZLFkPOOkqmLY/sdJ0XGbchdU2ijUAktPshzUw
         j7ow==
X-Gm-Message-State: AGi0PuYsxoFrWu+1MJvrQ/nloPD54vA6uVXIBl+eGThZ8cerCIEDEZ/T
        uKnt/GyK7aPYgCAx1H7+G5A8vkZDuA0=
X-Google-Smtp-Source: APiQypIx9KrNx2LF2FcbeEhR63iQeFhm/vEb33NPfDZ4CwyVqp+DOUH81Qbn7N/Wm3gPHSytybgsdQ==
X-Received: by 2002:a17:90b:2385:: with SMTP id mr5mr1590000pjb.172.1588146532530;
        Wed, 29 Apr 2020 00:48:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o99sm3879443pjo.8.2020.04.29.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:48:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E54CE42000; Wed, 29 Apr 2020 07:48:45 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v1 6/6] loop: add error handling support for add_disk()
Date:   Wed, 29 Apr 2020 07:48:44 +0000
Message-Id: <20200429074844.6241-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074844.6241-1-mcgrof@kernel.org>
References: <20200429074844.6241-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6dccba22c9b5..dcb126f3a7e1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2096,10 +2096,15 @@ static int loop_add(struct loop_device **l, int i)
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_put_disk;
+
 	*l = lo;
 	return lo->lo_number;
 
+out_put_disk:
+	put_disk(lo->lo_disk);
 out_free_queue:
 	blk_cleanup_queue(lo->lo_queue);
 out_cleanup_tags:
-- 
2.25.1

